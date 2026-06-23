package com.ruoyi.smartpart.domain.vo.Contract;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import com.ruoyi.common.core.domain.model.TenantBody;
import com.ruoyi.smartpart.domain.vo.room.RoomPreviewVo;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * <p>
 * 合同
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Data
public class ContracPreviewtListVo  {



    /**
     * 合同id
     */
    @ApiModelProperty("合同id")
    @TableId(value = "contract_id", type = IdType.AUTO)
    private Long contractId;


    /**
     * 合同名称
     */
    @ApiModelProperty("合同名称")
    @TableField("contract_name")
    private String contractName;

    /**
     * 合同版本
     */
    @ApiModelProperty("合同版本")
    @TableField("version_num")
    private String versionNum;

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
     * 结束时间
     */
    @TableField("over_time")
    @ApiModelProperty("结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime overTime;

    /**
     * 开始时间
     */
    @ApiModelProperty("开始时间")
    @TableField("start_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startTime;



    /**
     * 签订日期
     */
    @TableField("date_sign")
    @ApiModelProperty("签订日期")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime dateSign;


    /**
     * 更新人
     */
    @ApiModelProperty("经办人")
    @TableField(fill = FieldFill.UPDATE)
    private String updateBy;


    @ApiModelProperty("租户信息")
    private TenantBody tenantBody;

    @ApiModelProperty("租赁地址")
    private RoomPreviewVo roomPreviewVo;




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
     * 日租金
     */
    @ApiModelProperty("日租金")
    @TableField("daily_rent")
    private Double dailyRent;


    /**
     * 固定月租金
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
     * 固定月管理费
     */
    @TableField("month_fee")
    @ApiModelProperty("月管理费")
    private Double monthFee;

    /**
     * 租金
     */
    @ApiModelProperty("租金")
    @TableField("tenant_money")
    private Double tenantMoney;

    /**
     * 管理费
     */
    @ApiModelProperty("管理费")
    @TableField("manage_money")
    private Double manageMoney;



    /**
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;


}
