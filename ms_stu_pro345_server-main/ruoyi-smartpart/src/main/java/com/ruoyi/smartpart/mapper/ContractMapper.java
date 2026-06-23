package com.ruoyi.smartpart.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.vo.Contract.ContractListVo;
import com.ruoyi.smartpart.domain.vo.Contract.TenantListVo;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 合同 Mapper 接口
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface ContractMapper extends BaseMapper<Contract> {

    /**
     * 分页查询 合同信息
     * @return
     *
     */
    Page<ContractListVo> getPageLists(@Param("page")Page<ContractListVo> page,
                                      @Param(Constants.WRAPPER) Wrapper<Contract> wrapper);

    Page<TenantListVo> getPageTenantLists(@Param("page")Page<TenantListVo> page,
                                    @Param(Constants.WRAPPER) Wrapper<SysUser> wrapper);

    Contract getByRoomId(Long RoomId);


}
