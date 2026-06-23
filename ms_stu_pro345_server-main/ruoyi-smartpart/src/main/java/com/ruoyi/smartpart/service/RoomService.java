package com.ruoyi.smartpart.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.Room;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.room.*;
import com.ruoyi.smartpart.domain.vo.room.*;
import com.ruoyi.smartpart.utils.PageParam;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
public interface RoomService extends IService<Room> {
    /**
     * 获取分页列表
     * @param query 查询参数
     * @param pageParam 分页参数
     * @return 分页数据
     */
    Page<RoomListVo> getPageList(RoomQuery query, PageParam pageParam);

    /**
     * 获取租户我的房间分页列表
     * @param query 查询参数
     * @param pageParam 分页参数
     * @return 分页数据
     */
    Page<MyRoomVo> getMyRoomList(MyRoomQuery query, PageParam pageParam);

    /**
     * 获取首页房间列表
     * @param query 查询参数
     * @param pageParam 分页参数
     * @return 分页数据
     */
    Page<HomeRoomVo> getHomeRoomList(HomeRoomQuery query, PageParam pageParam);

    /**
     * 获取租户个人信息
     * @return 个人信息
     */
    TenantInfoVo getTenantInfo();


    /**
     * 获取合同模块新增功能下的房间分页列表
     * @param pageParam
     * @param roomQueryByContract
     * @return
     */
    Page<RoomByContractListVo> getRoomByContract(PageParam pageParam, RoomQueryByContract roomQueryByContract);

    /**
     * 新增房间
     * @param create 房间
     * @return 影响行数
     */
    Integer createRoom(RoomCreate create);

    /**
     * 根据id查询房间详情
     * @param roomId 房间id
     * @return 房间详情
     */
    RoomDetailVo getRoomInfo(Long roomId);

    /**
     * 修改房间
     * @param update 修改参数
     * @return 影响行数
     */
    Integer updateRoom(RoomUpdateQuery update);

    /**
     * 批量删除房间
     * @param roomIds 房间id列表
     * @return 影响行数
     */
    Integer deleteRoom(List<Long> roomIds);

    /**
     * 修改房间状态
     * @param query 修改参数
     * @return 影响行数
     */
    Integer updateStatus(RoomStatusUpdateQuery query);

    /**
     * 取消房间申请
     * @param applicationId 申请id
     * @return 影响行数
     */
    Integer cancelApplication(Long applicationId);

    /**
     * 获取房间记录列表
     * @param roomId 房间id
     * @return 房间记录列表
     */
    List<RoomRecordVo> getRoomRecordList(Long roomId);

    /**
     * 更新房间的用户
     * @param roomId
     * @param userId
     * @return
     */
    int updateRoomUserId(Long roomId, Long userId);

    /**
     * 判断用户是否在租
     * @param userId 用户id
     * @return
     */
    boolean isUserHaveRoom(Long userId);
}
