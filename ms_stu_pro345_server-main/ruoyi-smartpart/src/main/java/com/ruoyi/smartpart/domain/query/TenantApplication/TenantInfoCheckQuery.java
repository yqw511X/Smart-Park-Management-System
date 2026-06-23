package com.ruoyi.smartpart.domain.query.TenantApplication;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

/**
 * 租赁信息确认请求类
 */
@Data
@ApiModel("租赁信息确认请求类")
public class TenantInfoCheckQuery implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "真实姓名", required = true)
    @NotBlank(message = "真实姓名不能为空")
    private String realName;

    @ApiModelProperty(value = "身份证号", required = true)
    @NotBlank(message = "身份证号不能为空")
    private String idCard;

    @ApiModelProperty(value = "个人邮箱")
    private String email;

    @ApiModelProperty(value = "联系电话", required = true)
    @NotBlank(message = "联系电话不能为空")
    private String phoneNumber;

    @ApiModelProperty(value = "家庭地址", required = true)
    @NotBlank(message = "家庭地址不能为空")
    private String address;
}
