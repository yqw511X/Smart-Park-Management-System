package com.ruoyi.smartpart.domain.query.repairorder;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.time.LocalDateTime;
import java.util.List;

@Data
@ApiModel(description = "维修单修改对象")
public class RepairOrderUpdate {

    @ApiModelProperty(value = "维修单id",required = true)
    @NotNull(message = "维修单id不能为空")
    private Long repairOrderId;

    @ApiModelProperty("维修区域0基础设施 1水电设施 2厨房与卫生间设施 3供暖与制冷系统 4公共区域 5固有家电 6安全设施")
    @NotBlank(message = "维修区域不能为空")
    private String repairArea;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("维修时间")
    private LocalDateTime repairTime;
    @ApiModelProperty("维修图片")
    private List<String> repairImage;

    @ApiModelProperty("维修描述")
    @NotBlank(message = "维修描述不能为空")
    private String remark;

    @ApiModelProperty("上门时间")
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ssXXX")
    @NotNull(message = "上门时间不能为空")
    private LocalDateTime visitTime;

    @ApiModelProperty("联系人")
    @NotBlank(message = "联系人不能为空")
    private String contactName;

    @ApiModelProperty("联系电话")
    @NotBlank(message = "联系电话不能为空")
    private String contactPhone;
}
