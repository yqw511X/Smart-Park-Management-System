package com.ruoyi.smartpart.domain.vo.Bill;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
import java.time.YearMonth;


@Data
@ApiModel(value = "Bill查询对象", description = "查询")
public class BillListVo {



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
     * 状态(0未收款,1已收款)
     */
    @TableField("nick_name")
    @ApiModelProperty("租户名称")
    private String nickName;



    /**
     * 合同id
     */
    @ApiModelProperty("合同id")
    @TableField("contract_id")
    private Long contractId;

    /**
     * 合同编号
     */
    @ApiModelProperty("合同编号")
    @TableField("contract_num")
    private String contractNum;

    /**
     * 合同名称
     */
    @ApiModelProperty("合同名称")
    @TableField("contract_name")
    private String contractName;

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
