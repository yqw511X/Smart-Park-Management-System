package com.ruoyi.smartpart.domain.vo.room;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.ruoyi.common.annotation.Excel;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@ApiModel("租赁房屋详情")
public class RoomRecordByApproveVo {


    /** 用户昵称 */
    @Excel(name = "用户名称")
    private String nickName;
    /**
     * 状态
     */
    @TableField("status")
    @ApiModelProperty("租户状态（0待签订，1执行中，2已完成）")
    private String status;

    /**
     * 入住时间
     */
    @TableField("time")
    @ApiModelProperty("入住时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private LocalDateTime time;

    /** 用户昵称 */
    @Excel(name = "身份证号码")
    private String idNum;

    /** 用户邮箱 */
    @Excel(name = "用户邮箱")
    private String email;

    /** 手机号码 */
    @Excel(name = "手机号码", cellType = Excel.ColumnType.TEXT)
    private String phonenumber;







}
