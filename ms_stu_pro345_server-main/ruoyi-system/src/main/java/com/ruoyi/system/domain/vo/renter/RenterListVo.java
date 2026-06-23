package com.ruoyi.system.domain.vo.renter;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@ApiModel("查询")
@Data
public class RenterListVo {

    @ApiModelProperty("租客ID")
    private Long userId;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("租客姓名")
    private String userName;

    @ApiModelProperty("身份证号")
    private String idNum;

    @ApiModelProperty("手机号")
    private String phoneNumber;

    @ApiModelProperty("家庭住址")
    private String address;

    @ApiModelProperty("租户状态0未租 1在租")
    private String status;

    @ApiModelProperty("在租房间")
    private String roomName;

    @ApiModelProperty("在租房间id")
    private Long roomId;
}
