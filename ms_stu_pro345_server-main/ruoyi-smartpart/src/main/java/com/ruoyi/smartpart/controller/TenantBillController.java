package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.common.utils.SecurityUtils;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQuery;
import com.ruoyi.smartpart.domain.query.Bill.TenantBillQueryById;
import com.ruoyi.smartpart.domain.vo.Bill.BillListVo;
import com.ruoyi.smartpart.mapping.BillMapping;
import com.ruoyi.smartpart.service.BillService;
import com.ruoyi.smartpart.utils.BaseController;
import com.ruoyi.smartpart.utils.PageDTO;
import com.ruoyi.smartpart.utils.PageParam;
import com.ruoyi.smartpart.utils.Result;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Min;
import java.util.ArrayList;
import java.util.List;

/**
 * 租户端-我的房间
 */
@RestController
@RequestMapping("/tenant/bill")
@Api(tags = "租户端-我的账单相关接口")
public class TenantBillController extends BaseController {

    @Autowired
    private BillService billService;

    @ApiOperation(value = "分页查询租户端-我的账单信息列表",notes = "ruoyi自带的实现方法")
    @GetMapping("/list")
    public PageDTO<BillListVo> list(@Validated PageParam pageParam,
                                    TenantBillQuery tenantBillQuery){




        Long userId = SecurityUtils.getUserId(); // 这是 RuoYi 提供的便捷方法

        TenantBillQueryById tenantBillQueryById = BillMapping.INSTANCE.tenantBillBody(tenantBillQuery);

        tenantBillQueryById.setTenantId(userId);

        Page<BillListVo> page = billService.getPageListsByTenantId(pageParam,tenantBillQueryById);
        return PageDTO.of(page,BillListVo.class);



    }








}
