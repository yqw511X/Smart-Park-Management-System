package com.ruoyi.smartpart.domain.vo.room;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;


@Data
@ApiModel("新增功能下的房间信息列表")
public class RoomByContractListVo  {

    @TableField("park_name")
    @ApiModelProperty("所属园区")
    private String parkName;

    @TableField("room_id")
    @ApiModelProperty("房间id")
    private Long roomId;

    @TableField("room_name")
    @ApiModelProperty("房间名称")
    private String roomName;

    @TableField("building_id")
    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @TableField("building_name")
    @ApiModelProperty("所属楼宇")
    private String buildingName;

    @TableField("floor_id")
    @ApiModelProperty("楼层id")
    private Long floorId;

    @TableField("floor_name")
    @ApiModelProperty("所属楼层")
    private String floorName;

    @TableField("area")
    @ApiModelProperty("出租面积")
    private Double area;

    @TableField("tenant_money")
    @ApiModelProperty("租金")
    private Double tenantMoney;

    @TableField("tenant_money_type")
    @ApiModelProperty("租金类型(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    private String tenantMoneyType;


}
