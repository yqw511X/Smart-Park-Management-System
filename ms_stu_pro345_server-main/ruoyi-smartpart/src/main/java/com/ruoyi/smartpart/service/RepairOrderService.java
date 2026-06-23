package com.ruoyi.smartpart.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.create.RepairOrderCreate;
import com.ruoyi.smartpart.domain.entity.RepairOrder;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.query.repairorder.*;
import com.ruoyi.smartpart.domain.vo.repairorder.*;
import com.ruoyi.smartpart.utils.PageParam;
import org.springframework.validation.annotation.Validated;

import java.util.List;

/**
 * <p>
 * 维修单 服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface RepairOrderService extends IService<RepairOrder> {

    List<RepairOrder> selectList(String repairNum, String status);

    int insertRenterOrder(RepairOrderCreate repairOrder);

    int updateRepairOrder(RepairManCreate repairManCreate);

    int updateRepairOrderStatus(RepairOrderStatusUpdate statusUpdate);

    int deleteRepairOrderByIds(Long[] repairOrderIds);

    RepairOrderDtlVo getRepairOrderDtlVo(Long repairOrderId);

    List<RepairLogMeVo> selectRepairList(Long repairOrderId);

    List<RepairOrderPageVo> selectRepairTenant(RepairOrderTenantQuery repairOrderQuery);

    int updateRepairOrderTenant(RepairOrderUpdate repairOrderUpdate);

    RepairOrderReDtlVo getRepairOrderReDtlVo(Long repairOrderId);
    RepairOrderMeQuery selectRepairListWorker(Long repairOrderId);

    /**
     * 获取分页对象
     * @param repairOrderQuery 查询参数
     * @param pageParam 分页参数
     * @return 维修单列表
     */
    Page<RepairManOrderListVo> getOrderManPage(RepairOrderQuery repairOrderQuery,PageParam pageParam);
}
