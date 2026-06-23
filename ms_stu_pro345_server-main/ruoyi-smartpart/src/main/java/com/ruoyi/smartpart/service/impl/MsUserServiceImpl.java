package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.common.constant.RepairManConstants;
import com.ruoyi.common.exception.ServiceException;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.entity.MsUser;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.query.Bill.WorkbenchQuery;
import com.ruoyi.smartpart.domain.query.msUser.RenterUpdate;
import com.ruoyi.smartpart.domain.vo.Bill.BillListVo;
import com.ruoyi.smartpart.domain.vo.repairman.RepairManNameListVo;
import com.ruoyi.smartpart.domain.vo.workbench.BillStatisticsVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchChartVo;
import com.ruoyi.smartpart.domain.vo.workbench.WorkbenchOverviewVo;
import com.ruoyi.smartpart.mapper.BillMapper;
import com.ruoyi.smartpart.mapper.MsUserMapper;
import com.ruoyi.smartpart.mapping.BillMapping;
import com.ruoyi.smartpart.mapping.MsUserMapping;
import com.ruoyi.smartpart.service.BillService;
import com.ruoyi.smartpart.service.MsUserService;
import com.ruoyi.smartpart.service.RoomService;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.system.domain.vo.renter.RenterListVo;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Service
public class MsUserServiceImpl extends ServiceImpl<MsUserMapper, MsUser> implements MsUserService {

    @Autowired
    private MsUserMapper msUserMapper;

    @Autowired
    private SysUserServiceImpl sysUserService;

    @Autowired
    private RoomService roomService;

    @Override
    public List<RepairManNameListVo> getRepairManNameList() {
        QueryWrapper<MsUser> qw = Wrappers.query();
        qw.eq("sur.role_id", RepairManConstants.ROLE_ID);
        return msUserMapper.getRepairManNameList(qw);
    }

    @Override
    public Page<RenterListVo> getRenterList(PageParam pageParam,String renterName) {
        // 分页对象
        Page<RenterListVo> page = new Page<>(pageParam.getPageNum(),pageParam.getPageSize());
        // 条件对象
        QueryWrapper<MsUser> qw = Wrappers.query();
        qw.eq("u.del_flag", "0");
        qw.eq("u.status", "0");
        qw.like(StringUtils.isNotEmpty(renterName),"u.nick_name",renterName);
        // 租房状态设置
        Page<RenterListVo> renterPage = msUserMapper.getRenterList(qw, page);
        for (RenterListVo renter : renterPage.getRecords()){
            if(StringUtils.isNotNull(renter.getRoomId())){
                renter.setStatus("1");
            }else{
                renter.setStatus("0");
            }
        }
        return renterPage;
    }

    @Override
    public boolean updateRenter(RenterUpdate renterUpdate) {
        if (!renterUpdate.getPassword().equals(renterUpdate.getConfirmPassword())) {
            throw new ServiceException("两次密码不一致");
        }
        MsUser existUser = this.getById(renterUpdate.getUserId());
        if (existUser == null) {
            throw new ServiceException("用户不存在");
        }
        MsUser updateUser = MsUserMapping.INSTANCE.toEntity(renterUpdate);
        updateUser.setPassword(SecurityUtils.encryptPassword(renterUpdate.getPassword()));
        boolean success = this.updateById(updateUser);
        if (!success) {
            throw new ServiceException("更新失败");
        }
        return success;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public int deleteRenterByIds(Long[] userIds) {
        for (Long userId : userIds) {
            if (roomService.isUserHaveRoom(userId)) {
                throw new ServiceException("用户ID为" + userId + "的租户正在租，不能删除");
            }
        }
        return msUserMapper.deleteBatchIds(Arrays.asList(userIds));
    }
}
