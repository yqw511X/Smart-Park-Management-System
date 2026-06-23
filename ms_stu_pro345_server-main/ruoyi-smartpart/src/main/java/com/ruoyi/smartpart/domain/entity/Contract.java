package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * <p>
 * 合同
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Data
@ToString
@TableName("contract")
@Accessors(chain = true)
@ApiModel(value = "Contract对象", description = "合同")
public class Contract {

  private static final long serialVersionUID = 1L;

  /**
   * 合同id
   */
  @ApiModelProperty("合同id")
  @TableId(value = "contract_id", type = IdType.AUTO)
  private Long contractId;

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
   * 合同名称
   */
  @ApiModelProperty("合同名称")
  @TableField("contract_name")
  private String contractName;

  /**
   * 合同编号
   */
  @ApiModelProperty("合同编号")
  @TableField("contract_num")
  private String contractNum;

  /**
   * 状态（0待签订，1执行中，2已完成）
   */
  @TableField("status")
  @ApiModelProperty("状态（0待签订，1执行中，2已完成）")
  private String status;

  /**
   * 租金类型
   */
  @Excel(name = "租金类型", readConverterExp = "0=元/平方/天,1=元/平方/月  ")
  @ApiModelProperty(value = "租金类型",
          example = "0", // 示例值
          allowableValues = "0, 1" )
  @TableField("tenant_type")
  private String tenantType;
  /**
   * 管理费类型
   */
  @Excel(name = "管理费类型", readConverterExp = "0=元/平方/天,1=元/平方/月  ")
  @ApiModelProperty(value = "管理费类型",
          example = "0", // 示例值
          allowableValues = "0, 1" )
  @TableField("manage_money_type")
  private String manageMoneyType;

  /**
   * 租金
   */
  @ApiModelProperty("租金")
  @TableField("tenant_money")
  private Double tenantMoney;

  /**
   * 租金收租方法（0固定资金，1按日收）
   */
  @TableField("tenant_method")
  @ApiModelProperty("租金收租方法（0固定资金，1按日收）")
  private String tenantMethod;


  /**
   * 租金类型
   */
  @ApiModelProperty("租金单价")
  @TableField("tenant_unit_price")
  private Double tenantUnitPrice;

  /**
   * 租金
   */
  @ApiModelProperty("管理费单价")
  @TableField("manage_unit_price")
  private Double manageUnitPrice;




  /**
   * 管理费
   */
  @ApiModelProperty("管理费")
  @TableField("manage_money")
  private Double manageMoney;



  /**
   * 当次抵押支付
   */
  @ApiModelProperty("当次抵押支付")
  @TableField("mortgage_pay")
  private Double mortgagePay;

  /**
   * 抵押月数
   */
  @ApiModelProperty("抵押月数")
  @TableField("mortgage_month")
  private Integer mortgageMonth;

  /**
   * 结束时间
   */
  @TableField("over_time")
  @ApiModelProperty("结束时间")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
  private LocalDateTime overTime;

  /**
   * 开始时间
   */
  @ApiModelProperty("开始时间")
  @TableField("start_time")
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
  private LocalDateTime startTime;

  /**
   * 合同版本
   */
  @ApiModelProperty("合同版本")
  @TableField("version_num")
  private String versionNum;

  /**
   * 日租金
   */
  @ApiModelProperty("日租金")
  @TableField("daily_rent")
  private Double dailyRent;

  /**
   * 月租金
   */
  @ApiModelProperty("月租金")
  @TableField("month_rent")
  private Double monthRent;

  /**
   * 日管理费
   */
  @TableField("daily_fee")
  @ApiModelProperty("日管理费")
  private Double dailyFee;

  /**
   * 月管理费
   */
  @TableField("month_fee")
  @ApiModelProperty("月管理费")
  private Double monthFee;

  /**
   * 签订日期
   */
  @TableField("date_sign")
  @ApiModelProperty("签订日期")
  private LocalDateTime dateSign;







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
   * 逻辑删除（0-未删，1-已删）
   */
  @TableField("del_flag")
  @ApiModelProperty("逻辑删除（0-未删，1-已删）")
  private Boolean delFlag;
}