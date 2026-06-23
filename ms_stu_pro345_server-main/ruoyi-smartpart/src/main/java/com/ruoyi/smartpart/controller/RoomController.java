package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.query.room.RoomCreate;
import com.ruoyi.smartpart.domain.query.room.RoomQuery;
import com.ruoyi.smartpart.domain.query.room.RoomStatusUpdateQuery;
import com.ruoyi.smartpart.domain.query.room.RoomUpdateQuery;
import com.ruoyi.smartpart.domain.vo.room.RoomDetailVo;
import com.ruoyi.smartpart.domain.vo.room.RoomListVo;
import com.ruoyi.smartpart.domain.vo.room.RoomRecordVo;
import com.ruoyi.smartpart.service.RoomService;
import com.ruoyi.smartpart.utils.BaseController;
import com.ruoyi.smartpart.utils.PageDTO;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/room")
@Api(tags = "房间相关接口")
public class RoomController extends BaseController {

    @Autowired
    private RoomService roomService;

    @ApiOperation("房间分页列表")
    @GetMapping
    public PageDTO<RoomListVo> getPageList(RoomQuery query, @Validated PageParam pageParam){
        Page<RoomListVo> pageList = roomService.getPageList(query, pageParam);
        return PageDTO.of(pageList, RoomListVo.class);
    }

    @ApiOperation(value = "新增房间",notes = "图片要用数组的形式传回")
    @PostMapping
    public Result<Void> createRoom(@RequestBody @Validated RoomCreate create){
        return toResult(roomService.createRoom(create));
    }

    @ApiOperation("查询房间详情(用于编辑回显)")
    @GetMapping("/{roomId}")
    public Result<RoomDetailVo> getRoomInfo(@ApiParam(value = "房间ID", required = true) @PathVariable Long roomId){
        return Result.success(roomService.getRoomInfo(roomId));
    }

    @ApiOperation("修改房间")
    @PutMapping
    public Result<Void> updateRoom(@RequestBody @Validated RoomUpdateQuery update){
        return toResult(roomService.updateRoom(update));
    }

    @ApiOperation("修改房间上架状态")
    @PutMapping("/status")
    public Result<Void> updateStatus(@RequestBody @Validated RoomStatusUpdateQuery query){
        return toResult(roomService.updateStatus(query));
    }

    @ApiOperation("获取房间租赁记录")
    @GetMapping("/record/{roomId}")
    public Result<List<RoomRecordVo>> getRoomRecordList(@ApiParam(value = "房间ID", required = true) @PathVariable Long roomId) {
        return Result.success(roomService.getRoomRecordList(roomId));
    }

    @ApiOperation("删除房间(批量)")
    @DeleteMapping("/{roomIds}")
    public Result<Void> removeRoom(@ApiParam(value = "房间ID列表", required = true) @PathVariable List<Long> roomIds){
        return toResult(roomService.deleteRoom(roomIds));
    }

}
