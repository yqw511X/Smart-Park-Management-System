package com.ruoyi.smartpart.domain.vo.room;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 首页房间列表VO
 */
@Data
@ApiModel("首页房间列表")
public class HomeRoomVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("所属园区")
    private String parkName;

    @ApiModelProperty("房间id")
    private Long roomId;

    @ApiModelProperty("房间名称")
    private String roomName;

    @ApiModelProperty("所属楼宇")
    private String buildingName;

    @ApiModelProperty("所属楼层")
    private String floorName;

    @ApiModelProperty("面积")
    private Double area;

    @ApiModelProperty("租金")
    private Double tenantMoney;

    @ApiModelProperty("租金类型(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    private String tenantMoneyType;

    @ApiModelProperty("租赁状态(0未租 1在租)")
    private String tenantStatus;

}
