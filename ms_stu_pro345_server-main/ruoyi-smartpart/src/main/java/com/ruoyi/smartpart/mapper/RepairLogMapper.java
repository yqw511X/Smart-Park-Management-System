package com.ruoyi.smartpart.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.smartpart.domain.entity.RepairLog;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairLogProVo;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 345项目团队
 * @since 2026-02-09
 */
public interface RepairLogMapper extends BaseMapper<RepairLog> {

    List<RepairLogProVo> selectProList(Long repairOrderId);
}
