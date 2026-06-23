package com.ruoyi.smartpart.service;

import com.ruoyi.smartpart.domain.entity.Building;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.query.Building.BuildingCreate;
import com.ruoyi.smartpart.domain.query.Building.BuildingUpdate;
import com.ruoyi.smartpart.domain.vo.Building.BuildingDetailVo;
import com.ruoyi.smartpart.domain.vo.Building.BuildingNameListVo;

import java.util.List;

/**
 * <p>
 * 楼宇表 服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface BuildingService extends IService<Building> {
    /**
     * 新增楼宇
     * @param create 楼宇参数
     * @return 影响行数
     */
    Integer addBuilding(BuildingCreate create);

    /**
     * 修改楼宇
     * @param update 楼宇参数
     * @return 影响行数
     */
    Integer updateBuilding(BuildingUpdate update);

    /**
     * 删除楼宇
     * @param buildIds 楼宇id
     * @return 影响行数
     */
    Integer deleteBuilding(List<Long> buildIds);

    /**
     * 楼宇详情
     * @param buildId 楼宇id
     * @return 影响行数
     */
    BuildingDetailVo getDetail(Long buildId);

    /**
     * 查询楼宇名称列表
     * @return 名称列表
     */
    List<BuildingNameListVo> getNameList();

}
