package com.ruoyi.smartpart.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.entity.MsUser;
import com.ruoyi.smartpart.domain.query.msUser.RenterUpdate;
import com.ruoyi.smartpart.domain.vo.repairman.RepairManNameListVo;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.system.domain.vo.renter.RenterListVo;

import java.util.List;

public interface MsUserService extends IService<MsUser> {
    /**
     * 获取维修工名称列表
     * @return 维修工名称列表
     */
    List<RepairManNameListVo> getRepairManNameList();

    /**
     * 获取租户列表
     * @param renterName 租户名称
     * @return 租户列表
     */
    Page<RenterListVo> getRenterList(PageParam pageParam, String renterName);

    /**
     * 更新租户信息
     * 包含密码一致性校验和用户存在性校验
     * @param renterUpdate 租户更新对象
     * @return 更新是否成功
     */
    boolean updateRenter(RenterUpdate renterUpdate);

    /**
     * 删除租户（支持批量）
     * 包含在租校验，用户在租不能删除
     * @param userIds 用户id数组
     * @return 删除数量
     */
    int deleteRenterByIds(Long[] userIds);
}
