package com.ruoyi.smartpart.domain.vo.Floor;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;


@Data
@ApiModel("楼层名称列表")
public class FloorNameListVo {

    @ApiModelProperty("楼层id")
    private Long floorId;

    @ApiModelProperty("楼层")
    private Long floorNum;

    @ApiModelProperty("楼层名称")
    private String floorName;
}
