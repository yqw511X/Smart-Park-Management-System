package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.utils.DictUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.entity.Building;
import com.ruoyi.smartpart.domain.query.Building.BuildingCreate;
import com.ruoyi.smartpart.domain.query.Building.BuildingUpdate;
import com.ruoyi.smartpart.domain.vo.Building.BuildingDetailVo;
import com.ruoyi.smartpart.domain.vo.Building.BuildingListVo;
import com.ruoyi.smartpart.domain.vo.Building.BuildingNameListVo;
import com.ruoyi.smartpart.service.BuildingService;
import com.ruoyi.smartpart.utils.BaseController;
import com.ruoyi.smartpart.utils.PageDTO;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/building")
@Api(tags = "楼宇相关接口")
public class BuildingController extends BaseController {

    @Autowired
    private BuildingService buildingService;

    @ApiOperation("新增楼宇")
    @PostMapping
    public Result<Void> addBuilding(@RequestBody @Validated BuildingCreate create){
        return toResult(buildingService.addBuilding(create));
    }

    @GetMapping
    @ApiOperation("查询楼宇列表(分页)")
    @ApiImplicitParam(name = "buildingName",value = "楼宇名称")
    public PageDTO<BuildingListVo> getPage(String buildingName, @Validated PageParam pageParam){
        LambdaQueryWrapper<Building> lqw = Wrappers.lambdaQuery();
        lqw.like(StringUtils.hasText(buildingName),Building::getBuildingName, buildingName);

        //分页对象
        Page<Building> page = buildingService.page(new Page<>(pageParam.getPageNum(), pageParam.getPageSize()), lqw);
        return PageDTO.of(page, BuildingListVo.class);
    }

    @GetMapping("/list")
    @ApiOperation("查询楼宇名称列表")
    public Result<List<BuildingNameListVo>> list(){
        return Result.success(buildingService.getNameList());
    }


    @PutMapping
    @ApiOperation("修改楼宇")
    public Result<Void> update(@RequestBody @Validated BuildingUpdate update){
        return toResult(buildingService.updateBuilding(update));
    }

    @DeleteMapping("/{buildIds}")
    @ApiOperation("删除楼宇(批量)")
    public Result<Void> delete(@PathVariable List<Long> buildIds){
        return toResult(buildingService.deleteBuilding(buildIds));
    }

    @GetMapping("/{buildId}")
    @ApiOperation("查询楼宇详情")
    public Result<BuildingDetailVo> detail(@PathVariable Long buildId){
        return Result.success(buildingService.getDetail(buildId));
    }

}
