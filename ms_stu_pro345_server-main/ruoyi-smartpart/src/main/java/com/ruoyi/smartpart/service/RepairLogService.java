package com.ruoyi.smartpart.service;

import com.ruoyi.smartpart.domain.entity.RepairLog;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairLogProVo;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairStatusLog;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-02-09
 */
public interface RepairLogService extends IService<RepairLog> {

    RepairStatusLog selectList(Long repairOrderId);
}
