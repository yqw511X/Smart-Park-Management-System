package com.ruoyi.smartpart.domain.query.repairorder;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiParam;
import lombok.Data;
import org.springframework.web.bind.annotation.RequestParam;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import java.time.LocalDateTime;

@Data
@ApiModel("维修单状态修改对象")
public class RepairOrderStatusUpdate {

    @ApiModelProperty(value = "工单id", required = true)
    @NotNull(message = "工单id不能为空")
    Long id;

    @ApiModelProperty(value = "租户只能修改两个状态 1、完成维修单(状态值2)  2、取消维修单(状态值3)", required = true)
    @Pattern(regexp = "^[23]$", message = "租户只能 完成维修单(状态值2)  取消维修单(状态值3)")
    String status;
}
