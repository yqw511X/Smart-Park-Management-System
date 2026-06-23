package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.smartpart.domain.create.RepairOrderCreate;
import com.ruoyi.smartpart.domain.entity.RepairLog;
import com.ruoyi.smartpart.domain.entity.RepairOrder;
import com.ruoyi.smartpart.domain.query.repairorder.*;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairLogProVo;
import com.ruoyi.smartpart.domain.vo.repairlog.RepairStatusLog;
import com.ruoyi.smartpart.domain.vo.repairman.RepairManNameListVo;
import com.ruoyi.smartpart.domain.vo.repairorder.*;
import com.ruoyi.smartpart.service.MsUserService;
import com.ruoyi.smartpart.service.RepairLogService;
import com.ruoyi.smartpart.service.RepairOrderService;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.Result;
import com.ruoyi.system.domain.renter.RenterAdd;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.PrimitiveIterator;

/**
 * <p>
 * 维修单 前端控制器
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@RestController
@RequestMapping("/repair-order")
@Api(tags = "工单管理")

public class RepairOrderController extends BaseController {

    @Autowired
    private RepairOrderService repairOrderService;

    @Autowired
    private SysUserServiceImpl sysUserService;

    @Autowired
    private RepairLogService repairLogService;

    @Autowired
    private MsUserService msUserService;

    @ApiOperation("根据报修单号,工单状态查询工单列表")
    @GetMapping("/list")
    public TableDataInfo<List<RepairOrderListVo>> getRepairOrderList(PageParam pageParam, String repairNum, String status) {
        List<RepairOrder> repairOrderListVo = repairOrderService.selectList(repairNum, status);
        List<RepairOrderListVo> repairOrderListVo1List = new ArrayList<>();
        for (RepairOrder repairOrder : repairOrderListVo) {
            RepairOrderListVo repairOrderListVo1 = new RepairOrderListVo();
            repairOrderListVo1.setRepairOrderId(repairOrder.getRepairOrderId());
            repairOrderListVo1.setRepairNum(repairOrder.getRepairNum());
            repairOrderListVo1.setStatus(repairOrder.getStatus());
            repairOrderListVo1.setCreateTime(repairOrder.getCreateTime());
            //维修工可能为空
            SysUser repairUser = sysUserService.selectUserById(repairOrder.getRepairId());
            repairOrderListVo1.setWorkerName(StringUtils.isNotNull(repairUser)?repairUser.getNickName():null);
            repairOrderListVo1.setContactName(repairOrder.getContactName());
            repairOrderListVo1.setContactPhone(repairOrder.getContactPhone());
            repairOrderListVo1.setRepairArea(repairOrder.getRepairArea());
            repairOrderListVo1List.add(repairOrderListVo1);
        }
        List<RepairOrderListVo> repairOrderListVo1List1 = repairOrderListVo1List.subList((pageParam.getPageNum() - 1) * pageParam.getPageSize(), Math.min(pageParam.getPageNum() * pageParam.getPageSize(), repairOrderListVo1List.size()));
        return getDataTable(repairOrderListVo1List1, (long) repairOrderListVo1List.size());
    }


    @ApiOperation("租户端创建工单")
    @PostMapping("/create")
    public AjaxResult createRepairOrder(@RequestBody @Validated RepairOrderCreate repairOrder) {
        int i = repairOrderService.insertRenterOrder(repairOrder);
        if(i == 0){
            return AjaxResult.error("创建失败");
        }
        return AjaxResult.success(i);
    }

    @ApiOperation("租户端修改状态")
    @PutMapping("/cancel")
    public AjaxResult cancelRepairOrder(@RequestBody @Validated RepairOrderStatusUpdate statusUpdate) {
        int i = repairOrderService.updateRepairOrderStatus(statusUpdate);
        if(i == 0){
            return AjaxResult.error("修改失败");
        }
        return AjaxResult.success(i);
    }

    @ApiOperation("管理员指派维修工")
    @PostMapping("/assign")
    public Result<Integer> assignRepairOrder(@Validated @RequestBody RepairManCreate repairManCreate) {
        int i = repairOrderService.updateRepairOrder(repairManCreate);
        return Result.success(i);
    }

    @ApiOperation("批量删除工单(支持批量)")
    @DeleteMapping("/{repairOrderIds}")
    public Result<Integer> deleteRepairOrderByIds(@PathVariable Long[] repairOrderIds){
        int i = repairOrderService.deleteRepairOrderByIds(repairOrderIds);
        return Result.success(i);
    }

    @ApiOperation("根据工单id查询报修信息详情")
    @GetMapping("/{repairOrderId}")
    public Result<RepairOrderDtlVo> getRepairOrderDetail(@PathVariable Long repairOrderId){
        RepairOrderDtlVo repairOrderDtlVo = repairOrderService.getRepairOrderDtlVo(repairOrderId);
        return Result.success(repairOrderDtlVo);
    }

    @ApiOperation("查询维修进度")
    @GetMapping("/progress/{repairOrderId}")
    public Result<RepairStatusLog> getRepairOrderProgress(@PathVariable Long repairOrderId){
        RepairStatusLog repairLog = repairLogService.selectList(repairOrderId);
        return Result.success(repairLog);
    }

    @ApiOperation("查询维修日志")
    @GetMapping("/repair-info/{repairOrderId}")
    public Result<List<RepairLogMeVo>> getRepairOrderInfo(@PathVariable Long repairOrderId){
        List<RepairLogMeVo> repairLogList = repairOrderService.selectRepairList(repairOrderId);
        return Result.success(repairLogList);
    }

    @ApiOperation("租户端我的报修")
    @GetMapping("/me")
    public TableDataInfo<List<RepairOrderPageVo>> getRepairOrderMe(PageParam pageParam, @Validated RepairOrderTenantQuery repairOrderQuery){

        List<RepairOrderPageVo> repairOrderMeVoList = repairOrderService.selectRepairTenant(repairOrderQuery);
        List<RepairOrderPageVo> repairOrderMeVoList1 = repairOrderMeVoList.subList((pageParam.getPageNum() - 1) * pageParam.getPageSize(), Math.min(pageParam.getPageNum() * pageParam.getPageSize(), repairOrderMeVoList.size()));
        return getDataTable(repairOrderMeVoList1, (long) repairOrderMeVoList.size());
    }

    @ApiOperation("租户端修改我的报修")
    @PostMapping("/update")
    public AjaxResult updateRepairOrder(@RequestBody @Validated RepairOrderUpdate repairOrderUpdate){
        int i = repairOrderService.updateRepairOrderTenant(repairOrderUpdate);
        if(i == 0){
            return AjaxResult.error("修改失败");
        }
        return AjaxResult.success(i);
    }


    @ApiOperation("维修工端查询工单详细信息")
    @GetMapping("/worker/{repairOrderId}")
    public Result<RepairOrderReDtlVo> getRepairOrderDetailWorker(@PathVariable Long repairOrderId){
        RepairOrderReDtlVo repairOrderDtlVo = repairOrderService.getRepairOrderReDtlVo(repairOrderId);
        return Result.success(repairOrderDtlVo);
    }

    @ApiOperation("根据维修单id查询维修信息")
    @GetMapping("/{repairOrderId}/Me")
    public Result<RepairOrderMeQuery> getRepairOrderInfoWorker(@PathVariable Long repairOrderId){
        RepairOrderMeQuery repairLogLi = repairOrderService.selectRepairListWorker(repairOrderId);
        return Result.success(repairLogLi);
    }

    @ApiOperation(value = "查询维修工名称列表")
    @GetMapping("/repairMan/name")
    public List<RepairManNameListVo> getRepairNameList(){
        return msUserService.getRepairManNameList();
    }

    @ApiOperation(value = "查询工单列表(维修工端)",notes = "测试维修工账号weixiu，密码123456")
    @GetMapping("/repairMan/list")
    public TableDataInfo<List<RepairManOrderListVo>> getRepairOrderList(@Validated RepairOrderQuery repairOrderQuery,
                                                                      @Validated PageParam pageParam) {
        Page<RepairManOrderListVo> page = repairOrderService.getOrderManPage(repairOrderQuery, pageParam);
        return getDataTable(page.getRecords(),page.getTotal());
    }

}
