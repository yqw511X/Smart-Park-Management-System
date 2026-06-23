package com.ruoyi.smartpart.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.vo.Bill.BillListVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContractListVo;
import com.ruoyi.smartpart.utils.PageParam;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface BillMapper extends BaseMapper<Bill> {

    /**
     * 分页查询 仓库信息
     * @return
     *
     */
    Page<BillListVo> getPageLists(@Param("page")Page<BillListVo> page,
                                  @Param(Constants.WRAPPER) Wrapper<Bill> wrapper);


    Page<BillListVo> getPageListsByTenantId(PageParam pageParam, TenantBillQueryById billQuery);

}
