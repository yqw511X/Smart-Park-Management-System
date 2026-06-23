package com.ruoyi.smartpart.domain.vo.room;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 租户个人信息VO
 */
@Data
@ApiModel("租户个人信息VO")
public class TenantInfoVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("真实姓名")
    private String realName;

    @ApiModelProperty("身份证号")
    private String idCard;

    @ApiModelProperty("个人邮箱")
    private String email;

    @ApiModelProperty("联系电话")
    private String phonenumber;

    @ApiModelProperty("家庭地址")
    private String address;

    @ApiModelProperty("房间状态 0未租且无房间申请  1未租但有未通过的房间申请  2有房间")
    private String roomStatus;
}
