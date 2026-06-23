package com.ruoyi.web.controller.system;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.entity.SysUser;
import com.ruoyi.common.core.domain.model.RegisterBody;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.framework.web.service.SysRegisterService;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.entity.MsUser;
import com.ruoyi.smartpart.domain.entity.Room;
import com.ruoyi.smartpart.domain.entity.TenantApplication;
import com.ruoyi.smartpart.domain.query.Contract.ContractInsertQuery;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationChange;
import com.ruoyi.smartpart.domain.query.TenantApplication.TenantApplicationQuery;
import com.ruoyi.smartpart.domain.query.msUser.RenterUpdate;
import com.ruoyi.smartpart.domain.vo.msUser.RenterDetailVo;
import com.ruoyi.smartpart.domain.vo.msUser.RenterInsert;
import com.ruoyi.smartpart.domain.vo.room.RoomRecordByApproveVo;
import com.ruoyi.smartpart.mapping.MsUserMapping;
import com.ruoyi.smartpart.mapping.SysUserMapping;
import com.ruoyi.smartpart.service.ContractService;
import com.ruoyi.smartpart.service.MsUserService;
import com.ruoyi.smartpart.service.RoomService;
import com.ruoyi.smartpart.service.impl.TenantApplicationServiceImpl;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.Result;
import com.ruoyi.system.domain.renter.RenterAdd;
import com.ruoyi.system.domain.vo.renter.RenterListVo;
import com.ruoyi.system.service.impl.SysUserServiceImpl;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;


@Api(tags = "租户管理")
@RestController
@RequestMapping("/renter")
public class RenterController extends BaseController {

    @Autowired
    private SysUserServiceImpl sysUserService;

    @Autowired
    private TenantApplicationServiceImpl tenantApplicationService;

    @Autowired
    private RoomService roomService;

    @Autowired
    private ContractService contractService;

    @Autowired
    private MsUserService msUserService;

    @Autowired
    private SysRegisterService registerService;

    // 编号前缀，可以根据业务类型修改，例如 "CONTRACT_", "BILL_", "ORDER_" 等
    private static final String PREFIX = "CONTRACT_";

    // 用于生成当日序号的原子计数器
    private static final AtomicInteger sequenceCounter = new AtomicInteger(0);

    // 日期格式化器，用于生成日期部分
    private static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyyMMdd");


    @ApiOperation("根据用户名查询所有租户")
    @GetMapping("/all")
    public TableDataInfo<List<RenterListVo>> getRenterList(PageParam pageParam,String username){
        Page<RenterListVo> page = msUserService.getRenterList(pageParam, username);
        return getDataTable(page.getRecords(), page.getTotal());
    }

    @PostMapping("/add")
    @ApiOperation("添加租户")
    public Result<Integer> addRenter(@RequestBody RenterInsert renterAdd) {
        // 校验确认密码是否与密码一致
        if (!renterAdd.getPassword().equals(renterAdd.getConfirmPassword())) {
            return Result.fail("确认密码与密码不一致");
        }



        RegisterBody renter = SysUserMapping.INSTANCE.toRenter(renterAdd);
        renter.setUsername(renterAdd.getUserName());
        renter.setNickname(renterAdd.getUserName());
        renter.setPasswords(renterAdd.getConfirmPassword());
        renter.setRoleId(3L);
        System.out.println(renter.toString());


        String msg = registerService.register(renter);

        return StringUtils.isEmpty(msg) ? Result.success(null):Result.fail(msg);

    }

    @PutMapping("/update")
    @ApiOperation("更新租户")
    public Result<Integer> updateRenter(@RequestBody @Validated RenterUpdate renterUpdate){
        msUserService.updateRenter(renterUpdate);

        return Result.success(null);
    }

