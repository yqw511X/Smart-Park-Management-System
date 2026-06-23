package com.ruoyi.smartpart.domain.vo.repairorder;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel("维修信息")
public class RepairOrderMeVo {

    @ApiModelProperty("维修工名称")
    private String repairName;

    @ApiModelProperty("电话")
    private String phonenumber;
}
