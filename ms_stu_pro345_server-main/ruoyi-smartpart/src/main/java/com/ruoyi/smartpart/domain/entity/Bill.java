package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

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
@TableName("bill")
@Accessors(chain = true)
@ApiModel(value = "Bill对象", description = "")
public class Bill implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 账单id
     */
    @ApiModelProperty("账单id")
    @TableId(value = "bill_id", type = IdType.AUTO)
    private Long billId;

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
     * 合同id
     */
    @ApiModelProperty("合同id")
    @TableField("contract_id")
    private Long contractId;

    /**
     * 租金
     */
    @ApiModelProperty("租金")
    @TableField("tenant_money")
    private Double tenantMoney;

    /**
     * 状态(0未收款,1已收款)
     */
    @TableField("status")
    @ApiModelProperty("状态(0未收款,1已收款)")
    private String status;

    /**
     * 账期
     */
    @TableField("payment")
    @ApiModelProperty("账期")
    private String payment;

    /**
     * 账期
     */
    @TableField("start_payment")
    @ApiModelProperty("账期开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startPayment;

    /**
     * 账期
     */
    @TableField("end_payment")
    @ApiModelProperty("账期开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endPayment;
    /**
     * 收款截止日期
     */
    @TableField("deadline")
    @ApiModelProperty("收款截止日期")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime deadline;



    /**
     * 押金
     */
    @TableField("deposit")
    @ApiModelProperty("押金")
    private Double deposit;

    /**
     * 管理费应收
     */
    @TableField("manage_fee")
    @ApiModelProperty("管理费应收")
    private Double manageFee;


    /**
     * 退款费用
     */
    @ApiModelProperty("退款费用")
    @TableField("refund_fees")
    private double refundFees;

    /**
     * 退款费用
     */
    @ApiModelProperty("应收总费用")
    @TableField("total_pay")
    private double totalPay;

    /**
     * 是否逾期
     */
    @TableField("overdue")
    @ApiModelProperty("逾期(0 为未逾期 ，1 逾期)")
    private String overdue;
    /**
     * 创建人
     */
    @ApiModelProperty("创建人")
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    /**
     * 创建时间
     */
    @ApiModelProperty("创建时间")
    @TableField(fill = FieldFill.INSERT)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    /**
     * 更新人
     */
    @ApiModelProperty("更新人")
    @TableField(fill = FieldFill.UPDATE)
    private String updateBy;

    /**
     * 更新时间
     */
    @ApiModelProperty("更新时间")
    @TableField(fill = FieldFill.UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    /**
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;

    /**
     * 逻辑删除（0-未删，2-已删）
     */
    @TableField("del_flag")
    @TableLogic(value = "0", delval = "1")
    @ApiModelProperty("逻辑删除（0-未删，1-已删）")
    private Integer delFlag;
}
