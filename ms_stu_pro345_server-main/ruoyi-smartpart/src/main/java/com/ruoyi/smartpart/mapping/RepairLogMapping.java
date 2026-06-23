package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.RepairLog;
import com.ruoyi.smartpart.domain.entity.RepairOrder;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairLogProVo;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairStatusLog;
import com.ruoyi.smartpart.domain.vo.repairorder.RepairOrderDtlVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface RepairLogMapping {

    RepairLogMapping INSTANCE = Mappers.getMapper(RepairLogMapping.class);

    //转状态列表
    List<RepairLogProVo> toLog(List<RepairLog> repairLogs);


}
