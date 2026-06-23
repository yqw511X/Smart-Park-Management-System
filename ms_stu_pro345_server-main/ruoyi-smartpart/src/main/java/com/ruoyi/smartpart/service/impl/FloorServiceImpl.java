package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ruoyi.common.constant.RoomConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.entity.Floor;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.floor.FloorCreate;
import com.ruoyi.smartpart.domain.query.floor.FloorUpdate;
import com.ruoyi.smartpart.domain.vo.Floor.FloorDetailVo;
import com.ruoyi.smartpart.mapper.FloorMapper;
import com.ruoyi.smartpart.mapper.RoomMapper;
import com.ruoyi.smartpart.mapping.FloorMapping;
import com.ruoyi.smartpart.service.FloorService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Objects;

/**
 * <p>
 * 楼层表 服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
public class FloorServiceImpl extends ServiceImpl<FloorMapper, Floor> implements FloorService {

    @Autowired
    private FloorMapper floorMapper;

    @Autowired
    private RoomMapper roomMapper;

    @Override
    public Integer addFloor(FloorCreate create) {
        //楼层唯一性校验
        LambdaQueryWrapper<Floor> lqwNum = Wrappers.lambdaQuery();
        lqwNum.eq(Floor::getBuildingId, create.getBuildingId());
        lqwNum.eq(Floor::getFloorNum, create.getFloorNum());
        if( floorMapper.selectCount(lqwNum) > 0){
            throw new ServiceException("该楼宇中,楼层‘"+create.getFloorNum()+"’已存在！");
        }
        return floorMapper.insert(FloorMapping.INSTANCE.toEntity(create));
    }

    @Override
    public Integer updateFloor(FloorUpdate update) {
        //楼层唯一性校验
        LambdaQueryWrapper<Floor> lqwNum = Wrappers.lambdaQuery();
        lqwNum.eq(Floor::getBuildingId, update.getBuildingId());
        lqwNum.eq(Floor::getFloorNum, update.getFloorNum());
        Floor floor = floorMapper.selectOne(lqwNum);
        //Long类型的比较 需要用底下的方法来完成比较合适
        if( StringUtils.isNotNull(floor) && !Objects.equals(floor.getFloorId(), update.getFloorId())){
            throw new ServiceException("该楼宇中,楼层‘"+update.getFloorNum()+"’已存在！");
        }
        return floorMapper.updateById(FloorMapping.INSTANCE.toEntity(update));
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Integer deleteFloor(List<Long> floorIds) {
        LambdaQueryWrapper<Room> checkWrapper = Wrappers.lambdaQuery();
        checkWrapper.in(Room::getFloorId, floorIds);
        checkWrapper.eq(Room::getTenantStatus, RoomConstants.RENT);
        checkWrapper.isNotNull(Room::getUserId);
        Long count = roomMapper.selectCount(checkWrapper);
        if (count > 0) {
            throw new ServiceException("该楼层下存在正在出租的房间，不能删除！");
        }
        LambdaQueryWrapper<Room> deleteRoomWrapper = Wrappers.lambdaQuery();
        deleteRoomWrapper.in(Room::getFloorId, floorIds);
        roomMapper.delete(deleteRoomWrapper);
        return floorMapper.deleteBatchIds(floorIds);
    }

    @Override
    public FloorDetailVo getFloorDetail(Long floorId) {
        LambdaQueryWrapper<Floor> lqw = Wrappers.lambdaQuery();
        lqw.eq(Floor::getFloorId, floorId);
        return FloorMapping.INSTANCE.toDetail(floorMapper.selectOne(lqw));
    }

}
