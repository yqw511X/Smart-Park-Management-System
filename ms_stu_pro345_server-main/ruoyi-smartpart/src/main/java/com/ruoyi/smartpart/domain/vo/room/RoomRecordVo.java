package com.ruoyi.smartpart.domain.vo.room;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ApiModel("房间租赁记录详情Vo")
public class RoomRecordVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("租户状态(0在租、1退租)")
    private String status;

    @ApiModelProperty("租户名称")
    private String tenantName;

    @ApiModelProperty("入住时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime time;

    @ApiModelProperty("退租时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime tenantTime;

    @ApiModelProperty("身份证")
    private String idNum;

    @ApiModelProperty("邮箱")
    private String email;

    @ApiModelProperty("联系方式")
    private String phonenumber;

    @ApiModelProperty("家庭住址")
    private String address;
}
