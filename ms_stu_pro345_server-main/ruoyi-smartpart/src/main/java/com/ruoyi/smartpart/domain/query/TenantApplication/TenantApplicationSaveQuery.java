package com.ruoyi.smartpart.domain.query.TenantApplication;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * 租房申请保存参数
 */
@Data
@ApiModel("租房申请保存参数")
public class TenantApplicationSaveQuery implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty(value = "房间id", required = true)
    @NotNull(message = "房间id不能为空")
    private Long roomId;

    @ApiModelProperty(value = "开始时间", required = true)
    @NotNull(message = "开始时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date startTime;

    @ApiModelProperty(value = "结束时间", required = true)
    @NotNull(message = "结束时间不能为空")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private Date endTime;
}
