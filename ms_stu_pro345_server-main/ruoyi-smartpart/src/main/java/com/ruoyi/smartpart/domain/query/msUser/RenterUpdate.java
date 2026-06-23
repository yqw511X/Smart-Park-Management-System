package com.ruoyi.smartpart.domain.query.msUser;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

@ApiModel(description = "租客更新对象")
@Data
public class RenterUpdate {

    @ApiModelProperty(value = "用户id")
    @NotNull(message = "用户id不能为空")
    private Long userId;

    @ApiModelProperty(value = "真实姓名")
    private String nickName;

    @ApiModelProperty(value = "账户名")
    private String userName;

    @ApiModelProperty(value = "手机号")
    private String phonenumber;

    @ApiModelProperty(value = "邮箱")
    private String email;

    @ApiModelProperty(value = "身份证号")
    private String idNum;

    @ApiModelProperty(value = "地址")
    private String address;

    @ApiModelProperty(value = "密码", required = true)
    @NotNull(message = "密码不能为空")
    private String password;

    @ApiModelProperty(value = "确认密码", required = true)
    @NotNull(message = "确认密码不能为空")
    private String confirmPassword;
}
