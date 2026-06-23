package com.ruoyi.smartpart.controller;

import com.alibaba.fastjson2.JSONObject;
import com.alipay.api.AlipayApiException;

import com.alipay.api.internal.util.AlipaySignature;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.vo.Bill.BillListVo;
import com.ruoyi.smartpart.mapping.BillMapping;
import com.ruoyi.smartpart.service.BillService;
import com.ruoyi.smartpart.service.ContractService;
import com.ruoyi.smartpart.utils.BaseController;
import com.ruoyi.smartpart.utils.PayUtil;
import com.ruoyi.smartpart.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * 支付宝支付 控制层
 * 符合 RuoYi 框架规范
 */
@RestController
@RequestMapping("/api/alipay")
@Api(tags = "支付宝支付功能")
public class AliPayController extends BaseController {

    private static final Logger log = LoggerFactory.getLogger(AliPayController.class);

    @Autowired
    private PayUtil payUtil;

    @Autowired
    private BillService billService;



    @Autowired
    private ContractService contractService;

    // 从配置文件注入公钥等，确保与 PayUtil 中的一致
    @Value("${alipay.alipay-public-key}")
    private String ALIPAY_PUBLIC_KEY;

    @Value("${alipay.charset}")
    private String CHARSET = "UTF-8";

    @Value("${alipay.sign-type}")
    private String SIGN_TYPE = "RSA2";


    /**
     * 发起支付请求
     *
     * @param billId 包含订单信息的id
     * @return 返回支付页面的 HTML 表单
     */
    @ApiOperation("支付功能的跳转到支付宝支付界面")
    @ResponseBody
    @GetMapping("/pay")
    public Result<String> alipay(@RequestParam("billId") Long billId) {

        try {

            Bill orderModel = billService.getOne(new LambdaQueryWrapper<Bill>()
                    .eq(Bill::getBillId, billId).eq(Bill::getDelFlag, 0));


            // 1. 获取当前登录用户 ID (使用 RuoYi 工具类)
            Long currentUserId = SecurityUtils.getUserId();
//            Long currentUserId =113L;
            // 2. 查询数据库中真实的订单信息，确保是当前用户自己的订单

            Bill dbBill = billService.getById(orderModel.getBillId()); // 是 bill_id
            Long contractId = orderModel.getContractId();
            Contract contract = contractService.getOne(
                    new LambdaQueryWrapper<Contract>()
                            .eq(Contract::getContractId, contractId).eq(Contract::getDelFlag, 0));


            if (dbBill == null) {
                log.warn("用户 {} 尝试支付一个不存在的订单: {}", currentUserId, orderModel.getTenantId());
                return Result.fail("订单不存在");
            }
            if (!currentUserId.equals(dbBill.getTenantId())) {
                log.warn("用户 {} 尝试支付不属于自己的订单: {}", currentUserId, dbBill.getBillId());
                return Result.fail("无权操作此订单");
            }
            if (!"0".equals(dbBill.getStatus())) { // 假设 UNPAID 是待支付状态
                log.warn("订单 {} 状态不允许支付: {}", dbBill.getBillId(), dbBill.getStatus());
                return Result.fail("订单状态不允许支付");
            }

            // 3. 使用数据库中的 bill_id 作为支付宝的商户订单号
            String outTradeNo = String.valueOf(dbBill.getBillId()); // 修改：直接使用 bill_id

            // 4. 准备支付信息
            String subject = contract.getContractName(); // 商品名称
            Double totalAmount = dbBill.getTotalPay(); // 订单金额

            log.info("用户 {} 准备支付账单 {}, 商品: {}, 金额: {}", currentUserId, dbBill.getBillId(), subject, totalAmount);


            // 6. 调用 PayUtil 向支付宝发送支付请求
            String payFormHtml = payUtil.sendRequestToAlipay(outTradeNo, totalAmount, subject);



            return Result.success(payFormHtml, "获取支付表单成功");

        } catch (AlipayApiException e) {
            log.error("调用支付宝接口失败: {}", e.getMessage(), e);
            return Result.fail("支付请求失败: " + e.getMessage());
        } catch (Exception e) {
            log.error("处理支付请求时发生未知错误: {}", e.getMessage(), e);
            return Result.fail("支付请求失败: " + e.getMessage());
        }
    }


