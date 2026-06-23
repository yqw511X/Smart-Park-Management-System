package com.ruoyi.common.core.domain.model;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Pattern;

/**
 * 用户注册对象
 * 
 * @author ruoyi
 */
@Data
@ApiModel("注册用户需求")
public class RegisterBody extends LoginBody
{
    /**
     * 用户名
     */
    @ApiModelProperty("用户名")

    private String username;

    /**
     *      用户姓名
     *
     */
    @ApiModelProperty("用户真实姓名")
    private  String nickname;
    /**
     * 用户密码
     */
    @ApiModelProperty("用户密码")
    private String password;

    /**
     *  确认二次密码
     *
     */
    @ApiModelProperty("确认二次密码")

    private  String passwords;


    @ApiModelProperty("用户角色类型（3租户 4维修工）")
    @Pattern(regexp = "^3|4$", message = "类型只能3或4")
    private Long roleId;

    @ApiModelProperty("用户电话号码")
    private String phonenumber;

    @ApiModelProperty("身份证号码")

    private String idNum;


    /**
     * 验证码
     */
    private String code;

    /**
     * 唯一标识
     */
    private String uuid;
}
