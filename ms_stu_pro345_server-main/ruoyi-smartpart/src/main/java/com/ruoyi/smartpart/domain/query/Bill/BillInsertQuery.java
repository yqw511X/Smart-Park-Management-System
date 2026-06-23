package com.ruoyi.smartpart.domain.query.Bill;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;


@Data
@ApiModel(value = "Bill新增对象", description = "新增")
public class BillInsertQuery implements Serializable {

    private static final long serialVersionUID = 1L;



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
    @ApiModelProperty("物业管理费应收")
    private Double manageFee;

    /**
     * 是否逾期
     */
    @TableField("overdue")
    @ApiModelProperty("逾期(0 为未逾期 ，1 逾期)")
    private String overdue;

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
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;


}
