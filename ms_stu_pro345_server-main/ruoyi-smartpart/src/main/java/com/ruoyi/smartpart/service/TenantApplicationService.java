package com.ruoyi.smartpart.service;

import com.ruoyi.smartpart.domain.entity.TenantApplication;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationChange;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationSaveQuery;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantInfoCheckQuery;

/**
 * <p>
 * 租户申请表 服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface TenantApplicationService extends IService<TenantApplication> {

    /**
     * 提交租房申请
     * @param saveQuery 申请参数
     * @return 影响行数
     */
    Integer submitApplication(TenantApplicationSaveQuery saveQuery);

    /**
     * 校验租赁状态
     * @param checkQuery 校验参数
     */
    void checkLeaseStatus(TenantInfoCheckQuery checkQuery);

    /**
     * 校验用户是否有未通过的房间申请
     * @param userId 用户id
     * @return
     */
    boolean hasUnPassApplication(Long userId);

    /**
     * 更新申请的租房状态by合同id（更新为在租）
     * @param contractId 合同id
     * @return 影响函数
     */
    int updateRoomStatusByContractId(Long contractId);

    /**
     * 校验审批状态是否允许修改
     * @param tenantApplicationChange 状态修改参数
     */
    void checkApprovalStatusChange(TenantApplicationChange tenantApplicationChange);
}
