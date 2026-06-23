package com.ruoyi.smartpart.domain.vo.workbench;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 工作台概览VO
 */
@Data
@ApiModel("工作台概览VO")
public class WorkbenchOverviewVo {

    @ApiModelProperty("本月总应收")
    private BillStatisticsVo totalBill;

    @ApiModelProperty("物业费应收")
    private BillStatisticsVo propertyBill;

    @ApiModelProperty("租金应收")
    private BillStatisticsVo rentBill;

    @ApiModelProperty("水电费应收")
    private BillStatisticsVo utilityBill;
}
