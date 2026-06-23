package com.ruoyi.smartpart.domain.query.repairorder;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Pattern;

@Data
@ApiModel(description = "维修单查询参数")
public class RepairOrderQuery {

    @ApiModelProperty("维修单号")
    private String repairNum;

    @ApiModelProperty("维修单状态(1待处理 2已完成)")
    @Pattern(regexp = "^$|^[12]$", message = "维修单状态只能为null、1或2")
    private String status;
}
