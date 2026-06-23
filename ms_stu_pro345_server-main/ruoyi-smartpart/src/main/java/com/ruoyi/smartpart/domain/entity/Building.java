package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

/**
 * <p>
 * 楼宇表
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Getter
@Setter
@ToString
@TableName("building")
@Accessors(chain = true)
@ApiModel(value = "Building对象", description = "楼宇表")
public class Building implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 楼宇id
     */
    @ApiModelProperty("楼宇id")
    @TableId(value = "building_id", type = IdType.AUTO)
    private Long buildingId;

    /**
     * 楼宇名称
     */
    @ApiModelProperty("楼宇名称")
    @TableField("building_name")
    private String buildingName;

    /**
     * 所属园区名称
     */
    @TableField("park_name")
    @ApiModelProperty("所属园区名称")
    private String parkName;

    /**
     * 创建人
     */
    @ApiModelProperty("创建人")
    @TableField(fill = FieldFill.INSERT)
    private String createBy;

    /**
     * 创建时间
     */
    @ApiModelProperty("创建时间")
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新人
     */
    @ApiModelProperty("更新人")
    @TableField(fill = FieldFill.UPDATE)
    private String updateBy;

    /**
     * 更新时间
     */
    @ApiModelProperty("更新时间")
    @TableField(fill = FieldFill.UPDATE)
    private Date updateTime;

    /**
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;

    /**
     * 逻辑删除（0-未删，1-已删）
     */
    @TableField("del_flag")
    @ApiModelProperty("逻辑删除（0-未删，1-已删）")
    private Boolean delFlag;
}
