package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ruoyi.common.constant.RepairOrderConstants;
import com.ruoyi.smartpart.domain.entity.RepairLog;
import com.ruoyi.smartpart.domain.entity.RepairOrder;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairLogProVo;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairStatusLog;
import com.ruoyi.smartpart.mapper.RepairLogMapper;
import com.ruoyi.smartpart.mapping.RepairLogMapping;
import com.ruoyi.smartpart.service.RepairLogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.smartpart.service.RepairOrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-02-09
 */
@Service
public class RepairLogServiceImpl extends ServiceImpl<RepairLogMapper, RepairLog> implements RepairLogService {

    @Autowired
    private RepairLogMapper repairLogMapper;

    @Autowired
    private RepairOrderService repairOrderService;

    @Override
    public RepairStatusLog selectList(Long repairOrderId) {
        RepairStatusLog statusLog = new RepairStatusLog();
        //获取维修单
        statusLog.setFinalStatus(repairOrderService.getById(repairOrderId).getStatus());
        //获取维修日志
        LambdaQueryWrapper<RepairLog> lqw = Wrappers.lambdaQuery();
        lqw.eq(RepairLog::getRepairOrderId, repairOrderId)
            .orderByAsc(RepairLog::getStatus);
        //根据状态设置操作人员
        List<RepairLog> repairLogs = repairLogMapper.selectList(lqw);
        for (RepairLog log : repairLogs){
            if (log.getStatus().equals(RepairOrderConstants.PENDING_PROCESS)){
                log.setHuman(log.getRepairName());
            }
        }
        statusLog.setOptionList(RepairLogMapping.INSTANCE.toLog(repairLogs));
        return statusLog;
    }
}
