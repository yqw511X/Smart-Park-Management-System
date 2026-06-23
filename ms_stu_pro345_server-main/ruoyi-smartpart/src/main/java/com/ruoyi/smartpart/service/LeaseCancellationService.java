package com.ruoyi.smartpart.service;

import com.baomidou.mybatisplus.extension.service.IService;

import com.ruoyi.smartpart.domain.entity.LeaseCancellation;
import com.ruoyi.smartpart.domain.query.Contract.LeaseCancellationQuery;

public interface LeaseCancellationService extends IService<LeaseCancellation> {

    int insert(LeaseCancellationQuery leaseCancellationQuery);
}
