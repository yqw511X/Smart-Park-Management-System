package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.TenantBody;
import com.ruoyi.smartpart.domain.entity.Building;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.entity.Floor;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.query.room.MyRoomQuery;
import com.ruoyi.smartpart.domain.vo.Contract.ContracPreviewtListVo;
import com.ruoyi.smartpart.domain.vo.room.MyRoomVo;
import com.ruoyi.smartpart.domain.vo.room.RoomPreviewVo;
import com.ruoyi.smartpart.domain.vo.room.TenantInfoVo;
import com.ruoyi.smartpart.mapping.ContractMapping;
import com.ruoyi.smartpart.mapping.RoomMapping;
import com.ruoyi.smartpart.mapping.SysUserMapping;
import com.ruoyi.smartpart.service.*;
import com.ruoyi.smartpart.utils.BaseController;
import com.ruoyi.smartpart.utils.PageDTO;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.Result;
import com.ruoyi.system.service.ISysUserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 租户端-我的房间
 */
@RestController
@RequestMapping("/tenant/room")
@Api(tags = "租户端-我的房间相关接口")
public class TenantRoomController extends BaseController {

    @Autowired
    private RoomService roomService;

    @Autowired
    private ContractService contractService;

    @Autowired
    private BillService billService;

    @Autowired
    private FloorService floorService;

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private BuildingService buildingService;

    @ApiOperation("查询已上架的房间列表(我的房间)")
    @GetMapping("/list")
    public PageDTO<MyRoomVo> getMyRoomList(MyRoomQuery query, @Validated PageParam pageParam) {
        Page<MyRoomVo> pageList = roomService.getMyRoomList(query, pageParam);
        return PageDTO.of(pageList, MyRoomVo.class);
    }

    @ApiOperation("取消申请")
    @PutMapping("/cancel/{applicationId}")
    @ApiImplicitParam(name = "applicationId",value = "房间申请记录id")
    public Result<Void> cancelApplication(@PathVariable Long applicationId) {
        return toResult(roomService.cancelApplication(applicationId));
    }

    @ApiOperation("合同详情-待写")
    @PutMapping("/contract/{roomId}")
    @ApiImplicitParam(name = "roomId",value = "房间id")
    public Result<ContracPreviewtListVo> getContractDetail(@ApiParam(value = "房间ID", required = true) @PathVariable Long roomId){

        Room room = roomService.getById(roomId);

        Contract contract = contractService.getByRoomId(roomId);

        if (contract.getStatus().equals("0")) {


            return Result.fail("房间不处于在租/退租状态无法查看合同信息");

        }


        Long contractId = contract.getContractId();
        Contract one = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getContractId, contractId).eq(Contract::getDelFlag, 0));


        ContracPreviewtListVo previewtOne = ContractMapping.INSTANCE.toSet(one);



        Long floorId = room.getFloorId();
        Long buildingId = room.getBuildingId();
        Floor floor = floorService.getOne(new LambdaQueryWrapper<Floor>()
                .eq(Floor::getFloorId, floorId).eq(Floor::getDelFlag, 0));

        Building building = buildingService.getOne(new LambdaQueryWrapper<Building>()
                .eq(Building::getBuildingId, buildingId).eq(Building::getDelFlag, 0));

        RoomPreviewVo preview = RoomMapping.INSTANCE.toPreview(room);

        preview.setFloorName(floor.getFloorName());
        preview.setBuildingName(building.getBuildingName());


        previewtOne.setRoomPreviewVo(preview);

        Long tenantId = one.getTenantId();
        SysUser sysUser = sysUserService.selectUserById(tenantId);

        TenantBody previewtenant = SysUserMapping.INSTANCE.toPreview(sysUser);
        previewtenant.setHomeAddress(room.getRoomName());


        previewtOne.setTenantBody(previewtenant);
        return  Result.success(previewtOne);




    }

}
