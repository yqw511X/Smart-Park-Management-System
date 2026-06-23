package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
@Setter
@ToString
@TableName("lease_cancellation")
@Accessors(chain = true)
@ApiModel(value = "lease_cancellation对象", description = "退租表")
public class LeaseCancellation implements Serializable {

  /**
   * 退租id
   */
  @ApiModelProperty("退租id")
  @TableId(value = "lease_cancellation_id", type = IdType.AUTO)
  private long leaseCancellationId;
  /**
   * 租户id
   */
  @ApiModelProperty("租户id")
  @TableField("tenant_id")
  private long tenantId;
  /**
   * 合同id
   */
  @ApiModelProperty("合同id")
  @TableField("contract_id")
  private long contractId;

  /**
   * 应收费用
   */
  @ApiModelProperty("应收费用")
  @TableField("account_receivable")
  private double accountReceivable;

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
   * 退款原因
   */
  @ApiModelProperty("退款原因")
  @TableField("lease_reason")
  private String leaseReason;


  @ApiModelProperty("退租时间")
  @TableField("tenant_time")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
  private LocalDateTime tenantTime;


}
