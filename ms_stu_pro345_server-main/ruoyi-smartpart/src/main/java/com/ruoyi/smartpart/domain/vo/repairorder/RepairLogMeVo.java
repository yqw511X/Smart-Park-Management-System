package com.ruoyi.smartpart.domain.vo.repairorder;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@ApiModel("维修日志")
public class RepairLogMeVo {

    @ApiModelProperty("操作类型")
    private String status;

    @ApiModelProperty("操作人")
    private String human;

    @ApiModelProperty("维修人")
    private String repairName;

    @ApiModelProperty("操作时间")
    private LocalDateTime operationTime;
}
