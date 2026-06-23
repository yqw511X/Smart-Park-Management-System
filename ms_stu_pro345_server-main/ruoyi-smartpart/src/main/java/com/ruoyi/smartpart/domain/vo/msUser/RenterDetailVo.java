package com.ruoyi.smartpart.domain.vo.msUser;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel(description = "租客详情信息")
@Data
public class RenterDetailVo {

    @ApiModelProperty(value = "账户名")
    private String nickName;

    @ApiModelProperty(value = "真实姓名")
    private String userName;

    @ApiModelProperty(value = "手机号")
    private String phonenumber;

    @ApiModelProperty(value = "邮箱")
    private String email;

    @ApiModelProperty(value = "身份证号")
    private String idNum;

     @ApiModelProperty(value = "地址")
    private String address;

     @ApiModelProperty("在租房间id")
     private Long roomId;
}