    @GetMapping("/{userId}")
    @ApiOperation("根据ID查询租户(可以在编辑(修改租户)是获取到原来数据)")
    public Result<RenterDetailVo> getRenterById(@PathVariable Long userId){
        MsUser user = msUserService.getById(userId);
        if(user == null){
            return Result.fail("租户不存在");
        }
        return Result.success(MsUserMapping.INSTANCE.toDetail(user));
    }

    @ApiOperation("删除租户(支持批量)")
    @DeleteMapping("/{userIds}")
    public Result<Integer> deleteRenterByIds(@PathVariable Long[] userIds){
        int i = msUserService.deleteRenterByIds(userIds);
        return Result.success(i);
    }

    @ApiOperation("租赁申请审批")
    @GetMapping("/approveRenterStatus")
    public TableDataInfo<List<TenantApplicationQuery>> approveRenterStatus(PageParam pageParam,
                                                                           @RequestParam(required = false) String name,
                                                                           @RequestParam(required = false) String phone,
                                                                           @RequestParam(required = false) String status){


        try {
            // 参数校验
            if (pageParam == null) {
                pageParam = new PageParam(); // 默认第1页，每页10条
            }

            // 防止负数或零
            int pageNum = Math.max(1, pageParam.getPageNum());
            int pageSize = Math.max(1, pageParam.getPageSize());

            List<TenantApplicationQuery> allData = tenantApplicationService.selectTenant(name, phone, status);
            if (allData == null || allData.isEmpty()) {
                return getDataTable(new ArrayList<>(), 0L);
            }

            // 安全分页
            int total = allData.size();
            int startIndex = (pageNum - 1) * pageSize;
            int endIndex = Math.min(startIndex + pageSize, total);

            if (startIndex >= total) {
                // 页码超出范围，返回空列表
                return getDataTable(new ArrayList<>(), (long) total);
            }

            List<TenantApplicationQuery> paginatedList = allData.subList(startIndex, endIndex);
            return getDataTable(paginatedList, (long) total);

        } catch (Exception e) {
            return getDataTable(new ArrayList<>(), 0L);
        }
    }

