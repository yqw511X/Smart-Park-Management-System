package com.ruoyi.smartpart.domain.vo.workbench;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel("工作台图表VO")
public class WorkbenchChartVo {

    @ApiModelProperty("月份列表，格式: 01-12")
    private List<String> months;

    @ApiModelProperty("对应月份的数值列表")
    private List<Double> values;
}
