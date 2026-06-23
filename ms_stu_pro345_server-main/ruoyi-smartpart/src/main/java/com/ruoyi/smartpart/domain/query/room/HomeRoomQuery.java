package com.ruoyi.smartpart.domain.query.room;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * 首页房间查询参数
 */
@Data
@ApiModel("首页房间查询参数")
public class HomeRoomQuery implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("房间名称")
    private String roomName;

    @ApiModelProperty("所属楼宇")
    private String buildingName;

    @ApiModelProperty("园区名称")
    private String parkName;

}
