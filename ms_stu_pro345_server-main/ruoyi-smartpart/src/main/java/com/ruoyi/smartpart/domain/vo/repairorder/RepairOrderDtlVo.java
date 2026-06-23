package com.ruoyi.smartpart.domain.vo.repairorder;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@ApiModel("维修详情")
@Data
public class RepairOrderDtlVo {

    @ApiModelProperty("维修单id")
    private Long repairOrderId;

    @ApiModelProperty("租户名称")
    private String tenantName;

    @ApiModelProperty("联系人")
    private String contactName;

    @ApiModelProperty("联系电话")
    private String contactPhone;

    @ApiModelProperty("上门时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime visitTime;

    @ApiModelProperty("维修图片")
    private List<String> repairImage;

    @ApiModelProperty("维修单号")
    private String repairOrderNum;

    @ApiModelProperty("报修时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime repairTime;

    @ApiModelProperty("报修修区域")
    private String repairArea;

    @ApiModelProperty("维修描述")
    private String remark;

    @ApiModelProperty("所属园区")
    private String parkName;

    @ApiModelProperty("所属楼宇")
    private String buildingName;

    @ApiModelProperty("所属楼层")
    private String floorName;

    @ApiModelProperty("房间名称")
    private String roomName;

}
