package com.ruoyi.smartpart.domain.vo.repairlog;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

@Data
@ApiModel
public class RepairStatusLog {

    @ApiModelProperty("人员信息")
    private List<RepairLogProVo> optionList;

    @ApiModelProperty("维修单状态（0待分配，1待处理，2已完成，3已取消）")
    private String finalStatus;
}
