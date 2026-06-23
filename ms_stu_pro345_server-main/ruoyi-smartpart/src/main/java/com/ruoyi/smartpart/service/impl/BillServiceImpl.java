package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.query.Bill.WorkbenchQuery;
import com.ruoyi.smartpart.domain.vo.Bill.BillListVo;
import com.ruoyi.smartpart.domain.vo.workbench.BillStatisticsVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchChartVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchOverviewVo;
import com.ruoyi.smartpart.mapper.BillMapper;
import com.ruoyi.smartpart.mapping.BillMapping;
import com.ruoyi.smartpart.service.BillService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.smartpart.utils.PageParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.time.temporal.TemporalAdjusters;
import java.util.List;
import java.util.Map;
import java.util.Arrays;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
public class BillServiceImpl extends ServiceImpl<BillMapper, Bill> implements BillService {

    @Autowired
    private BillMapper billMapper;

    @Override
    public WorkbenchOverviewVo getWorkbenchOverview() {
        String targetMonth = YearMonth.now().toString(); // 默认当前月

        List<Bill> monthBills = billMapper.selectList(new LambdaQueryWrapper<Bill>()
                .like(Bill::getPayment, targetMonth));

        WorkbenchOverviewVo overview = new WorkbenchOverviewVo();
        BillStatisticsVo totalStats = new BillStatisticsVo();
        BillStatisticsVo propertyStats = new BillStatisticsVo();
        BillStatisticsVo rentStats = new BillStatisticsVo();
        BillStatisticsVo utilityStats = new BillStatisticsVo();
        for (Bill bill : monthBills) {
            //该账单是否已收
            boolean isPaid = "1".equals(bill.getStatus());
            double totalPay = bill.getTotalPay();
            double manageFee = bill.getManageFee() != null ? bill.getManageFee() : 0.0;
            double tenantMoney = bill.getTenantMoney() != null ? bill.getTenantMoney() : 0.0;
            //总共应收
            totalStats.setTotal(totalStats.getTotal() + totalPay);
            if (isPaid) {
                totalStats.setPaid(totalStats.getPaid() + totalPay);
            } else {
                totalStats.setUnpaid(totalStats.getUnpaid() + totalPay);
            }
            //物业费
            propertyStats.setTotal(propertyStats.getTotal() + manageFee);
            if (isPaid) {
                propertyStats.setPaid(propertyStats.getPaid() + manageFee);
            } else {
                propertyStats.setUnpaid(propertyStats.getUnpaid() + manageFee);
            }
            //租金
            rentStats.setTotal(rentStats.getTotal() + tenantMoney);
            if (isPaid) {
                rentStats.setPaid(rentStats.getPaid() + tenantMoney);
            } else {
                rentStats.setUnpaid(rentStats.getUnpaid() + tenantMoney);
            }
        }
        overview.setTotalBill(totalStats);
        overview.setPropertyBill(propertyStats);
        overview.setRentBill(rentStats);
        overview.setUtilityBill(utilityStats);
        return overview;
    }

    @Override
    public int insert(BillInsertQuery billInsertQuery) {
        Bill insert = BillMapping.INSTANCE.toInsert(billInsertQuery);

        return billMapper.insert(insert);
    }

    /**
     *     使用过程中需要URL注入  swagger文档由于billquery内的时间对象不能进行时间查询
     *
     * @param pageParam
     * @param billQuery
     * @return
     */
    //分页查询功能
    @Override
    public Page<BillListVo> getPageLists(PageParam pageParam, BillQuery billQuery) {

        // 获取分页对象
        Page<BillListVo> page=new Page<>(pageParam.getPageNum(),pageParam.getPageSize());


        //获取构造器对象
        QueryWrapper<Bill> qw = Wrappers.query();

        qw.like(StringUtils.isNotEmpty(billQuery.getNickName()),"t2.nick_name",
                billQuery.getNickName());
        qw.like(StringUtils.isNotEmpty(billQuery.getContractNum()),"t3.contract_num",
                billQuery.getContractNum());
        YearMonth contractYearMonth = billQuery.getContractYearMonth();

        LocalDateTime startTime = null;
        LocalDateTime endTime = null;
        if (contractYearMonth!=null){

            startTime = contractYearMonth.atDay(1).atStartOfDay(); // LocalDateTime: 2026-02-01T00:00
            // 获取年月的最后一天 23:59:59
            endTime = contractYearMonth.atEndOfMonth().atTime(LocalTime.MAX); // LocalDateTime: 2026-02-28T23:59/ 转换为 LocalDateTime，时间部分为 23:59:59.999999999

            // 3. 构建 QueryWrapper 查询条件
            qw.ge("t2.create_time", startTime) // time >= 2026-02-01 00:00:00
                    .lt("t2.create_time", endTime.plusNanos(1)); // time < 2026-02-28 23:59:59.000000001 (或者使用 le(endTime))
        }

        qw.eq(StringUtils.isNotEmpty(billQuery.getStatus()),"t1.status",
                billQuery.getStatus());
        qw.eq(StringUtils.isNotEmpty(billQuery.getOverdue()),"t1.overdue",
                billQuery.getOverdue());
        qw.eq("t1.del_flag","0");
        return billMapper.getPageLists(page, qw);
    }

