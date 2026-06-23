package com.ruoyi.smartpart.utils;

import com.baomidou.mybatisplus.generator.FastAutoGenerator;
import com.baomidou.mybatisplus.generator.config.OutputFile;
import com.baomidou.mybatisplus.generator.config.rules.DateType;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;

import java.util.Collections;
import java.util.Scanner;

public class CodeGenerator {
    // 基础配置（需根据实际情况修改）
    private static final String DB_URL = "jdbc:mysql://120.78.172.212:3306/ms_stu_pro345?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8";
    private static final String DB_USERNAME = "student";
    private static final String DB_PASSWORD = "Student@123";
    private static final String PROJECT_PATH = System.getProperty("user.dir");
    private static final String BASE_PACKAGE = "com.ruoyi.smartpart";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("请输入要生成代码的表名（多个用逗号分隔）：");
        String tables = scanner.nextLine().trim();

        FastAutoGenerator.create(DB_URL, DB_USERNAME, DB_PASSWORD)
                // 全局配置
                .globalConfig(builder -> {
                    builder.author("345项目团队")        // 作者
                            .outputDir(PROJECT_PATH + "/ruoyi-smartpart/src/main/java") // 输出目录
                            .disableOpenDir()             // 生成后不打开文件夹
                            .enableSwagger()              // 开启Swagger注解
                            .dateType(DateType.TIME_PACK) // 使用Java8时间类型
                            .commentDate("yyyy-MM-dd");   // 注释日期格式
                })
                // 包配置
                .packageConfig(builder -> {
                    builder.parent(BASE_PACKAGE)      // 父包名
                            .entity("domain.entity")             // 实体类包名
                            .service("service")            // Service包名
                            .serviceImpl("service.impl")   // ServiceImpl包名
                            .mapper("mapper")             // Mapper包名
                            .controller("controller")     // Controller包名
                            .pathInfo(Collections.singletonMap(OutputFile.xml,
                                    PROJECT_PATH + "/ruoyi-smartpart/src/main/resources/mapper")); // XML位置
                })
                // 策略配置
                .strategyConfig(builder -> {
                    builder.addInclude(tables.split(",")) // 输入的表名
                            // 实体类策略
                            .entityBuilder()
                            .enableFileOverride() // 覆盖已存在文件
                            .naming(NamingStrategy.underline_to_camel)  // 下划线转驼峰
                            .columnNaming(NamingStrategy.underline_to_camel)
                            .enableLombok()             // 启用Lombok
                            .enableChainModel()         // 链式编程
                            .enableTableFieldAnnotation()// 字段注解
                            // Mapper策略
                            .mapperBuilder()
                            .enableBaseResultMap()      // 生成resultMap
                            .enableBaseColumnList()     // 生成columnList
                            .formatMapperFileName("%sMapper")
                            // Service策略
                            .serviceBuilder()
                            .formatServiceFileName("%sService")
                            .formatServiceImplFileName("%sServiceImpl")
                            // Controller策略
                            .controllerBuilder()
                            .enableHyphenStyle() // 启用驼峰转连字符
                            .enableRestStyle()          // REST风格
                            .formatFileName("%sController");
                })
                .templateEngine(new FreemarkerTemplateEngine()) // 使用Freemarker
                .execute();
    }
}