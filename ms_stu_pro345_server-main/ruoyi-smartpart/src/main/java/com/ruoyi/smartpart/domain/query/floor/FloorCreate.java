package com.ruoyi.smartpart.domain.query.floor;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.util.Date;


@Data
@ApiModel("新增楼层")
public class FloorCreate {

    @ApiModelProperty("楼宇id")
    @NotNull(message = "楼宇id不能为空")
    private Long buildingId;

    @ApiModelProperty("楼层")
    @NotNull(message = "楼层不能为空")
    private Long floorNum;

    @ApiModelProperty("楼层名称")
    @NotBlank(message = "楼层名称不能为空")
    private String floorName;
}
