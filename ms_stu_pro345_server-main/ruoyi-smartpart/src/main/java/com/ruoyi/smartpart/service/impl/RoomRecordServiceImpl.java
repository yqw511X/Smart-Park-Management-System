package com.ruoyi.smartpart.service.impl;

import com.ruoyi.common.constant.RoomConstants;
import com.ruoyi.smartpart.domain.entity.RoomRecord;
import com.ruoyi.smartpart.mapper.RoomRecordMapper;
import com.ruoyi.smartpart.service.RoomRecordService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
public class RoomRecordServiceImpl extends ServiceImpl<RoomRecordMapper, RoomRecord> implements RoomRecordService {

    @Override
    public boolean createRoomRecord(Long roomId, Long tenantId, Long contractId, LocalDateTime time) {
        RoomRecord roomRecord = new RoomRecord();
        roomRecord.setRoomId(roomId);
        roomRecord.setTenantId(tenantId);
        roomRecord.setContractId(contractId);
        roomRecord.setTime(time);
        roomRecord.setStatus(RoomConstants.RENT);
        return save(roomRecord);
    }
}
