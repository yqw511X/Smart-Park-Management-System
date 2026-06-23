package com.ruoyi.smartpart.domain.query.room;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.List;

@Data
@ApiModel("房间新增")
public class RoomCreate implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("楼宇id")
    @NotNull(message = "楼宇id不能为空")
    private Long buildingId;

    @ApiModelProperty("楼层id")
    @NotNull(message = "楼层id不能为空")
    private Long floorId;

    @ApiModelProperty("房间名称")
    @NotBlank(message = "房间名称不能为空")
    private String roomName;

    @ApiModelProperty("租金")
    @NotNull(message = "租金不能为空")
    private Double tenantMoney;

    @ApiModelProperty("租金类型(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    @NotBlank(message = "租金类型不能为空")
    private String tenantMoneyType;

    @ApiModelProperty("物业费")
    @NotNull(message = "物业费不能为空")
    private Double money;

    @ApiModelProperty("物业费单位(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    @NotBlank(message = "物业费单位不能为空")
    private String moneyType;

    @ApiModelProperty("面积")
    @NotNull(message = "面积不能为空")
    private Double area;

    @ApiModelProperty("房间类型(1_loft 2_商业配套 3_办公场所 4其他)")
    @NotBlank(message = "房间类型不能为空")
    private String roomType;

    @ApiModelProperty("房高")
    private Double roomHeight;

    @ApiModelProperty("装修类型(1简装 2精装 3毛坯房)")
    @NotBlank(message = "装修类型不能为空")
    private String renovationType;

    @ApiModelProperty("房间图片(可多张)")
    private List<String> roomImage;

    @ApiModelProperty("简介")
    private String introduce;
}
