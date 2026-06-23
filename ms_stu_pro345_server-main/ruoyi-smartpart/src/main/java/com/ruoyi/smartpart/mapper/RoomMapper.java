package com.ruoyi.smartpart.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.room.RoomQuery;
import com.ruoyi.smartpart.domain.query.room.RoomQueryByContract;
import com.ruoyi.smartpart.domain.vo.room.HomeRoomVo;
import com.ruoyi.smartpart.domain.vo.room.MyRoomVo;
import com.ruoyi.smartpart.domain.vo.room.RoomByContractListVo;
import com.ruoyi.smartpart.domain.vo.room.RoomListVo;
import com.ruoyi.smartpart.utils.PageParam;
import org.apache.ibatis.annotations.Param;


public interface RoomMapper extends BaseMapper<Room> {
    /**
     * 获取分页列表
     * @param wrapper 条件构造器
     * @param page 分页构造器
     * @return 分页列表
     */
    Page<RoomListVo> getPageList(@Param("ew") Wrapper<RoomListVo> wrapper,
                                 @Param("page") Page<RoomListVo> page);

    /**
     * 获取首页房间列表
     * @param wrapper 条件构造器
     * @param page 分页构造器
     * @return 分页列表
     */
    Page<HomeRoomVo> getHomeRoomList(@Param("ew") Wrapper<HomeRoomVo> wrapper,
                                     @Param("page") Page<HomeRoomVo> page);

    /**
     * 获取租户我的房间分页列表
     * @param wrapper 条件构造器
     * @param page 分页构造器
     * @return 分页列表
     */
    Page<MyRoomVo> getMyRoomList(@Param("ew") Wrapper<MyRoomVo> wrapper,
                                 @Param("page") Page<MyRoomVo> page);


    Page<RoomByContractListVo> getRoomByContract(@Param("page") Page<RoomByContractListVo> page
            , @Param(Constants.WRAPPER) Wrapper<RoomByContractListVo> wrapper);
}
