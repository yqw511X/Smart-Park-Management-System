package com.ruoyi.smartpart.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.query.Bill.WorkbenchQuery;
import com.ruoyi.smartpart.domain.vo.Bill.BillListVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchChartVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchOverviewVo;
import com.ruoyi.smartpart.utils.PageParam;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface BillService extends IService<Bill> {

    int insert(BillInsertQuery billInsertQuery);

    Page<BillListVo> getPageLists(PageParam pageParam, BillQuery billQuery);
    Page<BillListVo> getPageListsByTenantId(PageParam pageParam, TenantBillQueryById billQuery);

    //获取本月份各类收款信息
    WorkbenchOverviewVo getWorkbenchOverview();

    // 工作台图表：应收款
    WorkbenchChartVo getReceivableChart(WorkbenchQuery query);
    // 工作台图表：已收款
    WorkbenchChartVo getPaidChart(WorkbenchQuery query);
    // 工作台图表：未收款
    WorkbenchChartVo getUnpaidChart(WorkbenchQuery query);
}
