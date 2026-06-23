package com.ruoyi.smartpart.domain.vo.room;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 租户我的房间列表对象
 */
@Data
@ApiModel("租户我的房间列表对象")
public class MyRoomVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("房间申请ID")
    private Long applicationId;

    @ApiModelProperty("所属园区")
    private String parkName;

    @ApiModelProperty("房间名称")
    private String roomName;

    @ApiModelProperty("房间id")
    private Long roomId;

    @ApiModelProperty("所属楼宇")
    private String buildingName;

    @ApiModelProperty("所属楼层")
    private String floorName;

    @ApiModelProperty("面积（平方米）")
    private Double area;

    @ApiModelProperty("租金（元）")
    private Double tenantMoney;

    @ApiModelProperty("租金类型(0_元/m²/天 1_元/m²/月 2_元/天 3_元/月)")
    private String tenantMoneyType;

    @ApiModelProperty("申请时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime applyTime;

    @ApiModelProperty("审批状态(0待审批,1审批通过,2已拒绝,3已取消)")
    private String approvalStatus;

    @ApiModelProperty("房屋状态(0退租 1在租)")
    private String tenantStatus;

    @ApiModelProperty("申请租赁开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;

    @ApiModelProperty("申请租赁结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endTime;
}
