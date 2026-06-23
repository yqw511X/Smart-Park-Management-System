package com.ruoyi.common.utils;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 * 身份证号码校验工具类
 */
public class IdCardUtils {

    // 加权因子
    private static final int[] WEIGHT_FACTORS = {
            7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2
    };

    // 校验码
    private static final char[] CHECK_CODES = {
            '1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'
    };

    /**
     * 校验身份证号码是否有效
     *
     * @param idCard 待校验的身份证号码
     * @return 如果有效返回 true，否则返回 false
     */
    public static boolean isValidIdCard(String idCard) {
        if (idCard == null || idCard.trim().isEmpty()) {
            return false;
        }
        idCard = idCard.toUpperCase().trim(); // 统一转为大写并去除首尾空格

        // 1. 格式校验：必须是 18 位，前 17 位是数字，最后一位是数字或 'X'
        if (!idCard.matches("^\\d{17}[0-9X]$")) {
            return false;
        }

        // 2. 地区码校验 (可选，可以校验前 6 位是否在已知地区码列表中)
        // 这部分比较复杂，需要一个最新的地区码字典，此处省略或简化为只校验数字
        String areaCode = idCard.substring(0, 6);
        if (!isAreaCodeValid(areaCode)) {
            // 如果需要严格校验地区码，这里可以返回 false
            // return false;
            // 为了简化，我们暂时跳过地区码校验，只校验日期和校验码
        }

        // 3. 出生日期校验：第 7 位到第 14 位 (YYYYMMDD)
        String birthDateStr = idCard.substring(6, 14);
        if (!isValidBirthDate(birthDateStr)) {
            return false;
        }

        // 4. 校验码校验
        return calculateCheckCode(idCard) == idCard.charAt(17);
    }

    /**
     * 校验出生日期是否有效 (YYYYMMDD 格式)
     * @param birthDateStr 8 位日期字符串
     * @return 有效返回 true，否则返回 false
     */
    private static boolean isValidBirthDate(String birthDateStr) {
        try {
            // 使用 DateTimeFormatter 解析 YYYYMMDD
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
            LocalDate birthDate = LocalDate.parse(birthDateStr, formatter);

            // 可以添加额外逻辑，比如检查日期是否在未来
            LocalDate now = LocalDate.now();
            if (birthDate.isAfter(now)) {
                // 出生日期不能是未来日期
                return false;
            }

            // 检查年龄合理性（例如，不能太小也不能太大，比如小于0岁或大于150岁）
            int age = now.getYear() - birthDate.getYear();
            if (age < 0 || age > 150) {
                return false;
            }

            return true;
        } catch (DateTimeParseException e) {
            // 日期格式错误或日期不存在 (如 19900230)
            return false;
        }
    }

    /**
     * 计算校验码
     * @param idCard 身份证号前 17 位
     * @return 计算得出的校验码
     */
    private static char calculateCheckCode(String idCard) {
        int sum = 0;
        for (int i = 0; i < 17; i++) {
            int digit = Character.getNumericValue(idCard.charAt(i));
            sum += digit * WEIGHT_FACTORS[i];
        }
        int remainder = sum % 11;
        return CHECK_CODES[remainder];
    }

    /**
     * 校验地区码 (简化版，只校验是否为数字)
     * @param areaCode 6 位地区码
     * @return 有效返回 true，否则返回 false
     */
    private static boolean isAreaCodeValid(String areaCode) {
        // 这里可以实现更复杂的逻辑，比如查询数据库或静态字典
        // 简单起见，只校验是否为 6 位数字
        return areaCode.matches("\\d{6}");
        // 如果需要严格校验，可以在这里添加具体地区码的判断逻辑
    }



}