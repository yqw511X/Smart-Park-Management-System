package com.ruoyi.smartpart.domain.vo.room;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@ApiModel("房间详情VO")
public class RoomDetailVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("房间id")
    private Long roomId;

    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("楼层id")
    private Long floorId;

    @ApiModelProperty("楼层名称")
    private String floorName;

    @ApiModelProperty("房间名称")
    private String roomName;

    @ApiModelProperty("租金")
    private Double tenantMoney;

    @ApiModelProperty("租金类型(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    private String tenantMoneyType;

    @ApiModelProperty("物业费")
    private Double money;

    @ApiModelProperty("物业费单位(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    private String moneyType;

    @ApiModelProperty("面积")
    private Double area;

    @ApiModelProperty("房间类型(1_loft 2_商业配套 3_办公场所 4其他)")
    private String roomType;

    @ApiModelProperty("房高")
    private Double roomHeight;

    @ApiModelProperty("装修类型(1简装 2精装 3毛坯房)")
    private String renovationType;

    @ApiModelProperty("房间图片(可多张)")
    private List<String> roomImage;

    @ApiModelProperty("简介")
    private String introduce;
}
