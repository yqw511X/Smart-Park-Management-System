package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.Building;
import com.ruoyi.smartpart.domain.entity.Floor;
import com.ruoyi.smartpart.domain.query.Building.BuildingCreate;
import com.ruoyi.smartpart.domain.query.Building.BuildingUpdate;
import com.ruoyi.smartpart.domain.query.floor.FloorCreate;
import com.ruoyi.smartpart.domain.query.floor.FloorUpdate;
import com.ruoyi.smartpart.domain.vo.Floor.FloorDetailVo;
import com.ruoyi.smartpart.domain.vo.Floor.FloorListVo;
import com.ruoyi.smartpart.domain.vo.Floor.FloorNameListVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface FloorMapping {

    FloorMapping INSTANCE = Mappers.getMapper(FloorMapping.class);

    //转列表
    List<FloorListVo> toListVo(List<Floor> floors);

    //转实体
    Floor toEntity(FloorCreate create);

    //转实体
    Floor toEntity(FloorUpdate update);

    //转详情
    FloorDetailVo toDetail(Floor floor);

    //转名称列表
    List<FloorNameListVo> toNameList(List<Floor> floors);
}
