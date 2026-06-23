package com.ruoyi.smartpart.domain.vo.Floor;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

@Data
@ApiModel("楼层详情")
public class FloorDetailVo {

    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("楼层id")
    private Long floorId;

    @ApiModelProperty("楼层")
    private Long floorNum;

    @ApiModelProperty("楼层名称")
    private String floorName;
}
