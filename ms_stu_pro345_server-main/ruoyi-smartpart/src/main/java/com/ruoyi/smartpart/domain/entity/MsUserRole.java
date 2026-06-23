package com.ruoyi.smartpart.domain.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("sys_user_role")
public class MsUserRole {
  private long userId;
  private long roleId;
}
