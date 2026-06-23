package com.ruoyi.smartpart.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.format.FormatterRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration // 确保这个注解存在
public class WebConfig implements WebMvcConfigurer {

    @Autowired // 确保注入了 Converter
    private StringToYearMonthConverter stringToYearMonthConverter;

    @Override
    public void addFormatters(FormatterRegistry registry) {
        // 确保注册了你的 Converter
        registry.addConverter(stringToYearMonthConverter);
    }
}