package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.constant.RepairManConstants;
import com.ruoyi.common.constant.RepairOrderConstants;
import com.ruoyi.common.core.domain.entity.SysRole;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.create.RepairOrderCreate;
import com.ruoyi.smartpart.domain.entity.*;
import com.ruoyi.smartpart.domain.query.repairorder.*;
import com.ruoyi.smartpart.domain.vo.repairorder.*;
import com.ruoyi.smartpart.mapper.*;
import com.ruoyi.smartpart.mapping.RepairOrderMapping;
import com.ruoyi.smartpart.service.RepairOrderService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.TimeUtils;
import com.ruoyi.system.service.ISysRoleService;
import com.ruoyi.system.service.impl.SysRoleServiceImpl;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

/**
 * <p>
 * 维修单 服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
public class RepairOrderServiceImpl extends ServiceImpl<RepairOrderMapper, RepairOrder> implements RepairOrderService {

    @Autowired
    private ISysRoleService sysRoleService;
    @Autowired
    private RepairOrderMapper repairOrderMapper;

    @Autowired
    private SysUserServiceImpl sysUserService;

    @Autowired
    private RoomMapper roomMapper;
    ;

    @Autowired
    private BuildingMapper buildingMapper;

    @Autowired
    private FloorMapper floorMapper;

    @Autowired
    private RepairLogMapper repairLogMapper;

    @Override
    public List<RepairOrder> selectList(String repairNum, String status) {
        return repairOrderMapper.selectListRepairOrder(repairNum, status);
    }

    @Override
    public int insertRenterOrder(RepairOrderCreate repairOrder) {
        //创建工单的前提是用户必须在租
        LambdaQueryWrapper<Room> lqw = Wrappers.lambdaQuery();
        lqw.eq(Room::getUserId, SecurityUtils.getUserId());
        Room myRoom = roomMapper.selectOne(lqw);
        if( StringUtils.isNull(myRoom) ){
            throw new ServiceException("无在租房间，无法创建工单！");
        }

        RepairOrder repairOrderEntity = new RepairOrder();
        repairOrderEntity.setTenantId(SecurityUtils.getUserId());
        repairOrderEntity.setStatus("0");
        repairOrderEntity.setRoomId(myRoom.getRoomId());
        repairOrderEntity.setRepairOrderId(repairOrder.getRepairOrderId());
        repairOrderEntity.setRepairArea(repairOrder.getRepairArea());
        repairOrderEntity.setRepairTime(LocalDateTime.now());
        repairOrderEntity.setRepairImage(repairOrder.getRepairImage());
        repairOrderEntity.setRepairNum(generatePureNumRepairOrderNum());
        repairOrderEntity.setVisitTime(repairOrder.getVisitTime());
        repairOrderEntity.setContactName(repairOrder.getContactName());
        repairOrderEntity.setContactPhone(repairOrder.getContactPhone());
        repairOrderEntity.setRemark(repairOrder.getRemark());
        int insert = repairOrderMapper.insert(repairOrderEntity);
        RepairLog repairLog = new RepairLog();
        repairLog.setStatus("0");
        repairLog.setRepairOrderId(repairOrderEntity.getRepairOrderId());
        repairLog.setOperationTime(repairOrderEntity.getRepairTime());
        repairLog.setHuman(sysUserService.selectById(repairOrderEntity.getTenantId()).getNickName());
        repairLogMapper.insert(repairLog);
        return insert;
    }

    @Override
    public int updateRepairOrder(RepairManCreate repairManCreate) {
        Long id = repairManCreate.getId();
        Long repairId = repairManCreate.getRepairId();
        RepairOrder repairOrder = repairOrderMapper.selectById(id);
        if (repairOrder == null) {
            return 0;
        }
        repairOrder.setRepairId(repairId);
        repairOrder.setStatus("1");
        RepairLog repairLog = new RepairLog();
        repairLog.setStatus("1");
        repairLog.setRepairOrderId(repairOrder.getRepairOrderId());
        repairLog.setOperationTime(repairOrder.getUpdateTime());
        repairLog.setHuman(sysUserService.selectById(repairOrder.getTenantId()).getNickName());
        repairLog.setRepairName(sysUserService.selectById(repairId).getNickName());
        repairLogMapper.insert(repairLog);
        return repairOrderMapper.updateById(repairOrder);
    }

    @Override
    public int updateRepairOrderStatus(RepairOrderStatusUpdate statusUpdate) {
        Long id = statusUpdate.getId();
        String status = statusUpdate.getStatus();
        //已完成订单和已取消订单无法操作
        RepairOrder repairOrder = repairOrderMapper.selectById(id);
        if(repairOrder.getStatus().equals(RepairOrderConstants.FINISH)){
            throw new ServiceException("该维修单已完成，请勿操作！");
        }else if (repairOrder.getStatus().equals(RepairOrderConstants.CANCELLED)){
            throw new ServiceException("该维修单已取消，请勿操作！");
        }
        //租户只能 完成维修单(状态值2)  取消维修单(状态值3)
        if(status.equals(RepairOrderConstants.PENDING_ASSIGN) || status.equals(RepairOrderConstants.PENDING_PROCESS)){
            throw new ServiceException("租户只能 完成维修单(状态值2)  取消维修单(状态值3) ");
        }
        //完成维修单的前置校验（1）维修单未委派 （2）当前时间早于上门时间！
        if(status.equals(RepairOrderConstants.FINISH)){
            if(repairOrder.getStatus().equals(RepairOrderConstants.PENDING_ASSIGN)){
                throw new ServiceException("该维修单未指派维修工，不能完成");
            }else if(repairOrder.getStatus().equals(RepairOrderConstants.PENDING_PROCESS) && TimeUtils.isAfterNow(repairOrder.getVisitTime())){
                throw new ServiceException("当前时间早于上门时间！");
            }
        }
        //添加维修日志
        repairOrder.setStatus(status);
        RepairLog repairLog = new RepairLog();
        repairLog.setStatus(status);
        repairLog.setRepairOrderId(repairOrder.getRepairOrderId());
        repairLog.setOperationTime(repairOrder.getUpdateTime());
        repairLog.setHuman(sysUserService.selectById(repairOrder.getTenantId()).getNickName());
        repairLogMapper.insert(repairLog);
        return repairOrderMapper.updateById(repairOrder);
    }

    @Override
    public int deleteRepairOrderByIds(Long[] repairOrderIds) {
        List<Long> ids = Arrays.asList(repairOrderIds);
        return repairOrderMapper.deleteBatchIds(ids);
    }

    @Override
    public RepairOrderDtlVo getRepairOrderDtlVo(Long repairOrderId) {
        //维修单
        RepairOrder repairOrder = repairOrderMapper.selectById(repairOrderId);
        if (repairOrder == null) {
            return null;
        }
        //房间
        Room room = roomMapper.selectById(repairOrder.getRoomId());
        //实体组装
        String buildingName = null;
        String floorName = null;
        try {
            //楼宇名称
            buildingName = buildingMapper.selectById(room.getBuildingId()).getBuildingName();
            //楼层名称
            floorName = floorMapper.selectById(room.getFloorId()).getFloorName();
        } catch (Exception e) {
            throw new ServiceException("维修单对应房间的楼宇和楼层被删除了，无法查询");
        }
        RepairOrderDtlVo orderVo = RepairOrderMapping.INSTANCE.toOrderVo(room, repairOrder);
        orderVo.setTenantName(sysUserService.selectById(repairOrder.getTenantId()).getNickName());
        orderVo.setBuildingName(buildingName);
        orderVo.setFloorName(floorName);
        return orderVo;
    }

    @Override
    public List<RepairLogMeVo> selectRepairList(Long repairOrderId) {
        LambdaQueryWrapper<RepairLog> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RepairLog::getRepairOrderId, repairOrderId);
        List<RepairLog> repairLogs = repairLogMapper.selectList(wrapper);
        ArrayList<RepairLogMeVo> objects = new ArrayList<>();
        for (RepairLog repairLog : repairLogs) {
            RepairLogMeVo repairLogMeVo = new RepairLogMeVo();
            repairLogMeVo.setStatus(repairLog.getStatus());
            repairLogMeVo.setHuman(repairLog.getHuman());
            repairLogMeVo.setRepairName(repairLog.getRepairName());
            repairLogMeVo.setOperationTime(repairLog.getOperationTime());
            objects.add(repairLogMeVo);
        }
        return objects;
    }

    @Override
    public List<RepairOrderPageVo> selectRepairTenant(RepairOrderTenantQuery repairOrderQuery) {
        LambdaQueryWrapper<RepairOrder> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(RepairOrder::getTenantId, SecurityUtils.getUserId());
        wrapper.like(StringUtils.isNotEmpty(repairOrderQuery.getStatus()), RepairOrder::getStatus, repairOrderQuery.getStatus());
        wrapper.like(StringUtils.isNotEmpty(repairOrderQuery.getRepairNum()), RepairOrder::getRepairNum, repairOrderQuery.getRepairNum());
        wrapper.orderByDesc(RepairOrder::getRepairTime);
        List<RepairOrder> repairOrders = repairOrderMapper.selectList(wrapper);
        ArrayList<RepairOrderPageVo> objects = new ArrayList<>();
        for (RepairOrder repairOrder : repairOrders) {
            RepairOrderPageVo repairOrderPageVo = new RepairOrderPageVo();
            repairOrderPageVo.setRepairArea(repairOrder.getRepairArea());
            repairOrderPageVo.setRepairTime(repairOrder.getRepairTime());
            repairOrderPageVo.setStatus(repairOrder.getStatus());
            repairOrderPageVo.setRepairOrderId(repairOrder.getRepairOrderId());
            repairOrderPageVo.setContactName(repairOrder.getContactName());
            repairOrderPageVo.setRepairNum(repairOrder.getRepairNum());
            if(StringUtils.isNotNull(repairOrder.getRepairId())){
                repairOrderPageVo.setRepairName(sysUserService.selectById(repairOrder.getRepairId()).getNickName());
            }
            repairOrderPageVo.setContactPhone(repairOrder.getContactPhone());
            objects.add(repairOrderPageVo);
        }
        return objects;
    }

    @Override
    public int updateRepairOrderTenant(RepairOrderUpdate repairOrderUpdate) {
        RepairOrder repairOrder = repairOrderMapper.selectById(repairOrderUpdate.getRepairOrderId());
        if(repairOrder == null){
            return 0;
        }
        repairOrder.setRepairTime(repairOrderUpdate.getRepairTime());
        repairOrder.setRepairImage(repairOrderUpdate.getRepairImage());
        repairOrder.setContactName(repairOrderUpdate.getContactName());
        repairOrder.setContactPhone(repairOrderUpdate.getContactPhone());
        repairOrder.setRepairArea(repairOrderUpdate.getRepairArea());
        repairOrder.setRemark(repairOrderUpdate.getRemark());
        repairOrder.setVisitTime(repairOrderUpdate.getVisitTime());

        return repairOrderMapper.updateById(repairOrder);
    }

    @Override
    public RepairOrderReDtlVo getRepairOrderReDtlVo(Long repairOrderId) {
        RepairOrder repairOrder = repairOrderMapper.selectById(repairOrderId);
        if(repairOrder == null){
            return null;
        }
        Long roomId = repairOrder.getRoomId();
        Room room = roomMapper.selectById(roomId);
        String parkName = room.getParkName();
        RepairOrderReDtlVo repairOrderReDtlVo = new RepairOrderReDtlVo();
        repairOrderReDtlVo.setTenantName(sysUserService.selectById(repairOrder.getTenantId()).getNickName());
        repairOrderReDtlVo.setParkName(room.getParkName());
        repairOrderReDtlVo.setRepairNum(repairOrder.getRepairNum());
        repairOrderReDtlVo.setRepairTime(repairOrder.getRepairTime());
        repairOrderReDtlVo.setRepairArea(repairOrder.getRepairArea());
        repairOrderReDtlVo.setStatus(repairOrder.getStatus());
        repairOrderReDtlVo.setContactPhone(repairOrder.getContactPhone());
        return repairOrderReDtlVo;
    }

    @Override
    public RepairOrderMeQuery selectRepairListWorker(Long repairOrderId) {
        RepairOrder repairOrder = repairOrderMapper.selectById(repairOrderId);
        if(repairOrder == null){
            return null;
        }
        Long repairId = repairOrder.getRepairId();
        LocalDateTime createTime = repairOrder.getCreateTime();
        LocalDateTime updateTime = repairOrder.getUpdateTime();

        String nickName = sysUserService.selectById(repairId).getNickName();
        String phone = sysUserService.selectById(repairId).getPhonenumber();

        RepairOrderMeQuery repairOrderMeVo = new RepairOrderMeQuery();
        repairOrderMeVo.setRepairName(nickName);
        repairOrderMeVo.setPhonenumber(phone);
        repairOrderMeVo.setCreateTime(createTime);
        repairOrderMeVo.setUpdateTime(updateTime);

        return repairOrderMeVo;
    }

    @Override
    public Page<RepairManOrderListVo> getOrderManPage(RepairOrderQuery repairOrderQuery, PageParam pageParam) {
        //维修工账号校验
        List<Long> roleIds = sysRoleService.selectRoleListByUserId(SecurityUtils.getUserId());
        Boolean isRepairMan = false;
        for(Long roleId:roleIds){
            if (roleId.equals(RepairManConstants.ROLE_ID)){
                isRepairMan = true;
            }
        }
        if (!isRepairMan){
            throw new ServiceException("登录账号非维修工");
        }
        //分页参数
        Page<RepairOrder> page = new Page<>(pageParam.getPageNum(),pageParam.getPageSize());
        //条件参数
        LambdaQueryWrapper<RepairOrder> lqw = Wrappers.lambdaQuery();
        lqw.eq(RepairOrder::getRepairId, SecurityUtils.getUserId());
        lqw.ne(RepairOrder::getStatus, RepairOrderConstants.CANCELLED);
        lqw.like(StringUtils.isNotEmpty(repairOrderQuery.getRepairNum()),
                RepairOrder::getRepairNum,repairOrderQuery.getRepairNum());
        lqw.eq(StringUtils.isNotEmpty(repairOrderQuery.getStatus()),
                RepairOrder::getStatus,repairOrderQuery.getStatus());
        return RepairOrderMapping.INSTANCE.toPage(repairOrderMapper.selectPage(page,lqw));
    }

    public static String generatePureNumRepairOrderNum() {
        // 1. 获取13位时间戳（秒级，保证单号随时间递增）
        long timestamp = System.currentTimeMillis();
        // 2. 生成4位随机数（可调整位数，比如3位/5位）
        int randomNum = ThreadLocalRandom.current().nextInt(1000, 9999); // 4位随机数（1000-9999）
        // 3. 拼接成纯数字单号
        return timestamp + String.valueOf(randomNum);
    }
}
