package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.smartpart.domain.entity.Floor;
import com.ruoyi.smartpart.domain.query.floor.FloorCreate;
import com.ruoyi.smartpart.domain.query.floor.FloorUpdate;
import com.ruoyi.smartpart.domain.vo.Floor.FloorDetailVo;
import com.ruoyi.smartpart.domain.vo.Floor.FloorListVo;
import com.ruoyi.smartpart.domain.vo.Floor.FloorNameListVo;
import com.ruoyi.smartpart.mapping.FloorMapping;
import com.ruoyi.smartpart.service.FloorService;
import com.ruoyi.smartpart.service.RoomService;
import com.ruoyi.smartpart.utils.BaseController;
import com.ruoyi.smartpart.utils.PageDTO;
import com.ruoyi.smartpart.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Api(tags = "楼层相关接口")
@RestController
@RequestMapping("/floor")
public class FloorController extends BaseController {

    @Autowired
    private FloorService floorService;

    @ApiOperation("查询楼层列表")
    @GetMapping("/{buildingId}")
    public Result<List<FloorListVo>> getFloorList(@PathVariable Long buildingId){
        LambdaQueryWrapper<Floor> lqw = Wrappers.lambdaQuery();
        lqw.eq(Floor::getBuildingId, buildingId);
        return Result.success(FloorMapping.INSTANCE.toListVo(floorService.list(lqw)));
    }

    @ApiOperation("新增楼层")
    @PostMapping
    public Result<Void> addFloor(@Validated @RequestBody FloorCreate create){
        return toResult(floorService.addFloor(create));
    }

    @ApiOperation("修改楼层")
    @PutMapping
    public Result<Void> updateFloor(@Validated @RequestBody FloorUpdate update){
        return toResult(floorService.updateFloor(update));
    }

    @ApiOperation("删除楼层(批量)")
    @DeleteMapping("/{floorIds}")
    public Result<Void> removeFloor(@PathVariable List<Long> floorIds){
        return toResult(floorService.deleteFloor(floorIds));
    }

    @ApiOperation("查询楼层详情")
    @GetMapping("/detail/{floorId}")
    public Result<FloorDetailVo> getFloorDetail(@PathVariable Long floorId){
        return Result.success(floorService.getFloorDetail(floorId));
    }

    @ApiOperation("查询楼层名称列表")
    @GetMapping("/name/{buildingId}")
    public Result<List<FloorNameListVo>> getNameList(@PathVariable Long buildingId){
        LambdaQueryWrapper<Floor> lqw = Wrappers.lambdaQuery();
        lqw.eq(Floor::getBuildingId, buildingId);
        return Result.success(FloorMapping.INSTANCE.toNameList(floorService.list(lqw)));
    }
}
