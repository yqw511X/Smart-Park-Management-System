package com.ruoyi.smartpart.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.MsUser;
import com.ruoyi.smartpart.domain.vo.repairman.RepairManNameListVo;
import com.ruoyi.system.domain.vo.renter.RenterListVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MsUserMapper extends BaseMapper<MsUser> {
    /**
     * 获取维修工名称列表
     * @return 维修工名称列表
     */
    List<RepairManNameListVo> getRepairManNameList(@Param(Constants.WRAPPER)Wrapper<MsUser> wrapper);

    Page<RenterListVo> getRenterList(@Param(Constants.WRAPPER)Wrapper<MsUser> wrapper, @Param("page")Page<RenterListVo> page);
}
