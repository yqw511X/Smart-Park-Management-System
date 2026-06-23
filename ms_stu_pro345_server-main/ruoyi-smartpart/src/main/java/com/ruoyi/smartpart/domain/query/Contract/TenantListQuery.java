package com.ruoyi.smartpart.domain.query.Contract;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
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
@ApiModel("新增功能下租户信息需求")
public class TenantListQuery {




    @TableField("nickName")
    @ApiModelProperty("客户名称")
    private String nickName;

    /**
     * 电话号码
     */
    @TableField("phonenumber")
    @ApiModelProperty("电话号码")
    private String phonenumber;



}
