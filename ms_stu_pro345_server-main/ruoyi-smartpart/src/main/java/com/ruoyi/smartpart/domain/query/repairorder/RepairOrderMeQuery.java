package com.ruoyi.smartpart.domain.query.repairorder;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@ApiModel(description = "报修单查询参数")
@Data
public class RepairOrderMeQuery {

    @ApiModelProperty("维修人名称")
    private String repairName;

    @ApiModelProperty("电话")
    private String phonenumber;

    @ApiModelProperty("开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    @ApiModelProperty("结束时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;



}
