package com.ruoyi.smartpart.domain.query.Contract;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Data
@ApiModel(value = "合同改变对象", description = "用于合同信息改变")
public class ContractChangeQuery {



    /**
     * 合同id
     */
    @ApiModelProperty("合同id")
    @TableId(value = "contract_id", type = IdType.AUTO)
    @NotNull(message = "合同id不为空")
    private Long contractId;

    /**
     * 租户id
     */
    @TableField("tenant_id")
    @ApiModelProperty("租户id")
    @NotNull(message = "租户id不为空")
    private Long tenantId;

    /**
     * 房间id
     */
    @TableField("room_id")
    @ApiModelProperty("房间id")
    @NotNull(message = "房间id不为空")
    private Long roomId;

    /**
     * 合同名称
     */
    @ApiModelProperty("合同名称")
    @TableField("contract_name")
    @NotBlank(message = "合同名称不为空")
    private String contractName;



    /**
     * 合同编号
     */
    @ApiModelProperty("合同编号")
    @TableField("contract_num")
    @NotBlank(message = "合同编号不为空")
    private String contractNum;


    /**
     * 租金类型
     */
    @ApiModelProperty("租金类型 (0 元/平方/天 ，1 元/平方/月  )")
    @TableField("tenant_type")
    @NotBlank(message = "租金类型不为空(0 元/平方/天 ，1 元/平方/月  )")
    private String tenantType;



    /**
     * 租金收租方法（0固定资金，1按日收）
     */
    @TableField("tenant_method")
    @ApiModelProperty("租金收租方法（0固定资金，1按日收）")
    @NotBlank(message = "租金收租方法（0固定资金，1按日收）不为空")
    private String tenantMethod;


    /**
     * 租金类型
     */
    @ApiModelProperty("租金单价")
    @TableField("tenant_unit_price")
    @NotNull(message = "租金单价不为空")
    private Double tenantUnitPrice;

    /**
     * 租金
     */
    @ApiModelProperty("管理费单价")
    @TableField("manage_unit_price")
    @NotNull(message = "管理费单价不为空")
    private Double manageUnitPrice;


    /**
     * 管理费类型
     */
    @ApiModelProperty("管理费类型 (0 元/平方/天 ，1 元/平方/月  )")
    @TableField("manage_money_type")
    @NotBlank(message = "管理费类型不为空(0 元/平方/天 ，1 元/平方/月  )")
    private String manageMoneyType;





    /**
     * 当次抵押支付
     */
    @ApiModelProperty("当次抵押支付")
    @TableField("mortgage_pay")
    @NotNull(message = "当次抵押支付不为空")
    private Double mortgagePay;

    /**
     * 抵押月数
     */
    @ApiModelProperty("抵押月数")
    @TableField("mortgage_month")
    @NotNull(message = "抵押月数不为空")
    private Integer mortgageMonth;

    /**
     * 结束时间
     */
    @TableField("over_time")
    @ApiModelProperty("结束时间 yyyy-MM-dd HH:mm:ss")
    @NotNull(message = "结束时间不为空")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime overTime;

    /**
     * 开始时间
     */
    @ApiModelProperty("开始时间 yyyy-MM-dd HH:mm:ss")
    @TableField("start_time")
    @NotNull(message = "开始时间不为空")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;



    /**
     * 日租金
     */
    @ApiModelProperty("日租金")
    @TableField("daily_rent")
    @NotNull(message = "日租金不为空")
    private Double dailyRent;

    /**
     * 月租金
     */
    @ApiModelProperty("月租金")
    @TableField("month_rent")
    @NotNull(message = "月租金不为空")
    private Double monthRent;

    /**
     * 日管理费
     */
    @TableField("daily_fee")
    @ApiModelProperty("日管理费")
    @NotNull(message = "日管理费不为空")
    private Double dailyFee;

    /**
     * 月管理费
     */
    @TableField("month_fee")
    @ApiModelProperty("月管理费")
    @NotNull(message = "月管理费不为空")
    private Double monthFee;

    /**
     * 签订日期
     */
    @TableField("date_sign")
    @ApiModelProperty("签订日期 yyyy-MM-dd HH:mm:ss")
    @NotNull(message = "签订日期不为空")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime dateSign;



    /**
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;


}
