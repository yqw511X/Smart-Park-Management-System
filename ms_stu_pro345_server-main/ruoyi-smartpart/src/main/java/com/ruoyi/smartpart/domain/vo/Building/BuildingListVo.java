package com.ruoyi.smartpart.domain.vo.Building;

import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@ApiModel("楼宇列表")
public class BuildingListVo implements Serializable {

    private static final long serialVersionUID = 1L;

    @ApiModelProperty("所属园区名称")
    private String parkName;

    @ApiModelProperty("楼宇id")
    private Long buildingId;

    @ApiModelProperty("楼宇名称")
    private String buildingName;

    @ApiModelProperty("备注")
    private String remark;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @ApiModelProperty("创建时间")
    private LocalDateTime createTime;

    @ApiModelProperty("创建人")
    private String createBy;
}
