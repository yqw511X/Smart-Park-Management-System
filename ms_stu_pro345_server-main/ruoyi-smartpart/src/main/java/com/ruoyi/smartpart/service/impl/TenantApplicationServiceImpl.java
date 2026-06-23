package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ruoyi.common.constant.RoomApplicationConstants;
import com.ruoyi.common.constant.RoomConstants;
import com.ruoyi.common.constant.RoomUserConstants;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.entity.TenantApplication;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationChange;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationQuery;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationSaveQuery;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantInfoCheckQuery;
import com.ruoyi.smartpart.mapper.BuildingMapper;
import com.ruoyi.smartpart.mapper.FloorMapper;
import com.ruoyi.smartpart.mapper.RoomMapper;
import com.ruoyi.smartpart.mapper.TenantApplicationMapper;
import com.ruoyi.smartpart.mapping.TenantApplicationMapping;
import com.ruoyi.smartpart.service.RoomService;
import com.ruoyi.smartpart.service.TenantApplicationService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.system.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 租户申请表 服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
public class TenantApplicationServiceImpl extends ServiceImpl<TenantApplicationMapper, TenantApplication> implements TenantApplicationService {

    @Autowired
    private RoomMapper roomMapper;

    @Autowired
    private TenantApplicationMapper tenantApplicationMapper;

    @Autowired
    private FloorMapper floorMapper;

    @Autowired
    private BuildingMapper buildingMapper;

    @Autowired
    private RoomService roomService;

    @Autowired
    private TenantApplicationService tenantApplicationService;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Override
    public Integer submitApplication(TenantApplicationSaveQuery saveQuery) {
        // 1. 校验房间是否存在且已上架
        Room room = roomMapper.selectById(saveQuery.getRoomId());
        if (room == null) {
            throw new ServiceException("房间不存在");
        }
        if (!RoomConstants.SHELVES.equals(room.getStatus())) {
            throw new ServiceException("房间未上架，无法申请");
        }

        // 2. 校验开始时间不能早于当前时间(时间校验)
        if (saveQuery.getStartTime().before(new Date())) {
            throw new ServiceException("租房开始时间不能早于当前时间");
        }

        // 3. 校验房间是否在租
        if (RoomConstants.RENT.equals(room.getTenantStatus())) {
            throw new ServiceException("房间已在租，无法申请");
        }

        // 4. 校验租户是否已经申请过该房间（且处于待审批状态）
        Long userId = SecurityUtils.getUserId();
        SysUser sysUser = sysUserMapper.selectUserById(userId);
        LambdaQueryWrapper<TenantApplication> lqw = new LambdaQueryWrapper<>();
        lqw.eq(TenantApplication::getRoomId, saveQuery.getRoomId());
        lqw.eq(TenantApplication::getTenantId, userId);
        lqw.eq(TenantApplication::getStatus, RoomApplicationConstants.PENDING_APPROVAL);
        if (tenantApplicationMapper.selectCount(lqw) > 0) {
            throw new ServiceException("您已申请过该房间，请耐心等待审批");
        }

        // 5. 已被其他租户申请房间(但未过审批)，不允许同时申请
        LambdaQueryWrapper<TenantApplication> lqwTenantApplication = Wrappers.lambdaQuery();
        lqwTenantApplication.eq(TenantApplication::getRoomId, saveQuery.getRoomId());
        lqwTenantApplication.eq(TenantApplication::getStatus, "0");
        if(tenantApplicationMapper.selectCount(lqwTenantApplication)>0){
            throw new ServiceException("其他用户申请中");
        }

        // 6. 已被其他租户申请房间(过审批,但未签订)，不允许同时申请
        LambdaQueryWrapper<TenantApplication> lqwTenantApplication2 = Wrappers.lambdaQuery();
        lqwTenantApplication2.eq(TenantApplication::getRoomId, saveQuery.getRoomId());
        lqwTenantApplication2.eq(TenantApplication::getStatus, "1"); // 审批通过
        lqwTenantApplication2.isNull(TenantApplication::getRoomStatus); //未签订
        if(tenantApplicationMapper.selectCount(lqwTenantApplication)>0){
            throw new ServiceException("其他用户处在房屋待签订状态");
        }

        //6.校验用户目前租房状态
        //1、是否在租  2、未租是否有申请
        if( roomService.isUserHaveRoom(userId)){
            throw new ServiceException("当前您尚有房源处于未退租状态，故暂时无法进行新房屋的租赁事宜");
        }else if ( tenantApplicationService.hasUnPassApplication(userId)){
            throw new ServiceException("当前您尚有房源处于申请租赁状态，故暂时无法进行新房屋的租赁事宜");
        }

        // 6. 保存申请信息
        TenantApplication application = TenantApplicationMapping.INSTANCE.toEntity(saveQuery);
        application.setTenantId(userId);
        application.setApplyTime(LocalDateTime.now());
        application.setStatus(RoomApplicationConstants.PENDING_APPROVAL);
        application.setCreateBy(SecurityUtils.getUsername());
        application.setCreateTime(LocalDateTime.now());
        application.setApplyName(sysUser.getUserName());
        application.setContactPhone(sysUser.getPhonenumber());

        return tenantApplicationMapper.insert(application);
    }

