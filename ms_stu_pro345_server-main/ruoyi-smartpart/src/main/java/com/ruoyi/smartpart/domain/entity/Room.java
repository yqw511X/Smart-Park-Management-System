package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

/**
 * <p>
 *
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Getter
@Setter
@ToString
@TableName(value = "room", autoResultMap = true)
@Accessors(chain = true)
@ApiModel(value = "Room对象", description = "")
public class Room implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 房间id
     */
    @ApiModelProperty("房间id")
    @TableId(value = "room_id", type = IdType.AUTO)
    private Long roomId;

    /**
     * 用户id
     */
    @TableField("user_id")
    @ApiModelProperty("用户id")
    private Long userId;

    /**
     * 楼层id
     */
    @TableField("floor_id")
    @ApiModelProperty("楼层id")
    private Long floorId;

    /**
     * 房间名称
     */
    @TableField("room_name")
    @ApiModelProperty("房间名称")
    private String roomName;

    /**
     * 房间类型
     */
    @TableField("room_type")
    @ApiModelProperty("房间类型(1_loft 2_商业配套 3_办公场所 4其他)")
    private String roomType;

    /**
     * 物业费
     */
    @TableField("money")
    @ApiModelProperty("物业费")
    private Double money;

    /**
     * 物业费单位(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)
     */
    @ApiModelProperty("物业费单位(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    private String moneyType;

    /**
     * 装修类型
     */
    @ApiModelProperty("装修类型(1简装 2精装 3毛坯房)")
    @TableField("renovation_type")
    private String renovationType;

    /**
     * 房高
     */
    @ApiModelProperty("房高")
    @TableField("room_height")
    private Double roomHeight;

    /**
     * 上架状态
     */
    @TableField("status")
    @ApiModelProperty("上架状态(0未上架 1已上架)")
    private String status;

    /**
     * 租金
     */
    @ApiModelProperty("租金")
    @TableField("tenant_money")
    private Double tenantMoney;

    /**
     * 租金类型
     */
    @ApiModelProperty("租金类型(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)")
    @TableField("tenant_money_type")
    private String tenantMoneyType;

    /**
     * 房间图片
     * 指定使用 JacksonTypeHandler 来处理 Java 集合与数据库 JSON 的转换
     */
    @TableField(value = "room_image", typeHandler = JacksonTypeHandler.class)
    private List<String> roomImage;

    /**
     * 面积
     */
    @TableField("area")
    @ApiModelProperty("面积")
    private Double area;

    /**
     * 简介
     */
    @ApiModelProperty("简介")
    @TableField("introduce")
    private String introduce;

    /**
     * 楼宇id
     */
    @ApiModelProperty("楼宇id")
    @TableField("building_id")
    private Long buildingId;

    /**
     * 园区名称
     */
    @TableField("park_name")
    @ApiModelProperty("园区名称")
    private String parkName;

    /**
     * 租赁状态
     */
    @ApiModelProperty("租赁状态(0未租 1在租)")
    @TableField("tenant_status")
    private String tenantStatus;

    /**
     * 创建人
     */
    @ApiModelProperty("创建人")
    @TableField("create_by")
    private String createBy;

    /**
     * 创建时间
     */
    @ApiModelProperty("创建时间")
    @TableField("create_time")
    private LocalDateTime createTime;

    /**
     * 更新人
     */
    @ApiModelProperty("更新人")
    @TableField("update_by")
    private String updateBy;

    /**
     * 更新时间
     */
    @ApiModelProperty("更新时间")
    @TableField("update_time")
    private LocalDateTime updateTime;

    /**
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;

    /**
     * 逻辑删除（0-未删，1-已删）
     */
    @TableField("del_flag")
    @ApiModelProperty("逻辑删除（0-未删，1-已删）")
    private Boolean delFlag;
}
