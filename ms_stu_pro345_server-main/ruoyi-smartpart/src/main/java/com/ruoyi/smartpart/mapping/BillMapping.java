package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.vo.Bill.BillDetailVo;
import com.ruoyi.smartpart.domain.vo.workbench.BillStatisticsVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchOverviewVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface BillMapping {

    BillMapping INSTANCE = Mappers.getMapper(BillMapping.class);

    Bill toInsert(BillInsertQuery billInsertQuery);

    BillDetailVo toDetail(Bill bill);
    //租户端的查询需求对象
    TenantBillQueryById tenantBillBody(TenantBillQuery tenantBillQuery);
}
