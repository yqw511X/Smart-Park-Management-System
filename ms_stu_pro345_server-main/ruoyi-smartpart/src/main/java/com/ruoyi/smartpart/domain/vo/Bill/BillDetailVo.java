package com.ruoyi.smartpart.domain.vo.Bill;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.time.LocalDateTime;
@Data
@ApiModel(value = "Bill查询对象", description = "查询")
public class BillDetailVo {

    /**
     * 账单id
     */
    @ApiModelProperty("账单id")
    @TableId(value = "bill_id", type = IdType.AUTO)
    private Long billId;




    /**
     * 租金
     */
    @ApiModelProperty("租金")
    @TableField("tenant_money")
    private Double tenantMoney;

    /**
     * 状态(0未收款,1已收款)
     */
    @TableField("status")
    @ApiModelProperty("状态(0未收款,1已收款)")
    private String status;

    /**
     * 账期
     */
    @TableField("start_payment")
    @ApiModelProperty("账期开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime startPayment;

    /**
     * 账期
     */
    @TableField("end_payment")
    @ApiModelProperty("账期开始时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime endPayment;

    /**
     * 收款截止日期
     */
    @TableField("deadline")
    @ApiModelProperty("收款截止日期")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime deadline;





    /**
     * 是否逾期
     */
    @TableField("overdue")
    @ApiModelProperty("逾期(0 为未逾期 ，1 逾期)")
    private String overdue;





    /**
     * 备注
     */
    @TableField("remark")
    @ApiModelProperty("备注")
    private String remark;




}
