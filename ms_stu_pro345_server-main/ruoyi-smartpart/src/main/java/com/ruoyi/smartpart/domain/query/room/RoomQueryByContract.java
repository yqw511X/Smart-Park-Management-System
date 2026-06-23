package com.ruoyi.smartpart.domain.query.room;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;


@Data
@ApiModel("新增功能下的房间信息列表")
public class RoomQueryByContract  {

    @TableField("room_name")
    @ApiModelProperty("房间名称")
    private String roomName;

    @TableField("building_name")
    @ApiModelProperty("所属楼宇")
    private String buildingName;



}