    @Override
    public WorkbenchChartVo getReceivableChart(WorkbenchQuery query) {
        // 按“本月”返回每日统计；否则默认“本年”返回每月统计
        if (query != null && StringUtils.isNotEmpty(query.getMonth())) {
            String month = query.getMonth(); // 格式 yyyy-MM
            YearMonth ym = YearMonth.parse(month);
            int days = ym.lengthOfMonth();
            List<String> dayLabels = new ArrayList<>();
            for (int d = 1; d <= days; d++) {
                dayLabels.add(String.format("%02d", d));
            }
            List<Bill> bills = billMapper.selectList(new LambdaQueryWrapper<Bill>().like(Bill::getPayment, month));
            List<Double> values = new ArrayList<>();
            for (int d = 1; d <= days; d++) {
                String prefix = month + "-" + String.format("%02d", d);
                double sum = 0.0;
                for (Bill b : bills) {
                    LocalDateTime deadline = b.getDeadline();
                    if (deadline != null && deadline.toString().substring(0,10).equals(prefix)) {
                        sum += b.getTotalPay();
                    }
                }
                values.add(sum);
            }
            WorkbenchChartVo vo = new WorkbenchChartVo();
            vo.setMonths(dayLabels);
            vo.setValues(values);
            return vo;
        } else {
            String year = (query != null && StringUtils.isNotEmpty(query.getYear())) ? query.getYear() : String.valueOf(YearMonth.now().getYear());
            List<Bill> bills = billMapper.selectList(new LambdaQueryWrapper<Bill>().like(Bill::getPayment, year));
            List<String> months = Arrays.asList("01","02","03","04","05","06","07","08","09","10","11","12");
            List<Double> values = new ArrayList<>();
            for (String m : months) {
                double sum = 0.0;
                for (Bill b : bills) {
                    String p = b.getPayment();
                    if (StringUtils.isNotEmpty(p) && p.length() >= 7 && p.substring(0,7).equals(year + "-" + m)) {
                        sum += b.getTotalPay();
                    }
                }
                values.add(sum);
            }
            WorkbenchChartVo vo = new WorkbenchChartVo();
            vo.setMonths(months);
            vo.setValues(values);
            return vo;
        }
    }

    @Override
    public WorkbenchChartVo getPaidChart(WorkbenchQuery query) {
        if (query != null && StringUtils.isNotEmpty(query.getMonth())) {
            String month = query.getMonth(); // yyyy-MM
            YearMonth ym = YearMonth.parse(month);
            int days = ym.lengthOfMonth();
            List<String> dayLabels = new ArrayList<>();
            for (int d = 1; d <= days; d++) {
                dayLabels.add(String.format("%02d", d));
            }
            List<Bill> bills = billMapper.selectList(new LambdaQueryWrapper<Bill>().like(Bill::getPayment, month));
            List<Double> values = new ArrayList<>();
            for (int d = 1; d <= days; d++) {
                String prefix = month + "-" + String.format("%02d", d);
                double sum = 0.0;
                for (Bill b : bills) {
                    LocalDateTime deadline = b.getDeadline();
                    if (deadline != null && deadline.toString().substring(0,10).equals(prefix) && "1".equals(b.getStatus())) {
                        sum += b.getTotalPay();
                    }
                }
                values.add(sum);
            }
            WorkbenchChartVo vo = new WorkbenchChartVo();
            vo.setMonths(dayLabels);
            vo.setValues(values);
            return vo;
        } else {
            String year = (query != null && StringUtils.isNotEmpty(query.getYear())) ? query.getYear() : String.valueOf(YearMonth.now().getYear());
            List<Bill> bills = billMapper.selectList(new LambdaQueryWrapper<Bill>().like(Bill::getPayment, year));
            List<String> months = Arrays.asList("01","02","03","04","05","06","07","08","09","10","11","12");
            List<Double> values = new ArrayList<>();
            for (String m : months) {
                double sum = 0.0;
                for (Bill b : bills) {
                    String p = b.getPayment();
                    if (StringUtils.isNotEmpty(p) && p.length() >= 7 && p.substring(0,7).equals(year + "-" + m) && "1".equals(b.getStatus())) {
                        sum += b.getTotalPay();
                    }
                }
                values.add(sum);
            }
            WorkbenchChartVo vo = new WorkbenchChartVo();
            vo.setMonths(months);
            vo.setValues(values);
            return vo;
        }
    }

