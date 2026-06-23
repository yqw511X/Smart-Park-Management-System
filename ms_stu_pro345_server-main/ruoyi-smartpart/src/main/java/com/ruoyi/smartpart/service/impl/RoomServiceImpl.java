package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.constant.RoomApplicationConstants;
import com.ruoyi.common.constant.RoomConstants;
import com.ruoyi.common.constant.RoomUserConstants;
import com.ruoyi.common.constant.SqlConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.smartpart.domain.entity.Building;
import com.ruoyi.smartpart.domain.entity.Floor;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.room.*;
import com.ruoyi.smartpart.domain.vo.room.*;
import com.ruoyi.smartpart.mapper.BuildingMapper;
import com.ruoyi.smartpart.mapper.RoomMapper;
import com.ruoyi.smartpart.mapper.RoomRecordMapper;
import com.ruoyi.smartpart.domain.entity.TenantApplication;
import com.ruoyi.smartpart.mapper.TenantApplicationMapper;
import com.ruoyi.smartpart.mapping.RoomMapping;
import com.ruoyi.smartpart.mapping.SysUserMapping;
import com.ruoyi.smartpart.service.FloorService;
import com.ruoyi.smartpart.service.RoomService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.smartpart.service.TenantApplicationService;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.system.service.ISysUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
public class RoomServiceImpl extends ServiceImpl<RoomMapper, Room> implements RoomService {

    @Autowired
    private RoomMapper roomMapper;

    @Autowired
    private BuildingMapper buildingMapper;

    @Autowired
    private RoomRecordMapper roomRecordMapper;

    @Autowired
    private TenantApplicationMapper tenantApplicationMapper;

    @Autowired
    private ISysUserService userService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private TenantApplicationService tenantApplicationService;

    @Autowired
    private FloorService floorService;

    @Override
    public Page<RoomListVo> getPageList(RoomQuery query, PageParam pageParam) {
        //条件构造器对象
        QueryWrapper<RoomListVo> qw = Wrappers.query();
        qw.eq("r.del_flag", SqlConstants.EXIST);
        qw.like(StringUtils.isNotNull(query.getRoomName()), "r.room_name",
                query.getRoomName());
        qw.like(StringUtils.isNotNull(query.getBuildingName()), "b.building_name",
                query.getBuildingName());
        qw.eq(StringUtils.isNotNull(query.getTenantStatus()), "r.tenant_status",
                query.getTenantStatus());
        qw.orderByDesc("r.create_time");

        //分页构造器对象
        Page<RoomListVo> page = new Page<>(pageParam.getPageNum(),pageParam.getPageSize());

        //上架状态改为boolean值
        Page<RoomListVo> pageList = roomMapper.getPageList(qw, page);
        for(RoomListVo room : pageList.getRecords()){
            room.setStatus( room.getShelveStatus().equals(RoomConstants.SHELVES) );
        }
        return pageList;
    }

    @Override
    public Page<HomeRoomVo> getHomeRoomList(HomeRoomQuery query, PageParam pageParam) {
        // 条件构造器
        QueryWrapper<HomeRoomVo> qw = Wrappers.query();
        qw.eq("r.del_flag", SqlConstants.EXIST);
        // 只查询已上架的房间
        qw.eq("r.status", RoomConstants.SHELVES);
        // 只查询未租房间
        qw.eq("r.tenant_status", RoomConstants.NO_RENT);

        // 搜索条件
        qw.like(StringUtils.isNotEmpty(query.getRoomName()), "r.room_name", query.getRoomName());
        qw.like(StringUtils.isNotEmpty(query.getBuildingName()), "b.building_name", query.getBuildingName());
        qw.like(StringUtils.isNotEmpty(query.getParkName()), "r.park_name", query.getParkName());

        qw.orderByDesc("r.create_time");

        // 分页对象
        Page<HomeRoomVo> page = new Page<>(pageParam.getPageNum(), pageParam.getPageSize());

        return roomMapper.getHomeRoomList(qw, page);
    }

    @Override
    public TenantInfoVo getTenantInfo() {
        Long userId = SecurityUtils.getUserId();
        SysUser user = userService.selectUserById(userId);
        if (user == null) {
            throw new ServiceException("用户不存在");
        }
        TenantInfoVo info = SysUserMapping.INSTANCE.toInfo(user);
        //1、是否在租  2、未租是否有申请
        if( roomService.isUserHaveRoom(userId)){
            info.setRoomStatus(RoomUserConstants.HAS_ROOM);
        }else if ( tenantApplicationService.hasUnPassApplication(userId)){
            info.setRoomStatus(RoomUserConstants.HAS_APPLICATION);
        }else {
            info.setRoomStatus(RoomUserConstants.NO_ROOM);
        }

        return info;
    }

    @Override
    public Page<MyRoomVo> getMyRoomList(MyRoomQuery query, PageParam pageParam) {
        // 条件构造器
        QueryWrapper<MyRoomVo> qw = Wrappers.query();
        // 只能查询自己的申请记录
        qw.eq("ta.tenant_id", SecurityUtils.getUserId());
        // 只查询已上架的房间
        qw.eq("r.status", RoomConstants.SHELVES);
        // 排除已取消的申请 (状态为 3)
        qw.ne("ta.status", RoomApplicationConstants.CANCELLED);

        // 搜索条件
        qw.like(StringUtils.isNotNull(query.getRoomName()), "r.room_name", query.getRoomName());
        qw.like(StringUtils.isNotNull(query.getBuildingName()), "b.building_name", query.getBuildingName());
        qw.like(StringUtils.isNotNull(query.getParkName()), "r.park_name", query.getParkName());

        qw.orderByDesc("ta.apply_time");
        qw.eq("ta.del_flag", SqlConstants.EXIST);

        // 分页对象
        Page<MyRoomVo> page = new Page<>(pageParam.getPageNum(), pageParam.getPageSize());

        Page<MyRoomVo> resultPage = roomMapper.getMyRoomList(qw, page);

        return resultPage;
    }

