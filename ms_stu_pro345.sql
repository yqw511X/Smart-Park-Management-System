/*
 Navicat Premium Dump SQL

 Source Server         : ms_stu_pro324
 Source Server Type    : MySQL
 Source Server Version : 80018 (8.0.18)
 Source Host           : 120.78.172.212:3306
 Source Schema         : ms_stu_pro345

 Target Server Type    : MySQL
 Target Server Version : 80018 (8.0.18)
 File Encoding         : 65001

 Date: 23/06/2026 18:52:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for bill
-- ----------------------------
DROP TABLE IF EXISTS `bill`;
CREATE TABLE `bill`  (
  `bill_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账单id',
  `tenant_id` bigint(20) NULL DEFAULT NULL COMMENT '租户id',
  `room_id` bigint(20) NULL DEFAULT NULL COMMENT '房间id',
  `contract_id` bigint(20) NULL DEFAULT NULL COMMENT '合同id',
  `tenant_money` double NULL DEFAULT NULL COMMENT '租金',
  `manage_fee` double NULL DEFAULT NULL COMMENT '管理费应收',
  `total_pay` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '应收总费用',
  `overdue` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '逾期(0 为未逾期 ，1 逾期)',
  `payment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '账期',
  `start_payment` datetime NULL DEFAULT NULL COMMENT '账期开始时间',
  `end_payment` datetime NULL DEFAULT NULL COMMENT '账期结束时间',
  `deadline` datetime NULL DEFAULT NULL COMMENT '收款截止日期',
  `deposit` double NULL DEFAULT NULL COMMENT '押金',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态(0未收款,1已收款)',
  `refund_fees` double NULL DEFAULT NULL COMMENT '退费',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，2-已删）',
  PRIMARY KEY (`bill_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bill
-- ----------------------------
INSERT INTO `bill` VALUES (5, 113, 101, 6, -7440, -248, '1699.5', '1', '2026-02-01 00:00~2026-01-15 10:30', '2026-02-01 00:00:00', '2026-01-15 10:30:00', '2026-01-27 10:30:00', 1350, '1', 10800.5, 'admin', '2026-02-01 07:48:50', '张三', '2026-05-22 20:22:27', NULL, 0);
INSERT INTO `bill` VALUES (6, 113, 2, 8, 0, 0, '1850.0', '0', '2026-02-01 00:00:00~2026-02-01 00:00:00', '2026-02-01 00:00:00', '2026-03-01 00:00:00', '2026-01-27 10:30:02', 1350, '1', 0, 'fanshen', '2026-02-12 21:11:52', '张三', '2026-05-22 20:22:29', NULL, 0);
INSERT INTO `bill` VALUES (7, 3, 7, 10, 12, 12, '24.0', '0', '2026-02-27 00:00:00~2026-03-11 00:00:00', '2026-02-27 00:00:00', '2026-03-11 00:00:00', '2026-03-05 00:00:00', 1, '1', 1434, '张三', '2026-03-11 20:19:15', '张三', '2026-05-28 15:43:33', '无', 1);
INSERT INTO `bill` VALUES (8, 139, 17, 22, 0, 0, '333.34', '0', '2026-05-22 16:00:00~2026-05-23 00:00:00', '2026-05-22 16:00:00', '2026-05-23 00:00:00', '2026-05-22 00:00:00', 1000, '0', 303002.42, '张三', '2026-05-22 16:28:51', '', '2026-05-22 16:28:50', '天天', 0);
INSERT INTO `bill` VALUES (9, 151, 10, 20, 0, 0, '16668.33', '0', '2026-05-21 16:00:00~2026-05-22 00:00:00', '2026-05-21 16:00:00', '2026-05-22 00:00:00', '2026-05-26 20:03:47', NULL, '1', 0, '张三', '2026-05-22 16:33:40', '张三', '2026-05-29 19:03:11', '用户申请租房请求通过自动初始化合同', 0);
INSERT INTO `bill` VALUES (24, 138, 15, 18, 1066.67, 1066.72, '2133.39', '0', '2026-05-12 16:00:00~2026-05-29 00:00:00', '2026-05-12 16:00:00', '2026-05-29 00:00:00', '2026-05-12 00:00:00', 1000, '1', -1133.39, '张三', '2026-05-29 18:33:30', '', '2026-05-29 18:53:54', '', 0);

-- ----------------------------
-- Table structure for building
-- ----------------------------
DROP TABLE IF EXISTS `building`;
CREATE TABLE `building`  (
  `building_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '楼宇id',
  `building_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '楼宇名称',
  `park_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属园区名称',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，1-已删）',
  PRIMARY KEY (`building_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '楼宇表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of building
-- ----------------------------
INSERT INTO `building` VALUES (1, '翻斗楼1', '翻斗花园', '', '2026-01-19 19:25:45', 'admin', '2026-05-07 16:31:31', '测试', 1);
INSERT INTO `building` VALUES (2, '翻斗楼2', '翻斗花园', '', '2026-01-19 19:43:44', 'admin', '2026-05-07 16:31:33', '测试', 1);
INSERT INTO `building` VALUES (3, '翻斗楼3', '翻斗花园', '', '2026-01-19 20:15:12', '', '2026-05-07 16:31:34', '测试', 1);
INSERT INTO `building` VALUES (4, '翻斗楼4', '翻斗花园', '', '2026-01-19 20:23:01', '', '2026-05-07 16:31:36', '测试', 1);
INSERT INTO `building` VALUES (5, '翻斗楼5', '翻斗花园', '', '2026-01-19 20:25:16', '', '2026-05-07 16:31:37', '测试', 1);
INSERT INTO `building` VALUES (6, '爱情公寓1', '翻斗花园', 'admin', '2026-01-28 17:35:38', 'admin', '2026-05-07 16:31:38', '测试测试测试', 1);
INSERT INTO `building` VALUES (7, '曙光公寓', '翻斗花园', 'admin', '2026-01-28 17:38:03', 'admin', '2026-05-29 19:23:35', '测试', 1);
INSERT INTO `building` VALUES (8, '英雄联盟', '翻斗花园', 'admin', '2026-01-28 17:43:02', '', '2026-05-07 16:31:40', '测试', 1);
INSERT INTO `building` VALUES (9, '宝宝乐园', '翻斗花园', 'admin', '2026-01-28 17:44:06', '', '2026-05-07 16:31:41', '测试', 1);
INSERT INTO `building` VALUES (10, '班德尔城', '翻斗花园', 'admin', '2026-01-28 17:45:04', '', '2026-05-07 16:31:42', '测试', 1);
INSERT INTO `building` VALUES (11, '萤火之森', '翻斗花园', 'admin', '2026-01-28 17:56:21', '', '2026-05-07 16:31:43', '', 1);
INSERT INTO `building` VALUES (12, '哈基米', '翻斗花园', 'admin', '2026-01-28 18:40:24', '', '2026-05-07 16:31:47', '', 1);
INSERT INTO `building` VALUES (13, '宝宝巴士', '翻斗花园', 'admin', '2026-01-29 16:15:54', '', '2026-05-07 16:31:21', '', 0);
INSERT INTO `building` VALUES (14, '宝宝巴士1', '翻斗花园', 'admin', '2026-01-29 17:05:25', '', '2026-01-29 17:08:52', '测试', 1);
INSERT INTO `building` VALUES (15, '宝宝巴士2', '翻斗花园', 'admin', '2026-01-29 17:06:54', '', '2026-01-29 17:07:23', '测试', 1);
INSERT INTO `building` VALUES (16, '宝宝巴士3', '翻斗花园', 'admin', '2026-01-29 17:07:06', '', '2026-01-29 17:07:23', '测试', 1);
INSERT INTO `building` VALUES (17, '宝宝巴士1', '翻斗花园', 'admin', '2026-01-29 17:09:08', '', '2026-01-29 17:09:07', '', 0);
INSERT INTO `building` VALUES (18, '宝宝巴士2', '翻斗花园', 'admin', '2026-01-29 17:09:14', '', '2026-01-29 17:09:13', '', 0);
INSERT INTO `building` VALUES (19, '宝宝巴士3', '翻斗花园', 'admin', '2026-01-29 17:09:21', '', '2026-02-13 19:38:44', '', 1);
INSERT INTO `building` VALUES (20, '宝宝巴士5', '翻斗花园', 'admin', '2026-01-29 17:09:28', '', '2026-01-29 17:10:13', '', 1);
INSERT INTO `building` VALUES (21, '爱情公寓1', '翻斗花园', 'admin', '2026-01-29 17:09:36', '', '2026-01-29 17:09:35', '', 0);
INSERT INTO `building` VALUES (22, '爱情公寓2', '翻斗花园', 'admin', '2026-01-29 17:09:49', '', '2026-01-29 17:16:49', '', 1);
INSERT INTO `building` VALUES (23, '王朝烈马', '翻斗花园', 'admin', '2026-01-29 19:04:51', '', '2026-01-29 19:04:58', '测试', 1);
INSERT INTO `building` VALUES (24, '爱情公寓2', '翻斗花园', 'admin', '2026-01-29 19:05:18', '', '2026-01-29 19:05:18', '', 0);
INSERT INTO `building` VALUES (25, '爱情公寓3', '翻斗花园', 'admin', '2026-01-29 19:05:23', '', '2026-01-29 19:05:22', '', 0);
INSERT INTO `building` VALUES (26, '爱情公寓10086', '翻斗花园', 'admin', '2026-01-29 19:05:30', '', '2026-02-03 15:34:19', '', 1);
INSERT INTO `building` VALUES (27, '曙光公寓1', '翻斗花园', 'admin', '2026-02-02 18:21:48', '', '2026-02-02 18:21:48', '', 0);
INSERT INTO `building` VALUES (28, '华建大厦', '翻斗花园', '张三', '2026-04-30 16:36:09', '', '2026-04-30 16:36:09', '', 0);
INSERT INTO `building` VALUES (29, '撒旦撒', '翻斗花园', '张三', '2026-04-30 16:37:31', '', '2026-04-30 16:37:33', '', 1);

-- ----------------------------
-- Table structure for contract
-- ----------------------------
DROP TABLE IF EXISTS `contract`;
CREATE TABLE `contract`  (
  `contract_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '合同id',
  `tenant_id` bigint(20) NULL DEFAULT NULL COMMENT '租户id',
  `room_id` bigint(20) NULL DEFAULT NULL COMMENT '房间id',
  `contract_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合同名称',
  `contract_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合同编号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0待签订，1执行中，2已终止）',
  `tenant_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租金类型(0 元/平方/天 ，1 元/平方/月  )',
  `tenant_unit_price` double NULL DEFAULT NULL COMMENT '租金单价',
  `tenant_money` double NULL DEFAULT NULL COMMENT '租金',
  `tenant_method` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '租金收租方法（0固定资金，1按日收）',
  `manage_money_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '管理费类型(0 元/平方/天 ，1 元/平方/月  )',
  `manage_unit_price` double NULL DEFAULT NULL COMMENT '管理费单价',
  `manage_money` double NULL DEFAULT NULL COMMENT '管理费',
  `mortgage_pay` double NULL DEFAULT NULL COMMENT '当次抵押支付',
  `mortgage_month` int(11) NULL DEFAULT NULL COMMENT '抵押月数',
  `over_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `version_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '合同版本',
  `daily_rent` double NULL DEFAULT NULL COMMENT '日租金',
  `month_rent` double NULL DEFAULT NULL COMMENT '月租金',
  `daily_fee` double NULL DEFAULT NULL COMMENT '日管理费',
  `month_fee` double NULL DEFAULT NULL COMMENT '月管理费',
  `date_sign` datetime NULL DEFAULT NULL COMMENT '签订日期',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，1-已删）',
  PRIMARY KEY (`contract_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '合同' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of contract
-- ----------------------------
INSERT INTO `contract` VALUES (1, 113, 1, '租赁合同01', '1', '0', '0', 0.5, 1500, '0', '0', 0.3, 90, 500, 1, '2026-03-01 21:24:54', '2026-02-01 21:24:50', 'test-01', 50, 1500, 3, 90, '2026-01-22 21:24:31', '', '2026-01-22 21:26:12', '张三', '2026-03-11 20:51:54', NULL, 1);
INSERT INTO `contract` VALUES (2, 113, 2, '租赁合同02', '2', '2', '0', 1, 3000, '0', '0', 0.5, 150, 1000, 1, '2026-03-01 20:06:23', '2026-02-01 20:06:33', 'test-02', 100, 3000, 5, 150, '2026-01-27 20:07:20', '', '2026-01-27 20:05:50', '系统自动任务', '2026-05-16 21:12:47', NULL, 0);
INSERT INTO `contract` VALUES (6, 113, 4, '测试合同-张三-2026-01-30', '3', '2', '0', 100, 300, '0', '0', 2.5, 200, 1350, 3, '2027-01-27 18:00:00', '2026-02-01 00:00:00', '13', 465, 450, 15.5, 465, '2026-01-27 10:30:00', 'admin', '2026-01-27 23:59:13', 'admin', '2026-03-06 18:46:27', '此为自动化测试合同，有效期一年。', 0);
INSERT INTO `contract` VALUES (8, 113, 11, '测试合同-张三-2026-02', '4', '2', '0', 100, 300, '0', '0', 2.5, 200, 1350, 3, '2027-01-27 18:00:00', '2026-02-01 00:00:00', '1', 465, 450, 15.5, 465, '2026-01-27 10:30:02', 'admin', '2026-02-01 08:19:26', 'fanshen', '2026-05-07 17:20:43', '此为自动化测试合同，有效期一年。', 0);
INSERT INTO `contract` VALUES (9, 113, 9, '测试合同1', '9', '1', '0', 1, 7300, '0', '0', 1, 7300, 1350, 3, '2027-02-01 00:00:00', '2026-02-01 00:00:00', '2', 20, 600, 20, 600, '2026-01-20 00:00:00', 'fanshen', '2026-02-24 16:44:18', 'admin', '2026-03-09 21:34:09', 'wu ', 0);
INSERT INTO `contract` VALUES (10, 3, 3, '12111', '10', '2', '0', 1, 729, '0', '0', 1, 729, 1, 1, '2028-02-26 00:00:00', '2026-02-27 00:00:00', '1', 1, 30, 1, 30, '2026-03-05 00:00:00', 'admin', '2026-03-09 21:07:45', '张三', '2026-05-07 17:20:39', '无', 0);
INSERT INTO `contract` VALUES (11, 120, 5, '111', 'CONTRACT_20260311_0001', '0', '0', 2, 1760, '1', '0', 2, 1760, 300, 2, '2026-04-24 00:00:00', '2026-03-11 00:00:00', '0', 40, 1200, 40, 1200, '2026-03-11 00:00:00', '张三', '2026-03-11 20:44:42', '张三', '2026-03-11 20:51:12', '1', 1);
INSERT INTO `contract` VALUES (12, 135, 7, 'admin租房请求初始化合同', '20260420', '0', '1', 200, 406.6666666666667, '0', '1', 200, 406.6666666666667, 300, 2, '2026-06-01 16:00:00', '2026-04-01 16:00:00', '0', 6.666666666666667, 200, 6.666666666666667, 200, NULL, 'admin', '2026-04-20 16:39:50', 'admin', '2026-05-16 20:41:18', '用户申请租房请求通过自动初始化合同', 1);
INSERT INTO `contract` VALUES (14, 113, 13, 'fanshen租房请求初始化合同', '20260512', '0', '1', 100, 14800, '0', '1', 10, 12.333333333333332, 300, 2, '2026-06-18 16:00:00', '2026-05-12 16:00:00', '0', 400, 12000, 0.3333333333333333, 10, NULL, 'admin', '2026-05-12 00:46:50', 'admin', '2026-05-16 20:41:01', '用户申请租房请求通过自动初始化合同', 0);
INSERT INTO `contract` VALUES (18, 138, 15, 'wangzai租房请求初始化合同', '18', '2', '1', 100, 11333.22, '0', '1', 20, 2266.78, 1000, 1, '2026-06-15 16:00:00', '2026-05-12 16:00:00', '15', 333.33, 2000, 66.67, 2000, '2026-05-12 00:00:00', 'admin', '2026-05-12 23:43:58', '张三', '2026-05-29 18:33:30', '', 0);
INSERT INTO `contract` VALUES (20, 151, 10, 'zjy租房请求初始化合同', '20260521', '2', '1', 5000, 233333.33333333334, '0', '1', 50, 23.333333333333336, NULL, NULL, '2026-06-04 16:00:00', '2026-05-21 16:00:00', '1', 16666.666666666668, 500000, 1.6666666666666667, 50, NULL, '张三', '2026-05-21 19:49:39', '张三', '2026-05-26 20:19:45', '用户申请租房请求通过自动初始化合同', 0);
INSERT INTO `contract` VALUES (21, 151, 16, '华建大厦软件开发租房5.21', '21', '1', '1', 130, 788667.88, '0', '1', 34, 206267.87999999998, 2166, 1, '2027-05-21 00:00:00', '2026-05-22 00:00:00', '5', 2166.67, 17000, 566.67, 17000, '2026-05-22 00:00:00', '张三', '2026-05-21 21:14:57', '张三', '2026-05-22 20:21:38', '', 0);
INSERT INTO `contract` VALUES (22, 139, 17, 'lqy租房请求初始化合同', '22', '2', '1', 200, 242667.87999999998, '0', '1', 50, 60667.88, 1000, 1, '2027-05-21 16:00:00', '2026-05-22 16:00:00', '3', 666.67, 5000, 166.67, 5000, '2026-05-22 00:00:00', '张三', '2026-05-22 15:17:28', '张三', '2026-05-22 16:28:51', '天天', 0);
INSERT INTO `contract` VALUES (23, 151, 5, 's5s', '23', '0', '0', 50, 1456000, '0', '0', 5, 145600, 500, 1, '2027-05-21 00:00:00', '2026-05-22 00:00:00', '0', 4000, 12000, 400, 12000, '2026-05-22 00:00:00', 'fanshen', '2026-05-22 17:29:37', '张三', '2026-05-22 20:21:32', '', 0);
INSERT INTO `contract` VALUES (57, 152, 19, 'zyr租房请求初始化合同', '57', '2', '1', 1584, 4516512, '0', '1', 522, 1488396, 12000, 1, '2027-05-27 16:00:00', '2026-05-28 16:00:00', '1', 12408, 122670, 4089, 122670, '2026-05-28 00:00:00', '张三', '2026-05-28 15:50:32', '张三', '2026-05-28 16:10:55', '', 0);
INSERT INTO `contract` VALUES (58, 153, 20, 'hwy租房请求初始化合同', '58', '2', '1', 245, 692630.12, '0', '1', 34, 96121.48, 2000, 1, '2027-05-27 16:00:00', '2026-05-28 16:00:00', '1', 1902.83, 7922, 264.07, 7922, '2026-05-28 00:00:00', '张三', '2026-05-28 20:25:56', '张三', '2026-05-28 20:27:03', '', 0);

-- ----------------------------
-- Table structure for floor
-- ----------------------------
DROP TABLE IF EXISTS `floor`;
CREATE TABLE `floor`  (
  `floor_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '楼层id',
  `building_id` bigint(20) NULL DEFAULT NULL COMMENT '楼宇id',
  `floor_num` int(5) NULL DEFAULT NULL COMMENT '楼层',
  `floor_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '楼层名称',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，1-已删）',
  PRIMARY KEY (`floor_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '楼层表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of floor
-- ----------------------------
INSERT INTO `floor` VALUES (1, 1, 1, '一楼', 'admin', '2026-01-22 21:12:56', 'admin', '2026-01-22 21:53:19', NULL, 0);
INSERT INTO `floor` VALUES (2, 1, 2, '二楼', 'admin', '2026-01-22 21:13:44', '', '2026-01-22 21:53:19', NULL, 0);
INSERT INTO `floor` VALUES (3, 2, 4, '测试', 'admin', '2026-01-29 14:40:34', 'admin', '2026-01-29 16:07:12', NULL, 1);
INSERT INTO `floor` VALUES (4, 2, 2, '测试', 'admin', '2026-01-29 14:42:59', '', '2026-01-29 16:07:20', NULL, 1);
INSERT INTO `floor` VALUES (5, 2, 1, '测试', 'admin', '2026-01-29 14:45:46', '', '2026-01-29 16:07:24', NULL, 1);
INSERT INTO `floor` VALUES (6, 2, 3, '测试', 'admin', '2026-01-29 15:37:04', '', '2026-01-29 16:07:12', NULL, 1);
INSERT INTO `floor` VALUES (7, 2, 5, '测试', 'admin', '2026-01-29 15:37:13', '', '2026-01-29 16:06:53', NULL, 1);
INSERT INTO `floor` VALUES (8, 2, 1, '测试', 'admin', '2026-01-29 16:07:35', '', '2026-01-29 16:08:11', NULL, 1);
INSERT INTO `floor` VALUES (9, 2, 2, '测试', 'admin', '2026-01-29 16:07:42', '', '2026-01-29 16:16:31', NULL, 1);
INSERT INTO `floor` VALUES (10, 2, 3, '测试', 'admin', '2026-01-29 16:07:51', '', '2026-01-29 16:08:11', NULL, 1);
INSERT INTO `floor` VALUES (11, 2, 4, '测试', 'admin', '2026-01-29 16:08:02', '', '2026-01-29 16:09:12', NULL, 1);
INSERT INTO `floor` VALUES (12, 2, 1, '测试', 'admin', '2026-01-29 16:08:31', '', '2026-01-29 16:21:56', NULL, 1);
INSERT INTO `floor` VALUES (13, 2, 3, '测试', 'admin', '2026-01-29 16:08:38', '', '2026-01-29 16:08:48', NULL, 1);
INSERT INTO `floor` VALUES (14, 2, 5, '测试', 'admin', '2026-01-29 16:08:44', '', '2026-01-29 16:08:51', NULL, 1);
INSERT INTO `floor` VALUES (15, 2, 2, '测试', 'admin', '2026-01-29 16:21:31', '', '2026-01-29 16:21:54', NULL, 1);
INSERT INTO `floor` VALUES (16, 2, 3, '测试', 'admin', '2026-01-29 16:21:40', '', '2026-01-29 17:16:34', NULL, 1);
INSERT INTO `floor` VALUES (17, 2, 4, '测试', 'admin', '2026-01-29 16:21:47', '', '2026-01-29 17:13:05', NULL, 1);
INSERT INTO `floor` VALUES (18, 2, 1, '111', 'admin', '2026-01-29 17:12:07', '', '2026-01-29 17:13:05', NULL, 1);
INSERT INTO `floor` VALUES (19, 2, 2, '222', 'admin', '2026-01-29 17:12:57', '', '2026-01-29 17:13:02', NULL, 1);
INSERT INTO `floor` VALUES (20, 2, 1, '222', 'admin', '2026-01-29 17:14:25', '', '2026-01-29 17:14:28', NULL, 1);
INSERT INTO `floor` VALUES (21, 17, 1, '一楼', 'admin', '2026-01-29 19:07:19', 'admin', '2026-02-02 18:15:53', NULL, 0);
INSERT INTO `floor` VALUES (22, 21, 1, '23 ', 'admin', '2026-01-29 19:08:13', '', '2026-01-29 19:08:17', NULL, 1);
INSERT INTO `floor` VALUES (23, 17, 2, '二楼', 'admin', '2026-02-02 18:16:03', '', '2026-02-02 18:16:03', NULL, 0);
INSERT INTO `floor` VALUES (24, 17, 3, '三楼', 'admin', '2026-02-02 18:16:15', '', '2026-02-02 18:16:15', NULL, 0);
INSERT INTO `floor` VALUES (25, 28, 1, '一层', '张三', '2026-04-30 16:36:46', '', '2026-04-30 16:36:46', NULL, 0);
INSERT INTO `floor` VALUES (26, 28, 2, '二层', '张三', '2026-04-30 16:36:57', '', '2026-04-30 16:36:57', NULL, 0);
INSERT INTO `floor` VALUES (27, 28, 3, '三', '张三', '2026-04-30 16:37:05', '张三', '2026-04-30 16:37:13', NULL, 1);
INSERT INTO `floor` VALUES (28, 28, 3, '三层', '张三', '2026-04-30 16:37:24', '', '2026-04-30 16:37:24', NULL, 0);

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint(20) NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------

-- ----------------------------
-- Table structure for lease_cancellation
-- ----------------------------
DROP TABLE IF EXISTS `lease_cancellation`;
CREATE TABLE `lease_cancellation`  (
  `lease_cancellation_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '退租id',
  `tenant_id` bigint(20) NULL DEFAULT NULL COMMENT '租户id',
  `contract_id` bigint(20) NULL DEFAULT NULL COMMENT '合同id',
  `account_receivable` double NULL DEFAULT NULL COMMENT '应收费用',
  `refund_fees` double NULL DEFAULT NULL COMMENT '退款费用',
  `total_pay` double NULL DEFAULT NULL COMMENT '应收总费用',
  `lease_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退款原因',
  `tenant_time` datetime NULL DEFAULT NULL COMMENT '退租时间',
  PRIMARY KEY (`lease_cancellation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '退租' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of lease_cancellation
-- ----------------------------
INSERT INTO `lease_cancellation` VALUES (7, 113, 6, 12500, 10800.5, 1699.5, '租约到期，正常退租。', '2026-01-15 10:30:00');
INSERT INTO `lease_cancellation` VALUES (8, 113, 8, 1850, 0, 1850, '房间有鬼', '2026-02-01 00:00:00');
INSERT INTO `lease_cancellation` VALUES (9, 0, 10, 1458, 1434, 24, '家庭因素', '2026-03-11 00:00:00');
INSERT INTO `lease_cancellation` VALUES (10, 0, 22, 303335.76, 303002.42, 333.34, '家庭因素', '2026-05-23 00:00:00');
INSERT INTO `lease_cancellation` VALUES (11, 0, 20, 236.67, 0, 16668.33, '工作变动', '2026-05-22 00:00:00');
INSERT INTO `lease_cancellation` VALUES (12, 0, 18, 13600, 12266.63, 1333.37, '工作变动', '2026-05-22 00:00:00');
INSERT INTO `lease_cancellation` VALUES (13, 0, 18, 13600, 13199.99, 400.01, '工作变动', '2026-05-15 00:00:00');
INSERT INTO `lease_cancellation` VALUES (14, 0, 18, 13600, 13466.66, 133.34, '工作变动', '2026-05-13 00:00:00');
INSERT INTO `lease_cancellation` VALUES (15, 0, 18, 13600, 13466.66, 133.34, '工作变动', '2026-05-13 00:00:00');
INSERT INTO `lease_cancellation` VALUES (16, 0, 57, 6004908, 5996730, 8178, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (17, 0, 18, 13600, 11466.61, 2133.39, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (18, 0, 18, 13600, 11466.61, 2133.39, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (19, 0, 18, 13600, 11466.61, 2133.39, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (20, 0, 18, 13600, 11466.61, 2133.39, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (21, 0, 18, 13600, 11466.61, 2133.39, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (22, 0, 18, 13600, 11466.61, 2133.39, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (23, 0, 18, 13600, 11466.61, 2133.39, '工作变动', '2026-05-28 00:00:00');
INSERT INTO `lease_cancellation` VALUES (24, 0, 58, 788751.6, 788223.46, 528.14, '经济原因', '2026-05-29 00:00:00');
INSERT INTO `lease_cancellation` VALUES (25, 0, 18, 13600, 11333.28, 2266.72, '工作变动', '2026-05-29 00:00:00');
INSERT INTO `lease_cancellation` VALUES (26, 0, 18, 13600, 11333.28, 2266.72, '工作变动', '2026-05-29 00:00:00');

-- ----------------------------
-- Table structure for repair_log
-- ----------------------------
DROP TABLE IF EXISTS `repair_log`;
CREATE TABLE `repair_log`  (
  `repair_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '维修日志id',
  `repair_order_id` bigint(20) NULL DEFAULT NULL COMMENT '维修工单id',
  `operation_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态(0待分配,1待处理,2已完成,3已取消)',
  `del_flag` tinyint(1) NULL DEFAULT 0,
  `human` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作人',
  `repair_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维修人',
  PRIMARY KEY (`repair_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of repair_log
-- ----------------------------
INSERT INTO `repair_log` VALUES (7, 5, '2026-04-21 21:22:28', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (8, 6, '2026-04-21 21:22:28', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (9, 7, '2026-04-21 21:22:28', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (10, 8, '2026-04-21 21:22:28', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (11, 9, '2026-04-21 21:22:28', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (12, 6, '2026-04-21 21:44:29', '3', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (13, 7, '2026-04-21 21:45:43', '1', 0, '范深', '维修工1号');
INSERT INTO `repair_log` VALUES (14, 8, '2026-04-21 21:46:48', '1', 0, '范深', '维修工1号');
INSERT INTO `repair_log` VALUES (15, 8, '2026-04-21 21:46:48', '3', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (16, 9, '2026-04-21 21:47:27', '1', 0, '范深', '维修工1号');
INSERT INTO `repair_log` VALUES (17, 9, '2026-04-21 23:16:31', '2', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (18, 5, '2026-04-23 18:44:03', '1', 0, '范深', '龙傲天');
INSERT INTO `repair_log` VALUES (19, 5, '2026-04-23 18:44:03', '1', 0, '范深', '龙傲天');
INSERT INTO `repair_log` VALUES (20, 5, '2026-04-23 18:44:03', '1', 0, '范深', 'lisi');
INSERT INTO `repair_log` VALUES (21, 7, '2026-04-21 21:45:43', '1', 0, '范深', 'lisi');
INSERT INTO `repair_log` VALUES (22, 5, '2026-04-23 18:44:03', '1', 0, '范深', '龙傲天');
INSERT INTO `repair_log` VALUES (23, 5, '2026-04-23 18:44:03', '1', 0, '范深', '龙傲天');
INSERT INTO `repair_log` VALUES (24, 10, NULL, '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (25, 11, NULL, '0', 0, '若依', NULL);
INSERT INTO `repair_log` VALUES (26, 5, '2026-04-23 18:44:03', '3', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (27, 12, NULL, '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (28, 13, NULL, '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (29, 14, NULL, '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (30, 5, '2026-05-10 18:55:09', '3', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (31, 7, '2026-04-21 21:45:43', '3', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (32, 15, NULL, '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (33, 16, '2026-05-11 23:59:18', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (34, 17, '2026-05-12 23:48:33', '0', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (35, 17, '2026-05-12 23:48:32', '1', 0, '旺仔', '维修工1号');
INSERT INTO `repair_log` VALUES (36, 17, '2026-05-12 23:48:32', '1', 0, '旺仔', '维修工1号');
INSERT INTO `repair_log` VALUES (37, 17, '2026-05-12 23:48:32', '1', 0, '旺仔', '龙傲天');
INSERT INTO `repair_log` VALUES (38, 17, '2026-05-12 23:48:32', '3', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (39, 18, '2026-05-16 14:18:44', '0', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (40, 19, '2026-05-16 14:40:02', '0', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (41, 19, '2026-05-16 14:40:01', '3', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (42, 20, '2026-05-16 15:11:47', '0', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (43, 21, '2026-05-16 15:16:58', '0', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (44, 21, '2026-05-16 15:16:57', '3', 0, '旺仔', NULL);
INSERT INTO `repair_log` VALUES (45, 22, '2026-05-22 14:50:44', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (46, 22, '2026-05-22 14:50:44', '1', 0, '范深', '龙傲天');
INSERT INTO `repair_log` VALUES (47, 16, '2026-05-11 23:59:17', '3', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (48, 22, '2026-05-22 14:50:44', '2', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (49, 23, '2026-05-28 15:45:23', '0', 0, '范深', NULL);
INSERT INTO `repair_log` VALUES (50, 23, '2026-05-28 15:45:23', '1', 0, '范深', '龙傲天');
INSERT INTO `repair_log` VALUES (51, 23, '2026-05-28 15:45:23', '2', 0, '范深', NULL);

-- ----------------------------
-- Table structure for repair_order
-- ----------------------------
DROP TABLE IF EXISTS `repair_order`;
CREATE TABLE `repair_order`  (
  `repair_order_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '维修单id',
  `tenant_id` bigint(20) NULL DEFAULT NULL COMMENT '租户id',
  `repair_id` bigint(20) NULL DEFAULT NULL COMMENT '维修工id',
  `room_id` bigint(20) NULL DEFAULT NULL COMMENT '房间id',
  `repair_area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报修区域(0基础设施 1水电设施 2厨房与卫生间设施 3供暖与制冷系统 4公共区域 5固有家电 6安全设施)',
  `repair_time` datetime NULL DEFAULT NULL COMMENT '报修时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态（0待分配，1待处理，2已完成，3已取消）',
  `repair_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '报修单号',
  `repair_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '维修照片',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，1-已删）',
  `visit_time` datetime NULL DEFAULT NULL COMMENT '上门时间',
  `contact_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人电话',
  PRIMARY KEY (`repair_order_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '维修单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of repair_order
-- ----------------------------
INSERT INTO `repair_order` VALUES (5, 113, 116, 2, '0', '2026-04-21 21:22:28', '3', '17767784683726015', '', '', '2026-04-21 21:34:27', '', '2026-05-10 18:55:09', '花洒坏了', 0, '2026-04-24 21:22:28', '范深', '19306057793');
INSERT INTO `repair_order` VALUES (6, 113, NULL, 2, '5', '2026-04-21 21:22:28', '3', '17767790571147700', '', '', '2026-04-21 21:44:16', '', '2026-04-23 18:44:09', '马桶堵了', 0, '2026-04-24 21:22:28', '范深', '19306057793');
INSERT INTO `repair_order` VALUES (7, 113, 119, 2, '3', '2026-04-21 21:22:28', '3', '17767791443937236', '', '', '2026-04-21 21:45:43', '', '2026-04-21 21:45:43', '瓷砖裂开了', 0, '2026-04-24 21:22:28', '范深', '19306057793');
INSERT INTO `repair_order` VALUES (8, 113, 120, 2, '3', '2026-04-21 21:22:28', '3', '17767792096863033', '', '', '2026-04-21 21:46:48', '', '2026-04-21 21:46:48', '墙壁裂开了', 0, '2026-04-24 21:22:28', '范深', '19306057793');
INSERT INTO `repair_order` VALUES (9, 113, 120, 2, '3', '2026-04-21 21:22:28', '2', '17767792481895320', '', '', '2026-04-21 21:47:27', '', '2026-04-21 23:16:31', '消防栓坏了', 0, '2026-04-20 21:22:28', '范深', '19306057793');
INSERT INTO `repair_order` VALUES (10, 113, NULL, NULL, '', NULL, '0', '17781245450787352', '', '', '2026-05-07 11:29:05', '', '2026-05-07 11:29:05', '', 0, NULL, '', '');
INSERT INTO `repair_order` VALUES (11, 1, NULL, NULL, '3', NULL, '0', '17783283171477637', '', '', '2026-05-09 20:05:15', '', '2026-05-09 20:05:15', '11', 0, '2026-05-10 11:00:00', '刘', '19306057791');
INSERT INTO `repair_order` VALUES (12, 113, NULL, NULL, '1', NULL, '0', '17785034229644081', '', '', '2026-05-11 20:43:43', '', '2026-05-11 20:43:43', 'niaho', 0, '2026-05-12 08:00:00', '11', '11');
INSERT INTO `repair_order` VALUES (13, 113, NULL, NULL, '1', NULL, '0', '17785034302155861', '', '', '2026-05-11 20:43:50', '', '2026-05-11 20:43:50', 'niaho', 0, '2026-05-12 08:00:00', '11', '11');
INSERT INTO `repair_order` VALUES (14, 113, NULL, NULL, '1', NULL, '0', '17785035103523692', '', '', '2026-05-11 20:45:10', '', '2026-05-11 20:45:10', '1111', 0, '2026-05-12 10:00:00', '11', '11');
INSERT INTO `repair_order` VALUES (15, 113, NULL, NULL, '5', NULL, '0', '17785144236727650', '', '', '2026-05-11 23:47:03', '', '2026-05-11 23:58:09', '冰箱坏了', 1, '2026-05-12 10:00:00', '杰夫', '19306057796');
INSERT INTO `repair_order` VALUES (16, 113, NULL, NULL, '1', '2026-05-11 23:59:18', '3', '17785151577475258', '', '', '2026-05-11 23:59:17', '', '2026-05-11 23:59:17', '冰箱坏了', 0, '2026-05-12 10:00:00', '杰夫', '19306057796');
INSERT INTO `repair_order` VALUES (17, 138, 116, 15, '0', '2026-05-12 23:48:33', '3', '17786009133155724', '', '', '2026-05-12 23:48:32', '', '2026-05-12 23:48:32', '瓷砖脱落', 0, '2026-05-13 08:00:00', '旺仔妈', '19306057795');
INSERT INTO `repair_order` VALUES (18, 138, NULL, 15, '4', '2026-05-16 14:18:44', '0', '17789123238473364', '', '', '2026-05-16 14:18:43', '', '2026-05-16 14:18:43', '厕所堵了', 0, '2026-05-16 14:00:00', '旺仔爹', '19306057796');
INSERT INTO `repair_order` VALUES (19, 138, NULL, 15, '1', '2026-05-16 14:40:02', '3', '17789136019394079', '', '', '2026-05-16 14:40:01', '', '2026-05-16 14:40:01', '111', 0, '2026-05-16 14:00:00', '饭饭', '1111111111');
INSERT INTO `repair_order` VALUES (20, 138, NULL, 15, '1', '2026-05-16 15:11:47', '0', '17789155074847546', '[\"http://mashang.eicp.vip:5555/ms_stu_pro345/profile/upload/2026/05/16/图片2_20260516151133A001.png\"]', '', '2026-05-16 15:11:47', '', '2026-05-16 15:11:47', '1111', 0, '2026-05-16 14:00:00', '饭饭', '1111111111');
INSERT INTO `repair_order` VALUES (21, 138, 116, 15, '1', '2026-05-16 15:16:58', '1', '17789158177622786', '[\"http://mashang.eicp.vip:5555/ms_stu_pro345/profile/upload/2026/05/16/图片2_20260516162712A002.png\"]', '', '2026-05-16 15:16:57', '', '2026-05-22 20:17:41', '11', 0, '2026-05-16 16:00:00', '奶奶', '1111111');
INSERT INTO `repair_order` VALUES (22, 113, 116, 13, '2', '2026-05-22 14:50:44', '2', '17794326440312549', '[\"http://mashang.eicp.vip:5555/ms_stu_pro345/profile/upload/2026/05/22/OIP-C_20260522145043A002.jpg\"]', '', '2026-05-22 14:50:44', '', '2026-05-22 14:50:44', '下水道', 0, '2026-05-22 16:00:00', '范深', '19306057793');
INSERT INTO `repair_order` VALUES (23, 113, 116, 13, '1', '2026-05-28 15:45:23', '2', '17799543233133428', '[\"http://mashang.eicp.vip:5555/ms_stu_pro345/profile/upload/2026/05/28/OIP-C_20260528154522A001.jpg\"]', '', '2026-05-28 15:45:23', '', '2026-05-28 15:45:23', 'sax咋说', 0, '2026-05-28 16:00:00', '范深', '13844563343');

-- ----------------------------
-- Table structure for room
-- ----------------------------
DROP TABLE IF EXISTS `room`;
CREATE TABLE `room`  (
  `room_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '房间id',
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户id',
  `floor_id` bigint(20) NULL DEFAULT NULL COMMENT '楼层id',
  `building_id` bigint(20) NULL DEFAULT NULL COMMENT '楼宇id',
  `park_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '园区名称',
  `room_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间名称',
  `room_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间类型(1_loft 2_商业配套 3_办公场所 4其他)',
  `money` double NULL DEFAULT NULL COMMENT '物业费',
  `money_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物业费单位(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)',
  `renovation_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '装修类型(1简装 2精装 3毛坯房)',
  `room_height` double NULL DEFAULT NULL COMMENT '房高',
  `status` char(1) CHARACTER SET armscii8 COLLATE armscii8_general_ci NULL DEFAULT '0' COMMENT '上架状态(0未上架 1已上架)',
  `tenant_money` double NULL DEFAULT NULL COMMENT '租金',
  `tenant_money_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '租金类型(1_元/m²/天   2_元/m²/月   3_元/天  4_元/月)',
  `room_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房间图片(可多张)',
  `area` double NULL DEFAULT NULL COMMENT '面积',
  `introduce` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `tenant_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '租赁状态(0未租 1在租)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，1-已删）',
  PRIMARY KEY (`room_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room
-- ----------------------------
INSERT INTO `room` VALUES (1, NULL, 1, 1, '翻东花园', '101', '0', 90, '0', '0', 2, '1', 1500, '0', '[\"https://example.com/images/room_502_01.jpg\",\"https://example.com/images/room_502_02.jpg\",\"https://example.com/images/room_502_04.jpg\"]', 80, '1', '0', 'admin', '2026-01-27 20:29:26', '', '2026-05-06 21:41:06', NULL, 0);
INSERT INTO `room` VALUES (2, NULL, 21, 17, '翻斗花园', '102研发中心', '2', 1200, '3', '2', 3.8, '1', 4.5, '1', '[\"https://example.com/images/room_502_01.jpg\",\"https://example.com/images/room_502_02.jpg\",\"https://example.com/images/room_502_03.jpg\"]', 125.5, '该房间采光良好，配备中央空调，适合中型团队办公。', '0', '', '2026-01-28 21:00:21', '', '2026-05-06 21:46:31', NULL, 0);
INSERT INTO `room` VALUES (3, NULL, 21, 17, '翻斗花园', '宝宝花园', '3', 100, '3', '1', NULL, '1', 1000, '3', '[]', 20, '简单房型，性价比高', '0', '', '2026-02-02 18:07:12', '', '2026-05-22 17:28:41', NULL, 0);
INSERT INTO `room` VALUES (4, NULL, 21, 17, '翻斗花园', '萌萌乐园', '1', 200, '3', '2', NULL, '1', 2000, '3', '[]', 80, '精装房带给你极好的体验', '0', '', '2026-02-02 18:11:12', '', '2026-05-22 17:28:46', NULL, 0);
INSERT INTO `room` VALUES (5, 151, 21, 17, '翻斗花园', '萌萌乐园', '1', 200, '3', '2', NULL, '1', 2000, '3', '[]', 80, '精装房带给你极好的体验', '1', '', '2026-02-02 18:11:21', '', '2026-05-22 18:03:22', NULL, 0);
INSERT INTO `room` VALUES (6, NULL, 21, 17, '翻斗花园', '102', '2', 200, '3', '1', NULL, '1', 100, '0', '[]', 20, '', '0', '', '2026-02-02 18:13:35', '', '2026-05-22 17:28:49', NULL, 1);
INSERT INTO `room` VALUES (7, NULL, 23, 17, '翻斗花园', '201', '3', 200, '3', '2', NULL, '1', 200, '3', '[]', 1, '', '0', '', '2026-02-02 18:23:57', '', '2026-05-06 21:41:06', NULL, 0);
INSERT INTO `room` VALUES (8, NULL, 21, 17, '翻斗花园', '101', '2', 20, '3', '2', NULL, '1', 1000, '3', '[]', 20, '', '0', '', '2026-02-02 18:26:25', '', '2026-05-06 21:41:06', NULL, 0);
INSERT INTO `room` VALUES (9, NULL, 21, 17, '翻斗花园', '102', '1', 10, '3', '2', NULL, '1', 1000, '3', '[\"http://127.0.0.1:11345/profile/upload/2026/05/16/图片2_20260516140719A030.png\",\"http://127.0.0.1:11345/profile/upload/2026/05/16/图片2_20260516140721A031.png\"]', 20, '', '0', '', '2026-02-02 18:28:39', '', '2026-05-16 14:07:23', NULL, 0);
INSERT INTO `room` VALUES (10, 151, 25, 28, '翻斗花园', '服务区', '3', 50, '1', '2', NULL, '1', 5000, '0', '[]', 100, '', '1', '', '2026-04-30 16:38:37', '', '2026-05-22 16:30:31', NULL, 0);
INSERT INTO `room` VALUES (11, NULL, 25, 28, '翻斗花园', '222', '3', 134, '0', '1', NULL, '0', 1223, '0', '[]', 122, '', '0', '', '2026-04-30 16:48:12', '', '2026-05-06 21:41:06', NULL, 1);
INSERT INTO `room` VALUES (12, NULL, 25, 28, '翻斗花园', '唱歌区', '3', 362, '1', '1', NULL, '0', 5210, '1', '[]', 341, '', '0', '', '2026-04-30 16:50:20', '', '2026-05-06 21:41:06', NULL, 0);
INSERT INTO `room` VALUES (13, 113, 28, 28, '翻斗花园', '309', '3', 10, '0', '1', 12, '1', 100, '0', '[\"http://mashang.eicp.vip:5555/ms_stu_pro345/profile/upload/2026/05/16/图片2_20260516142057A032.png\"]', 120, '豪华', '1', '', '2026-05-07 19:53:03', '', '2026-05-16 16:53:20', NULL, 0);
INSERT INTO `room` VALUES (14, NULL, 28, 28, '翻斗花园', '309', '4', 111, '0', '2', 11, '0', 111, '0', '[]', 120, '豪华', '0', '', '2026-05-07 20:23:02', '', '2026-05-07 20:27:37', NULL, 1);
INSERT INTO `room` VALUES (15, 138, 28, 28, '翻斗花园', '311', '1', 20, '0', '1', 4, '1', 100, '0', '[\"http://127.0.0.1:11345/profile/upload/2026/05/16/图片2_20260516135552A028.png\"]', 100, '', '1', '', '2026-05-12 23:42:02', '', '2026-05-16 13:55:55', NULL, 0);
INSERT INTO `room` VALUES (16, 151, 28, 28, '翻斗花园', '软件开发', '1', 100, '2', '2', NULL, '1', 5241, '0', '[\"http://mashang.eicp.vip:5555/ms_stu_pro345/profile/upload/2026/05/17/OIP-C_20260517205852A001.jpg\"]', 500, '', '1', '', '2026-05-17 20:54:01', '', '2026-05-22 15:12:35', NULL, 0);
INSERT INTO `room` VALUES (17, 139, 26, 28, '翻斗花园', 'KTV', '1', 50, '3', '2', NULL, '1', 200, '2', '[]', 100, '', '1', '', '2026-05-22 15:15:49', '', '2026-05-22 15:20:06', NULL, 0);
INSERT INTO `room` VALUES (18, 151, 23, 17, '翻斗花园', '5.22测试', '2', 20, '1', '2', NULL, '1', 120, '0', '[\"http://mashang.eicp.vip:5555/ms_stu_pro345/profile/upload/2026/05/22/3cf8fe9f-0859-4c4e-894a-38385ae6abab_20260522161326A003.png\"]', 250, '', '1', '', '2026-05-22 16:13:28', '', '2026-05-22 17:12:23', NULL, 0);
INSERT INTO `room` VALUES (19, 152, 28, 28, '翻斗花园', '三层天台', '1', 522, '1', '2', NULL, '1', 1584, '0', '[]', 235, '', '1', '', '2026-05-28 15:49:57', '', '2026-05-28 15:51:31', NULL, 0);
INSERT INTO `room` VALUES (20, 153, 25, 28, '翻斗花园', '一层5.28', '3', 34, '0', '1', NULL, '1', 245, '0', '[]', 233, '', '1', '', '2026-05-28 20:23:20', '', '2026-05-28 20:26:35', NULL, 0);

-- ----------------------------
-- Table structure for room_record
-- ----------------------------
DROP TABLE IF EXISTS `room_record`;
CREATE TABLE `room_record`  (
  `record_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '房间记录id',
  `room_id` bigint(20) NULL DEFAULT NULL COMMENT '房间id',
  `tenant_id` bigint(20) NULL DEFAULT NULL COMMENT '租户id',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '状态((0在租、1退租))',
  `time` datetime NULL DEFAULT NULL COMMENT '入住时间',
  `contract_id` bigint(20) NULL DEFAULT NULL COMMENT '合同id',
  `tenant_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '退租原因',
  `tenant_time` datetime NULL DEFAULT NULL COMMENT '退租时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，1-已删）',
  PRIMARY KEY (`record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of room_record
-- ----------------------------
INSERT INTO `room_record` VALUES (1, 13, 113, '0', '2026-02-01 20:30:02', 1, NULL, '2026-03-01 20:30:18', 'admin', '2026-01-27 20:30:18', '', '2026-05-12 16:34:05', NULL, 0);
INSERT INTO `room_record` VALUES (2, 16, 151, '1', '2026-05-22 00:00:00', 21, NULL, NULL, '', '2026-05-22 15:12:35', '', '2026-05-22 15:12:35', NULL, 0);
INSERT INTO `room_record` VALUES (3, 17, 139, '1', '2026-05-22 16:00:00', 22, NULL, NULL, '', '2026-05-22 15:20:06', '', '2026-05-22 15:20:06', NULL, 0);
INSERT INTO `room_record` VALUES (4, 10, 151, '1', '2026-05-21 16:00:00', 20, NULL, NULL, '', '2026-05-22 16:30:31', '', '2026-05-22 16:30:31', NULL, 0);
INSERT INTO `room_record` VALUES (5, 18, 151, '1', '2026-05-22 00:00:00', 23, NULL, NULL, '', '2026-05-22 17:12:23', '', '2026-05-22 17:12:23', NULL, 0);
INSERT INTO `room_record` VALUES (6, 5, 151, '1', '2026-05-22 00:00:00', 24, NULL, NULL, '', '2026-05-22 18:03:22', '', '2026-05-22 18:03:22', NULL, 0);
INSERT INTO `room_record` VALUES (7, 19, 152, '1', '2026-05-28 16:00:00', 57, NULL, NULL, '', '2026-05-28 15:51:31', '', '2026-05-28 15:51:31', NULL, 0);
INSERT INTO `room_record` VALUES (8, 20, 153, '1', '2026-05-28 16:00:00', 58, NULL, NULL, '', '2026-05-28 20:26:35', '', '2026-05-28 20:26:35', NULL, 0);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2026-01-08 16:39:44', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2026-01-08 16:39:44', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2026-01-08 16:39:44', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2026-01-08 16:39:44', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2026-01-08 16:39:44', 'admin', '2026-01-28 15:21:32', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2026-01-08 16:39:44', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 117 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2026-01-08 16:39:44', 'admin', '2026-01-27 20:15:52', '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 1, '元/m²/天', '0', 'rent_type', NULL, 'default', 'N', '0', 'admin', '2026-01-27 20:26:25', 'admin', '2026-02-02 19:00:33', NULL);
INSERT INTO `sys_dict_data` VALUES (101, 2, '元/m²/月', '1', 'rent_type', NULL, 'default', 'N', '0', 'admin', '2026-01-27 20:29:10', 'admin', '2026-02-02 19:00:48', NULL);
INSERT INTO `sys_dict_data` VALUES (102, 3, '元/天', '2', 'rent_type', NULL, 'default', 'N', '0', 'admin', '2026-01-27 20:29:36', 'admin', '2026-02-02 19:00:53', NULL);
INSERT INTO `sys_dict_data` VALUES (103, 4, '元/月', '3', 'rent_type', NULL, 'default', 'N', '0', 'admin', '2026-01-27 20:29:53', 'admin', '2026-02-02 19:01:00', NULL);
INSERT INTO `sys_dict_data` VALUES (104, 1, '元/m²/天', '0', 'money_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:35:19', 'admin', '2026-02-02 19:01:15', NULL);
INSERT INTO `sys_dict_data` VALUES (105, 2, '元/m²/月', '1', 'money_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:35:45', 'admin', '2026-02-02 19:01:26', NULL);
INSERT INTO `sys_dict_data` VALUES (106, 3, '元/天', '2', 'money_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:36:03', 'admin', '2026-02-02 19:01:32', NULL);
INSERT INTO `sys_dict_data` VALUES (107, 4, '元/月', '3', 'money_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:36:16', 'admin', '2026-02-02 19:01:36', NULL);
INSERT INTO `sys_dict_data` VALUES (108, 1, 'loft', '0', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:38:36', 'admin', '2026-02-02 19:01:52', NULL);
INSERT INTO `sys_dict_data` VALUES (109, 2, '商业配套', '1', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:38:57', 'admin', '2026-02-02 19:02:00', NULL);
INSERT INTO `sys_dict_data` VALUES (110, 3, '办公场所', '2', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:39:13', 'admin', '2026-02-02 19:02:05', NULL);
INSERT INTO `sys_dict_data` VALUES (111, 4, '其他', '3', 'room_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:39:27', 'admin', '2026-02-02 19:02:10', NULL);
INSERT INTO `sys_dict_data` VALUES (112, 1, '简装', '0', 'renovation_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:42:04', 'admin', '2026-02-02 19:02:19', NULL);
INSERT INTO `sys_dict_data` VALUES (113, 2, '精装', '1', 'renovation_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:42:19', 'admin', '2026-02-02 19:02:24', NULL);
INSERT INTO `sys_dict_data` VALUES (114, 3, '毛坯房', '2', 'renovation_type', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:42:31', 'admin', '2026-02-02 19:02:29', NULL);
INSERT INTO `sys_dict_data` VALUES (115, 1, '未租', '0', 'tenant_status', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:44:15', 'admin', '2026-02-01 10:44:35', NULL);
INSERT INTO `sys_dict_data` VALUES (116, 1, '在租', '1', 'tenant_status', NULL, 'default', 'N', '0', 'admin', '2026-02-01 10:44:28', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '租金类型', 'rent_type', '0', 'admin', '2026-01-27 13:07:42', 'admin', '2026-01-27 20:23:56', NULL);
INSERT INTO `sys_dict_type` VALUES (101, '物业费单位', 'money_type', '0', 'admin', '2026-02-01 10:34:22', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (102, '房型', 'room_type', '0', 'admin', '2026-02-01 10:37:48', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (103, '装修类型', 'renovation_type', '0', 'admin', '2026-02-01 10:41:02', '', NULL, NULL);
INSERT INTO `sys_dict_type` VALUES (104, '租赁状态', 'tenant_status', '0', 'admin', '2026-02-01 10:43:43', '', NULL, NULL);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2026-01-08 16:39:44', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 968 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:07:34');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:08:19');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:08:29');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:08:42');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:08:42');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:08:42');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:08:43');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-01-19 19:08:47');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 19:10:02');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-19 22:53:26');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-21 20:43:40');
INSERT INTO `sys_logininfor` VALUES (111, 'fanfan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:08:28');
INSERT INTO `sys_logininfor` VALUES (112, '', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '* 必须填写', '2026-01-22 01:20:11');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-22 01:20:20');
INSERT INTO `sys_logininfor` VALUES (114, 'fansheng', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:23:09');
INSERT INTO `sys_logininfor` VALUES (115, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:25:37');
INSERT INTO `sys_logininfor` VALUES (116, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:47:25');
INSERT INTO `sys_logininfor` VALUES (117, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:48:24');
INSERT INTO `sys_logininfor` VALUES (118, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:48:49');
INSERT INTO `sys_logininfor` VALUES (119, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:52:39');
INSERT INTO `sys_logininfor` VALUES (120, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:55:16');
INSERT INTO `sys_logininfor` VALUES (121, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 01:59:30');
INSERT INTO `sys_logininfor` VALUES (122, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 02:37:45');
INSERT INTO `sys_logininfor` VALUES (123, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 03:07:37');
INSERT INTO `sys_logininfor` VALUES (124, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 03:18:49');
INSERT INTO `sys_logininfor` VALUES (125, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 03:37:01');
INSERT INTO `sys_logininfor` VALUES (126, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 03:53:42');
INSERT INTO `sys_logininfor` VALUES (127, '2215343467', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 18:56:34');
INSERT INTO `sys_logininfor` VALUES (128, '2215343467', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 19:03:32');
INSERT INTO `sys_logininfor` VALUES (129, '2215343467', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-01-22 19:04:25');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-26 13:15:01');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 10:59:24');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 12:35:26');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 19:40:03');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 19:40:05');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 19:45:08');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 19:54:19');
INSERT INTO `sys_logininfor` VALUES (137, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-01-27 19:54:47');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-01-27 19:54:52');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-27 19:54:57');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-01-28 15:17:20');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 15:21:04');
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-28 19:36:38');
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-29 20:13:27');
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-01-31 20:57:19');
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-01 10:32:01');
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-01 10:32:10');
INSERT INTO `sys_logininfor` VALUES (147, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-02 18:28:54');
INSERT INTO `sys_logininfor` VALUES (148, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 04:37:55');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-04 14:24:43');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-05 09:21:35');
INSERT INTO `sys_logininfor` VALUES (151, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-05 15:31:00');
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-05 16:51:02');
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-05 16:51:04');
INSERT INTO `sys_logininfor` VALUES (154, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-06 15:09:50');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-06 16:36:06');
INSERT INTO `sys_logininfor` VALUES (156, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-06 16:36:20');
INSERT INTO `sys_logininfor` VALUES (157, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-06 16:36:52');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-06 16:37:10');
INSERT INTO `sys_logininfor` VALUES (159, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-06 16:37:32');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-06 16:39:19');
INSERT INTO `sys_logininfor` VALUES (161, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-02-06 16:39:33');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-02-06 16:39:42');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-06 16:39:45');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-06 16:41:27');
INSERT INTO `sys_logininfor` VALUES (165, 'z张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-02-06 16:41:38');
INSERT INTO `sys_logininfor` VALUES (166, 'z张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-02-06 16:41:39');
INSERT INTO `sys_logininfor` VALUES (167, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-02-06 16:41:44');
INSERT INTO `sys_logininfor` VALUES (168, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-06 16:41:56');
INSERT INTO `sys_logininfor` VALUES (169, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-06 17:51:30');
INSERT INTO `sys_logininfor` VALUES (170, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-06 17:51:39');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 10:29:37');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 10:31:14');
INSERT INTO `sys_logininfor` VALUES (173, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 10:31:28');
INSERT INTO `sys_logininfor` VALUES (174, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 16:28:01');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 16:28:04');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 16:33:20');
INSERT INTO `sys_logininfor` VALUES (177, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 16:33:29');
INSERT INTO `sys_logininfor` VALUES (178, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 16:33:45');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 16:33:46');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 16:34:13');
INSERT INTO `sys_logininfor` VALUES (181, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 16:34:20');
INSERT INTO `sys_logininfor` VALUES (182, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 16:58:19');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 16:58:23');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 17:08:42');
INSERT INTO `sys_logininfor` VALUES (185, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 17:08:51');
INSERT INTO `sys_logininfor` VALUES (186, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 17:13:22');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 17:13:25');
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 17:13:54');
INSERT INTO `sys_logininfor` VALUES (189, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 17:14:05');
INSERT INTO `sys_logininfor` VALUES (190, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 17:15:23');
INSERT INTO `sys_logininfor` VALUES (191, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 17:15:32');
INSERT INTO `sys_logininfor` VALUES (192, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-08 17:15:42');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 17:15:45');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-08 19:33:47');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-10 10:37:40');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-10 14:52:47');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-10 16:38:20');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-10 16:38:27');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-10 16:38:30');
INSERT INTO `sys_logininfor` VALUES (200, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-10 16:38:40');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-11 17:23:42');
INSERT INTO `sys_logininfor` VALUES (202, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-11 19:25:34');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-11 19:25:39');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-11 19:27:09');
INSERT INTO `sys_logininfor` VALUES (205, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-11 19:27:17');
INSERT INTO `sys_logininfor` VALUES (206, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-11 19:41:06');
INSERT INTO `sys_logininfor` VALUES (207, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-11 20:06:33');
INSERT INTO `sys_logininfor` VALUES (208, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-11 20:06:46');
INSERT INTO `sys_logininfor` VALUES (209, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-12 15:49:39');
INSERT INTO `sys_logininfor` VALUES (210, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-12 16:37:36');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-12 18:06:15');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-12 18:18:36');
INSERT INTO `sys_logininfor` VALUES (213, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-12 18:18:46');
INSERT INTO `sys_logininfor` VALUES (214, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-12 20:00:37');
INSERT INTO `sys_logininfor` VALUES (215, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-12 20:00:50');
INSERT INTO `sys_logininfor` VALUES (216, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-12 20:10:40');
INSERT INTO `sys_logininfor` VALUES (217, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-02-12 20:10:48');
INSERT INTO `sys_logininfor` VALUES (218, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-12 20:10:53');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-13 15:17:20');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-13 15:19:23');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-13 15:29:20');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-13 15:29:28');
INSERT INTO `sys_logininfor` VALUES (223, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-13 15:29:34');
INSERT INTO `sys_logininfor` VALUES (224, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-13 15:29:39');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-13 15:29:41');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-13 15:30:16');
INSERT INTO `sys_logininfor` VALUES (227, 'ww', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-13 15:30:22');
INSERT INTO `sys_logininfor` VALUES (228, 'ww', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-13 18:41:26');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-15 22:21:19');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-16 14:16:26');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-16 14:36:36');
INSERT INTO `sys_logininfor` VALUES (232, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-16 14:36:48');
INSERT INTO `sys_logininfor` VALUES (233, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-16 23:04:07');
INSERT INTO `sys_logininfor` VALUES (234, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-23 14:18:26');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-23 14:18:44');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-23 14:44:59');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-23 14:56:13');
INSERT INTO `sys_logininfor` VALUES (238, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-23 14:56:31');
INSERT INTO `sys_logininfor` VALUES (239, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-24 12:58:48');
INSERT INTO `sys_logininfor` VALUES (240, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-24 12:59:01');
INSERT INTO `sys_logininfor` VALUES (241, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-24 12:59:13');
INSERT INTO `sys_logininfor` VALUES (242, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-24 16:37:07');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-26 18:01:26');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-02-26 18:02:05');
INSERT INTO `sys_logininfor` VALUES (245, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-26 18:02:20');
INSERT INTO `sys_logininfor` VALUES (246, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-02-27 17:29:05');
INSERT INTO `sys_logininfor` VALUES (247, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-02 16:19:16');
INSERT INTO `sys_logininfor` VALUES (248, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-02 16:19:25');
INSERT INTO `sys_logininfor` VALUES (249, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-02 16:19:51');
INSERT INTO `sys_logininfor` VALUES (250, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-02 16:19:57');
INSERT INTO `sys_logininfor` VALUES (251, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-02 16:20:58');
INSERT INTO `sys_logininfor` VALUES (252, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-02 16:21:04');
INSERT INTO `sys_logininfor` VALUES (253, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-02 16:45:05');
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-02 16:45:09');
INSERT INTO `sys_logininfor` VALUES (255, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-03 15:13:46');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-05 15:53:23');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-06 17:35:45');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-06 17:37:44');
INSERT INTO `sys_logininfor` VALUES (259, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-06 17:37:52');
INSERT INTO `sys_logininfor` VALUES (260, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-06 17:37:58');
INSERT INTO `sys_logininfor` VALUES (261, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-06 18:39:56');
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-07 16:30:05');
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-07 16:30:11');
INSERT INTO `sys_logininfor` VALUES (264, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-07 16:30:23');
INSERT INTO `sys_logininfor` VALUES (265, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-07 16:59:19');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-07 16:59:24');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-07 20:28:54');
INSERT INTO `sys_logininfor` VALUES (268, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-07 20:29:17');
INSERT INTO `sys_logininfor` VALUES (269, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-07 20:30:25');
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-07 20:30:30');
INSERT INTO `sys_logininfor` VALUES (271, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-07 20:30:47');
INSERT INTO `sys_logininfor` VALUES (272, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-07 20:31:00');
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-07 21:12:28');
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-08 11:41:51');
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-09 14:45:18');
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-09 23:16:20');
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-09 23:16:26');
INSERT INTO `sys_logininfor` VALUES (278, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-09 23:16:40');
INSERT INTO `sys_logininfor` VALUES (279, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-09 23:50:44');
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-09 23:50:49');
INSERT INTO `sys_logininfor` VALUES (281, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-10 18:09:49');
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-10 18:30:17');
INSERT INTO `sys_logininfor` VALUES (283, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-10 18:30:36');
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-11 13:59:52');
INSERT INTO `sys_logininfor` VALUES (285, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-11 13:59:57');
INSERT INTO `sys_logininfor` VALUES (286, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-11 14:00:08');
INSERT INTO `sys_logininfor` VALUES (287, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-03-11 14:00:13');
INSERT INTO `sys_logininfor` VALUES (288, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-11 14:00:15');
INSERT INTO `sys_logininfor` VALUES (289, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-11 21:37:47');
INSERT INTO `sys_logininfor` VALUES (290, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-13 13:43:57');
INSERT INTO `sys_logininfor` VALUES (291, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-13 13:44:20');
INSERT INTO `sys_logininfor` VALUES (292, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-13 13:44:31');
INSERT INTO `sys_logininfor` VALUES (293, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-13 13:45:14');
INSERT INTO `sys_logininfor` VALUES (294, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-13 13:45:19');
INSERT INTO `sys_logininfor` VALUES (295, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-13 13:45:23');
INSERT INTO `sys_logininfor` VALUES (296, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-13 13:45:37');
INSERT INTO `sys_logininfor` VALUES (297, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 13:50:53');
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-19 13:51:53');
INSERT INTO `sys_logininfor` VALUES (299, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 13:52:11');
INSERT INTO `sys_logininfor` VALUES (300, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-19 14:16:12');
INSERT INTO `sys_logininfor` VALUES (301, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 14:16:20');
INSERT INTO `sys_logininfor` VALUES (302, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-19 16:38:35');
INSERT INTO `sys_logininfor` VALUES (303, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 16:38:43');
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 20:06:00');
INSERT INTO `sys_logininfor` VALUES (305, '123456', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:10:44');
INSERT INTO `sys_logininfor` VALUES (306, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:10:50');
INSERT INTO `sys_logininfor` VALUES (307, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:10:51');
INSERT INTO `sys_logininfor` VALUES (308, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:10:51');
INSERT INTO `sys_logininfor` VALUES (309, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:11:22');
INSERT INTO `sys_logininfor` VALUES (310, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:11:40');
INSERT INTO `sys_logininfor` VALUES (311, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:11:55');
INSERT INTO `sys_logininfor` VALUES (312, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:12:21');
INSERT INTO `sys_logininfor` VALUES (313, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:12:34');
INSERT INTO `sys_logininfor` VALUES (314, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:12:38');
INSERT INTO `sys_logininfor` VALUES (315, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:12:53');
INSERT INTO `sys_logininfor` VALUES (316, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:13:04');
INSERT INTO `sys_logininfor` VALUES (317, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:13:09');
INSERT INTO `sys_logininfor` VALUES (318, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2026-03-19 20:13:26');
INSERT INTO `sys_logininfor` VALUES (319, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 20:13:41');
INSERT INTO `sys_logininfor` VALUES (320, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:15:28');
INSERT INTO `sys_logininfor` VALUES (321, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:05');
INSERT INTO `sys_logininfor` VALUES (322, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:06');
INSERT INTO `sys_logininfor` VALUES (323, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:08');
INSERT INTO `sys_logininfor` VALUES (324, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:08');
INSERT INTO `sys_logininfor` VALUES (325, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:08');
INSERT INTO `sys_logininfor` VALUES (326, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:08');
INSERT INTO `sys_logininfor` VALUES (327, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:08');
INSERT INTO `sys_logininfor` VALUES (328, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:09');
INSERT INTO `sys_logininfor` VALUES (329, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:09');
INSERT INTO `sys_logininfor` VALUES (330, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:09');
INSERT INTO `sys_logininfor` VALUES (331, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:10');
INSERT INTO `sys_logininfor` VALUES (332, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:10');
INSERT INTO `sys_logininfor` VALUES (333, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:10');
INSERT INTO `sys_logininfor` VALUES (334, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:10');
INSERT INTO `sys_logininfor` VALUES (335, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:11');
INSERT INTO `sys_logininfor` VALUES (336, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:11');
INSERT INTO `sys_logininfor` VALUES (337, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:11');
INSERT INTO `sys_logininfor` VALUES (338, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:11');
INSERT INTO `sys_logininfor` VALUES (339, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:11');
INSERT INTO `sys_logininfor` VALUES (340, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:12');
INSERT INTO `sys_logininfor` VALUES (341, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:12');
INSERT INTO `sys_logininfor` VALUES (342, 'fanshen@qq.com', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-19 20:17:12');
INSERT INTO `sys_logininfor` VALUES (343, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 20:17:32');
INSERT INTO `sys_logininfor` VALUES (344, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-19 20:18:14');
INSERT INTO `sys_logininfor` VALUES (345, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-22 13:02:26');
INSERT INTO `sys_logininfor` VALUES (346, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 14:40:38');
INSERT INTO `sys_logininfor` VALUES (347, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-22 14:44:10');
INSERT INTO `sys_logininfor` VALUES (348, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-22 14:44:46');
INSERT INTO `sys_logininfor` VALUES (349, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-22 14:44:55');
INSERT INTO `sys_logininfor` VALUES (350, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-22 14:45:11');
INSERT INTO `sys_logininfor` VALUES (351, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-22 14:45:21');
INSERT INTO `sys_logininfor` VALUES (352, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-03-22 14:45:22');
INSERT INTO `sys_logininfor` VALUES (353, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-22 14:45:40');
INSERT INTO `sys_logininfor` VALUES (354, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 14:45:53');
INSERT INTO `sys_logininfor` VALUES (355, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-22 14:46:57');
INSERT INTO `sys_logininfor` VALUES (356, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2026-03-22 14:47:10');
INSERT INTO `sys_logininfor` VALUES (357, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-03-22 14:47:15');
INSERT INTO `sys_logininfor` VALUES (358, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2026-03-22 14:47:35');
INSERT INTO `sys_logininfor` VALUES (359, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 14:48:35');
INSERT INTO `sys_logininfor` VALUES (360, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-22 14:49:26');
INSERT INTO `sys_logininfor` VALUES (361, 'wangwu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 14:49:35');
INSERT INTO `sys_logininfor` VALUES (362, 'wangwu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-22 14:49:56');
INSERT INTO `sys_logininfor` VALUES (363, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 14:50:04');
INSERT INTO `sys_logininfor` VALUES (364, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-22 14:55:03');
INSERT INTO `sys_logininfor` VALUES (365, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2026-03-22 14:55:18');
INSERT INTO `sys_logininfor` VALUES (366, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 15:38:42');
INSERT INTO `sys_logininfor` VALUES (367, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 19:39:29');
INSERT INTO `sys_logininfor` VALUES (368, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-22 20:18:32');
INSERT INTO `sys_logininfor` VALUES (369, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-26 21:06:22');
INSERT INTO `sys_logininfor` VALUES (370, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-27 10:27:58');
INSERT INTO `sys_logininfor` VALUES (371, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-27 10:28:02');
INSERT INTO `sys_logininfor` VALUES (372, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-27 10:28:32');
INSERT INTO `sys_logininfor` VALUES (373, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-27 10:29:31');
INSERT INTO `sys_logininfor` VALUES (374, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-27 10:29:46');
INSERT INTO `sys_logininfor` VALUES (375, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-03-27 10:30:19');
INSERT INTO `sys_logininfor` VALUES (376, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-27 10:30:43');
INSERT INTO `sys_logininfor` VALUES (377, 'wangwu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-03-27 10:31:02');
INSERT INTO `sys_logininfor` VALUES (378, 'wangwu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-27 10:31:11');
INSERT INTO `sys_logininfor` VALUES (379, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-03-27 18:40:22');
INSERT INTO `sys_logininfor` VALUES (380, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-07 18:20:20');
INSERT INTO `sys_logininfor` VALUES (381, 'testuser001', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-04-07 18:21:17');
INSERT INTO `sys_logininfor` VALUES (382, 'testuser001', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-04-07 18:22:51');
INSERT INTO `sys_logininfor` VALUES (383, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-10 15:26:07');
INSERT INTO `sys_logininfor` VALUES (384, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-18 13:56:00');
INSERT INTO `sys_logininfor` VALUES (385, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-20 15:22:12');
INSERT INTO `sys_logininfor` VALUES (386, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-20 18:21:51');
INSERT INTO `sys_logininfor` VALUES (387, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-20 18:21:57');
INSERT INTO `sys_logininfor` VALUES (388, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-20 18:23:10');
INSERT INTO `sys_logininfor` VALUES (389, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-20 18:23:42');
INSERT INTO `sys_logininfor` VALUES (390, 'zhangsan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-20 18:23:55');
INSERT INTO `sys_logininfor` VALUES (391, 'zhangsan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-04-20 18:23:58');
INSERT INTO `sys_logininfor` VALUES (392, 'zhangsan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-20 18:24:02');
INSERT INTO `sys_logininfor` VALUES (393, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-20 18:24:10');
INSERT INTO `sys_logininfor` VALUES (394, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-04-20 18:24:13');
INSERT INTO `sys_logininfor` VALUES (395, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-20 18:24:17');
INSERT INTO `sys_logininfor` VALUES (396, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-20 19:36:52');
INSERT INTO `sys_logininfor` VALUES (397, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-04-21 16:04:09');
INSERT INTO `sys_logininfor` VALUES (398, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 16:04:17');
INSERT INTO `sys_logininfor` VALUES (399, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-21 16:04:25');
INSERT INTO `sys_logininfor` VALUES (400, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 16:04:39');
INSERT INTO `sys_logininfor` VALUES (401, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-21 16:04:50');
INSERT INTO `sys_logininfor` VALUES (402, 'zhangsan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-21 16:05:34');
INSERT INTO `sys_logininfor` VALUES (403, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 16:05:43');
INSERT INTO `sys_logininfor` VALUES (404, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-21 16:31:08');
INSERT INTO `sys_logininfor` VALUES (405, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 16:31:18');
INSERT INTO `sys_logininfor` VALUES (406, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-21 17:46:26');
INSERT INTO `sys_logininfor` VALUES (407, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 17:46:42');
INSERT INTO `sys_logininfor` VALUES (408, 'u1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-21 20:59:39');
INSERT INTO `sys_logininfor` VALUES (409, 'u1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-21 21:01:45');
INSERT INTO `sys_logininfor` VALUES (410, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2', '2026-04-21 21:01:59');
INSERT INTO `sys_logininfor` VALUES (411, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 21:03:14');
INSERT INTO `sys_logininfor` VALUES (412, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-21 21:03:50');
INSERT INTO `sys_logininfor` VALUES (413, 'weixiu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 21:03:54');
INSERT INTO `sys_logininfor` VALUES (414, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-21 21:21:21');
INSERT INTO `sys_logininfor` VALUES (415, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-04-23 17:49:38');
INSERT INTO `sys_logininfor` VALUES (416, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-23 17:49:41');
INSERT INTO `sys_logininfor` VALUES (417, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-04-27 08:54:52');
INSERT INTO `sys_logininfor` VALUES (418, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-27 08:54:55');
INSERT INTO `sys_logininfor` VALUES (419, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-27 11:18:11');
INSERT INTO `sys_logininfor` VALUES (420, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-27 11:18:15');
INSERT INTO `sys_logininfor` VALUES (421, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-27 11:18:38');
INSERT INTO `sys_logininfor` VALUES (422, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-27 11:18:48');
INSERT INTO `sys_logininfor` VALUES (423, 'weixiu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-27 16:43:01');
INSERT INTO `sys_logininfor` VALUES (424, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-28 11:06:15');
INSERT INTO `sys_logininfor` VALUES (425, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-28 11:06:31');
INSERT INTO `sys_logininfor` VALUES (426, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-28 11:10:51');
INSERT INTO `sys_logininfor` VALUES (427, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-28 14:18:45');
INSERT INTO `sys_logininfor` VALUES (428, 'weixiu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-28 14:19:00');
INSERT INTO `sys_logininfor` VALUES (429, 'weixiu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-28 16:27:03');
INSERT INTO `sys_logininfor` VALUES (430, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-28 16:27:22');
INSERT INTO `sys_logininfor` VALUES (431, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 16:40:42');
INSERT INTO `sys_logininfor` VALUES (432, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-29 16:41:38');
INSERT INTO `sys_logininfor` VALUES (433, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-29 16:41:44');
INSERT INTO `sys_logininfor` VALUES (434, '12', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-29 16:41:44');
INSERT INTO `sys_logininfor` VALUES (435, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-29 16:42:01');
INSERT INTO `sys_logininfor` VALUES (436, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-29 16:42:01');
INSERT INTO `sys_logininfor` VALUES (437, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-04-29 16:42:02');
INSERT INTO `sys_logininfor` VALUES (438, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 16:42:10');
INSERT INTO `sys_logininfor` VALUES (439, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 16:43:21');
INSERT INTO `sys_logininfor` VALUES (440, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 16:43:53');
INSERT INTO `sys_logininfor` VALUES (441, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 16:57:31');
INSERT INTO `sys_logininfor` VALUES (442, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-29 16:58:39');
INSERT INTO `sys_logininfor` VALUES (443, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 16:58:57');
INSERT INTO `sys_logininfor` VALUES (444, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 17:01:43');
INSERT INTO `sys_logininfor` VALUES (445, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-29 17:03:39');
INSERT INTO `sys_logininfor` VALUES (446, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 17:03:57');
INSERT INTO `sys_logininfor` VALUES (447, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-29 17:04:40');
INSERT INTO `sys_logininfor` VALUES (448, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-30 16:20:03');
INSERT INTO `sys_logininfor` VALUES (449, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-30 16:20:31');
INSERT INTO `sys_logininfor` VALUES (450, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-30 16:34:16');
INSERT INTO `sys_logininfor` VALUES (451, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-30 16:34:20');
INSERT INTO `sys_logininfor` VALUES (452, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-30 16:35:30');
INSERT INTO `sys_logininfor` VALUES (453, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-30 16:58:09');
INSERT INTO `sys_logininfor` VALUES (454, 'qqq', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', 'nested exception is org.apache.ibatis.exceptions.TooManyResultsException: Expected one result (or null) to be returned by selectOne(), but found: 2', '2026-04-30 16:58:23');
INSERT INTO `sys_logininfor` VALUES (455, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-04-30 17:00:24');
INSERT INTO `sys_logininfor` VALUES (456, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-30 17:00:27');
INSERT INTO `sys_logininfor` VALUES (457, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-30 17:02:01');
INSERT INTO `sys_logininfor` VALUES (458, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-30 17:02:16');
INSERT INTO `sys_logininfor` VALUES (459, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-04-30 17:05:06');
INSERT INTO `sys_logininfor` VALUES (460, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-04-30 17:05:16');
INSERT INTO `sys_logininfor` VALUES (461, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 18:08:24');
INSERT INTO `sys_logininfor` VALUES (462, 'testuser001', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-01 18:09:04');
INSERT INTO `sys_logininfor` VALUES (463, 'plainTextPassword123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-01 18:09:17');
INSERT INTO `sys_logininfor` VALUES (464, 'testuser001', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 18:09:26');
INSERT INTO `sys_logininfor` VALUES (465, 'testuser002', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-01 18:10:53');
INSERT INTO `sys_logininfor` VALUES (466, 'testuser003', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-01 18:11:19');
INSERT INTO `sys_logininfor` VALUES (467, 'testuser001', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-01 18:24:46');
INSERT INTO `sys_logininfor` VALUES (468, 'testuser001', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 18:32:03');
INSERT INTO `sys_logininfor` VALUES (469, 'testuser002', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 18:32:42');
INSERT INTO `sys_logininfor` VALUES (470, 'testuser003', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 18:32:46');
INSERT INTO `sys_logininfor` VALUES (471, 'testuser003', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 18:32:50');
INSERT INTO `sys_logininfor` VALUES (472, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:00:50');
INSERT INTO `sys_logininfor` VALUES (473, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:01:12');
INSERT INTO `sys_logininfor` VALUES (474, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:01:53');
INSERT INTO `sys_logininfor` VALUES (475, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:02:10');
INSERT INTO `sys_logininfor` VALUES (476, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-05-01 19:04:51');
INSERT INTO `sys_logininfor` VALUES (477, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-01 19:04:55');
INSERT INTO `sys_logininfor` VALUES (478, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-05-01 19:05:11');
INSERT INTO `sys_logininfor` VALUES (479, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-01 19:05:15');
INSERT INTO `sys_logininfor` VALUES (480, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-05-01 19:05:24');
INSERT INTO `sys_logininfor` VALUES (481, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-05-01 19:05:26');
INSERT INTO `sys_logininfor` VALUES (482, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-01 19:05:30');
INSERT INTO `sys_logininfor` VALUES (483, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:05:57');
INSERT INTO `sys_logininfor` VALUES (484, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:06:03');
INSERT INTO `sys_logininfor` VALUES (485, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:06:29');
INSERT INTO `sys_logininfor` VALUES (486, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:06:55');
INSERT INTO `sys_logininfor` VALUES (487, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:07:01');
INSERT INTO `sys_logininfor` VALUES (488, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:07:55');
INSERT INTO `sys_logininfor` VALUES (489, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:10:11');
INSERT INTO `sys_logininfor` VALUES (490, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:10:16');
INSERT INTO `sys_logininfor` VALUES (491, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:11:16');
INSERT INTO `sys_logininfor` VALUES (492, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:11:25');
INSERT INTO `sys_logininfor` VALUES (493, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:18:38');
INSERT INTO `sys_logininfor` VALUES (494, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:18:43');
INSERT INTO `sys_logininfor` VALUES (495, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-01 19:42:50');
INSERT INTO `sys_logininfor` VALUES (496, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-01 19:42:55');
INSERT INTO `sys_logininfor` VALUES (497, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-06 14:12:04');
INSERT INTO `sys_logininfor` VALUES (498, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-06 14:12:28');
INSERT INTO `sys_logininfor` VALUES (499, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-06 14:13:42');
INSERT INTO `sys_logininfor` VALUES (500, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-06 14:13:52');
INSERT INTO `sys_logininfor` VALUES (501, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-06 14:14:04');
INSERT INTO `sys_logininfor` VALUES (502, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-06 17:54:37');
INSERT INTO `sys_logininfor` VALUES (503, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-06 17:55:06');
INSERT INTO `sys_logininfor` VALUES (504, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-06 17:56:05');
INSERT INTO `sys_logininfor` VALUES (505, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-06 17:56:15');
INSERT INTO `sys_logininfor` VALUES (506, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-06 19:53:17');
INSERT INTO `sys_logininfor` VALUES (507, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-05-07 08:38:28');
INSERT INTO `sys_logininfor` VALUES (508, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 08:38:31');
INSERT INTO `sys_logininfor` VALUES (509, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-07 08:38:37');
INSERT INTO `sys_logininfor` VALUES (510, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 08:38:46');
INSERT INTO `sys_logininfor` VALUES (511, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-07 08:41:27');
INSERT INTO `sys_logininfor` VALUES (512, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 08:41:37');
INSERT INTO `sys_logininfor` VALUES (513, 'testuser003', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 16:28:23');
INSERT INTO `sys_logininfor` VALUES (514, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 17:32:59');
INSERT INTO `sys_logininfor` VALUES (515, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-05-07 19:35:23');
INSERT INTO `sys_logininfor` VALUES (516, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 19:35:26');
INSERT INTO `sys_logininfor` VALUES (517, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-07 19:37:24');
INSERT INTO `sys_logininfor` VALUES (518, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 19:37:50');
INSERT INTO `sys_logininfor` VALUES (519, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-07 19:41:12');
INSERT INTO `sys_logininfor` VALUES (520, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 19:41:20');
INSERT INTO `sys_logininfor` VALUES (521, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-07 19:41:26');
INSERT INTO `sys_logininfor` VALUES (522, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 19:41:40');
INSERT INTO `sys_logininfor` VALUES (523, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 19:43:04');
INSERT INTO `sys_logininfor` VALUES (524, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-05-07 20:07:33');
INSERT INTO `sys_logininfor` VALUES (525, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 20:07:37');
INSERT INTO `sys_logininfor` VALUES (526, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 20:26:49');
INSERT INTO `sys_logininfor` VALUES (527, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-07 20:30:39');
INSERT INTO `sys_logininfor` VALUES (528, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 15:11:50');
INSERT INTO `sys_logininfor` VALUES (529, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-09 15:13:33');
INSERT INTO `sys_logininfor` VALUES (530, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 15:13:41');
INSERT INTO `sys_logininfor` VALUES (531, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-09 15:18:45');
INSERT INTO `sys_logininfor` VALUES (532, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 15:18:53');
INSERT INTO `sys_logininfor` VALUES (533, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-09 15:30:55');
INSERT INTO `sys_logininfor` VALUES (534, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 15:32:49');
INSERT INTO `sys_logininfor` VALUES (535, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-09 15:32:54');
INSERT INTO `sys_logininfor` VALUES (536, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 15:33:02');
INSERT INTO `sys_logininfor` VALUES (537, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 15:35:59');
INSERT INTO `sys_logininfor` VALUES (538, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 15:36:00');
INSERT INTO `sys_logininfor` VALUES (539, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-09 20:02:34');
INSERT INTO `sys_logininfor` VALUES (540, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 16:39:03');
INSERT INTO `sys_logininfor` VALUES (541, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 16:54:31');
INSERT INTO `sys_logininfor` VALUES (542, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 16:54:33');
INSERT INTO `sys_logininfor` VALUES (543, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 16:56:35');
INSERT INTO `sys_logininfor` VALUES (544, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 16:56:43');
INSERT INTO `sys_logininfor` VALUES (545, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 16:57:03');
INSERT INTO `sys_logininfor` VALUES (546, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 16:57:05');
INSERT INTO `sys_logininfor` VALUES (547, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 17:00:31');
INSERT INTO `sys_logininfor` VALUES (548, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 17:00:45');
INSERT INTO `sys_logininfor` VALUES (549, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 17:05:46');
INSERT INTO `sys_logininfor` VALUES (550, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 17:05:49');
INSERT INTO `sys_logininfor` VALUES (551, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 17:07:16');
INSERT INTO `sys_logininfor` VALUES (552, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 17:07:24');
INSERT INTO `sys_logininfor` VALUES (553, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 17:07:38');
INSERT INTO `sys_logininfor` VALUES (554, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 17:07:43');
INSERT INTO `sys_logininfor` VALUES (555, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 17:08:26');
INSERT INTO `sys_logininfor` VALUES (556, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 17:08:36');
INSERT INTO `sys_logininfor` VALUES (557, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-10 17:11:21');
INSERT INTO `sys_logininfor` VALUES (558, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-10 17:11:42');
INSERT INTO `sys_logininfor` VALUES (559, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-11 20:10:56');
INSERT INTO `sys_logininfor` VALUES (560, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-11 20:36:12');
INSERT INTO `sys_logininfor` VALUES (561, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-11 20:36:24');
INSERT INTO `sys_logininfor` VALUES (562, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-11 20:50:51');
INSERT INTO `sys_logininfor` VALUES (563, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-11 20:50:55');
INSERT INTO `sys_logininfor` VALUES (564, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-11 20:54:15');
INSERT INTO `sys_logininfor` VALUES (565, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-11 20:54:24');
INSERT INTO `sys_logininfor` VALUES (566, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-11 23:25:06');
INSERT INTO `sys_logininfor` VALUES (567, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-11 23:30:25');
INSERT INTO `sys_logininfor` VALUES (568, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-11 23:51:24');
INSERT INTO `sys_logininfor` VALUES (569, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 15:59:19');
INSERT INTO `sys_logininfor` VALUES (570, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 15:59:20');
INSERT INTO `sys_logininfor` VALUES (571, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 16:03:13');
INSERT INTO `sys_logininfor` VALUES (572, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 20:28:22');
INSERT INTO `sys_logininfor` VALUES (573, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 20:28:23');
INSERT INTO `sys_logininfor` VALUES (574, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 23:11:39');
INSERT INTO `sys_logininfor` VALUES (575, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 23:13:26');
INSERT INTO `sys_logininfor` VALUES (576, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-12 23:23:32');
INSERT INTO `sys_logininfor` VALUES (577, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-12 23:39:42');
INSERT INTO `sys_logininfor` VALUES (578, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 23:40:10');
INSERT INTO `sys_logininfor` VALUES (579, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-12 23:40:46');
INSERT INTO `sys_logininfor` VALUES (580, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-12 23:40:57');
INSERT INTO `sys_logininfor` VALUES (581, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-14 20:04:52');
INSERT INTO `sys_logininfor` VALUES (582, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-14 20:04:54');
INSERT INTO `sys_logininfor` VALUES (583, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-14 20:33:40');
INSERT INTO `sys_logininfor` VALUES (584, '三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-14 20:33:52');
INSERT INTO `sys_logininfor` VALUES (585, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-14 20:34:17');
INSERT INTO `sys_logininfor` VALUES (586, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-15 18:54:07');
INSERT INTO `sys_logininfor` VALUES (587, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-15 18:54:10');
INSERT INTO `sys_logininfor` VALUES (588, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-15 20:16:25');
INSERT INTO `sys_logininfor` VALUES (589, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-16 11:30:23');
INSERT INTO `sys_logininfor` VALUES (590, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-16 11:31:38');
INSERT INTO `sys_logininfor` VALUES (591, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 11:31:48');
INSERT INTO `sys_logininfor` VALUES (592, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 11:41:19');
INSERT INTO `sys_logininfor` VALUES (593, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-16 11:41:20');
INSERT INTO `sys_logininfor` VALUES (594, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-16 11:41:22');
INSERT INTO `sys_logininfor` VALUES (595, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-16 11:41:23');
INSERT INTO `sys_logininfor` VALUES (596, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 11:41:27');
INSERT INTO `sys_logininfor` VALUES (597, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 11:57:54');
INSERT INTO `sys_logininfor` VALUES (598, 'wangzai', '172.18.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2026-05-16 12:01:17');
INSERT INTO `sys_logininfor` VALUES (599, 'wangzai', '172.18.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2026-05-16 12:03:23');
INSERT INTO `sys_logininfor` VALUES (600, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 12:05:11');
INSERT INTO `sys_logininfor` VALUES (601, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 13:09:00');
INSERT INTO `sys_logininfor` VALUES (602, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 13:09:15');
INSERT INTO `sys_logininfor` VALUES (603, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 14:08:17');
INSERT INTO `sys_logininfor` VALUES (604, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 14:08:27');
INSERT INTO `sys_logininfor` VALUES (605, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 14:10:00');
INSERT INTO `sys_logininfor` VALUES (606, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 14:10:03');
INSERT INTO `sys_logininfor` VALUES (607, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 14:10:34');
INSERT INTO `sys_logininfor` VALUES (608, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 14:10:43');
INSERT INTO `sys_logininfor` VALUES (609, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 14:21:33');
INSERT INTO `sys_logininfor` VALUES (610, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 14:21:43');
INSERT INTO `sys_logininfor` VALUES (611, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 14:24:03');
INSERT INTO `sys_logininfor` VALUES (612, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 16:37:05');
INSERT INTO `sys_logininfor` VALUES (613, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 16:37:16');
INSERT INTO `sys_logininfor` VALUES (614, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 16:40:20');
INSERT INTO `sys_logininfor` VALUES (615, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 16:40:37');
INSERT INTO `sys_logininfor` VALUES (616, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 16:40:56');
INSERT INTO `sys_logininfor` VALUES (617, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 16:41:18');
INSERT INTO `sys_logininfor` VALUES (618, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 17:22:18');
INSERT INTO `sys_logininfor` VALUES (619, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-16 17:22:27');
INSERT INTO `sys_logininfor` VALUES (620, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 17:22:35');
INSERT INTO `sys_logininfor` VALUES (621, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 17:27:29');
INSERT INTO `sys_logininfor` VALUES (622, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 17:27:48');
INSERT INTO `sys_logininfor` VALUES (623, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 17:37:54');
INSERT INTO `sys_logininfor` VALUES (624, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 17:37:59');
INSERT INTO `sys_logininfor` VALUES (625, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 18:10:15');
INSERT INTO `sys_logininfor` VALUES (626, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 18:10:22');
INSERT INTO `sys_logininfor` VALUES (627, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 18:26:59');
INSERT INTO `sys_logininfor` VALUES (628, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 18:32:16');
INSERT INTO `sys_logininfor` VALUES (629, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 18:32:47');
INSERT INTO `sys_logininfor` VALUES (630, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 18:35:50');
INSERT INTO `sys_logininfor` VALUES (631, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 18:35:53');
INSERT INTO `sys_logininfor` VALUES (632, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 18:38:12');
INSERT INTO `sys_logininfor` VALUES (633, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 18:38:21');
INSERT INTO `sys_logininfor` VALUES (634, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 18:58:51');
INSERT INTO `sys_logininfor` VALUES (635, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 18:59:14');
INSERT INTO `sys_logininfor` VALUES (636, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 19:54:10');
INSERT INTO `sys_logininfor` VALUES (637, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 19:54:53');
INSERT INTO `sys_logininfor` VALUES (638, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 19:54:55');
INSERT INTO `sys_logininfor` VALUES (639, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-16 19:57:56');
INSERT INTO `sys_logininfor` VALUES (640, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-16 20:33:17');
INSERT INTO `sys_logininfor` VALUES (641, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 09:42:43');
INSERT INTO `sys_logininfor` VALUES (642, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 17:25:13');
INSERT INTO `sys_logininfor` VALUES (643, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 17:28:40');
INSERT INTO `sys_logininfor` VALUES (644, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 17:28:48');
INSERT INTO `sys_logininfor` VALUES (645, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 17:28:57');
INSERT INTO `sys_logininfor` VALUES (646, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 17:29:15');
INSERT INTO `sys_logininfor` VALUES (647, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 17:29:18');
INSERT INTO `sys_logininfor` VALUES (648, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 17:29:36');
INSERT INTO `sys_logininfor` VALUES (649, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 17:29:38');
INSERT INTO `sys_logininfor` VALUES (650, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 17:29:44');
INSERT INTO `sys_logininfor` VALUES (651, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 17:29:50');
INSERT INTO `sys_logininfor` VALUES (652, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 17:30:27');
INSERT INTO `sys_logininfor` VALUES (653, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 20:35:38');
INSERT INTO `sys_logininfor` VALUES (654, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 20:40:46');
INSERT INTO `sys_logininfor` VALUES (655, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 20:41:19');
INSERT INTO `sys_logininfor` VALUES (656, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 20:41:25');
INSERT INTO `sys_logininfor` VALUES (657, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 20:43:34');
INSERT INTO `sys_logininfor` VALUES (658, 'mfz', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 20:43:44');
INSERT INTO `sys_logininfor` VALUES (659, 'mfz', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 20:43:58');
INSERT INTO `sys_logininfor` VALUES (660, 'mfz', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 20:47:37');
INSERT INTO `sys_logininfor` VALUES (661, 'mfz', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 20:48:58');
INSERT INTO `sys_logininfor` VALUES (662, 'lsj', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 20:50:14');
INSERT INTO `sys_logininfor` VALUES (663, 'lsj', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 20:50:23');
INSERT INTO `sys_logininfor` VALUES (664, 'lsj', '127.0.0.1', '内网IP', 'Chrome Mobile', 'Android 6.x', '1', '用户不存在/密码错误', '2026-05-17 20:50:59');
INSERT INTO `sys_logininfor` VALUES (665, 'lsj', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 20:51:56');
INSERT INTO `sys_logininfor` VALUES (666, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 20:52:05');
INSERT INTO `sys_logininfor` VALUES (667, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 20:52:07');
INSERT INTO `sys_logininfor` VALUES (668, 'lsj', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-17 20:52:26');
INSERT INTO `sys_logininfor` VALUES (669, 'lsj', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2026-05-17 20:52:27');
INSERT INTO `sys_logininfor` VALUES (670, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 20:52:57');
INSERT INTO `sys_logininfor` VALUES (671, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 20:53:08');
INSERT INTO `sys_logininfor` VALUES (672, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 20:56:13');
INSERT INTO `sys_logininfor` VALUES (673, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-17 21:05:13');
INSERT INTO `sys_logininfor` VALUES (674, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-17 21:05:19');
INSERT INTO `sys_logininfor` VALUES (675, 'lsj', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-18 09:23:17');
INSERT INTO `sys_logininfor` VALUES (676, 'zhangsan2026', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-18 10:05:45');
INSERT INTO `sys_logininfor` VALUES (677, 'zhangsan2026', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-18 10:06:15');
INSERT INTO `sys_logininfor` VALUES (678, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 15:05:44');
INSERT INTO `sys_logininfor` VALUES (679, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 15:16:57');
INSERT INTO `sys_logininfor` VALUES (680, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-21 15:17:02');
INSERT INTO `sys_logininfor` VALUES (681, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 15:17:10');
INSERT INTO `sys_logininfor` VALUES (682, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 15:33:34');
INSERT INTO `sys_logininfor` VALUES (683, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 15:33:43');
INSERT INTO `sys_logininfor` VALUES (684, 'zhangsan2026', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-21 15:34:57');
INSERT INTO `sys_logininfor` VALUES (685, 'zhangsan2026', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-21 15:38:22');
INSERT INTO `sys_logininfor` VALUES (686, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 15:56:39');
INSERT INTO `sys_logininfor` VALUES (687, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 15:56:55');
INSERT INTO `sys_logininfor` VALUES (688, 'yl', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-21 15:58:33');
INSERT INTO `sys_logininfor` VALUES (689, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 15:58:55');
INSERT INTO `sys_logininfor` VALUES (690, 'yl', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 15:59:06');
INSERT INTO `sys_logininfor` VALUES (691, 'yl', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 15:59:11');
INSERT INTO `sys_logininfor` VALUES (692, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 16:04:01');
INSERT INTO `sys_logininfor` VALUES (693, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 16:07:06');
INSERT INTO `sys_logininfor` VALUES (694, 'testuser005', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-21 16:13:46');
INSERT INTO `sys_logininfor` VALUES (695, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-21 16:14:19');
INSERT INTO `sys_logininfor` VALUES (696, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 16:14:47');
INSERT INTO `sys_logininfor` VALUES (697, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 16:14:59');
INSERT INTO `sys_logininfor` VALUES (698, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-21 16:15:07');
INSERT INTO `sys_logininfor` VALUES (699, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 16:15:13');
INSERT INTO `sys_logininfor` VALUES (700, 'lrl', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-21 18:55:10');
INSERT INTO `sys_logininfor` VALUES (701, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-21 18:55:23');
INSERT INTO `sys_logininfor` VALUES (702, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 18:55:27');
INSERT INTO `sys_logininfor` VALUES (703, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 18:59:47');
INSERT INTO `sys_logininfor` VALUES (704, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-21 21:09:51');
INSERT INTO `sys_logininfor` VALUES (705, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-05-22 13:45:53');
INSERT INTO `sys_logininfor` VALUES (706, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 13:45:58');
INSERT INTO `sys_logininfor` VALUES (707, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 14:32:36');
INSERT INTO `sys_logininfor` VALUES (708, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 14:42:37');
INSERT INTO `sys_logininfor` VALUES (709, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 14:44:10');
INSERT INTO `sys_logininfor` VALUES (710, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 14:45:00');
INSERT INTO `sys_logininfor` VALUES (711, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 14:45:28');
INSERT INTO `sys_logininfor` VALUES (712, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 14:45:44');
INSERT INTO `sys_logininfor` VALUES (713, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 14:45:58');
INSERT INTO `sys_logininfor` VALUES (714, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 14:49:37');
INSERT INTO `sys_logininfor` VALUES (715, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 14:49:54');
INSERT INTO `sys_logininfor` VALUES (716, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 14:55:53');
INSERT INTO `sys_logininfor` VALUES (717, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 14:56:33');
INSERT INTO `sys_logininfor` VALUES (718, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 15:02:39');
INSERT INTO `sys_logininfor` VALUES (719, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 15:02:47');
INSERT INTO `sys_logininfor` VALUES (720, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 15:12:09');
INSERT INTO `sys_logininfor` VALUES (721, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 15:12:16');
INSERT INTO `sys_logininfor` VALUES (722, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 15:16:45');
INSERT INTO `sys_logininfor` VALUES (723, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 15:16:51');
INSERT INTO `sys_logininfor` VALUES (724, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 15:20:36');
INSERT INTO `sys_logininfor` VALUES (725, '张三', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 15:53:09');
INSERT INTO `sys_logininfor` VALUES (726, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 15:53:49');
INSERT INTO `sys_logininfor` VALUES (727, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 15:54:55');
INSERT INTO `sys_logininfor` VALUES (728, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 15:55:09');
INSERT INTO `sys_logininfor` VALUES (729, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 15:55:17');
INSERT INTO `sys_logininfor` VALUES (730, 'zjy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 15:55:30');
INSERT INTO `sys_logininfor` VALUES (731, 'zjy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 15:56:06');
INSERT INTO `sys_logininfor` VALUES (732, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 15:56:16');
INSERT INTO `sys_logininfor` VALUES (733, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 16:19:05');
INSERT INTO `sys_logininfor` VALUES (734, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 16:19:10');
INSERT INTO `sys_logininfor` VALUES (735, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 16:30:09');
INSERT INTO `sys_logininfor` VALUES (736, 'zjy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 16:30:14');
INSERT INTO `sys_logininfor` VALUES (737, 'zjy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 16:32:25');
INSERT INTO `sys_logininfor` VALUES (738, 'zjy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 16:33:07');
INSERT INTO `sys_logininfor` VALUES (739, '张三', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 16:40:58');
INSERT INTO `sys_logininfor` VALUES (740, 'zjy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 16:41:11');
INSERT INTO `sys_logininfor` VALUES (741, 'zjy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 16:41:56');
INSERT INTO `sys_logininfor` VALUES (742, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 16:42:07');
INSERT INTO `sys_logininfor` VALUES (743, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-05-22 16:42:28');
INSERT INTO `sys_logininfor` VALUES (744, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 16:42:44');
INSERT INTO `sys_logininfor` VALUES (745, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 16:43:50');
INSERT INTO `sys_logininfor` VALUES (746, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 16:44:06');
INSERT INTO `sys_logininfor` VALUES (747, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 16:46:02');
INSERT INTO `sys_logininfor` VALUES (748, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 16:46:24');
INSERT INTO `sys_logininfor` VALUES (749, 'lqy', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2026-05-22 16:48:08');
INSERT INTO `sys_logininfor` VALUES (750, '张三', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 16:48:17');
INSERT INTO `sys_logininfor` VALUES (751, '张三', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2026-05-22 16:48:22');
INSERT INTO `sys_logininfor` VALUES (752, '张三', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2026-05-22 16:48:26');
INSERT INTO `sys_logininfor` VALUES (753, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 16:53:55');
INSERT INTO `sys_logininfor` VALUES (754, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 16:58:04');
INSERT INTO `sys_logininfor` VALUES (755, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 16:58:16');
INSERT INTO `sys_logininfor` VALUES (756, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-05-22 16:58:21');
INSERT INTO `sys_logininfor` VALUES (757, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 16:58:54');
INSERT INTO `sys_logininfor` VALUES (758, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:13:14');
INSERT INTO `sys_logininfor` VALUES (759, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:13:24');
INSERT INTO `sys_logininfor` VALUES (760, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:13:33');
INSERT INTO `sys_logininfor` VALUES (761, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:13:37');
INSERT INTO `sys_logininfor` VALUES (762, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:14:03');
INSERT INTO `sys_logininfor` VALUES (763, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:14:14');
INSERT INTO `sys_logininfor` VALUES (764, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:16:32');
INSERT INTO `sys_logininfor` VALUES (765, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:16:55');
INSERT INTO `sys_logininfor` VALUES (766, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 17:17:15');
INSERT INTO `sys_logininfor` VALUES (767, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 17:17:21');
INSERT INTO `sys_logininfor` VALUES (768, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:17:28');
INSERT INTO `sys_logininfor` VALUES (769, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:31:23');
INSERT INTO `sys_logininfor` VALUES (770, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:31:41');
INSERT INTO `sys_logininfor` VALUES (771, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:42:32');
INSERT INTO `sys_logininfor` VALUES (772, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2026-05-22 17:46:03');
INSERT INTO `sys_logininfor` VALUES (773, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:46:07');
INSERT INTO `sys_logininfor` VALUES (774, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:54:13');
INSERT INTO `sys_logininfor` VALUES (775, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:54:21');
INSERT INTO `sys_logininfor` VALUES (776, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 17:54:27');
INSERT INTO `sys_logininfor` VALUES (777, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 17:55:01');
INSERT INTO `sys_logininfor` VALUES (778, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 18:46:17');
INSERT INTO `sys_logininfor` VALUES (779, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 18:46:38');
INSERT INTO `sys_logininfor` VALUES (780, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 18:55:42');
INSERT INTO `sys_logininfor` VALUES (781, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 18:56:07');
INSERT INTO `sys_logininfor` VALUES (782, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 19:16:47');
INSERT INTO `sys_logininfor` VALUES (783, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 19:38:24');
INSERT INTO `sys_logininfor` VALUES (784, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 19:38:28');
INSERT INTO `sys_logininfor` VALUES (785, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 19:53:29');
INSERT INTO `sys_logininfor` VALUES (786, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 19:53:30');
INSERT INTO `sys_logininfor` VALUES (787, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 19:53:43');
INSERT INTO `sys_logininfor` VALUES (788, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 19:53:51');
INSERT INTO `sys_logininfor` VALUES (789, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 19:53:58');
INSERT INTO `sys_logininfor` VALUES (790, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 19:55:35');
INSERT INTO `sys_logininfor` VALUES (791, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-22 19:55:38');
INSERT INTO `sys_logininfor` VALUES (792, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 19:55:45');
INSERT INTO `sys_logininfor` VALUES (793, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 19:56:59');
INSERT INTO `sys_logininfor` VALUES (794, 'weixiu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 19:57:09');
INSERT INTO `sys_logininfor` VALUES (795, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:06:16');
INSERT INTO `sys_logininfor` VALUES (796, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:06:20');
INSERT INTO `sys_logininfor` VALUES (797, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:09:02');
INSERT INTO `sys_logininfor` VALUES (798, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:09:07');
INSERT INTO `sys_logininfor` VALUES (799, 'weixiu', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:13:02');
INSERT INTO `sys_logininfor` VALUES (800, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:13:23');
INSERT INTO `sys_logininfor` VALUES (801, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:14:31');
INSERT INTO `sys_logininfor` VALUES (802, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:16:05');
INSERT INTO `sys_logininfor` VALUES (803, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:16:12');
INSERT INTO `sys_logininfor` VALUES (804, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:21:13');
INSERT INTO `sys_logininfor` VALUES (805, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:21:18');
INSERT INTO `sys_logininfor` VALUES (806, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:21:18');
INSERT INTO `sys_logininfor` VALUES (807, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:23:19');
INSERT INTO `sys_logininfor` VALUES (808, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:23:29');
INSERT INTO `sys_logininfor` VALUES (809, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:23:35');
INSERT INTO `sys_logininfor` VALUES (810, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:23:49');
INSERT INTO `sys_logininfor` VALUES (811, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:24:58');
INSERT INTO `sys_logininfor` VALUES (812, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:25:09');
INSERT INTO `sys_logininfor` VALUES (813, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:26:35');
INSERT INTO `sys_logininfor` VALUES (814, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:26:45');
INSERT INTO `sys_logininfor` VALUES (815, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:27:02');
INSERT INTO `sys_logininfor` VALUES (816, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:27:07');
INSERT INTO `sys_logininfor` VALUES (817, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:32:09');
INSERT INTO `sys_logininfor` VALUES (818, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:38:40');
INSERT INTO `sys_logininfor` VALUES (819, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:38:50');
INSERT INTO `sys_logininfor` VALUES (820, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:41:49');
INSERT INTO `sys_logininfor` VALUES (821, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:42:03');
INSERT INTO `sys_logininfor` VALUES (822, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:42:18');
INSERT INTO `sys_logininfor` VALUES (823, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:42:32');
INSERT INTO `sys_logininfor` VALUES (824, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:52:18');
INSERT INTO `sys_logininfor` VALUES (825, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 20:52:25');
INSERT INTO `sys_logininfor` VALUES (826, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 20:59:51');
INSERT INTO `sys_logininfor` VALUES (827, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 21:00:01');
INSERT INTO `sys_logininfor` VALUES (828, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-22 21:03:11');
INSERT INTO `sys_logininfor` VALUES (829, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-22 21:03:27');
INSERT INTO `sys_logininfor` VALUES (830, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-24 16:54:20');
INSERT INTO `sys_logininfor` VALUES (831, 'zhangsan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-24 16:54:36');
INSERT INTO `sys_logininfor` VALUES (832, 'zhangsan', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-24 16:54:45');
INSERT INTO `sys_logininfor` VALUES (833, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2026-05-24 16:54:51');
INSERT INTO `sys_logininfor` VALUES (834, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-24 16:54:54');
INSERT INTO `sys_logininfor` VALUES (835, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-26 19:59:05');
INSERT INTO `sys_logininfor` VALUES (836, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-26 20:10:16');
INSERT INTO `sys_logininfor` VALUES (837, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-26 21:02:51');
INSERT INTO `sys_logininfor` VALUES (838, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-26 21:03:10');
INSERT INTO `sys_logininfor` VALUES (839, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-26 21:09:16');
INSERT INTO `sys_logininfor` VALUES (840, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-26 21:09:18');
INSERT INTO `sys_logininfor` VALUES (841, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-26 21:10:35');
INSERT INTO `sys_logininfor` VALUES (842, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-26 21:10:42');
INSERT INTO `sys_logininfor` VALUES (843, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-26 21:11:23');
INSERT INTO `sys_logininfor` VALUES (844, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-26 21:12:21');
INSERT INTO `sys_logininfor` VALUES (845, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-27 16:19:40');
INSERT INTO `sys_logininfor` VALUES (846, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-27 16:20:12');
INSERT INTO `sys_logininfor` VALUES (847, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-27 16:20:19');
INSERT INTO `sys_logininfor` VALUES (848, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-27 16:20:29');
INSERT INTO `sys_logininfor` VALUES (849, 'lisi', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 14:31:28');
INSERT INTO `sys_logininfor` VALUES (850, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 15:42:00');
INSERT INTO `sys_logininfor` VALUES (851, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 15:44:48');
INSERT INTO `sys_logininfor` VALUES (852, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 15:46:34');
INSERT INTO `sys_logininfor` VALUES (853, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 15:46:37');
INSERT INTO `sys_logininfor` VALUES (854, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-28 15:49:00');
INSERT INTO `sys_logininfor` VALUES (855, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 15:49:04');
INSERT INTO `sys_logininfor` VALUES (856, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 15:49:15');
INSERT INTO `sys_logininfor` VALUES (857, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 15:53:35');
INSERT INTO `sys_logininfor` VALUES (858, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 15:53:38');
INSERT INTO `sys_logininfor` VALUES (859, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 15:54:40');
INSERT INTO `sys_logininfor` VALUES (860, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 15:54:57');
INSERT INTO `sys_logininfor` VALUES (861, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 15:59:28');
INSERT INTO `sys_logininfor` VALUES (862, 'cjl', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 15:59:33');
INSERT INTO `sys_logininfor` VALUES (863, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:00:02');
INSERT INTO `sys_logininfor` VALUES (864, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:00:13');
INSERT INTO `sys_logininfor` VALUES (865, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:00:17');
INSERT INTO `sys_logininfor` VALUES (866, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:01:24');
INSERT INTO `sys_logininfor` VALUES (867, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:01:27');
INSERT INTO `sys_logininfor` VALUES (868, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:02:18');
INSERT INTO `sys_logininfor` VALUES (869, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:02:22');
INSERT INTO `sys_logininfor` VALUES (870, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:03:10');
INSERT INTO `sys_logininfor` VALUES (871, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:03:13');
INSERT INTO `sys_logininfor` VALUES (872, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:03:28');
INSERT INTO `sys_logininfor` VALUES (873, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:03:31');
INSERT INTO `sys_logininfor` VALUES (874, 'lqy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:05:04');
INSERT INTO `sys_logininfor` VALUES (875, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:05:47');
INSERT INTO `sys_logininfor` VALUES (876, 'zjy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:07:03');
INSERT INTO `sys_logininfor` VALUES (877, 'tyf', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:08:13');
INSERT INTO `sys_logininfor` VALUES (878, 'lrl', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:08:16');
INSERT INTO `sys_logininfor` VALUES (879, 'xyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:08:20');
INSERT INTO `sys_logininfor` VALUES (880, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:08:36');
INSERT INTO `sys_logininfor` VALUES (881, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:08:59');
INSERT INTO `sys_logininfor` VALUES (882, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:09:02');
INSERT INTO `sys_logininfor` VALUES (883, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:09:05');
INSERT INTO `sys_logininfor` VALUES (884, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:09:12');
INSERT INTO `sys_logininfor` VALUES (885, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:09:15');
INSERT INTO `sys_logininfor` VALUES (886, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:09:36');
INSERT INTO `sys_logininfor` VALUES (887, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:10:01');
INSERT INTO `sys_logininfor` VALUES (888, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:10:05');
INSERT INTO `sys_logininfor` VALUES (889, 'fanxiao', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:10:09');
INSERT INTO `sys_logininfor` VALUES (890, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:10:13');
INSERT INTO `sys_logininfor` VALUES (891, 'zyr', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:13:58');
INSERT INTO `sys_logininfor` VALUES (892, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:14:01');
INSERT INTO `sys_logininfor` VALUES (893, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:16:00');
INSERT INTO `sys_logininfor` VALUES (894, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:16:10');
INSERT INTO `sys_logininfor` VALUES (895, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:16:14');
INSERT INTO `sys_logininfor` VALUES (896, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:16:30');
INSERT INTO `sys_logininfor` VALUES (897, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-05-28 16:17:43');
INSERT INTO `sys_logininfor` VALUES (898, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:17:49');
INSERT INTO `sys_logininfor` VALUES (899, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:35:26');
INSERT INTO `sys_logininfor` VALUES (900, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:35:28');
INSERT INTO `sys_logininfor` VALUES (901, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:36:25');
INSERT INTO `sys_logininfor` VALUES (902, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:36:34');
INSERT INTO `sys_logininfor` VALUES (903, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:37:46');
INSERT INTO `sys_logininfor` VALUES (904, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:38:01');
INSERT INTO `sys_logininfor` VALUES (905, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:42:28');
INSERT INTO `sys_logininfor` VALUES (906, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:42:35');
INSERT INTO `sys_logininfor` VALUES (907, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:42:52');
INSERT INTO `sys_logininfor` VALUES (908, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:42:58');
INSERT INTO `sys_logininfor` VALUES (909, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:48:33');
INSERT INTO `sys_logininfor` VALUES (910, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:48:38');
INSERT INTO `sys_logininfor` VALUES (911, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:49:13');
INSERT INTO `sys_logininfor` VALUES (912, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:49:33');
INSERT INTO `sys_logininfor` VALUES (913, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:54:01');
INSERT INTO `sys_logininfor` VALUES (914, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:54:09');
INSERT INTO `sys_logininfor` VALUES (915, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 16:54:24');
INSERT INTO `sys_logininfor` VALUES (916, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 16:54:29');
INSERT INTO `sys_logininfor` VALUES (917, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 17:10:40');
INSERT INTO `sys_logininfor` VALUES (918, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 17:10:46');
INSERT INTO `sys_logininfor` VALUES (919, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 17:11:15');
INSERT INTO `sys_logininfor` VALUES (920, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 17:11:28');
INSERT INTO `sys_logininfor` VALUES (921, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 17:26:29');
INSERT INTO `sys_logininfor` VALUES (922, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 17:26:34');
INSERT INTO `sys_logininfor` VALUES (923, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 17:27:06');
INSERT INTO `sys_logininfor` VALUES (924, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 17:27:11');
INSERT INTO `sys_logininfor` VALUES (925, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 17:30:14');
INSERT INTO `sys_logininfor` VALUES (926, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 17:30:24');
INSERT INTO `sys_logininfor` VALUES (927, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 17:30:41');
INSERT INTO `sys_logininfor` VALUES (928, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 17:30:47');
INSERT INTO `sys_logininfor` VALUES (929, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 18:42:17');
INSERT INTO `sys_logininfor` VALUES (930, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 18:42:21');
INSERT INTO `sys_logininfor` VALUES (931, 'fanshen', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 18:42:29');
INSERT INTO `sys_logininfor` VALUES (932, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-28 20:21:30');
INSERT INTO `sys_logininfor` VALUES (934, 'hwy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2026-05-28 20:24:44');
INSERT INTO `sys_logininfor` VALUES (935, 'hwy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 20:25:04');
INSERT INTO `sys_logininfor` VALUES (936, 'hwy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-28 20:40:12');
INSERT INTO `sys_logininfor` VALUES (937, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 14:53:26');
INSERT INTO `sys_logininfor` VALUES (938, 'hwy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 14:53:40');
INSERT INTO `sys_logininfor` VALUES (939, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-29 14:58:22');
INSERT INTO `sys_logininfor` VALUES (940, 'hwy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 14:58:32');
INSERT INTO `sys_logininfor` VALUES (941, 'repairman', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-29 15:09:39');
INSERT INTO `sys_logininfor` VALUES (942, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 15:09:42');
INSERT INTO `sys_logininfor` VALUES (943, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-29 15:09:46');
INSERT INTO `sys_logininfor` VALUES (944, 'hwy', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 15:09:55');
INSERT INTO `sys_logininfor` VALUES (945, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 18:26:04');
INSERT INTO `sys_logininfor` VALUES (946, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-29 18:26:40');
INSERT INTO `sys_logininfor` VALUES (947, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 18:26:46');
INSERT INTO `sys_logininfor` VALUES (948, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-29 18:27:05');
INSERT INTO `sys_logininfor` VALUES (949, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 18:27:11');
INSERT INTO `sys_logininfor` VALUES (950, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-29 18:33:00');
INSERT INTO `sys_logininfor` VALUES (951, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 18:33:07');
INSERT INTO `sys_logininfor` VALUES (952, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-05-29 18:33:33');
INSERT INTO `sys_logininfor` VALUES (954, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 19:09:52');
INSERT INTO `sys_logininfor` VALUES (955, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 19:10:32');
INSERT INTO `sys_logininfor` VALUES (956, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-05-29 19:11:18');
INSERT INTO `sys_logininfor` VALUES (961, 'X001', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2026-06-13 23:24:53');
INSERT INTO `sys_logininfor` VALUES (962, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-06-13 23:24:59');
INSERT INTO `sys_logininfor` VALUES (963, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-06-13 23:26:41');
INSERT INTO `sys_logininfor` VALUES (964, '张三', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-06-13 23:26:47');
INSERT INTO `sys_logininfor` VALUES (965, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-06-13 23:30:47');
INSERT INTO `sys_logininfor` VALUES (966, 'longaotian', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2026-06-13 23:31:16');
INSERT INTO `sys_logininfor` VALUES (967, 'wangzai', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2026-06-13 23:31:23');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int(1) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(1) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2036 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2026-01-08 16:39:44', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2026-01-08 16:39:44', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2026-01-08 16:39:44', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', '', 0, 0, 'M', '0', '0', '', 'guide', 'admin', '2026-01-08 16:39:44', '', NULL, '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2026-01-08 16:39:44', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2026-01-08 16:39:44', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2026-01-08 16:39:44', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2026-01-08 16:39:44', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2026-01-08 16:39:44', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2026-01-08 16:39:44', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2026-01-08 16:39:44', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2026-01-08 16:39:44', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2026-01-08 16:39:44', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2026-01-08 16:39:44', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2026-01-08 16:39:44', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2026-01-08 16:39:44', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2026-01-08 16:39:44', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2026-01-08 16:39:44', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2026-01-08 16:39:44', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2026-01-08 16:39:44', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2026-01-08 16:39:44', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2026-01-08 16:39:44', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2026-01-08 16:39:44', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2026-01-08 16:39:44', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '工单管理', 0, 9, 'workOrderManagement', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-27 11:15:40', 'admin', '2026-02-05 18:37:18', '');
INSERT INTO `sys_menu` VALUES (2001, '工单管理', 2000, 1, 'order', 'workOrderManagement/index', NULL, '', 1, 0, 'C', '0', '0', '', '#', 'admin', '2026-01-27 11:16:59', 'admin', '2026-01-27 12:30:52', '');
INSERT INTO `sys_menu` VALUES (2002, '工单详情', 2000, 1, 'orderDetail', 'workOrderManagement/components/orderDetail.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-01-27 12:28:54', 'admin', '2026-04-27 11:18:33', '');
INSERT INTO `sys_menu` VALUES (2003, '租赁申请审批', 0, 10, 'leaseApplicationApproval', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-27 14:51:02', 'admin', '2026-02-06 16:38:14', '');
INSERT INTO `sys_menu` VALUES (2004, '租赁申请审批', 2003, 1, 'applicationApproval', 'leaseApplicationApproval/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-27 14:52:47', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '我的房间', 0, 11, 'tenantMyRoom', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-27 16:01:56', 'admin', '2026-02-08 16:59:40', '');
INSERT INTO `sys_menu` VALUES (2006, '我的房间', 2005, 1, 'myRoom', 'tenantMyRoom/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-27 16:03:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2007, '报修服务', 0, 12, 'repairService', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-27 16:15:58', 'admin', '2026-02-08 16:59:55', '');
INSERT INTO `sys_menu` VALUES (2008, '我的报修', 2007, 1, 'myRepair', 'repairService/index.vue', NULL, '', 1, 0, 'C', '0', '0', '', '#', 'admin', '2026-01-27 16:17:14', 'admin', '2026-01-27 16:17:36', '');
INSERT INTO `sys_menu` VALUES (2009, '新建报修', 2007, 2, 'addRepair', 'repairService/components/addRepair.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-01-27 16:27:06', 'admin', '2026-01-27 16:27:17', '');
INSERT INTO `sys_menu` VALUES (2010, '我的账单', 0, 13, 'tenantMyBill', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-27 16:50:08', 'admin', '2026-02-08 17:00:06', '');
INSERT INTO `sys_menu` VALUES (2011, '我的账单', 2010, 1, 'myBill', 'tenantMyBill/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-27 16:51:07', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '租房申请', 0, 14, 'tenantRentApplicatipn', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-27 17:10:08', 'admin', '2026-02-08 17:00:17', '');
INSERT INTO `sys_menu` VALUES (2013, '租房申请', 2012, 1, 'rentApplication', 'tenantRentApplication/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-27 17:10:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '工作台', 0, 5, 'adminConsole', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-28 15:26:27', 'admin', '2026-01-28 15:57:34', '');
INSERT INTO `sys_menu` VALUES (2015, '工作台', 2014, 1, 'console', 'adminConsole/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-28 15:28:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '租户管理', 0, 6, 'adminTenant', NULL, NULL, '', 1, 0, 'M', '0', '0', '', '#', 'admin', '2026-01-28 15:42:16', 'admin', '2026-01-28 15:57:47', '');
INSERT INTO `sys_menu` VALUES (2017, '租户管理', 2016, 1, 'tenantmanage', 'adminTenant/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-28 15:43:02', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '园区管理', 0, 7, 'parkmanage', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, '#', 'admin', '2026-01-28 15:58:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '楼宇管理', 2018, 1, 'buildingmanage', 'parkManagement/adminBuilding/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-28 16:00:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '房间管理', 2018, 2, 'roomManage', 'parkManagement/adminRoom/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-01-29 17:21:12', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '房间新增（编辑）', 2018, 3, 'roomDetail', 'parkManagement/roomDetail/index.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-01-30 16:02:35', 'admin', '2026-02-02 18:09:37', '');
INSERT INTO `sys_menu` VALUES (2022, '资产管理', 0, 8, 'assetManagement', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, '#', 'admin', '2026-02-04 14:28:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '合同管理', 2022, 1, 'contract', 'assetManagement/adminContract/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-02-04 14:30:06', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '账单管理', 2022, 2, 'bill', 'assetManagement/adminBill/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-02-04 14:31:04', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '合同编辑', 2022, 3, 'contractedit', 'assetManagement/contractEdit/index.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-02-04 15:48:15', 'admin', '2026-03-02 16:46:09', '');
INSERT INTO `sys_menu` VALUES (2026, '房间详情', 2012, 2, 'roomDetailReadOnly', 'tenantRentApplication/roomDetailReadOnly/index.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-02-08 16:29:47', 'admin', '2026-02-08 16:33:16', '');
INSERT INTO `sys_menu` VALUES (2027, '我的工单', 0, 15, 'repairMyOrder', NULL, NULL, '', 1, 0, 'M', '0', '0', NULL, '#', 'admin', '2026-02-08 17:04:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '我的工单', 2027, 1, 'myOrder', 'repairMyOrder/myOrder/index.vue', NULL, '', 1, 0, 'C', '0', '0', NULL, '#', 'admin', '2026-02-08 17:06:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '工单详情', 2027, 2, 'myorderdetail', 'repairMyOrder/OrderDetail/index', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-02-08 17:07:38', 'admin', '2026-02-08 17:13:50', '');
INSERT INTO `sys_menu` VALUES (2030, '合同详情', 2022, 4, 'contractdetail', 'assetManagement/contractDetail/index.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-03-07 17:00:21', 'admin', '2026-03-07 20:28:50', '');
INSERT INTO `sys_menu` VALUES (2031, '退租编辑', 2022, 5, 'lease', 'assetManagement/leaseEdit/index.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-03-10 00:01:21', 'admin', '2026-03-10 18:30:02', '');
INSERT INTO `sys_menu` VALUES (2032, '保修详情', 2007, 3, 'repairDetail', 'repairService/components/orderDetail.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-05-10 16:55:37', 'admin', '2026-05-11 20:51:11', '');
INSERT INTO `sys_menu` VALUES (2034, '房间详情', 2005, 2, 'tenantRoomDetail', 'tenantMyRoom/components/roomDetail.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-05-16 17:41:10', 'admin', '2026-05-22 17:13:53', '');
INSERT INTO `sys_menu` VALUES (2035, '合同详情', 2005, 3, 'tenantContract', 'tenantMyRoom/components/roomContract/index.vue', NULL, '', 1, 0, 'C', '1', '0', '', '#', 'admin', '2026-05-16 17:41:56', 'admin', '2026-05-22 17:13:58', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(4) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2026-01-08 16:39:44', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2026-01-08 16:39:44', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(2) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(1) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(1) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 262 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"工单管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"workOrderManagement\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 11:15:41', 113);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"工单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"order\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 11:16:59', 119);
INSERT INTO `sys_oper_log` VALUES (102, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/components/orderDeatil.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderDetail\",\"status\":\"0\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 12:28:54', 115);
INSERT INTO `sys_oper_log` VALUES (103, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/components/orderDeatil.vue\",\"createTime\":\"2026-01-27 12:28:54\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 12:29:34', 95);
INSERT INTO `sys_oper_log` VALUES (104, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 11:15:40\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"工单管理\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"workOrderManagement\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 12:30:21', 107);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/index\",\"createTime\":\"2026-01-27 11:16:59\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"工单管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"order\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 12:30:52', 97);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/components/orderDetail.vue\",\"createTime\":\"2026-01-27 12:28:54\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 12:31:24', 93);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/components/orderDetail.vue\",\"createTime\":\"2026-01-27 12:28:54\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 12:33:22', 97);
INSERT INTO `sys_oper_log` VALUES (108, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"价格单位\",\"dictType\":\"price_unit\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 13:07:42', 382);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租赁申请审批\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"leaseApplicationAproval\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 14:51:02', 82);
INSERT INTO `sys_oper_log` VALUES (110, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 14:51:02\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"租赁申请审批\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"leaseApplicationApproval\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 14:51:33', 83);
INSERT INTO `sys_oper_log` VALUES (111, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"leaseApplicationApproval/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租赁申请审批\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2003,\"path\":\"applicationApproval\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 14:52:47', 105);
INSERT INTO `sys_oper_log` VALUES (112, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的房间\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"tenantMyRoom\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:01:56', 92);
INSERT INTO `sys_oper_log` VALUES (113, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantMyRoom/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的房间\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2005,\"path\":\"myRoom\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:03:02', 85);
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"报修服务\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"repairService\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:15:58', 84);
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:15:58\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"报修服务\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"repairService\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:16:09', 88);
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/indx.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的报修\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2007,\"path\":\"myRepair\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:17:14', 95);
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/index.vue\",\"createTime\":\"2026-01-27 16:17:14\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2008,\"menuName\":\"我的报修\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2007,\"path\":\"myRepair\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:17:36', 75);
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/components/addRepair.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新建报修\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2007,\"path\":\"addRepair\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:27:06', 73);
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/components/addRepair.vue\",\"createTime\":\"2026-01-27 16:27:06\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2009,\"menuName\":\"新建报修\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2007,\"path\":\"addRepair\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:27:17', 82);
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的账单\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"tenantMyBill\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:50:09', 71);
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantMyBill/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的账单\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2010,\"path\":\"myBill\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 16:51:07', 75);
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租房申请\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"tenantRentApplicatipn\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 17:10:08', 72);
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantRentApplication/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租房申请\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2012,\"path\":\"rentApplication\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 17:10:46', 69);
INSERT INTO `sys_oper_log` VALUES (124, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-08 16:39:44\",\"cssClass\":\"\",\"default\":false,\"dictCode\":3,\"dictLabel\":\"未知\",\"dictSort\":3,\"dictType\":\"sys_user_sex\",\"dictValue\":\"2f\",\"isDefault\":\"N\",\"listClass\":\"\",\"params\":{},\"remark\":\"性别未知\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:15:39', 164);
INSERT INTO `sys_oper_log` VALUES (125, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-08 16:39:44\",\"cssClass\":\"\",\"default\":false,\"dictCode\":3,\"dictLabel\":\"未知\",\"dictSort\":3,\"dictType\":\"sys_user_sex\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"\",\"params\":{},\"remark\":\"性别未知\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:15:52', 142);
INSERT INTO `sys_oper_log` VALUES (126, '字典类型', 2, 'com.ruoyi.web.controller.system.SysDictTypeController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 13:07:42\",\"dictId\":100,\"dictName\":\"租金类型\",\"dictType\":\"rent_type\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:23:57', 689);
INSERT INTO `sys_oper_log` VALUES (127, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/m²/天\",\"dictSort\":1,\"dictType\":\"rent_type\",\"dictValue\":\"0\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:26:25', 267);
INSERT INTO `sys_oper_log` VALUES (128, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/m²/月\",\"dictSort\":0,\"dictType\":\"rent_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:29:10', 293);
INSERT INTO `sys_oper_log` VALUES (129, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:26:25\",\"default\":false,\"dictCode\":100,\"dictLabel\":\"元/m²/天\",\"dictSort\":1,\"dictType\":\"rent_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:29:17', 229);
INSERT INTO `sys_oper_log` VALUES (130, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:29:10\",\"default\":false,\"dictCode\":101,\"dictLabel\":\"元/m²/月\",\"dictSort\":2,\"dictType\":\"rent_type\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:29:21', 188);
INSERT INTO `sys_oper_log` VALUES (131, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/天\",\"dictSort\":3,\"dictType\":\"rent_type\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:29:36', 230);
INSERT INTO `sys_oper_log` VALUES (132, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/月\",\"dictSort\":4,\"dictType\":\"rent_type\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-27 20:29:54', 238);
INSERT INTO `sys_oper_log` VALUES (133, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2026-01-08 16:39:44\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:21:32', 112);
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"工作台\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"adminConsole\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:26:27', 99);
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-28 15:26:27\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"工作台\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"adminConsole\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:26:46', 84);
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"adminConsole/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"工作台\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2014,\"path\":\"console\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:28:08', 84);
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 14:51:02\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"租赁申请审批\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"leaseApplicationApproval\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:28:24', 81);
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租户管理\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"adminTenant\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:42:16', 79);
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"adminTenant/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"租户管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2016,\"path\":\"tenantmanage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:43:02', 93);
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-28 15:26:27\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2014,\"menuName\":\"工作台\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"adminConsole\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:57:34', 87);
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-28 15:42:16\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2016,\"menuName\":\"租户管理\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"adminTenant\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:57:48', 78);
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:01:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"我的房间\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"tenantMyRoom\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:57:59', 82);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"园区管理\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"parkmanage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:58:53', 77);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:01:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"我的房间\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"tenantMyRoom\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:59:01', 89);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:15:58\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"报修服务\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"repairService\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 15:59:09', 84);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkManagement/adminBuilding/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"楼宇管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2018,\"path\":\"buildingmanage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-28 16:00:18', 105);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkManagement/adminRoom/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"房间管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2018,\"path\":\"roomManage\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-29 17:21:12', 127);
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkManagement/roomEdit/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"新建房间\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"addRoom\",\"status\":\"0\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 16:02:35', 317);
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkManagement/roomDetail/index.vue\",\"createTime\":\"2026-01-30 16:02:35\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"房间新增（编辑）\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"addRoom\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 16:11:10', 118);
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkManagement/roomDetail/index.vue\",\"createTime\":\"2026-01-30 16:02:35\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"房间新增（编辑）\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"roomDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 16:13:44', 84);
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkManagement/roomDetail/index.vue\",\"createTime\":\"2026-01-30 16:02:35\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"房间新增（编辑）\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"roomDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-01-30 16:21:40', 79);
INSERT INTO `sys_oper_log` VALUES (152, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"物业费单位\",\"dictType\":\"money_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:34:22', 139);
INSERT INTO `sys_oper_log` VALUES (153, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/m²/天\",\"dictSort\":1,\"dictType\":\"money_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:35:19', 89);
INSERT INTO `sys_oper_log` VALUES (154, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/m²/月\",\"dictSort\":2,\"dictType\":\"money_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:35:45', 81);
INSERT INTO `sys_oper_log` VALUES (155, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/天\",\"dictSort\":3,\"dictType\":\"money_type\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:36:03', 105);
INSERT INTO `sys_oper_log` VALUES (156, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"元/月\",\"dictSort\":4,\"dictType\":\"money_type\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:36:16', 138);
INSERT INTO `sys_oper_log` VALUES (157, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"房型\",\"dictType\":\"room_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:37:48', 99);
INSERT INTO `sys_oper_log` VALUES (158, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"loft\",\"dictSort\":1,\"dictType\":\"room_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:38:36', 82);
INSERT INTO `sys_oper_log` VALUES (159, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"商业配套\",\"dictSort\":2,\"dictType\":\"room_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:38:57', 114);
INSERT INTO `sys_oper_log` VALUES (160, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"办公场所\",\"dictSort\":3,\"dictType\":\"room_type\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:39:13', 96);
INSERT INTO `sys_oper_log` VALUES (161, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"其他\",\"dictSort\":4,\"dictType\":\"room_type\",\"dictValue\":\"4\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:39:27', 104);
INSERT INTO `sys_oper_log` VALUES (162, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"装修类型\",\"dictType\":\"renovation_type\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:41:02', 76);
INSERT INTO `sys_oper_log` VALUES (163, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"简装\",\"dictSort\":1,\"dictType\":\"renovation_type\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:42:04', 96);
INSERT INTO `sys_oper_log` VALUES (164, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"精装\",\"dictSort\":2,\"dictType\":\"renovation_type\",\"dictValue\":\"2\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:42:20', 98);
INSERT INTO `sys_oper_log` VALUES (165, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"毛坯房\",\"dictSort\":3,\"dictType\":\"renovation_type\",\"dictValue\":\"3\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:42:31', 92);
INSERT INTO `sys_oper_log` VALUES (166, '字典类型', 1, 'com.ruoyi.web.controller.system.SysDictTypeController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/type', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"dictName\":\"租赁状态\",\"dictType\":\"tenant_status\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:43:43', 129);
INSERT INTO `sys_oper_log` VALUES (167, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"未租\",\"dictSort\":1,\"dictType\":\"tenant_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:44:15', 105);
INSERT INTO `sys_oper_log` VALUES (168, '字典数据', 1, 'com.ruoyi.web.controller.system.SysDictDataController.add()', 'POST', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"default\":false,\"dictLabel\":\"在租\",\"dictSort\":1,\"dictType\":\"tenant_status\",\"dictValue\":\"1\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:44:28', 84);
INSERT INTO `sys_oper_log` VALUES (169, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:44:15\",\"default\":false,\"dictCode\":115,\"dictLabel\":\"未租\",\"dictSort\":1,\"dictType\":\"tenant_status\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-01 10:44:35', 107);
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"parkManagement/roomDetail/index.vue\",\"createTime\":\"2026-01-30 16:02:35\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2021,\"menuName\":\"房间新增（编辑）\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2018,\"path\":\"roomDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 18:09:37', 109);
INSERT INTO `sys_oper_log` VALUES (171, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:26:25\",\"default\":false,\"dictCode\":100,\"dictLabel\":\"元/m²/天\",\"dictSort\":1,\"dictType\":\"rent_type\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:00:34', 307);
INSERT INTO `sys_oper_log` VALUES (172, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:29:10\",\"default\":false,\"dictCode\":101,\"dictLabel\":\"元/m²/月\",\"dictSort\":2,\"dictType\":\"rent_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:00:48', 121);
INSERT INTO `sys_oper_log` VALUES (173, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:29:36\",\"default\":false,\"dictCode\":102,\"dictLabel\":\"元/天\",\"dictSort\":3,\"dictType\":\"rent_type\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:00:53', 277);
INSERT INTO `sys_oper_log` VALUES (174, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-01-27 20:29:53\",\"default\":false,\"dictCode\":103,\"dictLabel\":\"元/月\",\"dictSort\":4,\"dictType\":\"rent_type\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:01:00', 1321);
INSERT INTO `sys_oper_log` VALUES (175, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:35:19\",\"default\":false,\"dictCode\":104,\"dictLabel\":\"元/m²/天\",\"dictSort\":1,\"dictType\":\"money_type\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:01:15', 101);
INSERT INTO `sys_oper_log` VALUES (176, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:35:45\",\"default\":false,\"dictCode\":105,\"dictLabel\":\"元/m²/月\",\"dictSort\":2,\"dictType\":\"money_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:01:28', 374);
INSERT INTO `sys_oper_log` VALUES (177, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:36:03\",\"default\":false,\"dictCode\":106,\"dictLabel\":\"元/天\",\"dictSort\":3,\"dictType\":\"money_type\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:01:32', 120);
INSERT INTO `sys_oper_log` VALUES (178, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:36:16\",\"default\":false,\"dictCode\":107,\"dictLabel\":\"元/月\",\"dictSort\":4,\"dictType\":\"money_type\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:01:36', 132);
INSERT INTO `sys_oper_log` VALUES (179, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:38:36\",\"default\":false,\"dictCode\":108,\"dictLabel\":\"loft\",\"dictSort\":1,\"dictType\":\"room_type\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:01:53', 101);
INSERT INTO `sys_oper_log` VALUES (180, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:38:57\",\"default\":false,\"dictCode\":109,\"dictLabel\":\"商业配套\",\"dictSort\":2,\"dictType\":\"room_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:02:00', 109);
INSERT INTO `sys_oper_log` VALUES (181, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:39:13\",\"default\":false,\"dictCode\":110,\"dictLabel\":\"办公场所\",\"dictSort\":3,\"dictType\":\"room_type\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:02:05', 143);
INSERT INTO `sys_oper_log` VALUES (182, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:39:27\",\"default\":false,\"dictCode\":111,\"dictLabel\":\"其他\",\"dictSort\":4,\"dictType\":\"room_type\",\"dictValue\":\"3\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:02:10', 151);
INSERT INTO `sys_oper_log` VALUES (183, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:42:04\",\"default\":false,\"dictCode\":112,\"dictLabel\":\"简装\",\"dictSort\":1,\"dictType\":\"renovation_type\",\"dictValue\":\"0\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:02:20', 326);
INSERT INTO `sys_oper_log` VALUES (184, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:42:19\",\"default\":false,\"dictCode\":113,\"dictLabel\":\"精装\",\"dictSort\":2,\"dictType\":\"renovation_type\",\"dictValue\":\"1\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:02:24', 93);
INSERT INTO `sys_oper_log` VALUES (185, '字典数据', 2, 'com.ruoyi.web.controller.system.SysDictDataController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/dict/data', '127.0.0.1', '内网IP', '{\"createBy\":\"admin\",\"createTime\":\"2026-02-01 10:42:31\",\"default\":false,\"dictCode\":114,\"dictLabel\":\"毛坯房\",\"dictSort\":3,\"dictType\":\"renovation_type\",\"dictValue\":\"2\",\"isDefault\":\"N\",\"listClass\":\"default\",\"params\":{},\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-02 19:02:30', 386);
INSERT INTO `sys_oper_log` VALUES (186, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2014,2015,2016,2017,2018,2019,2020,2021],\"params\":{},\"remark\":\"管理员\",\"roleId\":5,\"roleKey\":\"administrator\",\"roleName\":\"管理员\",\"roleSort\":5,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 14:26:14', 327);
INSERT INTO `sys_oper_log` VALUES (187, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"资产管理\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"assetManagement\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 14:28:35', 80);
INSERT INTO `sys_oper_log` VALUES (188, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:01:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"我的房间\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"tenantMyRoom\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 14:28:44', 78);
INSERT INTO `sys_oper_log` VALUES (189, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:15:58\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"报修服务\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"repairService\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 14:28:51', 75);
INSERT INTO `sys_oper_log` VALUES (190, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:50:08\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"我的账单\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"tenantMyBill\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 14:28:57', 71);
INSERT INTO `sys_oper_log` VALUES (191, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/adminContract/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"合同管理\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2022,\"path\":\"contract\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 14:30:06', 85);
INSERT INTO `sys_oper_log` VALUES (192, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/adminBill/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"账单管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2022,\"path\":\"bill\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 14:31:04', 75);
INSERT INTO `sys_oper_log` VALUES (193, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/contractEdit/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"合同编辑\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2022,\"path\":\"contractedit\",\"status\":\"0\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 15:48:16', 113);
INSERT INTO `sys_oper_log` VALUES (194, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/contractEdit/index.vue\",\"createTime\":\"2026-02-04 15:48:15\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"合同编辑\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2022,\"path\":\"contractedit\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-04 15:55:54', 90);
INSERT INTO `sys_oper_log` VALUES (195, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"工单管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"workOrderManagement\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"新增菜单\'工单管理\'失败，菜单名称已存在\",\"code\":500}', 0, NULL, '2026-02-05 18:36:47', 38);
INSERT INTO `sys_oper_log` VALUES (196, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 11:15:40\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"工单管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":0,\"path\":\"workOrderManagement\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-05 18:37:18', 83);
INSERT INTO `sys_oper_log` VALUES (197, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2005,2006,2007,2008,2009,2010,2011,2012,2013],\"params\":{},\"remark\":\"租户\",\"roleId\":3,\"roleKey\":\"tenant\",\"roleName\":\"租户\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:35:50', 316);
INSERT INTO `sys_oper_log` VALUES (198, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2000,2001,2002],\"params\":{},\"remark\":\"管理员\",\"roleId\":5,\"roleKey\":\"administrator\",\"roleName\":\"管理员\",\"roleSort\":5,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:37:26', 280);
INSERT INTO `sys_oper_log` VALUES (199, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2003,2004,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2000,2001,2002],\"params\":{},\"remark\":\"管理员\",\"roleId\":5,\"roleKey\":\"administrator\",\"roleName\":\"管理员\",\"roleSort\":5,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:37:56', 286);
INSERT INTO `sys_oper_log` VALUES (200, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 14:51:02\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2003,\"menuName\":\"租赁申请审批\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"leaseApplicationApproval\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:38:14', 108);
INSERT INTO `sys_oper_log` VALUES (201, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 17:10:08\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"租房申请\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"tenantRentApplicatipn\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:38:25', 84);
INSERT INTO `sys_oper_log` VALUES (202, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"长沙分公司\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"status\":\"0\"},\"deptId\":102,\"email\":\"fanxiao@qq.com\",\"idNum\":\"445322197110090039\",\"loginIp\":\"\",\"nickName\":\"凡小\",\"params\":{},\"phonenumber\":\"15222274591\",\"postIds\":[2],\"remark\":\"租户\",\"roleIds\":[5],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":3,\"userName\":\"fanxiao\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:39:13', 398);
INSERT INTO `sys_oper_log` VALUES (203, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"长沙分公司\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"status\":\"0\"},\"deptId\":102,\"email\":\"fanxiao@qq.com\",\"idNum\":\"445322197110090039\",\"loginIp\":\"\",\"nickName\":\"凡小\",\"params\":{},\"phonenumber\":\"15222274591\",\"postIds\":[2],\"remark\":\"租户\",\"roleIds\":[],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":5,\"roleKey\":\"administrator\",\"roleName\":\"管理员\",\"roleSort\":5,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":3,\"userName\":\"fanxiao\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:40:09', 319);
INSERT INTO `sys_oper_log` VALUES (204, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"zhangsan\",\"params\":{},\"postIds\":[],\"roleIds\":[5],\"status\":\"0\",\"userId\":117,\"userName\":\"张三\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:40:51', 290);
INSERT INTO `sys_oper_log` VALUES (205, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-02-06 16:40:51\",\"delFlag\":\"0\",\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"张三\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[5],\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":5,\"roleKey\":\"administrator\",\"roleName\":\"管理员\",\"roleSort\":5,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":117,\"userName\":\"张三\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-06 16:41:08', 295);
INSERT INTO `sys_oper_log` VALUES (206, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantRentApplication/roomDetailReadOnly/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"房间详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2012,\"path\":\"roomDetailReadOnly\",\"status\":\"0\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:29:47', 131);
INSERT INTO `sys_oper_log` VALUES (207, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantRentApplication/roomDetailReadOnly/index.vue\",\"createTime\":\"2026-02-08 16:29:47\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"房间详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2012,\"path\":\"roomDetailReadOnly\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:29:55', 81);
INSERT INTO `sys_oper_log` VALUES (208, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantRentApplication/roomDetailReadOnly/index.vue\",\"createTime\":\"2026-02-08 16:29:47\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2026,\"menuName\":\"房间详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2012,\"path\":\"roomDetailReadOnly\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:33:16', 89);
INSERT INTO `sys_oper_log` VALUES (209, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2005,2006,2007,2008,2009,2010,2011,2012,2013,2026],\"params\":{},\"remark\":\"租户\",\"roleId\":3,\"roleKey\":\"tenant\",\"roleName\":\"租户\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:34:08', 325);
INSERT INTO `sys_oper_log` VALUES (210, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:01:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"我的房间\",\"menuType\":\"M\",\"orderNum\":10,\"params\":{},\"parentId\":0,\"path\":\"tenantMyRoom\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:58:57', 75);
INSERT INTO `sys_oper_log` VALUES (211, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:15:58\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"报修服务\",\"menuType\":\"M\",\"orderNum\":11,\"params\":{},\"parentId\":0,\"path\":\"repairService\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:59:09', 80);
INSERT INTO `sys_oper_log` VALUES (212, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:50:08\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"我的账单\",\"menuType\":\"M\",\"orderNum\":12,\"params\":{},\"parentId\":0,\"path\":\"tenantMyBill\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:59:24', 81);
INSERT INTO `sys_oper_log` VALUES (213, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:01:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2005,\"menuName\":\"我的房间\",\"menuType\":\"M\",\"orderNum\":11,\"params\":{},\"parentId\":0,\"path\":\"tenantMyRoom\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:59:40', 76);
INSERT INTO `sys_oper_log` VALUES (214, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:15:58\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2007,\"menuName\":\"报修服务\",\"menuType\":\"M\",\"orderNum\":12,\"params\":{},\"parentId\":0,\"path\":\"repairService\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 16:59:55', 78);
INSERT INTO `sys_oper_log` VALUES (215, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 16:50:08\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2010,\"menuName\":\"我的账单\",\"menuType\":\"M\",\"orderNum\":13,\"params\":{},\"parentId\":0,\"path\":\"tenantMyBill\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 17:00:06', 72);
INSERT INTO `sys_oper_log` VALUES (216, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2026-01-27 17:10:08\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"租房申请\",\"menuType\":\"M\",\"orderNum\":14,\"params\":{},\"parentId\":0,\"path\":\"tenantRentApplicatipn\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 17:00:17', 92);
INSERT INTO `sys_oper_log` VALUES (217, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的工单\",\"menuType\":\"M\",\"orderNum\":15,\"params\":{},\"parentId\":0,\"path\":\"repairMyOrder\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 17:04:55', 99);
INSERT INTO `sys_oper_log` VALUES (218, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairMyOrder/myOrder/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"我的工单\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2027,\"path\":\"myOrder\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 17:06:46', 78);
INSERT INTO `sys_oper_log` VALUES (219, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairMyOrder/OrderDetail/index\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2027,\"path\":\"myorderdetail\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 17:07:38', 85);
INSERT INTO `sys_oper_log` VALUES (220, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2027,2028,2029],\"params\":{},\"remark\":\"维修工\",\"roleId\":4,\"roleKey\":\"repairman\",\"roleName\":\"维修工\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 17:08:23', 262);
INSERT INTO `sys_oper_log` VALUES (221, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairMyOrder/OrderDetail/index\",\"createTime\":\"2026-02-08 17:07:38\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2029,\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2027,\"path\":\"myorderdetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-08 17:13:50', 86);
INSERT INTO `sys_oper_log` VALUES (222, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/components/orderDetail.vue\",\"createTime\":\"2026-01-27 12:28:54\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-10 15:27:49', 109);
INSERT INTO `sys_oper_log` VALUES (223, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2027,2028,2029],\"params\":{},\"remark\":\"维修工\",\"roleId\":4,\"roleKey\":\"repairman\",\"roleName\":\"维修工\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-11 19:26:24', 295);
INSERT INTO `sys_oper_log` VALUES (224, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"lisi\",\"params\":{},\"postIds\":[],\"roleIds\":[4],\"status\":\"0\",\"userId\":119,\"userName\":\"lisi\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-11 19:27:04', 284);
INSERT INTO `sys_oper_log` VALUES (225, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"ww\",\"params\":{},\"postIds\":[],\"roleIds\":[5],\"status\":\"0\",\"userId\":121,\"userName\":\"ww\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-02-13 15:30:13', 319);
INSERT INTO `sys_oper_log` VALUES (226, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/contractEdit/index.vue\",\"createTime\":\"2026-02-04 15:48:15\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2025,\"menuName\":\"合同编辑\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2022,\"path\":\"contractedit\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-02 16:46:09', 105);
INSERT INTO `sys_oper_log` VALUES (227, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2022,\"path\":\"contractdetail\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 17:00:22', 89);
INSERT INTO `sys_oper_log` VALUES (228, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/contracDetail/index.vue\",\"createTime\":\"2026-03-07 17:00:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2022,\"path\":\"contractdetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 17:00:43', 81);
INSERT INTO `sys_oper_log` VALUES (229, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/contractDetail/index.vue\",\"createTime\":\"2026-03-07 17:00:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2022,\"path\":\"contractdetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 17:02:29', 79);
INSERT INTO `sys_oper_log` VALUES (230, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/contractDetail/index.vue\",\"createTime\":\"2026-03-07 17:00:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2022,\"path\":\"contractdetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 20:28:50', 136);
INSERT INTO `sys_oper_log` VALUES (231, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2030,2000,2001,2002,2003,2004],\"params\":{},\"remark\":\"管理员\",\"roleId\":5,\"roleKey\":\"administrator\",\"roleName\":\"管理员\",\"roleSort\":5,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-07 20:30:43', 320);
INSERT INTO `sys_oper_log` VALUES (232, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/leaseEdit/index.vue\",\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"退租编辑\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2022,\"path\":\"lease\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-10 00:01:21', 107);
INSERT INTO `sys_oper_log` VALUES (233, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"assetManagement/leaseEdit/index.vue\",\"createTime\":\"2026-03-10 00:01:21\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2031,\"menuName\":\"退租编辑\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2022,\"path\":\"lease\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-10 18:30:02', 194);
INSERT INTO `sys_oper_log` VALUES (234, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2030,2031,2000,2001,2002,2003,2004],\"params\":{},\"remark\":\"管理员\",\"roleId\":5,\"roleKey\":\"administrator\",\"roleName\":\"管理员\",\"roleSort\":5,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-10 18:30:13', 349);
INSERT INTO `sys_oper_log` VALUES (235, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":113}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:46:51', 148);
INSERT INTO `sys_oper_log` VALUES (236, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"nickName\":\"wangwu\",\"params\":{},\"postIds\":[],\"roleIds\":[5],\"status\":\"0\",\"userId\":130,\"userName\":\"wangwu\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-03-22 14:49:21', 323);
INSERT INTO `sys_oper_log` VALUES (237, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"workOrderManagement/components/orderDetail.vue\",\"createTime\":\"2026-01-27 12:28:54\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2002,\"menuName\":\"工单详情\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2000,\"path\":\"orderDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-04-27 11:18:33', 99);
INSERT INTO `sys_oper_log` VALUES (238, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-01 19:06:22', 157);
INSERT INTO `sys_oper_log` VALUES (239, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"长沙分公司\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"status\":\"0\"},\"deptId\":102,\"email\":\"fanxiao@qq.com\",\"idNum\":\"445322197110090039\",\"loginDate\":\"2026-05-01 19:06:29\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"凡小\",\"params\":{},\"phonenumber\":\"15222274591\",\"postIds\":[2],\"remark\":\"租户\",\"roleIds\":[3],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":3,\"userName\":\"fanxiao\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-01 19:06:42', 471);
INSERT INTO `sys_oper_log` VALUES (240, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2026-02-11 19:27:04\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2026-04-27 11:18:48\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"lisi\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[3],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":4,\"roleKey\":\"repairman\",\"roleName\":\"维修工\",\"roleSort\":4,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":119,\"userName\":\"lisi\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-01 19:10:57', 344);
INSERT INTO `sys_oper_log` VALUES (241, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":119}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-01 19:11:02', 152);
INSERT INTO `sys_oper_log` VALUES (242, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"保修详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2007,\"path\":\"repairDetail\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-10 16:55:38', 107);
INSERT INTO `sys_oper_log` VALUES (243, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/components/repairDetail.vue.vue\",\"createTime\":\"2026-05-10 16:55:37\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"保修详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2007,\"path\":\"repairDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-10 16:56:21', 115);
INSERT INTO `sys_oper_log` VALUES (244, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/components/orderDetail.vue.vue\",\"createTime\":\"2026-05-10 16:55:37\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"保修详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2007,\"path\":\"repairDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-10 16:57:54', 95);
INSERT INTO `sys_oper_log` VALUES (245, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/components/orderDetail.vue\",\"createTime\":\"2026-05-10 16:55:37\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"保修详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2007,\"path\":\"repairDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-10 16:58:47', 105);
INSERT INTO `sys_oper_log` VALUES (246, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2005,2006,2007,2008,2009,2032,2010,2011,2012,2013,2026],\"params\":{},\"remark\":\"租户\",\"roleId\":3,\"roleKey\":\"tenant\",\"roleName\":\"租户\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-10 17:07:12', 363);
INSERT INTO `sys_oper_log` VALUES (247, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"repairService/components/orderDetail.vue\",\"createTime\":\"2026-05-10 16:55:37\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2032,\"menuName\":\"保修详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2007,\"path\":\"repairDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-11 20:51:11', 137);
INSERT INTO `sys_oper_log` VALUES (248, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'wangzai', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"admin\":false,\"email\":\"2215343411@qq.com\",\"nickName\":\"旺仔\",\"params\":{},\"phonenumber\":\"15859032796\",\"sex\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-12 23:43:03', 307);
INSERT INTO `sys_oper_log` VALUES (249, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"房间详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2006,\"path\":\"tenantRoomDetail\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 17:40:41', 126);
INSERT INTO `sys_oper_log` VALUES (250, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/2033', '127.0.0.1', '内网IP', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 17:40:49', 119);
INSERT INTO `sys_oper_log` VALUES (251, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"房间详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"tenantRoomDetail\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 17:41:10', 85);
INSERT INTO `sys_oper_log` VALUES (252, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2005,\"path\":\"tenantContract\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 17:41:56', 82);
INSERT INTO `sys_oper_log` VALUES (253, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantMyRoom/components/roomDetail.vue\",\"createTime\":\"2026-05-16 17:41:10\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2034,\"menuName\":\"房间详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"tenantRoomDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 17:45:26', 100);
INSERT INTO `sys_oper_log` VALUES (254, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantMyRoom/components/roomContract.vue\",\"createTime\":\"2026-05-16 17:41:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2035,\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2005,\"path\":\"tenantContract\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 17:46:04', 87);
INSERT INTO `sys_oper_log` VALUES (255, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantMyRoom/components/roomContract/index.vue\",\"createTime\":\"2026-05-16 17:41:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2035,\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2005,\"path\":\"tenantContract\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 18:03:05', 84);
INSERT INTO `sys_oper_log` VALUES (256, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2005,2006,2034,2035,2007,2008,2009,2032,2010,2011,2012,2013,2026],\"params\":{},\"remark\":\"租户\",\"roleId\":3,\"roleKey\":\"tenant\",\"roleName\":\"租户\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-16 18:36:14', 302);
INSERT INTO `sys_oper_log` VALUES (257, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"address\":\"新疆维吾尔自治区吐鲁番市高昌区红柳河街道\",\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"delFlag\":\"0\",\"email\":\"37d0@0o10l.cn\",\"idNum\":\"514490200804065675\",\"loginIp\":\"\",\"nickName\":\"赖清妍\",\"params\":{},\"phonenumber\":\"14987454613\",\"postIds\":[],\"roleIds\":[3],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":139,\"userName\":\"lqy\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 17:29:34', 400);
INSERT INTO `sys_oper_log` VALUES (258, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"address\":\"辽宁省营口市老边区柳树镇\",\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"delFlag\":\"0\",\"email\":\"d27c@e051e.net\",\"idNum\":\"187742199809228251\",\"loginIp\":\"\",\"nickName\":\"陆淑君\",\"params\":{},\"phonenumber\":\"17585343052\",\"postIds\":[],\"roleIds\":[3],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":142,\"userName\":\"lsj\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-17 20:52:23', 380);
INSERT INTO `sys_oper_log` VALUES (259, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantMyRoom/components/roomDetail.vue\",\"createTime\":\"2026-05-16 17:41:10\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2034,\"menuName\":\"房间详情\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2005,\"path\":\"tenantRoomDetail\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 17:13:53', 85);
INSERT INTO `sys_oper_log` VALUES (260, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"tenantMyRoom/components/roomContract/index.vue\",\"createTime\":\"2026-05-16 17:41:56\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2035,\"menuName\":\"合同详情\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2005,\"path\":\"tenantContract\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-22 17:13:58', 71);
INSERT INTO `sys_oper_log` VALUES (261, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.resetPwd()', 'PUT', 1, 'admin', '研发部门', '/system/user/resetPwd', '127.0.0.1', '内网IP', '{\"admin\":false,\"params\":{},\"updateBy\":\"admin\",\"userId\":3}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2026-05-28 16:09:31', 150);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(4) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2026-01-08 16:39:44', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2026-01-08 16:39:44', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(4) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2026-01-08 16:39:44', '', NULL, '普通角色');
INSERT INTO `sys_role` VALUES (3, '租户', 'tenant', 3, '2', 1, 1, '0', '0', 'admin', NULL, 'admin', '2026-05-16 18:36:14', '租户');
INSERT INTO `sys_role` VALUES (4, '维修工', 'repairman', 4, '2', 1, 1, '0', '0', 'admin', NULL, 'admin', '2026-02-11 19:26:24', '维修工');
INSERT INTO `sys_role` VALUES (5, '管理员', 'administrator', 5, '1', 1, 1, '0', '0', 'admin', NULL, 'admin', '2026-03-10 18:30:13', '管理员');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (3, 2005);
INSERT INTO `sys_role_menu` VALUES (3, 2006);
INSERT INTO `sys_role_menu` VALUES (3, 2007);
INSERT INTO `sys_role_menu` VALUES (3, 2008);
INSERT INTO `sys_role_menu` VALUES (3, 2009);
INSERT INTO `sys_role_menu` VALUES (3, 2010);
INSERT INTO `sys_role_menu` VALUES (3, 2011);
INSERT INTO `sys_role_menu` VALUES (3, 2012);
INSERT INTO `sys_role_menu` VALUES (3, 2013);
INSERT INTO `sys_role_menu` VALUES (3, 2026);
INSERT INTO `sys_role_menu` VALUES (3, 2032);
INSERT INTO `sys_role_menu` VALUES (3, 2034);
INSERT INTO `sys_role_menu` VALUES (3, 2035);
INSERT INTO `sys_role_menu` VALUES (4, 2027);
INSERT INTO `sys_role_menu` VALUES (4, 2028);
INSERT INTO `sys_role_menu` VALUES (4, 2029);
INSERT INTO `sys_role_menu` VALUES (5, 2000);
INSERT INTO `sys_role_menu` VALUES (5, 2001);
INSERT INTO `sys_role_menu` VALUES (5, 2002);
INSERT INTO `sys_role_menu` VALUES (5, 2003);
INSERT INTO `sys_role_menu` VALUES (5, 2004);
INSERT INTO `sys_role_menu` VALUES (5, 2014);
INSERT INTO `sys_role_menu` VALUES (5, 2015);
INSERT INTO `sys_role_menu` VALUES (5, 2016);
INSERT INTO `sys_role_menu` VALUES (5, 2017);
INSERT INTO `sys_role_menu` VALUES (5, 2018);
INSERT INTO `sys_role_menu` VALUES (5, 2019);
INSERT INTO `sys_role_menu` VALUES (5, 2020);
INSERT INTO `sys_role_menu` VALUES (5, 2021);
INSERT INTO `sys_role_menu` VALUES (5, 2022);
INSERT INTO `sys_role_menu` VALUES (5, 2023);
INSERT INTO `sys_role_menu` VALUES (5, 2024);
INSERT INTO `sys_role_menu` VALUES (5, 2025);
INSERT INTO `sys_role_menu` VALUES (5, 2030);
INSERT INTO `sys_role_menu` VALUES (5, 2031);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `id_num` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '身份证',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', NULL, NULL, '0', '127.0.0.1', '2026-06-13 23:24:59', 'admin', '2026-01-08 16:39:44', '', '2026-06-13 23:24:59', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', NULL, NULL, '1', '127.0.0.1', '2026-01-08 16:39:44', 'admin', '2026-01-08 16:39:44', '', NULL, '测试员');
INSERT INTO `sys_user` VALUES (3, 0, 'fanxiao', '凡小', '00', 'fanxiao@qq.com', '15222274591', '0', '', '$2a$10$mM5aj2UK5vTFHknSbKcKKOqgqFFgSPHJGTEz9M4H2YFRwalvAMOka', '0', '111', '445322197110090039', '0', '127.0.0.1', '2026-05-28 16:09:37', 'admin', NULL, 'admin', '2026-05-28 16:09:36', '租户');
INSERT INTO `sys_user` VALUES (113, NULL, 'fanshen', '范深', '00', 'fanshen@qq.com', '18409767224', '0', '', '$2a$10$iBdCWvrUpWWvmINUE.0xHuo5wVagRXCvs5mdg6znIty0/zMLXmHg6', '0', '摸鱼区不想上班路 996 号', '340604195207020455', '0', '127.0.0.1', '2026-05-28 18:42:30', '', '2026-01-22 03:53:42', 'admin', '2026-05-28 18:42:29', NULL);
INSERT INTO `sys_user` VALUES (116, NULL, 'longaotian', '龙傲天', '00', '', '19306057796', '0', '', '$2a$10$dCSGuY3rm2hcafjqq5Ko/OAE1a9mLqZX0/N6ytKTRGj8lCJK3nup6', '0', NULL, '350304200505043152', '0', '127.0.0.1', '2026-06-13 23:30:47', '', '2026-01-22 19:04:24', '', '2026-06-13 23:30:47', NULL);
INSERT INTO `sys_user` VALUES (117, NULL, '张三', '张三', '00', '', '', '0', '', '$2a$10$SRGhh.P4y3bVEoVAJi3diOAgobE/v1Bm3zjRuULFr0pszhd92eRFq', '0', NULL, NULL, '0', '127.0.0.1', '2026-06-13 23:26:47', 'admin', '2026-02-06 16:40:51', 'admin', '2026-06-13 23:26:47', NULL);
INSERT INTO `sys_user` VALUES (119, NULL, 'lisi', 'lisi', '00', '', '', '0', '', '$2a$10$oOOQ2P1EdWLitiWeoxXoJemUnvDjxVDtM4BL55gC8WDmLnTgMFWlm', '0', NULL, NULL, '0', '127.0.0.1', '2026-05-28 14:31:28', 'admin', '2026-02-11 19:27:04', 'admin', '2026-05-28 14:31:28', NULL);
INSERT INTO `sys_user` VALUES (120, NULL, 'weixiu', '维修工1号', '00', '192', '1234567', '0', '', '$2a$10$iBdCWvrUpWWvmINUE.0xHuo5wVagRXCvs5mdg6znIty0/zMLXmHg6', '0', '123', '199', '0', '127.0.0.1', '2026-05-22 19:57:08', '', NULL, '', '2026-05-22 19:57:09', '维修工');
INSERT INTO `sys_user` VALUES (121, NULL, 'ww', 'ww', '00', '', '', '0', '', '$2a$10$JjopZZla8BJdI43wl87FvORJwzGUZfDqBaT/0gM5k0Df8GsqJEkVm', '0', NULL, NULL, '2', '127.0.0.1', '2026-02-13 18:41:26', 'admin', '2026-02-13 15:30:13', '', '2026-02-13 18:41:26', NULL);
INSERT INTO `sys_user` VALUES (129, NULL, '12', 'u1', '00', '192', '123456', '0', '', '$2a$10$iBdCWvrUpWWvmINUE.0xHuo5wVagRXCvs5mdg6znIty0/zMLXmHg6', '0', NULL, '199', '2', '', NULL, '', NULL, '', NULL, '');
INSERT INTO `sys_user` VALUES (130, NULL, 'wangwu', 'wangwu', '00', '', '', '0', '', '$2a$10$a95rcurNL035g./l6.mm8.74ywhFp3rJH.1R81O2aBDDsA6ONqd7q', '0', NULL, NULL, '0', '127.0.0.1', '2026-03-27 10:31:12', 'admin', '2026-03-22 14:49:21', '', '2026-03-27 10:31:11', NULL);
INSERT INTO `sys_user` VALUES (133, NULL, 'testuser002', '测试用户乙', '00', 'testuser002@qq.com', '19802039314', '0', '', '$2a$10$t7vkoGlAIa5YMZ0yAah39O9J24fE5a2NXdsqjZRJe2FYJ71nfxhQu', '0', NULL, '430923195808070850', '0', '127.0.0.1', '2026-05-01 18:32:43', '', '2026-05-01 18:10:53', '', '2026-05-01 18:32:42', NULL);
INSERT INTO `sys_user` VALUES (134, NULL, 'testuser003', '测试用户丙', '00', 'testuser003@qq.com', '19802039315', '0', '', '$2a$10$hl78HgrfSgB69bVA/19h5emsr83NHJVvMd3NFTOEdZcp38E8mb4lW', '0', NULL, '500237199104017038', '0', '127.0.0.1', '2026-05-07 16:28:27', '', '2026-05-01 18:11:19', '', '2026-05-07 16:28:23', NULL);
INSERT INTO `sys_user` VALUES (135, NULL, 'testuser001', '测试用户甲', '00', 'testuser001@qq.com', '19802039318', '0', '', '$2a$10$mnV7x2yL9YLyqc9QcV6bfu60MWzT7JOPEi4DOfg0vAROv3EI/bDhe', '0', NULL, '130407202010243833', '0', '127.0.0.1', '2026-05-01 18:32:03', '', '2026-05-01 18:24:46', '', '2026-05-01 18:32:03', NULL);
INSERT INTO `sys_user` VALUES (138, 0, 'wangzai', '旺仔', '00', '2215343411@qq.com', '15859032791', '0', '', '$2a$10$QCDrwS5bpMzVTnSj8ySdp.HOAWOciiUzuFD7iyYwiKSrMd560zkO6', '0', '青青草原1号', '11010519491231002X', '0', '127.0.0.1', '2026-06-13 23:31:23', '', '2026-05-12 23:39:42', '', '2026-06-13 23:31:23', NULL);
INSERT INTO `sys_user` VALUES (139, 0, 'lqy', '赖清妍', '00', '37d0@0o10l.cn', '14987454613', '0', '', '$2a$10$i6nr4t6bcSsI9DFgpCPbqOe5mc/0srL.zI///JYiknEmAH86WS2mO', '0', '新疆维吾尔自治区吐鲁番市高昌区红柳河街道', '514490200804065675', '0', '127.0.0.1', '2026-05-28 16:05:04', '', NULL, 'admin', '2026-05-28 16:05:04', NULL);
INSERT INTO `sys_user` VALUES (140, 0, 'mfz', '马夫子', '00', '5597@53e5i7.cn', '18288795662', '0', '', '$2a$10$HkX0rlxpBmprZsIPcL37auWX19GVci8Hlcpv/kBiHOwAxeMTKRqFe', '0', '湖南省张家界市永定区西溪坪街道', '252323198010265295', '0', '127.0.0.1', '2026-05-17 20:47:37', '', NULL, '', '2026-05-17 20:47:37', NULL);
INSERT INTO `sys_user` VALUES (149, NULL, 'yl', 'yl', '00', '', '15250709892', '0', '', '$2a$10$V4Gt.x0fWP0F8pnaZekWtOdPG6dTHRTKGOIKEYvKFi/7HX0BENw.O', '0', NULL, '479488201208151918', '0', '127.0.0.1', '2026-05-21 15:59:06', '', '2026-05-21 15:58:33', '', '2026-05-21 15:59:06', NULL);
INSERT INTO `sys_user` VALUES (151, NULL, 'zjy', '张佳怡', '00', '', '14672766221', '0', '', '$2a$10$YvIAzT2ffaex3a30SNfS/uce7OuW8gvsfk6k/PYEkvb16sUXtk/FW', '0', NULL, '360423199809130117 ', '0', '127.0.0.1', '2026-05-28 16:07:03', '', '2026-05-21 16:14:19', '', '2026-05-28 16:07:03', NULL);
INSERT INTO `sys_user` VALUES (152, NULL, 'zyr', 'zyr', '00', '', '15756821506', '0', '', '$2a$10$6rZ.oauK0/mPv8.xzcXJ/.iMDJaVVy4HnRtAxIgTsOLqNsizfo0PC', '0', NULL, '341302199102013398', '0', '127.0.0.1', '2026-05-28 16:10:13', '', '2026-05-28 15:49:00', '', '2026-05-28 16:10:13', NULL);
INSERT INTO `sys_user` VALUES (153, NULL, 'hw', 'hwy', '00', '', '15865343237', '0', '', '$2a$10$sD6YZkPsHCboh.QmFdUzIeDAGwunkAcIEEPH9qeuRMLJ.myKhHUp2', '0', NULL, '110101201202153354', '0', '127.0.0.1', '2026-05-29 15:09:56', '', '2026-05-28 20:24:44', '', '2026-05-29 15:09:55', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位（1 管理员）(2 租户) （ 0维修工）',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (3, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (100, 2);
INSERT INTO `sys_user_role` VALUES (101, 2);
INSERT INTO `sys_user_role` VALUES (102, 2);
INSERT INTO `sys_user_role` VALUES (103, 2);
INSERT INTO `sys_user_role` VALUES (104, 2);
INSERT INTO `sys_user_role` VALUES (113, 3);
INSERT INTO `sys_user_role` VALUES (116, 4);
INSERT INTO `sys_user_role` VALUES (117, 5);
INSERT INTO `sys_user_role` VALUES (119, 3);
INSERT INTO `sys_user_role` VALUES (120, 4);
INSERT INTO `sys_user_role` VALUES (127, 4);
INSERT INTO `sys_user_role` VALUES (129, 4);
INSERT INTO `sys_user_role` VALUES (130, 5);
INSERT INTO `sys_user_role` VALUES (131, 3);
INSERT INTO `sys_user_role` VALUES (132, 3);
INSERT INTO `sys_user_role` VALUES (133, 3);
INSERT INTO `sys_user_role` VALUES (134, 3);
INSERT INTO `sys_user_role` VALUES (135, 3);
INSERT INTO `sys_user_role` VALUES (138, 3);
INSERT INTO `sys_user_role` VALUES (139, 3);
INSERT INTO `sys_user_role` VALUES (142, 3);
INSERT INTO `sys_user_role` VALUES (146, 3);
INSERT INTO `sys_user_role` VALUES (147, 3);
INSERT INTO `sys_user_role` VALUES (148, 3);
INSERT INTO `sys_user_role` VALUES (149, 3);
INSERT INTO `sys_user_role` VALUES (150, 3);
INSERT INTO `sys_user_role` VALUES (151, 3);
INSERT INTO `sys_user_role` VALUES (152, 3);
INSERT INTO `sys_user_role` VALUES (153, 3);

-- ----------------------------
-- Table structure for tenant_application
-- ----------------------------
DROP TABLE IF EXISTS `tenant_application`;
CREATE TABLE `tenant_application`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '租户申请id',
  `tenant_id` bigint(11) NULL DEFAULT NULL COMMENT '租户id',
  `room_id` bigint(11) NULL DEFAULT NULL COMMENT '房间id',
  `start_time` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `apply_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  `contract_id` bigint(11) NULL DEFAULT NULL COMMENT '合同id(合同签订后才显示房屋状态)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '审批状态(0待审批,1审批通过,2已拒绝,3已取消)',
  `room_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '房屋状态（0退租 1在租）\r\n(当前申请周期中租户对该房间的租赁状态)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新人',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(1) NULL DEFAULT 0 COMMENT '逻辑删除（0-未删，1-已删）',
  `apply_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '申请人',
  `contact_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_application
-- ----------------------------
INSERT INTO `tenant_application` VALUES (1, 113, 9, '2026-03-01 00:00:00', '2027-03-01 23:59:59', '2026-02-06 16:35:22', NULL, '1', '0', '', '2026-02-06 16:35:22', '', '2026-05-12 21:03:27', NULL, 0, NULL, NULL);
INSERT INTO `tenant_application` VALUES (3, 135, 7, '2026-04-01 16:00:00', '2026-06-01 16:00:00', '2026-04-20 16:38:38', NULL, '1', '0', 'admin', '2026-04-20 16:38:38', '', '2026-05-12 21:03:27', 'hhh', 0, 'admin', '15888888888');
INSERT INTO `tenant_application` VALUES (4, 113, 13, '2026-05-06 16:00:00', '2026-06-17 16:00:00', '2026-05-07 20:44:18', NULL, '3', '0', 'fanshen', '2026-05-07 20:44:18', '', '2026-05-12 21:03:27', '', 0, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (5, 113, 13, '2026-05-06 16:00:00', '2026-06-18 16:00:00', '2026-05-07 20:52:21', NULL, '3', '0', 'fanshen', '2026-05-07 20:52:21', '', '2026-05-12 21:03:27', NULL, 0, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (6, 113, 13, '2026-05-13 16:00:00', '2026-06-24 16:00:00', '2026-05-09 15:41:30', NULL, '3', '0', 'fanshen', '2026-05-09 15:41:30', '', '2026-05-12 21:03:27', '', 0, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (7, 113, 13, '2026-05-12 16:00:00', '2026-06-18 16:00:00', '2026-05-12 00:39:53', NULL, '1', '0', 'fanshen', '2026-05-12 00:39:53', '', '2026-05-12 21:48:07', '', 1, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (8, 113, 13, '2026-05-12 16:00:00', '2026-06-16 16:00:00', '2026-05-12 16:11:45', NULL, '1', NULL, 'fanshen', '2026-05-12 16:11:45', '', '2026-05-12 21:48:07', '', 1, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (9, 113, 13, '2026-05-12 16:00:00', '2026-06-17 16:00:00', '2026-05-12 21:48:38', 17, '1', '0', 'fanshen', '2026-05-12 21:48:38', '', '2026-05-16 16:50:17', '', 0, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (10, 138, 15, '2026-05-12 16:00:00', '2026-06-15 16:00:00', '2026-05-12 23:43:26', 18, '1', '1', 'wangzai', '2026-05-12 23:43:26', '', '2026-05-12 23:47:17', '', 0, 'wangzai', '15859032796');
INSERT INTO `tenant_application` VALUES (11, 113, 13, '2026-05-20 16:00:00', '2026-06-22 16:00:00', '2026-05-16 16:45:25', NULL, '3', NULL, 'fanshen', '2026-05-16 16:45:25', '', '2026-05-16 16:45:24', NULL, 0, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (12, 113, 13, '2026-05-19 16:00:00', '2026-06-17 16:00:00', '2026-05-16 16:46:05', NULL, '2', NULL, 'fanshen', '2026-05-16 16:46:05', '', '2026-05-16 16:46:05', '不行', 0, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (13, 113, 13, '2026-05-19 16:00:00', '2026-06-24 16:00:00', '2026-05-16 16:51:14', 19, '1', '1', 'fanshen', '2026-05-16 16:51:14', '', '2026-05-16 16:53:20', '不行', 0, 'fanshen', '18409767224');
INSERT INTO `tenant_application` VALUES (14, 139, 16, '2026-05-17 16:00:00', '2026-05-30 16:00:00', '2026-05-17 21:03:59', NULL, '3', NULL, 'lqy', '2026-05-17 21:03:59', '', '2026-05-17 21:03:58', NULL, 0, 'lqy', '14987454613');
INSERT INTO `tenant_application` VALUES (15, 151, 10, '2026-05-21 16:00:00', '2026-06-04 16:00:00', '2026-05-21 19:49:24', 20, '1', '1', 'zjy', '2026-05-21 19:49:24', '', '2026-05-22 16:30:31', '', 0, 'zjy', '14672766221');
INSERT INTO `tenant_application` VALUES (16, 139, 17, '2026-05-22 16:00:00', '2026-06-29 16:00:00', '2026-05-22 15:17:18', 22, '1', '1', 'lqy', '2026-05-22 15:17:18', '', '2026-05-22 15:20:06', '', 0, 'lqy', '14987454613');
INSERT INTO `tenant_application` VALUES (17, 152, 19, '2026-05-28 16:00:00', '2026-06-29 16:00:00', '2026-05-28 15:50:20', 57, '1', '1', 'zyr', '2026-05-28 15:50:20', '', '2026-05-28 15:51:31', '', 0, 'zyr', '15756821506');
INSERT INTO `tenant_application` VALUES (18, 153, 20, '2026-05-28 16:00:00', '2026-06-29 16:00:00', '2026-05-28 20:25:34', 58, '1', '1', 'hwy', '2026-05-28 20:25:34', '', '2026-05-28 20:26:35', '', 0, 'hwy', '15865343237');

SET FOREIGN_KEY_CHECKS = 1;