    /**
     * 处理支付宝同步返回 (用户完成支付后浏览器跳转回的页面)
     * 注意：支付结果的最终确认应以异步通知为准
     *
     * returnUrl：是用户浏览器调用您后端的接口，您在此接口中处理后，再引导用户的浏览器跳转到前端页面。
     *
     * @param outTradeNo 支付宝返回的商户订单号
     * @param modelMap   用于向视图传递数据
     * @return 视图名称 (重定向到前端支付成功页面)
     */
    @ApiOperation("处理支付宝同步返回 (用户完成支付后浏览器跳转回的页面)")
    @GetMapping("/toSuccess")
    public RedirectView  returns(@RequestParam("out_trade_no") String outTradeNo, ModelMap modelMap) {
        // 1. 查询支付宝该笔订单的支付状态
        String queryResult = payUtil.query(outTradeNo);
        log.debug("支付宝查询结果: {}", queryResult);
        // 定义目标地址
        String targetUrl = "http://localhost:80/#/tenantMyBill/myBill";
        // 2. 解析结果
        JSONObject jsonObject = JSONObject.parseObject(queryResult);
        Object responseObj = jsonObject.get("alipay_trade_query_response");
        if (!(responseObj instanceof Map)) {
            log.error("解析支付宝查询结果失败，响应体格式异常: {}", queryResult);
            return new RedirectView(targetUrl);
        }
        Map<String, Object> responseMap = (Map<String, Object>) responseObj;
        log.debug("解析后的响应 Map: {}", responseMap);

        Object tradeStatus = responseMap.get("trade_status");





        // 3. 根据状态决定跳转
        if ("TRADE_SUCCESS".equals(tradeStatus) || "TRADE_FINISHED".equals(tradeStatus)) {
            log.info("订单 {} 支付成功 (同步返回)", outTradeNo);
            // 注意：这里不执行数据库更新，因为同步返回可能被用户中断或伪造。
            modelMap.addAttribute("outTradeNo", outTradeNo);
            Long billId = Long.valueOf(outTradeNo); // 将 out_trade_no 转换为 Long 类型的 bill_id
            Bill dbBill = billService.getById(billId); // 修改：直接根据 bill_id 查询



            // 7. 更新订单状态
            Bill updateBill = new Bill();
            updateBill.setBillId(dbBill.getBillId());
            updateBill.setStatus("1"); // 假设 '1' 是已支付状态
            boolean updateSuccess = billService.updateById(updateBill);

            return new RedirectView(targetUrl);
        } else {
            log.info("订单 {} 支付未成功 (同步返回), 状态: {}", outTradeNo, tradeStatus);
            return new RedirectView(targetUrl);
        }

    }

    /**
     * 处理支付宝异步通知 (这是更新订单状态的关键)
     *
     *
     * notifyUrl：是支付宝调用您后端的接口，您在此接口中更新数据库。
     *
     * @param request HttpServletRequest 包含支付宝的通知参数
     * @return "success" 或 "failure"，支付宝根据此结果判断是否重试通知
     */
    @ApiOperation("处理支付宝异步通知 (这是更新订单状态的关键)")
    @PostMapping("/notify") // URL 需要在支付宝开发者中心配置
    @ResponseBody
    public String handleNotify(HttpServletRequest request) {
        log.info("收到支付宝异步通知");
        try {
            // 1. 获取所有参数
            Map<String, String> params = new HashMap<>();
            Map<String, String[]> requestParams = request.getParameterMap();
            for (Map.Entry<String, String[]> entry : requestParams.entrySet()) {
                String key = entry.getKey();
                String[] values = entry.getValue();
                String valueStr = "";
                for (int i = 0; i < values.length; i++) {
                    valueStr = (i == values.length - 1) ? valueStr + values[i] : valueStr + values[i] + ",";
                }
                params.put(key, valueStr);
            }

            // 2. 验签 (必须!)
            String sign = params.get("sign");
            params.remove("sign");
            params.remove("sign_type");
            boolean signVerified = AlipaySignature.rsaCheckV1(params, ALIPAY_PUBLIC_KEY, CHARSET, SIGN_TYPE);

            if (!signVerified) {
                log.error("支付宝异步通知验签失败！参数: {}", params);
                return "failure";
            }
            log.info("支付宝异步通知验签成功");


            // 3. 获取关键参数
            String tradeStatus = params.get("trade_status");
            String outTradeNo = params.get("out_trade_no"); // 这个 now is the bill_id
            String totalAmount = params.get("total_amount");
            String tradeNo = params.get("trade_no"); // 支付宝交易号

            log.info("异步通知详情: outTradeNo(billId)={}, status={}, amount={}, tradeNo={}", outTradeNo, tradeStatus, totalAmount, tradeNo);
            // 4. 根据状态处理业务逻辑
            if ("TRADE_SUCCESS".equals(tradeStatus) || "TRADE_FINISHED".equals(tradeStatus)) {
                // 5. 直接使用 outTradeNo (即 bill_id) 查询数据库中的 Bill 记录
                Long billId = Long.valueOf(outTradeNo); // 将 out_trade_no 转换为 Long 类型的 bill_id
                Bill dbBill = billService.getById(billId); // 修改：直接根据 bill_id 查询

                if (dbBill == null) {
                    log.error("异步通知中找不到对应的账单记录: billId={}", billId);
                    return "success"; // 返回 success，避免支付宝反复通知
                }

                // 6. 检查订单金额是否一致 (可选，但更安全) (保持不变)
                if (Double.compare(dbBill.getTotalPay(), Double.parseDouble(totalAmount)) != 0) {
                    log.error("支付金额不匹配！账单金额: {}, 通知金额: {}", dbBill.getTotalPay(), totalAmount);
                    return "success"; // 或者返回 failure
                }

                // 7. 更新订单状态
                Bill updateBill = new Bill();
                updateBill.setBillId(dbBill.getBillId());
                updateBill.setStatus("1"); // 假设 '1' 是已支付状态


                boolean updateSuccess = billService.updateById(updateBill);
                if (updateSuccess) {
                    log.info("账单 {} 状态更新为已支付成功", dbBill.getBillId());
                    return "success"; // 通知支付宝，处理成功
                } else {
                    log.error("账单 {} 状态更新失败", dbBill.getBillId());
                    return "failure"; // 通知支付宝，处理失败，可能会重试
                }
            } else {
                log.info("收到非成功状态通知: {}", tradeStatus);
                // 根据业务需要处理其他状态，如关闭等
                return "success"; // 有时即使不是成功，也返回 success 以免重复通知
            }

        } catch (Exception e) {
            log.error("处理异步通知时发生异常: {}", e.getMessage(), e);
            return "failure"; // 发生异常，通知支付宝重试
        }
    }

}