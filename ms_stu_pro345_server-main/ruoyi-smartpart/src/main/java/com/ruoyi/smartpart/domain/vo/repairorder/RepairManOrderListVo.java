package com.ruoyi.smartpart.domain.vo.repairorder;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@ApiModel("维修单列表VO")
public class RepairManOrderListVo {

    @ApiModelProperty("维修单ID")
    private Long repairOrderId;

    @ApiModelProperty("报修单号")
    private String repairNum;

    @ApiModelProperty("报修区域(0基础设施 1水电设施 2厨房与卫生间设施 3供暖与制冷系统 4公共区域 5固有家电 6安全设施)")
    private String repairArea;

    @ApiModelProperty("联系人")
    private String contactName;

    @ApiModelProperty("联系电话")
    private String contactPhone;

    @ApiModelProperty("工单状态（0待分配，1待处理，2已完成，3已取消）")
    private String status;

    @ApiModelProperty("报修时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;
}
