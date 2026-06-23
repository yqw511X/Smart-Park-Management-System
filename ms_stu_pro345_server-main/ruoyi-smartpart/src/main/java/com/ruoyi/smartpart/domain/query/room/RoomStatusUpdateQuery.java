package com.ruoyi.smartpart.domain.query.room;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data
@ApiModel("房间上架状态修改参数")
public class RoomStatusUpdateQuery implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "房间id", required = true)
    @NotNull(message = "房间id不能为空")
    private Long roomId;

    @ApiModelProperty(value = "上架状态(0未上架 1已上架)", required = true)
    @NotBlank(message = "状态不能为空")
    private String status;
}
