package com.ruoyi.smartpart.domain.vo.Contract;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * <p>
 * 合同
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Data
public class ContractListVo {



    /**
     * 合同id
     */
    @ApiModelProperty("合同id")
    @TableId(value = "contract_id", type = IdType.AUTO)
    private Long contractId;


    /**
     * 合同名称
     */
    @ApiModelProperty("合同名称")
    @TableField("contract_name")
    private String contractName;

    /**
     * 合同编号
     */
    @ApiModelProperty("合同编号")
    @TableField("contract_num")
    private String contractNum;

    /**
     * 状态（0待签订，1执行中，2已完成）
     */
    @TableField("status")
    @ApiModelProperty("状态（0待签订，1执行中，2已完成）")
    private String status;



    /**
     * 结束时间
     */
    @TableField("over_time")
    @ApiModelProperty("结束时间")
    private LocalDateTime overTime;

    /**
     * 开始时间
     */
    @ApiModelProperty("开始时间")
    @TableField("start_time")
    private LocalDateTime startTime;



    /**
     * 签订日期
     */
    @TableField("date_sign")
    @ApiModelProperty("签订日期")
    private LocalDateTime dateSign;

    /**
     * 电话号码
     */
    @TableField("phonenumber")
    @ApiModelProperty("电话号码")
    private String phonenumber;


}
