package com.ruoyi.smartpart.service;

/**
 * 短信验证码服务接口
 */
public interface ISmsVerificationService {

    /**
     * 发送短信验证码
     *
     * @param phoneNumber 接收验证码的手机号
     * @param businessType 业务类型，例如 "register"(注册), "login"(登录), "reset_pwd"(重置密码)
     * @return true: 发送成功, false: 发送失败
     */
    boolean sendVerificationCode(String phoneNumber, String businessType);

    /**
     * 校验短信验证码
     *
     * @param phoneNumber 接收验证码的手机号
     * @param inputCode   用户输入的验证码
     * @param businessType 业务类型
     * @return true: 校验成功, false: 校验失败
     */
    boolean verifyCode(String phoneNumber, String inputCode, String businessType);
}
