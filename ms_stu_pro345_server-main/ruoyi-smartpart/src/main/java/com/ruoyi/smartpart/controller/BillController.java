package com.ruoyi.smartpart.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ruoyi.smartpart.domain.entity.Bill;
import com.ruoyi.smartpart.domain.entity.Contract;
import com.ruoyi.smartpart.domain.query.Bill.BillQuery;
import com.ruoyi.smartpart.domain.query.Contract.ContractQuery;
import com.ruoyi.smartpart.domain.vo.Bill.BillListVo;
import com.ruoyi.smartpart.domain.vo.Contract.ContractListVo;
import com.ruoyi.smartpart.service.BillService;
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

import javax.validation.constraints.Min;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@RestController
@RequestMapping("/bill")
@Api(tags = "账单相关接口")
public class BillController extends BaseController {


    @Autowired
    private BillService billService;

    @ApiOperation(value = "分页查询合同信息列表",notes = "ruoyi自带的实现方法")
    @GetMapping("/list")
    public PageDTO<BillListVo> list(@Validated PageParam pageParam,
                                        BillQuery billQuery){


        Page<BillListVo> page = billService.getPageLists(pageParam,billQuery);


        return PageDTO.of(page,BillListVo.class);



        }


    @ApiOperation("收款")
    @PostMapping("/pay")
    public Result<Void> contractSignById(@RequestParam("billIds")
                                         @Min(value = 1, message = "合同ID必须大于0") List<Long> billIds){

        List<Bill> billList =new ArrayList<>();
        for (Long billId : billIds) {

            Bill one = billService.getOne(new LambdaQueryWrapper<Bill>()
                    .eq(Bill::getBillId, billId).eq(Bill::getDelFlag, 0));

            String status = one.getStatus();
            if (status.equals("1")){

                return Result.fail("该账单已经支付,操作失败");
            }else {
                one.setStatus("1");
            }
            billList.add(one);
        }


        return toResult(billService.updateBatchById(billList));


    }

    /**
     *      容错处理 ： 如果 资产仓库 内部  资产  无法删除
     * @param  billIds
     * @return
     */
    @ApiOperation("删除合同信息")
    @ApiImplicitParam(name = "billIds",value = "账单ids",required = true)
    @DeleteMapping("/{billIds}")
    public Result<Void> delect(@PathVariable List<Long> billIds) {




        return  toResult(billService.removeByIds(billIds));
    }



}
