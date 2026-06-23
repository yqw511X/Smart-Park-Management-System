package com.ruoyi.smartpart.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.query.Contract.*;
import com.ruoyi.smartpart.domain.vo.Contract.ContracPreviewtListVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContractListVo;
import com.ruoyi.smartpart.domain.vo.Contract.TenantListVo;
import com.ruoyi.smartpart.utils.PageParam;

/**
 * <p>
 * 合同 服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface ContractService extends IService<Contract> {

    /**
     * 分页查询  资产仓库详情
     * @param pageParam  分页条件
     * @param contractQuery 检索条件
     * @return
     */
    Page<ContractListVo> getPageLists(PageParam pageParam, ContractQuery contractQuery);

    Page<TenantListVo> getPageTenantLists(PageParam pageParam, TenantListQuery tenantListQuery);

    /**
     * 创建合同
     * @param contractInsertQuery 合同创建对象
     * @return 返回合同id
     */
    Long insert(ContractInsertQuery contractInsertQuery);

    int updata(ContractUpdataQuery contractUpdataQuery);

    //改变合同信息 --  (已经签订的合同)
    int change(Contract contract);

    //修改合同对象信息
    int sign(Contract contract);


    int preview(ContracPreviewtListVo contracPreviewtListVo);

    Contract getByRoomId(Long roomId);
     void autoUpdateExpiredContracts();
}