    @Override
    public WorkbenchChartVo getUnpaidChart(WorkbenchQuery query) {
        if (query != null && StringUtils.isNotEmpty(query.getMonth())) {
            String month = query.getMonth(); // yyyy-MM
            YearMonth ym = YearMonth.parse(month);
            int days = ym.lengthOfMonth();
            List<String> dayLabels = new ArrayList<>();
            for (int d = 1; d <= days; d++) {
                dayLabels.add(String.format("%02d", d));
            }
            List<Bill> bills = billMapper.selectList(new LambdaQueryWrapper<Bill>().like(Bill::getPayment, month));
            List<Double> values = new ArrayList<>();
            for (int d = 1; d <= days; d++) {
                String prefix = month + "-" + String.format("%02d", d);
                double sum = 0.0;
                for (Bill b : bills) {
                    LocalDateTime deadline = b.getDeadline();
                    if (deadline != null && deadline.toString().substring(0,10).equals(prefix) && !"1".equals(b.getStatus())) {
                        sum += b.getTotalPay();
                    }
                }
                values.add(sum);
            }
            WorkbenchChartVo vo = new WorkbenchChartVo();
            vo.setMonths(dayLabels);
            vo.setValues(values);
            return vo;
        } else {
            String year = (query != null && StringUtils.isNotEmpty(query.getYear())) ? query.getYear() : String.valueOf(YearMonth.now().getYear());
            List<Bill> bills = billMapper.selectList(new LambdaQueryWrapper<Bill>().like(Bill::getPayment, year));
            List<String> months = Arrays.asList("01","02","03","04","05","06","07","08","09","10","11","12");
            List<Double> values = new ArrayList<>();
            for (String m : months) {
                double sum = 0.0;
                for (Bill b : bills) {
                    String p = b.getPayment();
                    if (StringUtils.isNotEmpty(p) && p.length() >= 7 && p.substring(0,7).equals(year + "-" + m) && !"1".equals(b.getStatus())) {
                        sum += b.getTotalPay();
                    }
                }
                values.add(sum);
            }
            WorkbenchChartVo vo = new WorkbenchChartVo();
            vo.setMonths(months);
            vo.setValues(values);
            return vo;
        }
    }


    //    租户端下的账单查询
    @Override
    public Page<BillListVo> getPageListsByTenantId(PageParam pageParam, TenantBillQueryById billQuery) {
        // 获取分页对象
        Page<BillListVo> page=new Page<>(pageParam.getPageNum(),pageParam.getPageSize());


        //获取构造器对象
        QueryWrapper<Bill> qw = Wrappers.query();


        qw.like(StringUtils.isNotEmpty(billQuery.getContractNum()),"t3.contract_num",
                billQuery.getContractNum());
        YearMonth contractYearMonth = billQuery.getContractYearMonth();

        LocalDateTime startTime = null;
        LocalDateTime endTime = null;
        if (contractYearMonth!=null){

            startTime = contractYearMonth.atDay(1).atStartOfDay(); // LocalDateTime: 2026-02-01T00:00
            // 获取年月的最后一天 23:59:59
            endTime = contractYearMonth.atEndOfMonth().atTime(LocalTime.MAX); // LocalDateTime: 2026-02-28T23:59/ 转换为 LocalDateTime，时间部分为 23:59:59.999999999

            // 3. 构建 QueryWrapper 查询条件
            qw.ge("t2.create_time", startTime) // time >= 2026-02-01 00:00:00
                    .lt("t2.create_time", endTime.plusNanos(1)); // time < 2026-02-28 23:59:59.000000001 (或者使用 le(endTime))
        }

        qw.eq(StringUtils.isNotEmpty(billQuery.getStatus()),"t1.status",
                billQuery.getStatus());
        qw.eq(StringUtils.isNotEmpty(billQuery.getOverdue()),"t1.overdue",
                billQuery.getOverdue());
        qw.eq("t2.user_id", billQuery.getTenantId());

        return billMapper.getPageLists(page, qw);
    }


}
