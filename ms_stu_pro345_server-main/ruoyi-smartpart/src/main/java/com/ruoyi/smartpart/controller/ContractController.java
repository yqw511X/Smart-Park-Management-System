package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.core.domain.R;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.TenantBody;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.utils.poi.ExcelUtil;
import com.ruoyi.smartpart.domain.entity.*;
import com.ruoyi.smartpart.domain.query.Bill.BillInsertQuery;
import com.ruoyi.smartpart.domain.query.Contract.*;
import com.ruoyi.smartpart.domain.query.room.RoomQueryByContract;
import com.ruoyi.smartpart.domain.vo.Bill.BillDetailVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContracPreviewtListVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContractListVo;
import com.ruoyi.smartpart.domain.vo.Contract.TenantListVo;
import com.ruoyi.smartpart.domain.vo.room.RoomByContractListVo;
import com.ruoyi.smartpart.domain.vo.room.RoomPreviewVo;
import com.ruoyi.smartpart.mapping.*;
import com.ruoyi.smartpart.service.*;
import com.ruoyi.smartpart.utils.BaseController;
import com.ruoyi.smartpart.utils.PageDTO;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.Result;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.Min;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * <p>
 * 合同 前端控制器
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@RestController
@RequestMapping("/contract")
@Api(tags = "合同相关接口")
public class ContractController extends BaseController {

    @Autowired
    private ContractService contractService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private ISysUserService sysUserService;

    @Autowired
    private LeaseCancellationService leaseCancellationService;

    @Autowired
    private BillService billService;

    @Autowired
    private FloorService floorService;

    @Autowired
    private BuildingService buildingService;

    @Autowired
    private TenantApplicationService tenantApplicationService;

    @Autowired
    private RoomRecordService roomRecordService;

    @ApiOperation(value = "分页查询合同信息列表",notes = "ruoyi自带的实现方法")
    @GetMapping("/list")
    public PageDTO<ContractListVo> list(@Validated PageParam pageParam,
                                              ContractQuery contractQuery){


        Page<ContractListVo> page = contractService.getPageLists(pageParam,contractQuery);


        return PageDTO.of(page,ContractListVo.class);

    }




    @ApiOperation( "分页查询新增功能下的租户信息列表")
    @GetMapping("/insert/tenantList")
    public PageDTO<TenantListVo> tenantList(@Validated PageParam pageParam,
                                            TenantListQuery tenantListQuery){





        Page<TenantListVo> page = contractService.getPageTenantLists(pageParam, tenantListQuery);


        return PageDTO.of(page,TenantListVo.class);

    }



    @ApiOperation( "分页查询新增功能下的房间信息列表")
    @GetMapping("/insert/roomList")
    public PageDTO<RoomByContractListVo> roomList(@Validated PageParam pageParam,
                                                  RoomQueryByContract roomQueryByContract){





        Page<RoomByContractListVo> page = roomService.getRoomByContract(pageParam, roomQueryByContract);


        return PageDTO.of(page,RoomByContractListVo.class);

    }



