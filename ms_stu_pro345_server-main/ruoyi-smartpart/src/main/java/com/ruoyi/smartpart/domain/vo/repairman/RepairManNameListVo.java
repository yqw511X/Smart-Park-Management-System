package com.ruoyi.smartpart.domain.vo.repairman;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("维修工名称列表")
public class RepairManNameListVo {
    @ApiModelProperty(value = "维修工id")
    private Long repairManId;

    @ApiModelProperty(value = "维修工名称")
    private String repairManName;
}
