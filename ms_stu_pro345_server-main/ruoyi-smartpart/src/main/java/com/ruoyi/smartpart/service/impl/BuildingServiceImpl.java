package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.entity.Building;
import com.ruoyi.smartpart.domain.entity.Floor;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.Building.BuildingCreate;
import com.ruoyi.smartpart.domain.query.Building.BuildingUpdate;
import com.ruoyi.smartpart.domain.vo.Building.BuildingDetailVo;
import com.ruoyi.smartpart.domain.vo.Building.BuildingNameListVo;
import com.ruoyi.smartpart.mapper.BuildingMapper;
import com.ruoyi.smartpart.mapper.FloorMapper;
import com.ruoyi.smartpart.mapper.RoomMapper;
import com.ruoyi.smartpart.mapping.BuildingMapping;
import com.ruoyi.smartpart.service.BuildingService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 楼宇表 服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
public class BuildingServiceImpl extends ServiceImpl<BuildingMapper, Building> implements BuildingService {

    @Autowired
    private BuildingMapper buildingMapper;

    @Autowired
    private RoomMapper roomMapper;

    @Autowired
    private FloorMapper floorMapper;

    @Override
    public Integer addBuilding(BuildingCreate create) {
        //名称唯一性校验
        LambdaQueryWrapper<Building> lqw = Wrappers.lambdaQuery();
        lqw.eq(Building::getBuildingName, create.getBuildingName());
        if(buildingMapper.selectCount(lqw) > 0){
            throw new ServiceException("该楼宇已存在，请勿重复添加！");
        }

        Building entity = BuildingMapping.INSTANCE.toEntity(create);
        //园区暂时写死在后端里面
        entity.setParkName("翻斗花园");
        return buildingMapper.insert(entity);
    }

    @Override
    public Integer updateBuilding(BuildingUpdate update) {
        //名称唯一性校验
        LambdaQueryWrapper<Building> lqw = Wrappers.lambdaQuery();
        lqw.eq(Building::getBuildingName, update.getBuildingName());
        Building exit = buildingMapper.selectOne(lqw);
        //Long类型推荐校验方法 允许保持内容不修改
        if( StringUtils.isNotNull(exit) && !Objects.equals(exit.getBuildingId(), update.getBuildingId())){
            throw new ServiceException(update.getBuildingName()+" 已存在！");
        }
        //更新
        Building entity = BuildingMapping.INSTANCE.toEntity(update);
        return buildingMapper.updateById(entity);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public Integer deleteBuilding(List<Long> buildIds) {
        for (Long buildId : buildIds) {
            // 1. 校验该楼宇下是否有房间在租（userId不为空且tenantStatus为1）
            LambdaQueryWrapper<Room> roomCheckWrapper = Wrappers.lambdaQuery();
            roomCheckWrapper.eq(Room::getBuildingId, buildId)
                            .isNotNull(Room::getUserId)
                            .eq(Room::getTenantStatus, "1");
            Long rentedCount = roomMapper.selectCount(roomCheckWrapper);
            if (rentedCount > 0) {
                throw new ServiceException("楼宇ID为" + buildId + "的楼宇下有房间正在租赁中，无法删除！");
            }
        }

        // 2. 批量删除房间
        LambdaQueryWrapper<Room> roomDeleteWrapper = Wrappers.lambdaQuery();
        roomDeleteWrapper.in(Room::getBuildingId, buildIds);
        roomMapper.delete(roomDeleteWrapper);

        // 3. 批量删除楼层
        LambdaQueryWrapper<Floor> floorDeleteWrapper = Wrappers.lambdaQuery();
        floorDeleteWrapper.in(Floor::getBuildingId, buildIds);
        floorMapper.delete(floorDeleteWrapper);

        // 4. 删除楼宇
        return buildingMapper.deleteBatchIds(buildIds);
    }

    @Override
    public BuildingDetailVo getDetail(Long buildId) {
        LambdaQueryWrapper<Building> lqw = Wrappers.lambdaQuery();
        lqw.eq(Building::getBuildingId, buildId);
        return BuildingMapping.INSTANCE.toDetail(buildingMapper.selectOne(lqw));
    }

    @Override
    public List<BuildingNameListVo> getNameList() {
        return BuildingMapping.INSTANCE.toNameList(buildingMapper.selectList(null));
    }
}
