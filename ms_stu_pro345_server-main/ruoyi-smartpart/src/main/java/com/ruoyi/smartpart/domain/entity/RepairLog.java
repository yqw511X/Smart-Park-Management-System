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
 * @since 2026-02-09
 */
@Getter
@Setter
@ToString
@Accessors(chain = true)
@TableName("repair_log")
@ApiModel(value = "RepairLog对象", description = "")
public class RepairLog implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 维修日志id
     */
    @ApiModelProperty("维修日志id")
    @TableId(value = "repair_log_id", type = IdType.AUTO)
    private Long repairLogId;

    /**
     * 维修工单id
     */
    @ApiModelProperty("维修工单id")
    @TableField("repair_order_id")
    private Long repairOrderId;

    /**
     * 操作时间
     */
    @ApiModelProperty("操作时间")
    @TableField("operation_time")
    private LocalDateTime operationTime;

    /**
     * 状态(0待分配,1待处理,2已完成,3已取消)
     */
    @TableField("status")
    @ApiModelProperty("状态(0待分配,1待处理,2已完成,3已取消)")
    private String status;

    @TableField("del_flag")
    private Boolean delFlag;

    @TableField("human")
    private String human;

    @TableField("repair_name")
    private String repairName;
}
