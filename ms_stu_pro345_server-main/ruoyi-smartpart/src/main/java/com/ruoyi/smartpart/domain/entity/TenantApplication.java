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
 * 租户申请表
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Getter
@Setter
@ToString
@Accessors(chain = true)
@TableName("tenant_application")
@ApiModel(value = "TenantApplication对象", description = "租户申请表")
public class TenantApplication implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 租户申请id
     */
    @ApiModelProperty("租户申请id")
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;

    /**
     * 租户id
     */
    @TableField("tenant_id")
    @ApiModelProperty("租户id")
    private Long tenantId;

    /**
     * 房间id
     */
    @TableField("room_id")
    @ApiModelProperty("房间id")
    private Long roomId;

    /**
     * 开始时间
     */
    @ApiModelProperty("开始时间")
    @TableField("start_time")
    private LocalDateTime startTime;

    /**
     * 结束时间
     */
    @TableField("end_time")
    @ApiModelProperty("结束时间")
    private LocalDateTime endTime;

    /**
     * 申请时间
     */
    @ApiModelProperty("申请时间")
    @TableField("apply_time")
    private LocalDateTime applyTime;

    @TableField("apply_name")
    @ApiModelProperty("申请人姓名")
    private String applyName;

    @TableField("contact_phone")
    @ApiModelProperty("申请人手机号")
    private String contactPhone;

    /**
     * 状态(0待审批,1审批通过,2已拒绝,3已取消)
     */
    @TableField("status")
    @ApiModelProperty("状态(0待审批,1审批通过,2已拒绝,3已取消)")
    private String status;

    @TableField("room_status")
    @ApiModelProperty("房屋状态（0退租 1在租）(当前申请周期中租户对该房间的租赁状态)")
    private String roomStatus;


    @TableField("contract_id")
    @ApiModelProperty("合同id")
    private Long contractId;

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
