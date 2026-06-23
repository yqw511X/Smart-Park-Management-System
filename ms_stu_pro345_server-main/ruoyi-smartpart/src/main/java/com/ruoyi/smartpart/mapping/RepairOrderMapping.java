package com.ruoyi.smartpart.mapping;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.entity.RepairOrder;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.vo.Bill.BillDetailVo;
import com.ruoyi.smartpart.domain.vo.repairorder.RepairManOrderListVo;
import com.ruoyi.smartpart.domain.vo.repairorder.RepairOrderDtlVo;
import com.ruoyi.smartpart.domain.vo.workbench.BillStatisticsVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchOverviewVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface RepairOrderMapping {

    RepairOrderMapping INSTANCE = Mappers.getMapper(RepairOrderMapping.class);

    //维修单转维修详情(这里要用 . 表示是谁的属性)
    @Mapping(source = "order.repairNum",target = "repairOrderNum")
    @Mapping(source = "order.remark",target = "remark")
    RepairOrderDtlVo toOrderVo(Room room,RepairOrder order);

    //转维修工订单列表
    Page<RepairManOrderListVo> toPage(Page<RepairOrder> orderPage);


}
