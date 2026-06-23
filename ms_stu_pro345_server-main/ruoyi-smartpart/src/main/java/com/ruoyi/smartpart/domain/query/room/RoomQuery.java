package com.ruoyi.smartpart.domain.query.room;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;


@Data
@ApiModel("房间分页查询参数")
public class RoomQuery implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("房间名称")
    private String roomName;

    @ApiModelProperty("所属楼宇")
    private String buildingName;

    @ApiModelProperty("租赁状态(0未租 1在租)")
    private String tenantStatus;

}
