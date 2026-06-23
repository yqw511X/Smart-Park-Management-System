package com.ruoyi.smartpart.domain.vo.room;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import java.io.Serializable;
import java.time.LocalDateTime;


@Data
@ApiModel("房间列表")
public class RoomListVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("所属园区")
    private String parkName;

    @ApiModelProperty("房间id")
    private Long roomId;

    @ApiModelProperty("房间名称")
    private String roomName;

    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("所属楼宇")
    private String buildingName;

    @ApiModelProperty("楼层id")
    private Long floorId;

    @ApiModelProperty("所属楼层")
    private String floorName;

    @ApiModelProperty("面积")
    private Double area;

    @ApiModelProperty("租赁状态(0未租 1在租)")
    private String tenantStatus;

    @ApiModelProperty("租金")
    private Double tenantMoney;

    @ApiModelProperty("租金类型(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    private String tenantMoneyType;

    @ApiModelProperty("上架时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @ApiModelProperty("是否上架(false未上架 true已上架)")
    private boolean status;

    @JsonIgnore
    @ApiModelProperty("是否上架(0未上架 1已上架)")
    private String shelveStatus;
}
