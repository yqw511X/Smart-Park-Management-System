package com.ruoyi.smartpart.service;

import com.ruoyi.smartpart.domain.entity.Floor;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.query.floor.FloorCreate;
import com.ruoyi.smartpart.domain.query.floor.FloorUpdate;
import com.ruoyi.smartpart.domain.vo.Floor.FloorDetailVo;
import io.swagger.models.auth.In;

import java.util.List;

/**
 * <p>
 * 楼层表 服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface FloorService extends IService<Floor> {

    /**
     * 楼层添加参数
     * @param create 楼层
     * @return 影响行数
     */
    Integer addFloor(FloorCreate create);

    /**
     * 楼层修改参数
     * @param update 楼层
     * @return 影响行数
     */
    Integer updateFloor(FloorUpdate update);

    /**
     * 删除楼层
     * @param floorIds 待删楼层
     * @return 影响行数
     */
    Integer deleteFloor(List<Long> floorIds);

    /**
     * 查询楼层详情
     * @param floorId 楼层Id
     * @return 影响行数
     */
    FloorDetailVo getFloorDetail(Long floorId);

}
