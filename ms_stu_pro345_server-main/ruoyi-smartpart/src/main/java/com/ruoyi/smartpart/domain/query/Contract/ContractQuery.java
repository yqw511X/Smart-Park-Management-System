package com.ruoyi.smartpart.domain.query.Contract;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * <p>
 * 合同
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Data
public class ContractQuery {






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

    @TableField("nickName")
    @ApiModelProperty("客户名称")
    private String nickName;



}
