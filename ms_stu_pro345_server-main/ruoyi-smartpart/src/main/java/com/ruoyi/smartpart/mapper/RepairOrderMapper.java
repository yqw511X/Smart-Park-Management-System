package com.ruoyi.smartpart.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.RepairOrder;
import com.ruoyi.smartpart.domain.query.repairorder.RepairOrderQuery;
import com.ruoyi.smartpart.domain.vo.repairorder.RepairManOrderListVo;
import com.ruoyi.smartpart.domain.vo.repairorder.RepairOrderPageVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 维修单 Mapper 接口
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface RepairOrderMapper extends BaseMapper<RepairOrder> {

    List<RepairOrder> selectListRepairOrder(@Param("repairNum") String repairNum, @Param("status") String status);

}
