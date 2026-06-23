package com.ruoyi.smartpart.domain.vo.Building;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ApiModel("楼宇名称列表")
public class BuildingNameListVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("楼宇名称")
    private String buildingName;
}
