package com.ruoyi.smartpart.utils;

import java.time.LocalDateTime;

public class TimeUtils {
    /**
     * 判断指定时间 是否早于当前时间（已过期）
     * @param time 待判断时间
     * @return true=已过期/在当前时间之前
     */
    public static boolean isBeforeNow(LocalDateTime time) {
        if (time == null) {
            return false;
        }
        return time.isBefore(LocalDateTime.now());
    }

    /**
     * 判断指定时间 是否晚于当前时间
     * @param time 待判断时间
     * @return true=在当前时间之后
     */
    public static boolean isAfterNow(LocalDateTime time) {
        if (time == null) {
            return false;
        }
        return time.isAfter(LocalDateTime.now());
    }
}
