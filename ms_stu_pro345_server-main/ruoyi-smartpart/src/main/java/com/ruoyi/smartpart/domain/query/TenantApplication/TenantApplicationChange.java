package com.ruoyi.smartpart.domain.query.TenantApplication;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
@Data
@ApiModel("租赁状态修改")
public class TenantApplicationChange {

    @ApiModelProperty("租赁申请id")
    @NotNull(message = "id不能为空")
    private Long id;

    @ApiModelProperty("审批状态 状态(0待审批,1审批通过,2已拒绝,3已取消)")
    @NotNull(message = "状态不能为空")
    private String status;

    @ApiModelProperty("备注")
    private String remark;
}