    @Override
    public Page<RoomByContractListVo> getRoomByContract(PageParam pageParam, RoomQueryByContract roomQueryByContract) {
        // 分页对象
        Page<RoomByContractListVo> page = new Page<>(pageParam.getPageNum(), pageParam.getPageSize());

        // 条件构造器
        QueryWrapper<RoomByContractListVo> qw = Wrappers.query();
        // 搜索条件
        qw.like(StringUtils.isNotNull(roomQueryByContract.getRoomName()), "r.room_name", roomQueryByContract.getRoomName());
        qw.like(StringUtils.isNotNull(roomQueryByContract.getBuildingName()), "b.building_name", roomQueryByContract.getBuildingName());

        return roomMapper.getRoomByContract(page,qw);


    }

    @Override
    public Integer createRoom(RoomCreate create) {
        //同楼宇中不能出现同名房间
        LambdaQueryWrapper<Room> roomLqw = Wrappers.lambdaQuery();
        roomLqw.eq(Room::getRoomName, create.getRoomName());
        roomLqw.eq(Room::getBuildingId, create.getBuildingId());
        if(roomMapper.selectCount(roomLqw) > 0){
            throw new ServiceException("同楼宇房间："+create.getRoomName()+"已存在！");
        }

        //根据楼宇id查询所属园区ToDo：校验楼层和楼宇是否一致
        LambdaQueryWrapper<Building> lqw = Wrappers.lambdaQuery();
        lqw.eq(Building::getBuildingId, create.getBuildingId());
        lqw.select(Building::getParkName);
        String parkName = buildingMapper.selectOne(lqw).getParkName();

        //Room实体
        Room newRoom = RoomMapping.INSTANCE.toEntity(create);
        newRoom.setParkName(parkName);

        return roomMapper.insert(newRoom);
    }

    @Override
    public RoomDetailVo getRoomInfo(Long roomId) {
        Room room = roomMapper.selectById(roomId);
        Floor floor = floorService.getById(room.getFloorId());
        RoomDetailVo detailVo = RoomMapping.INSTANCE.toDetailVo(room);
        //设置楼层名称
        if ( StringUtils.isNotNull(floor)){
            detailVo.setFloorName(floor.getFloorName());
        }
        return detailVo;
    }

    @Override
    public Integer updateRoom(RoomUpdateQuery update) {
        // 房间名称唯一性校验
        LambdaQueryWrapper<Room> lqw = Wrappers.lambdaQuery();
        lqw.eq(Room::getRoomName, update.getRoomName());
        lqw.eq(Room::getBuildingId, update.getBuildingId()); // 同一楼宇下名称唯一
        Room exist = roomMapper.selectOne(lqw);

        if (StringUtils.isNotNull(exist) && !Objects.equals(exist.getRoomId(), update.getRoomId())) {
            throw new ServiceException("同楼宇中房间：" + update.getRoomName() + "已存在！");
        }

        return roomMapper.updateById(RoomMapping.INSTANCE.toEntity(update));
    }

    @Override
    public Integer deleteRoom(List<Long> roomIds) {
        //TODO：删除校验（例如：房间是否正在出租中）、是否要用事务
        return roomMapper.deleteBatchIds(roomIds);
    }

    @Override
    public Integer updateStatus(RoomStatusUpdateQuery query) {
        //房间在租则不能下架
        Room room = roomMapper.selectById(query.getRoomId());
        if( room.getTenantStatus().equals(RoomConstants.RENT)
                && query.getStatus().equals(RoomConstants.NO_RENT)){
            throw new ServiceException("在租房间，不能下架");
        }
        //更改上架状态
        room.setRoomId(query.getRoomId());
        room.setStatus(query.getStatus());
        return roomMapper.updateById(room);
    }

    @Override
    public Integer cancelApplication(Long applicationId) {
        TenantApplication application = tenantApplicationMapper.selectById(applicationId);
        if (application == null) {
            throw new ServiceException("申请不存在");
        }
        // 校验是否是本人的申请
        if (!Objects.equals(application.getTenantId(), SecurityUtils.getUserId())) {
            throw new ServiceException("无权操作他人申请");
        }
        // 只有待审批状态可以取消
        if (!RoomApplicationConstants.PENDING_APPROVAL.equals(application.getStatus())) {
            throw new ServiceException("当前状态不可取消");
        }

        application.setStatus(RoomApplicationConstants.CANCELLED); // 设置为已取消
        return tenantApplicationMapper.updateById(application);
    }

    @Override
    public List<RoomRecordVo> getRoomRecordList(Long roomId) {
        return roomRecordMapper.selectRoomRecordList(roomId);
    }

    @Override
    public int updateRoomUserId(Long roomId, Long userId) {
        LambdaUpdateWrapper<Room> luw = Wrappers.lambdaUpdate();
        luw.set(Room::getUserId, userId);
        luw.set(Room::getTenantStatus,RoomConstants.RENT);
        luw.eq(Room::getRoomId, roomId);
        return roomMapper.update(null,luw);
    }

    @Override
    public boolean isUserHaveRoom(Long userId) {
        LambdaQueryWrapper<Room> lqw = Wrappers.lambdaQuery();
        lqw.eq(Room::getUserId, userId);
        lqw.eq(Room::getTenantStatus, RoomConstants.RENT);
        return roomMapper.selectCount(lqw) > 0;
    }
}
