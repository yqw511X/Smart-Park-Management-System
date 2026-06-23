package com.ruoyi.smartpart.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.entity.LeaseCancellation;
import com.ruoyi.smartpart.domain.query.Contract.LeaseCancellationQuery;
import com.ruoyi.smartpart.mapper.ContractMapper;
import com.ruoyi.smartpart.mapper.LeaseCancellationMapper;
import com.ruoyi.smartpart.mapping.LeaseCancellationMapping;
import com.ruoyi.smartpart.service.ContractService;
import com.ruoyi.smartpart.service.LeaseCancellationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LeaseCancellationServiceImpl extends ServiceImpl<LeaseCancellationMapper, LeaseCancellation> implements LeaseCancellationService {

    @Autowired
    private  LeaseCancellationMapper leaseCancellationMapper;



    //退租功能
    @Override
    public int insert(LeaseCancellationQuery leaseCancellationQuery) {
        LeaseCancellation insert = LeaseCancellationMapping.INSTANCE.toInsert(leaseCancellationQuery);



        return leaseCancellationMapper.insert(insert);
    }
}
