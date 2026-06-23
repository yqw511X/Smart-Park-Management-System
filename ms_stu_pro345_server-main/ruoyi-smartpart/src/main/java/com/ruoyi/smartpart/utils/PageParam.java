package com.ruoyi.smartpart.utils;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * 分页对象实体类
 */
@Data
@ApiModel
public class PageParam {

    @ApiModelProperty(value = "页码", required = true, example = "1")
    @NotNull(message = "pageNum不能为空!")
    private Integer pageNum;

    @ApiModelProperty(value = "每页大小", required = true, example = "10")
    @NotNull(message = "pageSize不能为空!")
    private Integer pageSize;
}
