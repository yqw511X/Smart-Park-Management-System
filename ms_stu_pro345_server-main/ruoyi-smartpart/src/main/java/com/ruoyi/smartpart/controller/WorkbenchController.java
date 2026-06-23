package com.ruoyi.smartpart.controller;

import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.smartpart.domain.query.Bill.WorkbenchQuery;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchChartVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchOverviewVo;
import com.ruoyi.smartpart.service.BillService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 工作台相关接口
 */
@Api(tags = "管理端-工作台相关接口")
@RestController
@RequestMapping("/workbench")
public class WorkbenchController extends BaseController {

    @Autowired
    private BillService billService;

    @ApiOperation("获取数据概览")
    @GetMapping("/overview")
    public R<WorkbenchOverviewVo> getOverview() {
        return R.ok(billService.getWorkbenchOverview());
    }

    @ApiOperation("图表-应收款")
    @GetMapping("/chart/receivable")
    public R<WorkbenchChartVo> receivableChart(WorkbenchQuery query) {
        return R.ok(billService.getReceivableChart(query));
    }

    @ApiOperation("图表-已收款")
    @GetMapping("/chart/paid")
    public R<WorkbenchChartVo> paidChart(WorkbenchQuery query) {
        return R.ok(billService.getPaidChart(query));
    }

    @ApiOperation("图表-未收款")
    @GetMapping("/chart/unpaid")
    public R<WorkbenchChartVo> unpaidChart(WorkbenchQuery query) {
        return R.ok(billService.getUnpaidChart(query));
    }
}
