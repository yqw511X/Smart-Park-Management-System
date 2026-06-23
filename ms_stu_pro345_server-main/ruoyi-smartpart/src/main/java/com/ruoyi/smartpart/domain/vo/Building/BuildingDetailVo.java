package com.ruoyi.smartpart.domain.vo.Building;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data
@ApiModel("楼宇详情")
public class BuildingDetailVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("楼宇名称")
    private String buildingName;

    @ApiModelProperty("备注")
    private String remark;
}
