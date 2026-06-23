package com.ruoyi.smartpart.mapping;

import com.ruoyi.smartpart.domain.entity.Building;
import com.ruoyi.smartpart.domain.query.Building.BuildingCreate;
import com.ruoyi.smartpart.domain.query.Building.BuildingUpdate;
import com.ruoyi.smartpart.domain.vo.Building.BuildingDetailVo;
import com.ruoyi.smartpart.domain.vo.Building.BuildingNameListVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

import java.util.List;

@Mapper
public interface BuildingMapping {

    BuildingMapping INSTANCE = Mappers.getMapper(BuildingMapping.class);

    //转实体
    Building toEntity(BuildingCreate create);

    //转实体
    Building toEntity(BuildingUpdate update);

    //转详情
    BuildingDetailVo toDetail(Building building);

    //转名称列表
    List<BuildingNameListVo> toNameList(List<Building> buildings);
}
