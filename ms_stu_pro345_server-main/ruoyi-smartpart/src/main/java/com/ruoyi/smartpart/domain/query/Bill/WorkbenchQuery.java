package com.ruoyi.smartpart.domain.query.Bill;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 工作台查询
 */
@Data
@ApiModel("工作台查询")
public class WorkbenchQuery {

    @ApiModelProperty(value = "月份", example = "2026-02")
    private String month;

    @ApiModelProperty(value = "年份", example = "2026")
    private String year;
}