    @PostMapping
    @ApiOperation("新增合同对象")
    public Result<Void> contractInsert(@RequestBody @Validated ContractInsertQuery contractInsertQuery){

        Long roomId = contractInsertQuery.getRoomId();



        //房间不可以二次出租
        Contract one = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getRoomId, roomId).eq(Contract::getDelFlag, 0));
        if (one !=null){
            return Result.fail("该房间已经出租 操作失败");
        }
        Room room = roomService.getOne(new LambdaQueryWrapper<Room>()
                .eq(Room::getRoomId, roomId).eq(Room::getDelFlag, 0));
        if (room == null || !room.getStatus().equals("1")){
            return Result.fail("该房间未上架 操作失败");
        }




        return toResult(contractService.insert(contractInsertQuery));





    }

    @ApiOperation("编辑合同")
    @PutMapping("/updata")
    public  Result<Void> contractUpdataById(@RequestBody @Validated ContractUpdataQuery contractUpdataQuery){

        // 查询合同对象
        Long contractId = contractUpdataQuery.getContractId();
        Long roomId = contractUpdataQuery.getRoomId();
        Contract one = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getContractId, contractId).eq(Contract::getDelFlag, 0));

        //房间不可以二次出租
        Contract contractTenat = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getRoomId, roomId).ne(Contract::getContractId,contractId).eq(Contract::getDelFlag, 0));
        if (contractTenat != null){
            return Result.fail("该房间已经出租 操作失败");
        }

        Room room = roomService.getOne(new LambdaQueryWrapper<Room>()
                .eq(Room::getRoomId, roomId).eq(Room::getDelFlag, 0));
        if (room == null || !room.getStatus().equals("1")){
            return Result.fail("该房间未上架 操作失败");
        }

        String status = one.getStatus();

        if (!status.equals("0")){

            return Result.fail("该合同已经签约,无法进行修改操作");
        }


        return  toResult(contractService.updata(contractUpdataQuery));
    }



    @ApiOperation("签订")
    @PostMapping("/sign")
    @Transactional(rollbackFor = Exception.class)
    public  Result<Void> contractSignById( @RequestParam("contractId")
                                               @Min(value = 1, message = "合同ID必须大于0") Long contractId){

        Contract one = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getContractId, contractId).eq(Contract::getDelFlag, 0));


        String status = one.getStatus();

        if (!status.equals("0")){
            return Result.fail("该合同已经签约,该操作");
        }
        // 更改合同对应的租赁申请状态
        tenantApplicationService.updateRoomStatusByContractId(contractId);
        // 对应房间设置房间用户id
        roomService.updateRoomUserId(one.getRoomId(),one.getTenantId());
        // 创建租房记录
        roomRecordService.createRoomRecord(one.getRoomId(), one.getTenantId(), one.getContractId(), one.getStartTime());

        return  toResult(contractService.sign(one));
    }

    @ApiOperation("预览")
    @GetMapping("/preview")
    public  Result<ContracPreviewtListVo> contractPreviewList(@RequestParam("contractId")
                                                           @Min(value = 1, message = "合同ID必须大于0") Long contractId){
        Contract one = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getContractId, contractId).eq(Contract::getDelFlag, 0));


        ContracPreviewtListVo previewtOne = ContractMapping.INSTANCE.toSet(one);

        Long roomId = one.getRoomId();

        Room room = roomService.getOne(new LambdaQueryWrapper<Room>()
                .eq(Room::getRoomId, roomId).eq(Room::getDelFlag, 0));

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


    @ApiOperation("预览账单详情")
    @GetMapping("/bill")
    public  Result<BillDetailVo> BillPreviewList(@RequestParam("contractId")
                                                              @Min(value = 1, message = "合同ID必须大于0") Long contractId){
        Bill bill = billService.getOne(new LambdaQueryWrapper<Bill>()
                .eq(Bill::getContractId, contractId).eq(Bill::getDelFlag, 0));


        BillDetailVo detail = BillMapping.INSTANCE.toDetail(bill);



        return  Result.success(detail);


    }


    @ApiOperation("变更")
    @PutMapping("/change")
    public  Result<Void> contractChangeById(@RequestBody @Validated ContractChangeQuery contractChangeQuery){

        // 查询合同对象
        Long contractId = contractChangeQuery.getContractId();
        Long roomId = contractChangeQuery.getRoomId();
        Contract one = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getContractId, contractId).eq(Contract::getDelFlag, 0));

        //房间不可以二次出租
        Contract contractTenat = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getRoomId, roomId).ne(Contract::getContractId,contractId).eq(Contract::getDelFlag, 0));
        if (contractTenat != null){
            return Result.fail("该房间已经出租 操作失败");
        }
        Room room = roomService.getOne(new LambdaQueryWrapper<Room>()
                .eq(Room::getRoomId, roomId).eq(Room::getDelFlag, 0));
        if (room == null || !room.getStatus().equals("1")){
            return Result.fail("该房间未上架 操作失败");
        }

        String status = one.getStatus();

        if (!status.equals("1")){

            return Result.fail("该合同不是签约状态,无法进行该操作");
        }

        Contract change = ContractMapping.INSTANCE.toChange(contractChangeQuery);
        change.setVersionNum(one.getVersionNum());


        return  toResult(contractService.change(change));




    }


    // 退租功能 退租时会引发账单的生成和

    @ApiOperation("退租功能")
    @PutMapping("/lease")
    public  Result<Void> contractLeaseById(@RequestBody @Validated LeaseCancellationQuery leaseCancellationQuery){

        long contractId = leaseCancellationQuery.getContractId();
        Contract contract = contractService.getOne(new LambdaQueryWrapper<Contract>()
                .eq(Contract::getContractId, contractId).eq(Contract::getDelFlag, 0));


        String status = contract.getStatus();
        if (!status.equals("1")){
            return Result.fail("该合同不是签约状态,无法进行修改操作");
        }

        // 账单开始 结束时间
        LocalDateTime tenantTime = leaseCancellationQuery.getTenantTime();

        LocalDateTime startTime = contract.getStartTime();


        // 2. 计算实际租住的自然日天数（对齐前端 Math.ceil 向上取整逻辑）
        long daysLong = Duration.between(startTime, tenantTime).toDays();
        long days = daysLong == 0 ? 1 : daysLong; // 不足一天按一天算

        // 3. 准备 BigDecimal 数值，防止精度丢失
        BigDecimal bigDays = BigDecimal.valueOf(days);
        BigDecimal divisor = new BigDecimal("30"); // 前端固定的除数

        BigDecimal actualRent;
        // 4. 核心修改：根据 tenantMethod 严格复刻前端计算逻辑
        if ("0".equals(contract.getTenantMethod())) {
            // 模式 '0'：按固定租金（前端逻辑：总天数 / 30 * 月租金）
            // 这里除以30时保留10位小数，采用四舍五入，尽量模拟JS的浮点数除法
            BigDecimal monthRent = BigDecimal.valueOf(contract.getMonthRent());
            actualRent = bigDays.divide(divisor, 10, RoundingMode.HALF_UP).multiply(monthRent);
        } else {
            // 模式 '1'：按实际天数（前端逻辑：总天数 * 日租金）
            BigDecimal dailyRent = BigDecimal.valueOf(contract.getDailyRent());
            actualRent = bigDays.multiply(dailyRent);
        }

        // 5. 管理费计算（前端逻辑：统一按天计算）
        BigDecimal dailyFee = BigDecimal.valueOf(contract.getDailyFee());
        BigDecimal actualManageFee = bigDays.multiply(dailyFee);

        // 6. 计算实际产生的总费用
        BigDecimal actualTotalCost = actualRent.add(actualManageFee);

        // 7. 计算退款 = 租客已交总金额 - 实际产生的费用
        BigDecimal paidAmount = BigDecimal.valueOf(contract.getMortgagePay());
        BigDecimal refundFees = paidAmount.subtract(actualTotalCost);

        // 8. 组装账单数据，最终金额保留2位小数存入数据库
        BillInsertQuery billInsertQuery = new BillInsertQuery();
        billInsertQuery.setManageFee(actualManageFee.setScale(2, RoundingMode.HALF_UP).doubleValue());
        billInsertQuery.setTenantMoney(actualRent.setScale(2, RoundingMode.HALF_UP).doubleValue());

        billInsertQuery.setContractId(contract.getContractId());
        billInsertQuery.setRoomId(contract.getRoomId());
        billInsertQuery.setTenantId(contract.getTenantId());
        billInsertQuery.setDeadline(contract.getDateSign());
        billInsertQuery.setDeposit(contract.getMortgagePay());
        billInsertQuery.setPayment(startTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")) + "~"
                + tenantTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        billInsertQuery.setStartPayment(startTime);
        billInsertQuery.setEndPayment(tenantTime);
        billInsertQuery.setStatus("0"); // 0-待结清/待审核

        // 核心赋值：使用后端按前端逻辑重新算出来的金额
        billInsertQuery.setRefundFees(refundFees.setScale(2, RoundingMode.HALF_UP).doubleValue());
        billInsertQuery.setTotalPay(actualTotalCost.setScale(2, RoundingMode.HALF_UP).doubleValue());

        billInsertQuery.setOverdue("0");
        billInsertQuery.setRemark(leaseCancellationQuery.getRemark());

        billService.insert(billInsertQuery);

        // 更新合同状态为已退租
        contract.setStatus("2");
        contractService.change(contract);

        // 记录退租流水
        return toResult(leaseCancellationService.insert(leaseCancellationQuery));
    }



    /**
     *      容错处理 ： 如果 账单 内部  合同  无法删除
     * @param  contractIds
     * @return
     */
    @ApiOperation("删除合同信息")
    @ApiImplicitParam(name = "contractIds",value = "合同ids",required = true)
    @DeleteMapping("/{contractIds}")
    public Result<Void> delect(@PathVariable List<Long> contractIds) {
        for (Long contractId : contractIds) {
            Bill one = billService.getOne(new LambdaQueryWrapper<Bill>()
                    .eq(Bill::getContractId, contractId).eq(Bill::getDelFlag, 0));

            if (one!=null){
                return Result.fail("该合同不是无法删除,账单数据依然存在");
            }


        }




        return  toResult(contractService.removeByIds(contractIds));
    }


    // 编号前缀，可以根据业务类型修改，例如 "CONTRACT_", "BILL_", "ORDER_" 等
    private static final String PREFIX = "CONTRACT_";

    // 用于生成当日序号的原子计数器
    private static final AtomicInteger sequenceCounter = new AtomicInteger(0);

    // 日期格式化器，用于生成日期部分
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyyMMdd");


    @ApiOperation(value = "合同编号生成")
    @GetMapping("/contractNum")
    public Result<String> contractNum(){

        // 1. 获取当前日期字符串 (例如 "20260224")
        String dateString = DATE_FORMAT.format(new Date());

        // 2. 获取并递增当日序号 (线程安全)
        int currentSequence = sequenceCounter.incrementAndGet();

        // 3. 格式化序号为4位数字，不足前面补0 (例如 1 -> "0001")
        String sequenceString = String.format("%04d", currentSequence);

        // 4. 组合前缀、日期和序号
        return Result.success(PREFIX + dateString + "_" + sequenceString);



    }














}
