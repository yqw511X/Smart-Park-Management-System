package com.ruoyi.smartpart.service;

import com.ruoyi.smartpart.domain.entity.RoomRecord;
import com.baomidou.mybatisplus.extension.service.IService;

import java.time.LocalDateTime;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface RoomRecordService extends IService<RoomRecord> {

    /**
     * 创建租房记录
     *
     * @param roomId 房间ID
     * @param tenantId 租户ID
     * @param contractId 合同ID
     * @param time 入住时间
     * @return 是否创建成功
     */
    boolean createRoomRecord(Long roomId, Long tenantId, Long contractId, LocalDateTime time);

}
