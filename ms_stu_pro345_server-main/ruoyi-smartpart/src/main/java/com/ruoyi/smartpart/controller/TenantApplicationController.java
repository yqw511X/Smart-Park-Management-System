package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationSaveQuery;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantInfoCheckQuery;
import com.ruoyi.smartpart.domain.query.room.HomeRoomQuery;
import com.ruoyi.smartpart.domain.vo.room.HomeRoomVo;
import com.ruoyi.smartpart.domain.vo.room.TenantInfoVo;
import com.ruoyi.smartpart.service.RoomService;
import com.ruoyi.smartpart.service.TenantApplicationService;
import com.ruoyi.smartpart.utils.*;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/tenant/application")
@Api(tags = "租户端-租房申请相关接口")
public class TenantApplicationController extends BaseController {

    @Autowired
    private RoomService roomService;

    @Autowired
    private TenantApplicationService tenantApplicationService;

    @ApiOperation("查询首页房间列表")
    @GetMapping("/room/list")
    public PageDTO<HomeRoomVo> getHomeRoomList(HomeRoomQuery query, @Validated PageParam pageParam) {
        Page<HomeRoomVo> pageList = roomService.getHomeRoomList(query, pageParam);
        return PageDTO.of(pageList, HomeRoomVo.class);
    }

    @ApiOperation("获取租户个人信息(用于申请确认)")
    @GetMapping("/info")
    public Result<TenantInfoVo> getTenantInfo() {
        return Result.success(roomService.getTenantInfo());
    }

    @ApiOperation("信息确认校验接口(租赁接口)")
    @PostMapping("/check-status")
    public Result<Void> checkLeaseStatus(@Validated @RequestBody TenantInfoCheckQuery checkQuery) {
        tenantApplicationService.checkLeaseStatus(checkQuery);
        return Result.success(null);
    }

    @ApiOperation("提交租房申请")
    @PostMapping("/submit")
    public Result<Void> submitApplication(@Validated @RequestBody TenantApplicationSaveQuery saveQuery) {
        return toResult(tenantApplicationService.submitApplication(saveQuery));
    }

}
