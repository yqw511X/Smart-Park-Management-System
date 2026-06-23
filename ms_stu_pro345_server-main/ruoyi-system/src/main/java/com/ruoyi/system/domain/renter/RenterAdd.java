package com.ruoyi.system.domain.renter;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel(description = "租客添加对象")
@Data
public class RenterAdd {

    @ApiModelProperty(value = "账户名", required = true)
    private String nickName;

    @ApiModelProperty(value = "真实姓名", required = true)
    private String userName;

    @ApiModelProperty(value = "手机号", required = true)
    private String phonenumber;

    @ApiModelProperty(value = "邮箱", required = true)
    private String email;

    @ApiModelProperty(value = "身份证号", required = true)
    private String idNum;

    @ApiModelProperty(value = "密码", required = true)
    private String password;

    @ApiModelProperty(value = "确认密码", required = true)
    private String confirmPassword;

     @ApiModelProperty(value = "地址", required = true)
    private String address;

     @ApiModelProperty("在租房间id")
     private Long roomId;
}
