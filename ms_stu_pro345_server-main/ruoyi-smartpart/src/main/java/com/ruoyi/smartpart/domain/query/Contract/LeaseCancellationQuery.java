package com.ruoyi.smartpart.domain.query.Contract;

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

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ApiModel(value = "退租需求对象", description = "用于合同模块的退租功能")
public class LeaseCancellationQuery  {


  /**
   * 租户id
   */
  @ApiModelProperty("租户id")
  @TableField("tenant_id")
  @NotNull(message = "租户id不为空")
  private long tenantId;
  /**
   * 合同id
   */
  @ApiModelProperty("合同id")
  @TableField("contract_id")
  @NotNull(message = "合同id不为空")
  private long contractId;

  /**
   * 退租时间
   */
  @ApiModelProperty("退租时间 yyyy-MM-dd HH:mm:ss")
  @TableField("tenant_time")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
  @NotNull(message = "退租时间不为空")
  private LocalDateTime tenantTime;
  /**
   * 应收费用
   */
  @ApiModelProperty("应收费用")
  @TableField("account_receivable")
  @NotNull(message = "应收费用不为空")
  private double accountReceivable;

  /**
   * 退款费用
   */
  @ApiModelProperty("退款费用")
  @TableField("refund_fees")
  @NotNull(message = "退款费用不为空")
  private double refundFees;

  /**
   * 退款费用
   */
  @ApiModelProperty("应收总费用")
  @TableField("total_pay")
  @NotNull(message = "应收总费用不为空")
  private double totalPay;

  /**
   * 退款原因
   */
  @ApiModelProperty("退款原因")
  @TableField("lease_reason")
  @NotBlank(message = "退款原因不为空")
  private String leaseReason;

  /**
   * 备注
   */
  @TableField("remark")
  @ApiModelProperty("备注")
  private String remark;



}
