package com.ruoyi.smartpart.domain.vo.Contract;


import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@ApiModel(value = "合同新增对象", description = "用于合同信息新增")
public class ContractInsertVo {



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
     * 租金
     */
    @ApiModelProperty("租金")
    @TableField("tenant_money")
    private Double tenantMoney;

    /**
     * 租金类型
     */
    @ApiModelProperty("租金类型")
    @TableField("tenant_type")
    private String tenantType;
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
     * 管理费类型
     */
    @ApiModelProperty("管理费类型")
    @TableField("manage_money_type")
    private String manageMoneyType;

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
     * 管理费
     */
    @ApiModelProperty("管理费")
    @TableField("manage_money")
    private Double manageMoney;



    /**
     * 结束时间
     */
    @TableField("over_time")
    @ApiModelProperty("结束时间")
    private LocalDateTime overTime;

    /**
     * 开始时间
     */
    @ApiModelProperty("开始时间")
    @TableField("start_time")
    private LocalDateTime startTime;

    /**
     * 合同版本
     */
    @ApiModelProperty("合同版本")
    @TableField("version_num")
    private String versionNum;



    /**
     * 签订日期
     */
    @TableField("date_sign")
    @ApiModelProperty("签订日期")
    private LocalDateTime dateSign;



    /**
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;


}
