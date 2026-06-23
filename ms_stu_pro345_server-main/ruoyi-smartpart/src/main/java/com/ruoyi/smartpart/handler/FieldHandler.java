package com.ruoyi.smartpart.handler;

import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import com.ruoyi.common.utils.DateUtils;
import com.ruoyi.common.utils.SecurityUtils;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class FieldHandler implements MetaObjectHandler {

    /**
     * 插入时的填充策略
     *
     * @param metaObject
     */

    @Override
    public void insertFill(MetaObject metaObject) {

        try {
            // 尝试获取当前登录用户
            String username = SecurityUtils.getLoginUser().getUsername();
            this.setFieldValByName("createTime", new Date(), metaObject);
            this.setFieldValByName("createBy", username, metaObject);
            this.setFieldValByName("updateTime", new Date(), metaObject);
            this.setFieldValByName("updateBy", username, metaObject);
        } catch (Exception e) {
            // 捕获异常！如果是启动任务等没有登录用户的场景，就给一个默认的系统值
            this.setFieldValByName("createTime", new Date(), metaObject);
            this.setFieldValByName("createBy", "系统自动任务", metaObject);
            this.setFieldValByName("updateBy", "系统自动任务", metaObject);
            this.setFieldValByName("updateTime", new Date(), metaObject);
        }
    }

    /**
     * 更新时的填充策略
     *
     * @param metaObject
     */
    @Override
    public void updateFill(MetaObject metaObject) {
        try {
            // 尝试获取当前登录用户
            String username = SecurityUtils.getLoginUser().getUsername();
            this.setFieldValByName("updateBy", username, metaObject);
            this.setFieldValByName("updateTime", new Date(), metaObject);
        } catch (Exception e) {
            // 捕获异常！如果是启动任务等没有登录用户的场景，就给一个默认的系统值
            this.setFieldValByName("updateBy", "系统自动任务", metaObject);
            this.setFieldValByName("updateTime", new Date(), metaObject);
        }
    }

}
