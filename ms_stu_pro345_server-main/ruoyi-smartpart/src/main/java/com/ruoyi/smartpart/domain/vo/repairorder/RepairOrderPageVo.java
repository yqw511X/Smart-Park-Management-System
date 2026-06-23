package com.ruoyi.smartpart.domain.vo.repairorder;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@ApiModel("我的报修")
public class RepairOrderPageVo {

    @ApiModelProperty("报修单id")
    private Long repairOrderId;

    @ApiModelProperty("报修单号")
    private String repairNum;

    @ApiModelProperty("报修单状态（0待分配，1待处理，2已完成，3已取消）")
    private String status;

    @ApiModelProperty("报修单时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime RepairTime;

    @ApiModelProperty("联系人")
    private String contactName;

    @ApiModelProperty("联系电话")
    private String contactPhone;

    @ApiModelProperty("维修工人")
    private String repairName;

    @ApiModelProperty("维修区域")
    private String repairArea;
}
