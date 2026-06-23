package com.ruoyi.smartpart.domain.vo.workbench;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 账单统计VO
 */
@Data
@ApiModel("账单统计VO")
public class BillStatisticsVo {

    @ApiModelProperty("总额")
    private Double total = 0.0;

    @ApiModelProperty("已收")
    private Double paid = 0.0;

    @ApiModelProperty("未收")
    private Double unpaid = 0.0;
}
