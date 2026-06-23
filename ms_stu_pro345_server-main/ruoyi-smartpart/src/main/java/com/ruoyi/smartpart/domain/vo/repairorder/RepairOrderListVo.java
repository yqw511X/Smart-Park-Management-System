package com.ruoyi.smartpart.domain.vo.repairorder;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@ApiModel("维修单列表VO")
public class RepairOrderListVo {

    @ApiModelProperty("维修单ID")
    private Long repairOrderId;

    @ApiModelProperty("报修单号")
    private String repairNum;

    @ApiModelProperty("报修区域")
    private String repairArea;

    @ApiModelProperty("联系人")
    private String contactName;

    @ApiModelProperty("联系电话")
    private String contactPhone;

    @ApiModelProperty("维修工人")
    private String workerName;

    @ApiModelProperty("工单状态")
    private String status;

    @ApiModelProperty("报修时间")
    private LocalDateTime createTime;


}
