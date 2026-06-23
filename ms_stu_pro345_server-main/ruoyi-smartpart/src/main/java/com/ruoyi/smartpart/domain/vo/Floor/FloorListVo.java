package com.ruoyi.smartpart.domain.vo.Floor;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;


@Data
@ApiModel("楼层列表")
public class FloorListVo{

    @ApiModelProperty("楼层id")
    private Long floorId;

    @ApiModelProperty("楼层")
    private Long floorNum;

    @ApiModelProperty("楼层名称")
    private String floorName;

    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("创建人")
    private String createBy;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}
