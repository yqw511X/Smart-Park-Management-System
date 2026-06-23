package com.ruoyi.smartpart.domain.vo.repairorder;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

@Data
@ApiModel("维修单详情")
public class RepairOrderReDtlVo {

    @ApiModelProperty("报修人")
    private String tenantName;

    @ApiModelProperty("维修单号")
    private String repairNum;

    @ApiModelProperty("状态")
    private String status;

    @ApiModelProperty("联系电话")
    private String contactPhone;

    @ApiModelProperty("报修时间")
    private LocalDateTime repairTime;

    @ApiModelProperty("报修区域")
    private String repairArea;

    @ApiModelProperty("园区")
    private String parkName;

    @ApiModelProperty("公司")
    private String company = "宜家居服务有限公司";
}
