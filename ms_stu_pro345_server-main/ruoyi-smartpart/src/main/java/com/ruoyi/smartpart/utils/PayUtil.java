package com.ruoyi.smartpart.utils;


import com.alibaba.fastjson2.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeQueryRequest;
import com.alipay.api.response.AlipayTradeQueryResponse;
import com.ruoyi.smartpart.service.TenantApplicationService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;

@Component
public class PayUtil {

    private static final Logger log = LoggerFactory.getLogger(PayUtil.class);

    @Value("${alipay.app-id}")
    private String APP_ID;

    @Value("${alipay.app-private-key}")
    private String APP_PRIVATE_KEY;

    @Value("${alipay.alipay-public-key}")
    private String ALIPAY_PUBLIC_KEY;

    @Value("${alipay.gateway-url}")
    private String GATEWAY_URL;

    @Value("${alipay.notify-url}")
    private String NOTIFY_URL;

    @Value("${alipay.return-url}")
    private String RETURN_URL;

    @Value("${alipay.charset}")
    private String CHARSET = "UTF-8";

    @Value("${alipay.format}")
    private String FORMAT = "JSON";

    @Value("${alipay.sign-type}")
    private String SIGN_TYPE = "RSA2";

    // 可以将 AlipayClient 设为单例，避免每次请求都创建新实例
    private AlipayClient alipayClient;

    // 删除构造函数中的初始化
    public PayUtil() {
        // 空构造函数，仅用于 Spring 创建实例
    }

    // 使用 @PostConstruct 确保在所有 @Value 注入完成后执行
    @PostConstruct
    public void initAlipayClient() {
        try {
            this.alipayClient = new DefaultAlipayClient(
                    GATEWAY_URL, APP_ID, APP_PRIVATE_KEY, FORMAT, CHARSET, ALIPAY_PUBLIC_KEY, SIGN_TYPE
            );
            log.info("AlipayClient 初始化成功");
            // Optional: Log keys' lengths to verify they are loaded correctly (remove after verification)
            log.debug("AppId: {}", APP_ID);
            log.debug("AppPrivateKey length: {}", APP_PRIVATE_KEY != null ? APP_PRIVATE_KEY.length() : "NULL");
            log.debug("AlipayPublicKey length: {}", ALIPAY_PUBLIC_KEY != null ? ALIPAY_PUBLIC_KEY.length() : "NULL");
        } catch (Exception e) {
            log.error("AlipayClient 初始化失败", e);
            throw new RuntimeException("AlipayClient 初始化失败", e);
        }
    }


    // 支付宝官方提供的接口
    public String sendRequestToAlipay(String outTradeNo, Double totalAmount, String subject) throws AlipayApiException {
        // 设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(RETURN_URL);
        alipayRequest.setNotifyUrl(NOTIFY_URL);

        // 使用 JSONObject 安全地构建业务参数
        JSONObject bizContent = new JSONObject();
//        bizContent.put("method", "api.alipay.pay"); // <--- 必须包含这一行！
        bizContent.put("out_trade_no", outTradeNo); // 修正字段名
        bizContent.put("total_amount", totalAmount);
        bizContent.put("subject", subject);
        bizContent.put("product_code", "FAST_INSTANT_TRADE_PAY");

        alipayRequest.setBizContent(bizContent.toJSONString());

        // 请求
        String result = alipayClient.pageExecute(alipayRequest).getBody();
        log.info("支付宝支付请求返回结果: {}", result);
        return result;
    }

    // 通过订单编号查询
    public String query(String outTradeNo) {
        AlipayTradeQueryRequest request = new AlipayTradeQueryRequest();
        JSONObject bizContent = new JSONObject();
        bizContent.put("out_trade_no", outTradeNo);
        request.setBizContent(bizContent.toString());

        AlipayTradeQueryResponse response = null;
        String body = null;
        try {
            response = alipayClient.execute(request);
            body = response.getBody();
        } catch (AlipayApiException e) {
            log.error("查询支付宝订单状态失败: {}", e.getMessage(), e);
        }
        if (response != null && response.isSuccess()) {
            log.info("支付宝订单查询成功");
        } else {
            log.warn("支付宝订单查询失败或返回结果不包含成功标识");
        }
        return body;
    }
}