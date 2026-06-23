package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.extension.handlers.JacksonTypeHandler;
import com.fasterxml.jackson.annotation.JsonFormat;
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
 * 维修单
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Getter
@Setter
@ToString
@Accessors(chain = true)
@TableName(value = "repair_order",autoResultMap = true)
@ApiModel(value = "RepairOrder对象", description = "维修单")
public class RepairOrder implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 维修单id
     */
    @ApiModelProperty("维修单id")
    @TableId(value = "repair_order_id", type = IdType.AUTO)
    private Long repairOrderId;

    /**
     * 租户id
     */
    @TableField("tenant_id")
    @ApiModelProperty("租户id")
    private Long tenantId;

    /**
     * 维修工id
     */
    @TableField("repair_id")
    @ApiModelProperty("维修工id")
    private Long repairId;

    /**
     * 房间id
     */
    @TableField("room_id")
    @ApiModelProperty("房间id")
    private Long roomId;

    /**
     * 报修区域
     */
    @ApiModelProperty("报修区域")
    @TableField("repair_area")
    private String repairArea;

    /**
     * 报修时间
     */
    @ApiModelProperty("报修时间")
    @TableField("repair_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime repairTime;

    /**
     * 上门时间
     */
    @ApiModelProperty("上门时间")
    @TableField("visit_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime visitTime;

    /**
     * 状态（0待分配，1待处理，2已完成，3已取消）
     */
    @TableField("status")
    @ApiModelProperty("状态（0待分配，1待处理，2已完成，3已取消）")
    private String status;

    /**
     * 报修单号
     */
    @ApiModelProperty("报修单号")
    @TableField("repair_num")
    private String repairNum;

    /**
     * 维修照片
     */
    @ApiModelProperty("维修照片")
    @TableField(value = "repair_image", typeHandler = JacksonTypeHandler.class)
    private List<String> repairImage;

    @ApiModelProperty("联系人")
    @TableField("contact_name")
    private String contactName;

     @ApiModelProperty("联系电话")
    @TableField("contact_phone")
    private String contactPhone;

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
    @ApiModelProperty("备注,描述")
    private String remark;

    /**
     * 逻辑删除（0-未删，1-已删）
     */
    @TableField("del_flag")
    @ApiModelProperty("逻辑删除（0-未删，1-已删）")
    private Boolean delFlag;
}
