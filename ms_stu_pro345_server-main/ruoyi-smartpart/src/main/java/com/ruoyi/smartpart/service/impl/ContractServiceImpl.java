package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.LoginUser;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.Contract.*;
import com.ruoyi.smartpart.domain.vo.Contract.ContracPreviewtListVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContractInsertVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContractListVo;
import com.ruoyi.smartpart.domain.vo.Contract.TenantListVo;
import com.ruoyi.smartpart.mapper.ContractMapper;
import com.ruoyi.smartpart.mapper.RoomMapper;
import com.ruoyi.smartpart.mapping.ContractMapping;
import com.ruoyi.smartpart.service.ContractService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.system.mapper.SysUserMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 合同 服务实现类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Service
@Slf4j
public class ContractServiceImpl extends ServiceImpl<ContractMapper, Contract> implements ContractService {

    @Autowired
    private  ContractMapper contractMapper;

    @Autowired
    private SysUserMapper sysUserMapper;

    @Autowired
    private RoomMapper roomMapper;

    @Override
    public Page<ContractListVo> getPageLists(PageParam pageParam, ContractQuery contractQuery) {

        // 获取分页对象
        Page<ContractListVo> page=new Page<>(pageParam.getPageNum(),pageParam.getPageSize());

        //获取构造器对象
        QueryWrapper<Contract> qw= Wrappers.query();
        qw.like(StringUtils.isNotEmpty(contractQuery.getContractName()),"t1.contract_name",
                contractQuery.getContractName());
        qw.like(StringUtils.isNotEmpty(contractQuery.getStatus()),"t1.status",
                contractQuery.getStatus());



        qw.like(StringUtils.isNotEmpty(contractQuery.getContractNum()),"t1.contract_num",
                contractQuery.getContractNum());
        String nickName = contractQuery.getNickName();
        if (nickName != null && !nickName.isEmpty()) {
            Long userId = sysUserMapper.selectUserByNickName(nickName).getUserId();

        if(userId!= null){
        qw.eq("t1.tenant_id", userId);
        }
        }
        qw.eq("t1.del_flag", 0);

        return contractMapper.getPageLists(page, qw);



    }

    @Override
    public Page<TenantListVo> getPageTenantLists(PageParam pageParam, TenantListQuery tenantListQuery) {
        // 获取分页对象
        Page<TenantListVo> page=new Page<>(pageParam.getPageNum(),pageParam.getPageSize());
        //获取构造器对象
        QueryWrapper<SysUser> qw= Wrappers.query();

        qw.like(StringUtils.isNotEmpty(tenantListQuery.getNickName()),"t1.nick_name",
                tenantListQuery.getNickName());
        qw.eq(StringUtils.isNotEmpty(tenantListQuery.getPhonenumber()),"t1.phonenumber",
                tenantListQuery.getPhonenumber());
        qw.eq("t1.del_flag", 0);

        return contractMapper.getPageTenantLists(page,qw);

    }


    /**
     *        新增  合同
     * @param contractInsertQuery
     * @return
     */
    @Override
    public Long insert(ContractInsertQuery contractInsertQuery) {

        Contract contract = ContractMapping.INSTANCE.toInsert(contractInsertQuery);
        Long tenantId = contract.getTenantId();
        SysUser sysUser = sysUserMapper.selectUserById(tenantId);
        if (sysUser ==null){
        //  不存在该用户 操作错误
            return 0L;
        }
        Long roomId = contract.getRoomId();
        Room room = roomMapper.selectById(roomId);
        if(room ==null){
        //该房间不存在 操作失败
            return 0L;
        }

        // 合同开始时间 结束时间
        LocalDateTime startTime = contract.getStartTime();

        LocalDateTime overTime = contract.getOverTime();


        Duration duration = Duration.between(startTime, overTime);

        long days = duration.toDays();



        contract.setManageMoney(contract.getDailyFee()*days);
        contract.setTenantMoney(contract.getDailyRent()*days);

        contract.setStatus("0");
        contract.setVersionNum("0");
        contractMapper.insert(contract);

        return contract.getContractId();
    }

    /**
     *
     *  修改 合同
     *
     *
     * @param contractUpdataQuery
     * @return
     */
    @Override
    public int updata(ContractUpdataQuery contractUpdataQuery) {
        Contract updata = ContractMapping.INSTANCE.toUpdata(contractUpdataQuery);

        // 合同开始时间 结束时间
        LocalDateTime startTime = updata.getStartTime();

        LocalDateTime overTime = updata.getOverTime();


        Duration duration = Duration.between(startTime, overTime);

        long days = duration.toDays();



        updata.setManageMoney(updata.getDailyFee()*days);
        updata.setTenantMoney(updata.getDailyRent()*days);

        updata.setStatus("0");
        updata.setVersionNum("0");

        return contractMapper.updateById(updata);
    }

    @Override
    public int change(Contract contract) {

        // 合同开始时间 结束时间
        LocalDateTime startTime = contract.getStartTime();

        LocalDateTime overTime = contract.getOverTime();


        Duration duration = Duration.between(startTime, overTime);

        long days = duration.toDays();



        contract.setManageMoney(contract.getDailyFee()*days);
        contract.setTenantMoney(contract.getDailyRent()*days);

        String versionNum = contract.getVersionNum();

        int newVersion  = Integer.parseInt(versionNum)+1;

        contract.setVersionNum(String.valueOf(newVersion));

        return contractMapper.updateById(contract);
    }

    @Override
    public int sign(Contract contract) {

       contract.setStatus("1");
       return  contractMapper.updateById(contract);

    }

    @Override
    public int preview(ContracPreviewtListVo contracPreviewtListVo) {
        return 0;
    }

    @Override
    public Contract getByRoomId(Long roomId) {

        return contractMapper.getByRoomId(roomId);
    }


    /**
     * 启动时自动检查并更新所有过期合同的状态
     */
    public void autoUpdateExpiredContracts() {




        // 1. 查询所有结束时间已过，且状态不是 "2" (已完成) 的合同
        LambdaQueryWrapper<Contract> wrapper = new LambdaQueryWrapper<>();
        wrapper.lt(Contract::getOverTime, LocalDateTime.now()) // overTime < 当前时间
                .ne(Contract::getStatus, "2") // status != "2"
                .eq(Contract::getDelFlag, false); // 排除已逻辑删除的数据

        List<Contract> expiredContracts = contractMapper.selectList(wrapper);

        // 2. 如果有需要更新的合同，进行批量更新
        if (expiredContracts != null && !expiredContracts.isEmpty()) {
            log.info("【启动任务】检测到 {} 份合同已到期，正在自动更新状态...", expiredContracts.size());

            for (Contract contract : expiredContracts) {
                contract.setStatus("2"); // 将状态改为 "2"
                contractMapper.updateById(contract);

                // 在后端控制台打印出具体的更新信息
                log.info("【启动任务】合同 [{}] (编号: {}) 已过期，状态已自动更新为 [已完成]",
                        contract.getContractName(), contract.getContractNum());
            }
            log.info("【启动任务】所有过期合同状态更新完毕！");
        } else {
            log.info("【启动任务】当前没有需要更新状态的过期合同。");
        }
    }

}