    @Override
    public void checkLeaseStatus(TenantInfoCheckQuery checkQuery) {
        Long userId = SecurityUtils.getUserId();

        // 1. 校验是否处于【在租】状态
        LambdaQueryWrapper<Room> roomLqw = new LambdaQueryWrapper<>();
        roomLqw.eq(Room::getUserId, userId);
        roomLqw.eq(Room::getTenantStatus, RoomConstants.RENT);
        if (roomMapper.selectCount(roomLqw) > 0) {
            throw new ServiceException("当前您尚有房源处于未退租状态，故暂时无法进行新房屋的租赁事宜");
        }

        // 2. 校验是否处于【未租】状态且有租赁申请（待审批）
        LambdaQueryWrapper<TenantApplication> applyLqw = new LambdaQueryWrapper<>();
        applyLqw.eq(TenantApplication::getTenantId, userId);
        applyLqw.eq(TenantApplication::getStatus, RoomApplicationConstants.PENDING_APPROVAL);
        if (tenantApplicationMapper.selectCount(applyLqw) > 0) {
            throw new ServiceException("当前您尚有房源处于申请租赁状态，故暂时无法进行新房屋的租赁事宜");
        }
    }

    @Override
    public boolean hasUnPassApplication(Long userId) {
        LambdaQueryWrapper<TenantApplication> lqw = Wrappers.lambdaQuery();
        lqw.eq(TenantApplication::getTenantId, userId);
        lqw.eq(TenantApplication::getStatus,
                RoomApplicationConstants.PENDING_APPROVAL );
        return tenantApplicationMapper.selectCount(lqw) > 0;
    }

    @Override
    public int updateRoomStatusByContractId(Long contractId) {
        LambdaUpdateWrapper<TenantApplication> luw = Wrappers.lambdaUpdate();
        luw.eq(TenantApplication::getContractId, contractId);
        luw.set(TenantApplication::getRoomStatus, RoomConstants.RENT);
        return tenantApplicationMapper.update(null, luw);
    }

    public List<TenantApplicationQuery> selectTenant(String name, String phone,String status) {
        LambdaQueryWrapper<TenantApplication> lqw = new LambdaQueryWrapper<>();
        lqw.like(StringUtils.isNotEmpty(name), TenantApplication::getApplyName, name);
        lqw.like(StringUtils.isNotEmpty(phone), TenantApplication::getContactPhone, phone);
        lqw.eq(StringUtils.isNotEmpty(status), TenantApplication::getStatus, status);
        lqw.orderByDesc(TenantApplication::getApplyTime);
        List<TenantApplication> tenantApplications = tenantApplicationMapper.selectList(lqw);
        ArrayList<TenantApplicationQuery> objects = new ArrayList<>();
        for (TenantApplication tenantApplication : tenantApplications) {
            Long roomId = tenantApplication.getRoomId();
            Room room = roomMapper.selectById(roomId);
            if(room == null){
                continue;
            }
            String floorName = floorMapper.selectById(room.getFloorId()).getFloorName();
            String buildingName = buildingMapper.selectById(room.getBuildingId()).getBuildingName();
            SysUser sysUser = sysUserMapper.selectUserById(tenantApplication.getTenantId());
            TenantApplicationQuery tenantApplication1 = new TenantApplicationQuery();
            tenantApplication1.setId(tenantApplication.getId());
            tenantApplication1.setStatus(room.getStatus());
            tenantApplication1.setTenantName(tenantApplication.getApplyName());
            tenantApplication1.setParkName(buildingName);
            tenantApplication1.setBuildingName(buildingName);
            tenantApplication1.setFloorName(floorName);
            tenantApplication1.setRoomNumber(room.getRoomName());
            tenantApplication1.setPhone(tenantApplication.getContactPhone());
            tenantApplication1.setStartTime(tenantApplication.getStartTime());
            tenantApplication1.setEndTime(tenantApplication.getEndTime());
            tenantApplication1.setApprovalStatus(tenantApplication.getStatus());
            tenantApplication1.setTenantName(sysUser.getUserName());
            objects.add(tenantApplication1);


        }
        return objects;
    }

    @Override
    public void checkApprovalStatusChange(TenantApplicationChange tenantApplicationChange) {
        Long id = tenantApplicationChange.getId();
        TenantApplication tenantApplication = tenantApplicationMapper.selectById(id);
        if (tenantApplication == null) {
            throw new ServiceException("申请不存在");
        }

        String currentStatus = tenantApplication.getStatus();

        // 如果当前状态不是待审批，则不允许修改
        if (!RoomApplicationConstants.PENDING_APPROVAL.equals(currentStatus)) {
            throw new ServiceException("当前状态不允许修改审批状态");
        }
    }

    public int updateApprovalStatus(TenantApplicationChange tenantApplicationChange) {
        Long id = tenantApplicationChange.getId();

        TenantApplication tenantApplication = tenantApplicationMapper.selectById(id);
        if (tenantApplication == null) {
            throw new ServiceException("申请不存在");
        }
        tenantApplication.setStatus(tenantApplicationChange.getStatus());
        tenantApplication.setRemark(tenantApplicationChange.getRemark());
        return tenantApplicationMapper.updateById(tenantApplication);
    }
}
