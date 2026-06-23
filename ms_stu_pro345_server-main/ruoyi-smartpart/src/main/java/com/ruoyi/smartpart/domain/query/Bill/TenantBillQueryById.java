package com.ruoyi.smartpart.domain.query.Bill;

import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.YearMonth;


@Data
@ApiModel(value = "Bill查询对象", description = "查询")
public class TenantBillQueryById {




    /**
     * 租户id
     */
    @TableField("tenant_id")
    @ApiModelProperty("租户id")
    private Long tenantId;


    /**
     * 合同编号
     */
    @ApiModelProperty("合同编号")
    @TableField("contract_num")
    private String contractNum;

    /**
     * 创建时间
     */
    @ApiModelProperty("账单月份开始时间 (格式: yyyy-MM-dd, 例如: 2026-02-01)")
    @DateTimeFormat(pattern = "yyyy-MM-dd") // 修改 pattern
    @JsonFormat(pattern = "yyyy-MM-dd")     // 修改 pattern
    private YearMonth  contractYearMonth;

    /**
     * 状态(0未收款,1已收款)
     */
    @TableField("status")
    @ApiModelProperty("状态(0未收款,1已收款)")
    private String status;


    /**
     * 是否逾期
     */
    @TableField("overdue")
    @ApiModelProperty("逾期(0 为未逾期 ，1 逾期)")
    private String overdue;








}
