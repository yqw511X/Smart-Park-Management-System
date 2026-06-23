package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

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
@Accessors(chain = true)
@TableName("room_record")
@ApiModel(value = "RoomRecord对象", description = "")
public class RoomRecord implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 房间记录id
     */
    @ApiModelProperty("房间记录id")
    @TableId(value = "record_id", type = IdType.AUTO)
    private Long recordId;

    /**
     * 房间id
     */
    @TableField("room_id")
    @ApiModelProperty("房间id")
    private Long roomId;

    /**
     * 租户id
     */
    @TableField("tenant_id")
    @ApiModelProperty("租户id")
    private Long tenantId;

    /**
     * 状态
     */
    @TableField("status")
    @ApiModelProperty("状态")
    private String status;

    /**
     * 入住时间
     */
    @TableField("time")
    @ApiModelProperty("入住时间")
    private LocalDateTime time;

    /**
     * 合同id
     */
    @ApiModelProperty("合同id")
    @TableField("contract_id")
    private Long contractId;

    /**
     * 退租时间
     */
    @ApiModelProperty("退租时间")
    @TableField("tenant_time")
    private LocalDateTime tenantTime;

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
