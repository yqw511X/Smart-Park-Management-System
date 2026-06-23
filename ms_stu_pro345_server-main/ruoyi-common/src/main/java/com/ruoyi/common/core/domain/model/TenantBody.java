package com.ruoyi.common.core.domain.model;

import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.Pattern;

/**
 * 用户注册对象
 * 
 * @author ruoyi
 */
@Data
@ApiModel("租户信息")
public class TenantBody
{
    /**
     * 用户ID
     */
    @ApiModelProperty("用户Id")
    @TableField("user_id")
    private Long userId;

    /**
     *      用户姓名
     *
     */
    @ApiModelProperty("用户真实姓名")
    @TableField("nick_name")
    private  String nickName;


    @ApiModelProperty("用户电话号码")
    @TableField("phonenumber")
    private String phonenumber;


    @ApiModelProperty("身份证号码")
    @TableField("id_num")
    private String idNum;

    @ApiModelProperty("个人邮箱")
    @TableField("email")
    private  String email;

    @ApiModelProperty("家庭住址")
    private  String homeAddress;

}
