package com.ruoyi.smartpart.domain.vo.Contract;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

/**
 * <p>
 * 合同
 * </p>
 *
 * @author 345项目团队
 * @since 2026-01-15
 */
@Data
public class TenantListVo {


    /** 用户ID */

    @TableField("user_id")
    @ApiModelProperty("用户Id")
    private Long userId;

    /** 用户昵称 */

    @TableField("nick_name")
    @ApiModelProperty("租户名字")
    private String nickName;

    /** 身份证号码 */

    @TableField("id_num")
    @ApiModelProperty("身份证号码")
    private String idNum;

    /** 用户邮箱 */

    @TableField("email")
    @ApiModelProperty("用户邮箱")
    private String email;

    /**
     * 家庭住址
     */
    @TableField("address")
    @ApiModelProperty("家庭住址")
    private String address;

    /**
     * 电话号码
     */
    @TableField("phonenumber")
    @ApiModelProperty("电话号码")
    private String phonenumber;


}
