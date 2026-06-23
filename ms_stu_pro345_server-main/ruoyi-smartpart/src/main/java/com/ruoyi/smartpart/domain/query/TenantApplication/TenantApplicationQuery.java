package com.ruoyi.smartpart.domain.query.TenantApplication;

import com.alipay.api.domain.PriceDetailDTO;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;

@Data
@ApiModel("租赁申请")
public class TenantApplicationQuery {

        @ApiModelProperty("租赁申请id")
        private Long id;

        @ApiModelProperty("租赁申请状态")
    private String status;

        @ApiModelProperty("租户")
    private String tenantName;

        @ApiModelProperty("申请园区")
    private String ParkName;

        @ApiModelProperty("申请楼层")
        private String floorName;

        @ApiModelProperty("申请楼宇")
        private String buildingName;

        @ApiModelProperty("申请房间号")
        private String roomNumber;

        @ApiModelProperty("电话")
        private String phone;

        @ApiModelProperty("开始时间")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private LocalDateTime startTime;


        @ApiModelProperty("结束时间")
        @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
        private LocalDateTime endTime;

        @ApiModelProperty("审批状态")
        private String approvalStatus;


}
