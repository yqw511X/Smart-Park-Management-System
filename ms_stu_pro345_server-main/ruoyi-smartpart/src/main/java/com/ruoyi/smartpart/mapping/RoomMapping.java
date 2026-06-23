package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.Building;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.Building.BuildingCreate;
import com.ruoyi.smartpart.domain.query.Building.BuildingUpdate;
import com.ruoyi.smartpart.domain.query.room.RoomCreate;
import com.ruoyi.smartpart.domain.query.room.RoomUpdateQuery;
import com.ruoyi.smartpart.domain.vo.room.RoomDetailVo;
import com.ruoyi.smartpart.domain.vo.room.RoomPreviewVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface RoomMapping {

    RoomMapping INSTANCE = Mappers.getMapper(RoomMapping.class);

    //转实体
    Room toEntity(RoomCreate create);

    Room toEntity(RoomUpdateQuery update);

    //转VO
    RoomDetailVo toDetailVo(Room entity);

    RoomPreviewVo toPreview(Room entity);

}
