package com.ruoyi.smartpart.domain.query.floor;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;


@Data
@ApiModel("修改楼层")
public class FloorUpdate {

    @ApiModelProperty("楼层id")
    @NotNull(message = "楼层id不能为空")
    private Long floorId;

    @ApiModelProperty("楼宇id")
    @NotNull(message = "楼宇id不能为空(判断楼层是否重复)")
    private Long buildingId;

    @ApiModelProperty("楼层")
    @NotNull(message = "楼层不能为空")
    private Long floorNum;

    @ApiModelProperty("楼层名称")
    @NotBlank(message = "楼层名称不能为空")
    private String floorName;
}
