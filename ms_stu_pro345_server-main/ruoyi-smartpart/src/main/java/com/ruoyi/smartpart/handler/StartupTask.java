package com.ruoyi.smartpart.handler;

import com.ruoyi.smartpart.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class StartupTask implements CommandLineRunner {

    @Autowired
    private ContractService contractService;

    @Override
    public void run(String... args) throws Exception {
        log.info("==========================================");
        log.info("         Spring Boot 项目启动成功！         ");
        log.info("         开始执行合同状态自动检查任务...     ");
        log.info("==========================================");

        // 调用上面写的批量检查方法
        contractService.autoUpdateExpiredContracts();

        log.info("==========================================");
    }
}