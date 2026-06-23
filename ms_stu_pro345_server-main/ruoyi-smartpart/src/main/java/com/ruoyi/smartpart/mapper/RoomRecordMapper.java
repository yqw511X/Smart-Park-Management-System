package com.ruoyi.smartpart.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.ruoyi.smartpart.domain.entity.RoomRecord;
import com.ruoyi.smartpart.domain.vo.room.RoomRecordVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface RoomRecordMapper extends BaseMapper<RoomRecord> {

    /**
     * 查询房间租赁记录
     * @param roomId 房间ID
     * @return 租赁记录列表
     */
    List<RoomRecordVo> selectRoomRecordList(@Param("roomId") Long roomId);

}
