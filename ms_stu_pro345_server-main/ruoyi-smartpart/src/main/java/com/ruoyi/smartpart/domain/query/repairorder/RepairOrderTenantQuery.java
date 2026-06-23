package com.ruoyi.smartpart.domain.query.repairorder;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Pattern;

@Data
@ApiModel(description = "维修单查询参数(租户)")
public class RepairOrderTenantQuery {

    @ApiModelProperty("维修单号")
    private String repairNum;

    @ApiModelProperty("维修单状态")
    @Pattern(regexp = "^$|^[1234]$", message = "维修单状态只能为null、1、2、3或4")
    private String status;
}
