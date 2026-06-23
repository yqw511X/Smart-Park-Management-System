package com.ruoyi.smartpart.domain.query.repairorder;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.Data;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.constraints.NotNull;

@Data
@ApiModel("维修工对象")
public class RepairManCreate {

    @ApiModelProperty(value = "维修工id", required = true)
    @NotNull(message = "维修工id不能为空")
    private Long repairId;

    @ApiModelProperty(value = "工单id", required = true)
    @NotNull(message = "工单id不能为空")
    private Long id;
}
