package com.ruoyi.smartpart.domain.vo.room;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
@ApiModel("租赁场地")
public class RoomPreviewVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("园区名称")
    private String parkName;


    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("楼宇名称")
    private String buildingName;


    @ApiModelProperty("楼层id")
    private Long floorId;

    @ApiModelProperty("楼层名称")
    private String floorName;


    @ApiModelProperty("房间id")
    private Long roomId;

    @ApiModelProperty("房间名称")
    private String roomName;



    @ApiModelProperty("面积")
    private Double area;


}