    @ApiOperation("修改审批状态修改(通过时生成一个待签订的合同)")
    @PostMapping("/approveRenterPass")
    @Transactional(rollbackFor = Exception.class)
    public Result<Integer> approveRenterPass(@RequestBody @Validated TenantApplicationChange tenantApplicationChange){
        Long id = tenantApplicationChange.getId();

        // 前置校验审批状态（只有待审批才能更改状态）
        tenantApplicationService.checkApprovalStatusChange(tenantApplicationChange);

        int i = tenantApplicationService.updateApprovalStatus(tenantApplicationChange);
        if (i == 0){
            return Result.fail("修改失败");
        }

        if (tenantApplicationChange.getStatus().equals("1")) {

            TenantApplication tenant = tenantApplicationService.getById(id);

            Room room = roomService.getById(tenant.getRoomId());


            ContractInsertQuery contractInsertQuery = new ContractInsertQuery();

            contractInsertQuery.setRoomId(room.getRoomId());
            if (room.getMoneyType().equals(1)) {
                contractInsertQuery.setDailyFee(room.getMoney() * room.getArea());
                contractInsertQuery.setMonthFee(room.getMoney() * room.getArea() * 30);
                contractInsertQuery.setManageUnitPrice(room.getMoney() * room.getArea());
                contractInsertQuery.setManageMoneyType("0");

            } else if (room.getMoneyType().equals(2)) {

                contractInsertQuery.setDailyFee(room.getMoney() * room.getArea() / 30);
                contractInsertQuery.setMonthFee(room.getMoney() * room.getArea());
                contractInsertQuery.setManageUnitPrice(room.getMoney() * room.getArea());
                contractInsertQuery.setManageMoneyType("1");


                contractInsertQuery.setManageMoneyType("1");
            } else if (room.getMoneyType().equals(3)) {
                contractInsertQuery.setDailyFee(room.getMoney());
                contractInsertQuery.setMonthFee(room.getMoney() * 30);
                contractInsertQuery.setManageUnitPrice(room.getMoney());
                contractInsertQuery.setManageMoneyType("0");
            } else {
                contractInsertQuery.setDailyFee(room.getMoney() / 30);
                contractInsertQuery.setMonthFee(room.getMoney());
                contractInsertQuery.setManageUnitPrice(room.getMoney());
                contractInsertQuery.setManageMoneyType("1");

            }


            if (room.getTenantMoneyType().equals(1)) {

                contractInsertQuery.setDailyRent(room.getTenantMoney() * room.getArea());
                contractInsertQuery.setMonthRent(room.getTenantMoney() * room.getArea() * 30);
                contractInsertQuery.setTenantUnitPrice(room.getTenantMoney() * room.getArea());
                contractInsertQuery.setTenantType("0");

            } else if (room.getTenantMoneyType().equals(2)) {

                contractInsertQuery.setDailyRent(room.getTenantMoney() * room.getArea() / 30);
                contractInsertQuery.setMonthRent(room.getTenantMoney() * room.getArea());
                contractInsertQuery.setTenantUnitPrice(room.getTenantMoney() * room.getArea());
                contractInsertQuery.setTenantType("1");


                contractInsertQuery.setManageMoneyType("1");
            } else if (room.getTenantMoneyType().equals(3)) {
                contractInsertQuery.setDailyRent(room.getTenantMoney() * room.getArea());
                contractInsertQuery.setMonthRent(room.getTenantMoney() * room.getArea() * 30);
                contractInsertQuery.setTenantUnitPrice(room.getTenantMoney());
                contractInsertQuery.setTenantType("0");
            } else {
                contractInsertQuery.setDailyRent(room.getTenantMoney() * room.getArea() / 30);
                contractInsertQuery.setMonthRent(room.getTenantMoney() * room.getArea());
                contractInsertQuery.setTenantUnitPrice(room.getTenantMoney());
                contractInsertQuery.setTenantType("1");

            }

            contractInsertQuery.setStartTime(tenant.getStartTime());
            contractInsertQuery.setOverTime(tenant.getEndTime());
            contractInsertQuery.setTenantId(tenant.getTenantId());
            contractInsertQuery.setRoomId(tenant.getRoomId());

            contractInsertQuery.setRemark("用户申请租房请求通过自动初始化合同");
            contractInsertQuery.setContractName(tenant.getApplyName() + "租房请求初始化合同");
            contractInsertQuery.setContractNum(DATE_FORMAT.format(new Date()));

            //对应该条租房请求设置合同id
            tenant.setContractId(contractService.insert(contractInsertQuery));
            tenantApplicationService.updateById(tenant);
        }

        return Result.success(i);
    }

    @ApiOperation(value = "租赁Id查询租户申请审批的租赁房屋详情")
    @GetMapping("/{id}}")
    public Result<RoomRecordByApproveVo> approveRoom(@PathVariable
                                                          Long id){


        TenantApplication byId = tenantApplicationService.getById(id);

        Long tenantId = byId.getTenantId();

        RenterAdd renterAdd = sysUserService.selectById(tenantId);
        Contract byRoomId = contractService.getByRoomId(byId.getRoomId());


        if(!byId.getStatus().equals("1")){
            return Result.fail("该租户申请审批未通过不存在租赁房屋详情");
        }

        RoomRecordByApproveVo roomRecordByApproveVo = new RoomRecordByApproveVo();
        roomRecordByApproveVo.setNickName(renterAdd.getNickName());
        roomRecordByApproveVo.setEmail(renterAdd.getEmail());
        roomRecordByApproveVo.setIdNum(renterAdd.getIdNum());
        roomRecordByApproveVo.setPhonenumber(renterAdd.getPhonenumber());
        roomRecordByApproveVo.setStatus(byRoomId.getStatus());
        roomRecordByApproveVo.setTime(byRoomId.getStartTime());
        return Result.success(roomRecordByApproveVo);
    }









}
