package com.ruoyi.smartpart.domain.query.Building;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;

@Data
@ApiModel("新增楼宇参数")
public class BuildingCreate implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("楼宇名称")
    @NotBlank(message = "楼宇名称不能为空")
    private String buildingName;

    @ApiModelProperty("备注")
    private String remark;

}
