package com.ruoyi.smartpart.config;

import com.ruoyi.common.utils.StringUtils;
import org.springframework.core.convert.converter.Converter;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.List;

@Component // 确保这个注解存在
public class StringToYearMonthConverter implements Converter<String, LocalDateTime> {

    // 定义一个支持的日期格式列表
    // 顺序很重要，通常把最常见的格式放在前面
    private static final List<DateTimeFormatter> SUPPORTED_FORMATTERS = Arrays.asList(
            DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"), // 完整格式: 2026-01-15 12:30:45
            DateTimeFormatter.ofPattern("yyyy-MM")               // 年月格式: 2026-01
            // 可以根据需要添加更多格式，如 "yyyy/MM/dd HH:mm:ss", "yyyy-MM-dd"
    );

    @Override
    public LocalDateTime convert(String source) {
        if (source == null || source.trim().isEmpty()) {
            return null; // 处理空值
        }

        String trimmedSource = source.trim();

        // 循环尝试每种格式
        for (DateTimeFormatter formatter : SUPPORTED_FORMATTERS) {
            try {
                // 如果是 "yyyy-MM" 格式，先解析为 YearMonth，再转为 LocalDateTime (月初第一天 00:00:00)
                if (formatter.equals(DateTimeFormatter.ofPattern("yyyy-MM"))) {
                    YearMonth yearMonth = YearMonth.parse(trimmedSource, formatter);
                    return yearMonth.atDay(1).atStartOfDay(); // 返回 00:00:00
                } else {
                    // 对于其他格式（如 "yyyy-MM-dd HH:mm:ss"），直接解析
                    return LocalDateTime.parse(trimmedSource, formatter);
                }
            } catch (DateTimeParseException ignored) {
                // 当前格式解析失败，继续尝试下一个
                // 通常不在此处打印日志，避免日志过多
            }
        }

        // 所有格式都尝试失败
        throw new IllegalArgumentException(
                "Unable to parse date string '" + source + "' with any of the supported formats: " +
                        SUPPORTED_FORMATTERS.stream()
                                .map(DateTimeFormatter::toString)
                                .reduce((f1, f2) -> f1 + ", " + f2)
                                .orElse("none")
        );
    }
}