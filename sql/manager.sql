/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : manager

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 08/09/2020 17:41:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for session
-- ----------------------------
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session`  (
  `session_key` char(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `session_data` blob NULL,
  `session_expiry` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of session
-- ----------------------------

-- ----------------------------
-- Table structure for sys_auth
-- ----------------------------
DROP TABLE IF EXISTS `sys_auth`;
CREATE TABLE `sys_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `auth_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '权限名称',
  `urlfor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'url反转',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父级id',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `is_active` int(11) NOT NULL DEFAULT 0 COMMENT '是否启用',
  `is_delete` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `weight` int(11) NOT NULL DEFAULT 0 COMMENT '权重,数值越大，排序越前',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 67 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_auth
-- ----------------------------
INSERT INTO `sys_auth` VALUES (1, '用户管理', '#', 0, '用户管理', 0, 0, 0, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (2, '个人中心', '#', 0, '菜单管理', 0, 0, 1, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (3, '财务中心', '#', 0, '权限管理', 0, 0, 2, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (4, '内容管理', '#', 0, '用户管理', 0, 0, 3, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (5, '车辆管理', '#', 0, '用户管理', 0, 0, 4, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (6, '菜单管理', '#', 0, '用户管理', 0, 0, 5, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (7, '权限管理', '#', 0, '用户管理', 0, 0, 6, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (8, '报表管理', '#', 0, '用户管理', 0, 0, 7, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (9, '用户列表', 'UserController.List', 1, '用户管理', 0, 0, 8, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (10, '工资条', 'SalaryController.Get', 2, '用户管理', 0, 0, 9, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (11, '工资管理', 'FinanceController.Get', 3, '用户管理', 0, 0, 10, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (12, '财务报表', 'FinanceDataController.Get', 3, '用户管理', 0, 0, 11, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (13, '新闻列表', 'NewsController.Get', 4, '用户管理', 0, 0, 12, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (14, '栏目管理', 'CateController.Get', 4, '用户管理', 0, 0, 13, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (15, '车辆列表', 'CarController.Get', 5, '用户管理', 0, 0, 14, '2020-08-17 23:59:53');
INSERT INTO `sys_auth` VALUES (16, '车辆品牌管理', 'CarBrandController.Get', 5, '用户管理，一级菜单', 0, 0, 15, '2020-08-18 11:45:36');
INSERT INTO `sys_auth` VALUES (17, '车辆申请', 'CarApplyController.Get', 5, '个人中心，一级菜单', 0, 0, 16, '2020-08-18 11:49:22');
INSERT INTO `sys_auth` VALUES (18, '车辆审批', 'AuthController.List', 5, '财务中心,一级菜单', 0, 0, 17, '2020-08-18 11:53:08');
INSERT INTO `sys_auth` VALUES (19, '车辆管理', 'AuthController.List', 5, '车辆管理，一级菜单', 0, 0, 18, '2020-08-18 11:54:14');
INSERT INTO `sys_auth` VALUES (20, '菜单列表', 'AuthController.List', 6, '212', 0, 0, 19, '2020-08-18 12:41:49');
INSERT INTO `sys_auth` VALUES (21, '权限列表', 'AuthController.List', 7, '菜单管理，一级菜单', 0, 0, 20, '2020-08-18 20:46:53');
INSERT INTO `sys_auth` VALUES (22, '角色列表', 'RoleController.List', 7, '', 0, 0, 21, '2020-08-18 21:02:08');
INSERT INTO `sys_auth` VALUES (40, '财务报表', 'SalaryController.Get', 8, '用户管理，一级菜单', 0, 0, 22, '2020-08-18 11:45:36');
INSERT INTO `sys_auth` VALUES (41, '业务报表', 'AuthController.List', 8, '用户管理，一级菜单', 0, 0, 23, '2020-08-18 11:45:36');
INSERT INTO `sys_auth` VALUES (42, '课程报表', 'AuthController.List', 8, '用户管理，一级菜单', 0, 0, 24, '2020-08-18 11:45:36');
INSERT INTO `sys_auth` VALUES (43, '测试菜单', '#', 0, '', 0, 0, 66, '2020-08-19 23:12:32');
INSERT INTO `sys_auth` VALUES (62, '个人信息', 'PersonController.Get', 2, '', 0, 0, 0, '2020-08-27 19:14:20');
INSERT INTO `sys_auth` VALUES (63, '测试菜单', '#', 0, '污', 0, 0, 99, '2020-09-01 01:32:41');
INSERT INTO `sys_auth` VALUES (64, '测试菜单3', '#', 0, '123', 0, 0, 100, '2020-09-01 01:33:42');
INSERT INTO `sys_auth` VALUES (65, '测试接口', '#', 0, '123', 1, 0, 231, '2020-09-01 22:26:55');
INSERT INTO `sys_auth` VALUES (66, '申请记录', 'CarApplyController.MyApply', 5, '申请记录，二级菜单', 0, 0, 5, '2020-09-06 16:47:47');

-- ----------------------------
-- Table structure for sys_car
-- ----------------------------
DROP TABLE IF EXISTS `sys_car`;
CREATE TABLE `sys_car`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '品牌名称',
  `car_brand_id` int(11) NOT NULL,
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '是否借出，0未借出',
  `is_active` int(11) NOT NULL DEFAULT 0 COMMENT '是否可用，0可用1不可',
  `is_delete` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除，0未删',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_car
-- ----------------------------
INSERT INTO `sys_car` VALUES (1, '桑塔纳', 2, '', 0, 0, 0, '2020-09-05 20:30:49');
INSERT INTO `sys_car` VALUES (2, '塞纳', 20, '', 1, 0, 0, '2020-09-05 21:13:01');
INSERT INTO `sys_car` VALUES (6, '威龙', 22, '', 0, 0, 0, '2020-09-06 14:57:22');
INSERT INTO `sys_car` VALUES (7, '萨塔纳2000', 1, '', 1, 0, 0, '2020-09-06 14:57:35');
INSERT INTO `sys_car` VALUES (8, 'R8', 2, '', 0, 0, 0, '2020-09-06 14:57:49');
INSERT INTO `sys_car` VALUES (9, 'P1', 20, '', 1, 0, 0, '2020-09-06 14:58:09');
INSERT INTO `sys_car` VALUES (10, '野马', 23, '', 0, 0, 0, '2020-09-06 14:58:42');
INSERT INTO `sys_car` VALUES (11, '599XXe', 26, '', 1, 0, 0, '2020-09-06 14:59:11');

-- ----------------------------
-- Table structure for sys_car_apply
-- ----------------------------
DROP TABLE IF EXISTS `sys_car_apply`;
CREATE TABLE `sys_car_apply`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `car_id` int(11) NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '理由',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `return_time` datetime(0) NULL DEFAULT NULL COMMENT '归还日期',
  `return_status` int(11) NOT NULL DEFAULT 0 COMMENT '申请状态0待批复1已批复-1已驳回2已完成3超时',
  `option` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '审批意见',
  `is_delete` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_car_apply
-- ----------------------------
INSERT INTO `sys_car_apply` VALUES (1, 1, 1, '123', '12', NULL, 0, '', 0, '2020-09-06 15:50:05');
INSERT INTO `sys_car_apply` VALUES (2, 1, 1, '231', '321', NULL, 0, '', 0, '2020-09-06 15:54:45');
INSERT INTO `sys_car_apply` VALUES (3, 1, 6, '21', '213', '2020-09-25 00:00:00', 0, '', 0, '2020-09-06 15:59:02');

-- ----------------------------
-- Table structure for sys_car_brand
-- ----------------------------
DROP TABLE IF EXISTS `sys_car_brand`;
CREATE TABLE `sys_car_brand`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '品牌名称',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `is_active` int(11) NOT NULL DEFAULT 0 COMMENT '是否可用，0可用1不可',
  `is_delete` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除，0未删',
  `created_at` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_car_brand
-- ----------------------------
INSERT INTO `sys_car_brand` VALUES (1, '大众', '牛逼', 0, 0, '2020-09-05 13:44:01');
INSERT INTO `sys_car_brand` VALUES (2, '奥迪', '很贵', 0, 0, '2020-09-05 18:03:12');
INSERT INTO `sys_car_brand` VALUES (16, '奥迪', '很贵11', 1, 1, '2020-09-05 19:13:42');
INSERT INTO `sys_car_brand` VALUES (17, '', '', 0, 1, '2020-09-05 19:14:09');
INSERT INTO `sys_car_brand` VALUES (18, '', '', 0, 1, '2020-09-05 19:14:41');
INSERT INTO `sys_car_brand` VALUES (19, '', '', 0, 1, '2020-09-05 19:25:08');
INSERT INTO `sys_car_brand` VALUES (20, '迈凯伦', '123', 0, 0, '2020-09-06 14:56:15');
INSERT INTO `sys_car_brand` VALUES (21, '阿斯顿马丁', '2', 0, 0, '2020-09-06 14:56:26');
INSERT INTO `sys_car_brand` VALUES (22, '布加迪', '1', 0, 0, '2020-09-06 14:56:33');
INSERT INTO `sys_car_brand` VALUES (23, '福特', '1', 0, 0, '2020-09-06 14:56:39');
INSERT INTO `sys_car_brand` VALUES (24, '悍马', '1', 0, 0, '2020-09-06 14:56:48');
INSERT INTO `sys_car_brand` VALUES (25, '五菱', '1', 0, 0, '2020-09-06 14:56:53');
INSERT INTO `sys_car_brand` VALUES (26, '保时捷', '1', 0, 0, '2020-09-06 14:58:55');

-- ----------------------------
-- Table structure for sys_cate
-- ----------------------------
DROP TABLE IF EXISTS `sys_cate`;
CREATE TABLE `sys_cate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `is_active` int(11) NOT NULL DEFAULT 0 COMMENT '是否启用0-启用；1-停用',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_cate
-- ----------------------------
INSERT INTO `sys_cate` VALUES (1, '娱乐八卦', '明星资讯那些事儿', 0, '2020-09-01 19:00:00');
INSERT INTO `sys_cate` VALUES (3, '时事政治', '秀才不出门，知尽天下事', 0, '2020-09-01 14:35:04');
INSERT INTO `sys_cate` VALUES (4, '军事体育', '纵览天下', 0, '2020-09-01 14:36:50');
INSERT INTO `sys_cate` VALUES (5, '教育风向', '高瞻远瞩', 0, '2020-09-01 14:38:25');
INSERT INTO `sys_cate` VALUES (6, '股市风云', '股市行情动态', 0, '2020-09-01 14:38:11');
INSERT INTO `sys_cate` VALUES (8, '游戏资讯', '新游热游新动态', 0, '2020-09-01 14:39:43');
INSERT INTO `sys_cate` VALUES (9, '科技要文', '213', 0, '2020-09-01 17:24:11');

-- ----------------------------
-- Table structure for sys_finance
-- ----------------------------
DROP TABLE IF EXISTS `sys_finance`;
CREATE TABLE `sys_finance`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `finance_date` varchar(62) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '月份',
  `sales_volume` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '销售额',
  `student_increase` int(11) NOT NULL DEFAULT 0 COMMENT '学员增加数量',
  `boot_num` int(11) NOT NULL DEFAULT 0 COMMENT 'SpringBoot销售数量',
  `cloud_num` int(11) NOT NULL DEFAULT 0 COMMENT 'SpringCloud销售数量',
  `vue_num` int(11) NOT NULL DEFAULT 0 COMMENT 'Vue销售数量',
  `react_num` int(11) NOT NULL DEFAULT 0 COMMENT 'React销售数量',
  `create_time` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 308 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_finance
-- ----------------------------
INSERT INTO `sys_finance` VALUES (299, '2020-01', 32142.76, 324, 123, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (300, '2020-02', 46327.54, 565, 312, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (301, '2020-03', 53424.56, 746, 543, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (302, '2020-04', 31245.10, 423, 432, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (303, '2020-05', 87031.30, 199, 654, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (304, '2020-06', 63124.31, 432, 321, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (305, '2020-07', 31224.32, 643, 322, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (306, '2020-08', 32212.46, 313, 765, 212, 243, 59, '2020-08-31 15:37:05');
INSERT INTO `sys_finance` VALUES (307, '2020-09', 32145.24, 312, 312, 212, 243, 59, '2020-08-31 15:37:05');

-- ----------------------------
-- Table structure for sys_login_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_login_log`;
CREATE TABLE `sys_login_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `os` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `browse` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_login_log
-- ----------------------------
INSERT INTO `sys_login_log` VALUES (1, 'root', '127.0.0.1:54799', '127.0.0.1:8080', NULL, '2020-09-08 12:47:41');
INSERT INTO `sys_login_log` VALUES (2, 'root', '127.0.0.1:54799', '127.0.0.1:8080', NULL, '2020-09-08 12:55:52');
INSERT INTO `sys_login_log` VALUES (3, 'root', '127.0.0.1:55507', 'other', NULL, '2020-09-08 12:58:11');
INSERT INTO `sys_login_log` VALUES (4, 'root', '127.0.0.1:55507', 'other', NULL, '2020-09-08 13:00:11');
INSERT INTO `sys_login_log` VALUES (5, 'root', '127.0.0.1:58145', 'Win10', 'chrome 85.0.4183.83', '2020-09-08 17:39:13');

-- ----------------------------
-- Table structure for sys_news
-- ----------------------------
DROP TABLE IF EXISTS `sys_news`;
CREATE TABLE `sys_news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '新闻标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '新闻内容',
  `is_delete` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除0-未删除；1-删除',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_news
-- ----------------------------
INSERT INTO `sys_news` VALUES (3, '2', '21', 1, '2020-09-01 17:19:29', 1);
INSERT INTO `sys_news` VALUES (4, '21', '12', 1, '2020-09-01 17:21:29', 1);
INSERT INTO `sys_news` VALUES (5, '21', '21', 1, '2020-09-01 17:21:21', 1);
INSERT INTO `sys_news` VALUES (6, '21', '2', 1, '2020-09-01 17:21:26', 1);
INSERT INTO `sys_news` VALUES (7, '特朗普死了', '1', 0, '2020-09-01 17:21:38', 1);
INSERT INTO `sys_news` VALUES (8, '2', '<p><strong>一级标题</strong></p><p><strong><u><em>这是内容</em></u></strong></p>', 0, '2020-09-01 22:18:18', 1);
INSERT INTO `sys_news` VALUES (9, '', '', 0, '2020-09-01 22:57:51', 0);
INSERT INTO `sys_news` VALUES (10, '1', '1', 1, '2020-09-01 17:19:34', 1);
INSERT INTO `sys_news` VALUES (12, '澳门皇家赌场上线啦！！！', '<h1 style=\"text-align: center;\"><strong>30w彩金征求赢家</strong></h1><p style=\"text-align: center;\">以小博大，紧张刺激</p><p style=\"text-align: left;\"><a href=\"http://www.baidu.com\"><img src=\"upload/2020/09/01/e298d31b-9de6-486f-a85f-e7088839cbbe.gif\" style=\"width: 300px;\" class=\"fr-fic fr-dib\" data-code=\"200\"></a></p><p style=\"text-align: center;\">你心动了吗？</p>', 0, '2020-09-02 00:19:18', 1);

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(65) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `flag` int(11) NOT NULL DEFAULT 0 COMMENT '通知类型',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '内容',
  `user_id` int(11) NOT NULL COMMENT '用户外键',
  `tag` int(11) NOT NULL DEFAULT 0 COMMENT '读状态（1已读0未读）',
  `created_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '权限名称',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `is_active` int(11) NOT NULL DEFAULT 0 COMMENT '是否启用',
  `is_delete` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', '管理员666', 0, 0, '2020-08-22 16:16:50');
INSERT INTO `sys_role` VALUES (2, '普通用户', '11', 1, 0, '2020-09-01 01:21:35');

-- ----------------------------
-- Table structure for sys_role_sys_auths
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_sys_auths`;
CREATE TABLE `sys_role_sys_auths`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sys_role_id` int(11) NOT NULL,
  `sys_auth_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 133 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_sys_auths
-- ----------------------------
INSERT INTO `sys_role_sys_auths` VALUES (106, 1, 1);
INSERT INTO `sys_role_sys_auths` VALUES (107, 1, 9);
INSERT INTO `sys_role_sys_auths` VALUES (108, 1, 2);
INSERT INTO `sys_role_sys_auths` VALUES (109, 1, 62);
INSERT INTO `sys_role_sys_auths` VALUES (110, 1, 10);
INSERT INTO `sys_role_sys_auths` VALUES (111, 1, 3);
INSERT INTO `sys_role_sys_auths` VALUES (112, 1, 11);
INSERT INTO `sys_role_sys_auths` VALUES (113, 1, 12);
INSERT INTO `sys_role_sys_auths` VALUES (114, 1, 4);
INSERT INTO `sys_role_sys_auths` VALUES (115, 1, 13);
INSERT INTO `sys_role_sys_auths` VALUES (116, 1, 14);
INSERT INTO `sys_role_sys_auths` VALUES (117, 1, 5);
INSERT INTO `sys_role_sys_auths` VALUES (118, 1, 66);
INSERT INTO `sys_role_sys_auths` VALUES (119, 1, 15);
INSERT INTO `sys_role_sys_auths` VALUES (120, 1, 16);
INSERT INTO `sys_role_sys_auths` VALUES (121, 1, 17);
INSERT INTO `sys_role_sys_auths` VALUES (122, 1, 18);
INSERT INTO `sys_role_sys_auths` VALUES (123, 1, 19);
INSERT INTO `sys_role_sys_auths` VALUES (124, 1, 6);
INSERT INTO `sys_role_sys_auths` VALUES (125, 1, 20);
INSERT INTO `sys_role_sys_auths` VALUES (126, 1, 7);
INSERT INTO `sys_role_sys_auths` VALUES (127, 1, 21);
INSERT INTO `sys_role_sys_auths` VALUES (128, 1, 22);
INSERT INTO `sys_role_sys_auths` VALUES (129, 1, 8);
INSERT INTO `sys_role_sys_auths` VALUES (130, 1, 40);
INSERT INTO `sys_role_sys_auths` VALUES (131, 1, 41);
INSERT INTO `sys_role_sys_auths` VALUES (132, 1, 42);

-- ----------------------------
-- Table structure for sys_role_sys_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_sys_users`;
CREATE TABLE `sys_role_sys_users`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sys_role_id` int(11) NOT NULL,
  `sys_user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_sys_users
-- ----------------------------
INSERT INTO `sys_role_sys_users` VALUES (1, 1, 1);
INSERT INTO `sys_role_sys_users` VALUES (2, 1, 2);

-- ----------------------------
-- Table structure for sys_salary
-- ----------------------------
DROP TABLE IF EXISTS `sys_salary`;
CREATE TABLE `sys_salary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工号',
  `salary` decimal(10, 2) NULL DEFAULT NULL COMMENT '基本工资',
  `work_day` decimal(10, 2) NULL DEFAULT NULL COMMENT '工作天数',
  `off_day` decimal(10, 2) NULL DEFAULT NULL COMMENT '请假天数',
  `rest_day` decimal(10, 2) NULL DEFAULT NULL COMMENT '调休天数',
  `reward` decimal(10, 2) NULL DEFAULT NULL COMMENT '奖金',
  `perk` decimal(10, 2) NULL DEFAULT NULL COMMENT '补贴',
  `social` decimal(10, 2) NULL DEFAULT NULL COMMENT '社保',
  `tax` decimal(10, 2) NULL DEFAULT NULL COMMENT '税',
  `fine` decimal(10, 2) NULL DEFAULT NULL COMMENT '罚金',
  `net_salary` decimal(10, 2) NULL DEFAULT NULL COMMENT '实发',
  `pay_date` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工资月份',
  `creat_time` date NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 426 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_salary
-- ----------------------------
INSERT INTO `sys_salary` VALUES (32, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (33, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (34, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (35, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (36, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (37, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (38, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (39, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (40, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (41, 'xiao001001', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (42, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (43, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (44, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (45, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (46, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (47, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (48, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (49, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (50, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (51, 'xiao001002', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (52, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (53, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (54, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (55, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (56, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (57, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (58, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (59, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (60, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (61, 'xiao001003', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (62, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (63, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (64, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (65, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (66, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (67, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (68, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (69, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (70, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (71, 'xiao001004', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (72, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (73, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (74, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (75, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (76, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (77, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (78, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (79, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (80, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (81, 'xiao001005', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (82, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (83, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (84, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (85, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (86, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (87, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (88, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (89, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (90, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (91, 'xiao001006', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (92, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (93, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (94, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (95, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (96, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (97, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (98, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (99, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (100, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (101, 'xiao001007', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (102, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (103, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (104, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (105, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (106, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (107, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (108, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (109, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (110, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (111, 'xiao001008', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (112, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (113, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (114, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (115, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (116, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (117, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (118, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (119, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (120, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (121, 'xiao001009', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (122, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (123, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (124, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (125, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (126, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (127, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (128, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (129, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (130, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (131, 'xiao0010010', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (132, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (133, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (134, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (135, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (136, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (137, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (138, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (139, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (140, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (141, 'xiao0010011', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (142, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (143, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (144, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (145, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (146, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (147, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (148, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (149, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (150, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (151, 'xiao0010012', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (152, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (153, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (154, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (155, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (156, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (157, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (158, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (159, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (160, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (161, 'xiao0010013', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (162, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (163, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (164, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (165, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (166, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (167, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (168, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (169, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (170, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (171, 'xiao0010014', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (172, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (173, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (174, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (175, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (176, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (177, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (178, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (179, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (180, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (181, 'xiao0010015', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (182, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (183, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (184, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (185, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (186, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (187, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (188, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (189, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (190, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (191, 'xiao0010016', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (192, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (193, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (194, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (195, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (196, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (197, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (198, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (199, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (200, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (201, 'xiao0010017', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (202, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (203, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (204, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (205, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (206, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (207, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (208, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (209, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (210, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (211, 'xiao0010018', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (212, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (213, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (214, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (215, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (216, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (217, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (218, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (219, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (220, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (221, 'xiao0010019', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (222, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (223, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (224, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (225, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (226, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (227, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (228, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (229, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (230, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (231, 'xiao0010020', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (232, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (233, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (234, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (235, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (236, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (237, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (238, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (239, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (240, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (241, 'xiao0010021', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (242, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (243, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (244, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (245, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (246, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (247, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (248, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (249, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (250, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (251, 'xiao0010022', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (252, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (253, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (254, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (255, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (256, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (257, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (258, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (259, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (260, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (261, 'xiao0010023', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (262, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (263, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (264, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (265, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (266, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (267, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (268, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (269, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (270, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (271, 'xiao0010024', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (272, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-01', '2020-08-28');
INSERT INTO `sys_salary` VALUES (273, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-02', '2020-08-28');
INSERT INTO `sys_salary` VALUES (274, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-03', '2020-08-28');
INSERT INTO `sys_salary` VALUES (275, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-04', '2020-08-28');
INSERT INTO `sys_salary` VALUES (276, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-05', '2020-08-28');
INSERT INTO `sys_salary` VALUES (277, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-06', '2020-08-28');
INSERT INTO `sys_salary` VALUES (278, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-07', '2020-08-28');
INSERT INTO `sys_salary` VALUES (279, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-08', '2020-08-28');
INSERT INTO `sys_salary` VALUES (280, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-09', '2020-08-28');
INSERT INTO `sys_salary` VALUES (281, 'xiao0010025', 3600.00, 20.50, 8.50, 1.00, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-010', '2020-08-28');
INSERT INTO `sys_salary` VALUES (417, 'xiao001002', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (418, 'xiao001003', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (419, 'xiao001004', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (420, 'xiao001005', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (421, 'xiao001006', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (422, 'xiao001007', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (423, 'xiao001008', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (424, 'xiao001009', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');
INSERT INTO `sys_salary` VALUES (425, 'xiao0010010', NULL, 20.50, NULL, NULL, 500.00, 500.00, 300.00, 120.00, 0.00, 6000.99, '2020-8', '2020-08-29');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `card_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别',
  `phone` bigint(20) NULL DEFAULT NULL COMMENT '手机号',
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `is_active` int(11) NOT NULL DEFAULT 1 COMMENT '1启用/0停用',
  `is_delete` int(11) NOT NULL DEFAULT 0 COMMENT '1删除/0未删除',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 71 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'xiao001001', 'root', 'e10adc3949ba59abbe56e057f20f883e', 18, 1, 15836917689, '北京1', 0, 0, '2020-08-26 18:10:25');
INSERT INTO `sys_user` VALUES (2, 'xiao001002', 'root123', 'e10adc3949ba59abbe56e057f20f883e', 21, 2, 15836917680, '北京', 0, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (3, 'xiao001003', 'xiao9878', 'e10adc3949ba59abbe56e057f20f883e', 25, 1, 15836917680, '天津', 0, 1, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (4, 'xiao001004', 'zs666', 'e10adc3949ba59abbe56e057f20f883e', 30, 2, 15836917680, '杭州', 0, 1, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (5, 'xiao001005', 'caizhengyi', 'e10adc3949ba59abbe56e057f20f883e', 15, 1, 15836917680, '武汉', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (6, 'xiao001006', 'oneplus1', 'e10adc3949ba59abbe56e057f20f883e', 61, 1, 15836917680, '南京', 0, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (7, 'xiao001007', 'oneplus2', 'e10adc3949ba59abbe56e057f20f883e', 51, 2, 15836917680, '广州', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (8, 'xiao001008', 'oneplus3', 'e10adc3949ba59abbe56e057f20f883e', 21, 2, 15836917680, '深圳', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (9, 'xiao001009', 'xiao98781', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (10, 'xiao001010', 'zs6661', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (11, 'xiao001011', 'caizhengyi1', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (12, 'xiao001012', 'oneplus11', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 0, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (13, 'xiao001013', 'oneplus21', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (14, 'xiao001014', 'oneplus13', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (16, 'xiao001016', 'oneplus132', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (17, 'xiao001017', 'dwadaw', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (18, 'xiao001018', 'dwadfd', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (19, 'xiao001019', 'cxzcw', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (20, 'xiao001020', 'dwaf', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (21, 'xiao001021', 'dsfxcgcx', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (22, 'xiao001022', 'wertxfs', 'e10adc3949ba59abbe56e057f20f883e', 20, 2, 15836917680, '北京市', 1, 0, '2020-08-28 11:38:40');
INSERT INTO `sys_user` VALUES (24, 'xiao001024', 'zxcv123', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, 15836917680, '45646', 1, 0, '2020-08-10 09:17:36');
INSERT INTO `sys_user` VALUES (25, 'xiao001025', 'zxcv12345', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, 15842156325, 'dwad', 1, 0, '2020-08-10 09:33:00');
INSERT INTO `sys_user` VALUES (26, 'xiao001026', '15616154', 'e36a2f90240e9e84483504fd4a704452', 1, 0, 15423654125, 'dwadwa', 1, 0, '2020-08-10 09:44:20');
INSERT INTO `sys_user` VALUES (27, 'xiao001027', '31eqw', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, 15423654125, 'dwa', 1, 0, '2020-08-10 09:47:24');
INSERT INTO `sys_user` VALUES (28, 'xiao001028', '14242424', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, 18546213641, '422', 1, 0, '2020-08-10 09:47:58');
INSERT INTO `sys_user` VALUES (29, 'xiao001029', 'dasdwa', 'e10adc3949ba59abbe56e057f20f883e', 1, 0, 12545684521, 'e2eq', 1, 0, '2020-08-10 09:49:10');
INSERT INTO `sys_user` VALUES (30, 'xiao001030', '424', '98474348b2ab7ae09e7a55460c5c2383', 1, 0, 15643218945, 'dwadwa', 1, 0, '2020-08-10 09:51:03');
INSERT INTO `sys_user` VALUES (31, 'xiao001031', 'dawdawfwa', '77927a7e2fef10596b4fcc1e39a492b9', 1, 0, 15643218945, 'ed2w', 1, 0, '2020-08-10 09:53:34');
INSERT INTO `sys_user` VALUES (33, 'xiao001033', 'dwadadaw', 'd881dc2ac3ee5a39d514e22cb63be9d8', 1, 0, 15643218945, 'eqwdw', 1, 0, '2020-08-10 09:57:16');
INSERT INTO `sys_user` VALUES (34, 'xiao001034', 'dwada', '2fb621d84a896252bc40c66646b2efe0', 1, 0, 15846521452, 'daw', 1, 0, '2020-08-10 09:58:36');
INSERT INTO `sys_user` VALUES (35, 'xiao001035', '32111321', '845646fea8d79da0fcbad61076672fb2', 1, 0, 15896345214, '委屈额', 1, 0, '2020-08-10 10:25:28');
INSERT INTO `sys_user` VALUES (36, 'xiao001036', 'wadwadadsz', '48f5b87d43152e923820bb9cf16587a3', 1, 0, 15643218945, '15挖到', 1, 0, '2020-08-10 10:34:45');
INSERT INTO `sys_user` VALUES (37, 'xiao001037', 'daw4d9a8w', 'f9dd04a5c25ed62c0460049fbc833675', 0, 1, 15643218945, '达瓦大', 1, 0, '2020-08-10 10:36:47');
INSERT INTO `sys_user` VALUES (38, 'xiao001038', 'dw1a56d1aw61a6gaw', 'c9d79085483b048b7a952460ae0aa932', 0, 1, 15643218945, 'dawa', 1, 0, '2020-08-10 10:38:39');
INSERT INTO `sys_user` VALUES (39, 'xiao001039', 'dwadawdawdxzcxvfxc', 'c3ae59901be0ee93a0da636d3e1d2705', 14, 1, 15643218945, 'dwadawdaw', 1, 0, '2020-08-10 10:39:47');
INSERT INTO `sys_user` VALUES (40, 'xiao001040', '15643218945', 'c0631fad0c7e24e13d9319d73d626085', 2, 1, 15643218945, 'qd2', 1, 0, '2020-08-10 10:42:41');
INSERT INTO `sys_user` VALUES (41, 'xiao001041', '414242424', 'bd1ef4d79f7d219b191e4ceec476fc83', 2, 1, 15643218945, 'xcsa', 1, 0, '2020-08-10 10:51:41');
INSERT INTO `sys_user` VALUES (42, 'xiao001042', 'server.go', 'b6eab485946ca46a862bdc6a3662b27c', 15, 1, 15839617680, '2', 1, 0, '2020-08-11 09:16:49');
INSERT INTO `sys_user` VALUES (43, 'xiao001043', '1583961768021', '51fba0a400957c71e773cdb15bf70748', 21, 2, 15839617680, '15839617680', 1, 0, '2020-08-11 09:18:18');
INSERT INTO `sys_user` VALUES (44, 'xiao001044', '15839617680213', '51fba0a400957c71e773cdb15bf70748', 22, 1, 15839617680, '爱我的', 1, 0, '2020-08-11 09:21:05');
INSERT INTO `sys_user` VALUES (45, 'xiao001045', '1582239617680', '51fba0a400957c71e773cdb15bf70748', 23, 2, 15839617680, '21', 1, 0, '2020-08-11 09:22:12');
INSERT INTO `sys_user` VALUES (46, 'xiao001046', 'main/user', '192a5b2f25f3f08209232ecea4be753c', 213, 1, 15839617680, '饿额', 1, 0, '2020-08-11 09:41:28');
INSERT INTO `sys_user` VALUES (48, 'xiao001048', '1215839617680', '51fba0a400957c71e773cdb15bf70748', 213, 1, 15839617680, '15839617680', 1, 0, '2020-08-11 09:47:42');
INSERT INTO `sys_user` VALUES (49, 'xiao001049', '1522839617680', '51fba0a400957c71e773cdb15bf70748', 22, 1, 15839617680, '15839617680', 1, 0, '2020-08-11 10:06:07');
INSERT INTO `sys_user` VALUES (50, 'xiao001050', '15839a23617680', '51fba0a400957c71e773cdb15bf70748', 2, 1, 15839617680, 'wda', 1, 0, '2020-08-11 10:18:23');
INSERT INTO `sys_user` VALUES (51, 'xiao001001', '1583961daw7680', '51fba0a400957c71e773cdb15bf70748', 23, 1, 15839617680, '15839617680', 1, 0, '2020-08-11 10:45:06');
INSERT INTO `sys_user` VALUES (52, 'xiao001001', '158396dwa17680', '51fba0a400957c71e773cdb15bf70748', 21, 1, 15839617680, '15839617680', 1, 0, '2020-08-11 10:45:58');
INSERT INTO `sys_user` VALUES (53, 'xiao001001', '3大的瓦打我', '81e326e61d0e64754fba32b4b6f2c15c', 112, 1, 15812345645, '15812345645', 1, 0, '2020-08-16 15:37:13');
INSERT INTO `sys_user` VALUES (54, 'xiao001001', '15812345645', 'a5cdbeca78b035090353f84fc13e54c9', 21, 1, 15812345645, '15812345645', 1, 0, '2020-08-16 15:37:32');
INSERT INTO `sys_user` VALUES (55, 'xiao001001', '15812213345645', 'a5cdbeca78b035090353f84fc13e54c9', 21, 1, 15812345645, '15812345645', 1, 0, '2020-08-16 15:38:51');
INSERT INTO `sys_user` VALUES (56, '', 'dwadawdaw', 'e10adc3949ba59abbe56e057f20f883e', 0, 1, 15696584125, '111', 1, 0, '2020-08-31 16:54:43');
INSERT INTO `sys_user` VALUES (57, '', '4198419516', 'e10adc3949ba59abbe56e057f20f883e', 0, 1, 12542684125, '1856', 1, 0, '2020-08-31 16:56:54');
INSERT INTO `sys_user` VALUES (58, '', '1561651', '9cf6f9edb58e7f3dadc1f65fdbe58b7a', 0, 1, 15545214521, 'wda', 1, 0, '2020-08-31 16:59:24');
INSERT INTO `sys_user` VALUES (59, '', '123456484261', 'e10adc3949ba59abbe56e057f20f883e', 0, 1, 15836917680, '2131321', 1, 0, '2020-08-31 17:00:46');
INSERT INTO `sys_user` VALUES (60, '', 'x_admin_close()', '2c922b9f50993adad2e9b91dcd249009', 0, 1, 15836917680, '21312', 1, 0, '2020-08-31 17:02:07');
INSERT INTO `sys_user` VALUES (61, '', '点燃ACG之魂，为梦想努力。', '832c417cb1d17f4b1afea8d0769da7de', 0, 1, 15836917680, '312', 1, 0, '2020-08-31 17:04:03');
INSERT INTO `sys_user` VALUES (62, '', '158369176213', 'aceeb492e4aa9de75d32e46bcf1ae04a', 0, 1, 15836917680, '231', 1, 0, '2020-08-31 17:11:12');
INSERT INTO `sys_user` VALUES (63, '', '915原神', 'a7452c5e0498bf9997015afb5b060c17', 0, 1, 15836917680, '2313', 1, 0, '2020-08-31 17:40:53');
INSERT INTO `sys_user` VALUES (64, '', '大武当213', 'e10adc3949ba59abbe56e057f20f883e', 0, 1, 15836917680, '256+1', 1, 0, '2020-08-31 19:52:16');
INSERT INTO `sys_user` VALUES (65, '', '156162', 'c43ac6a457d5408cdecdf10971792a34', 0, 1, 15245214524, '21', 1, 0, '2020-08-31 19:54:43');
INSERT INTO `sys_user` VALUES (66, '', 'dwadadx15', 'c0e5100a787738eb2f768bd18a294425', 0, 1, 15442563125, '165', 1, 0, '2020-08-31 19:55:26');
INSERT INTO `sys_user` VALUES (67, '', 'wda1d561awd3aw', '07ee5453e3523473a79ec03b6c1ffb1f', 0, 1, 15489456462, '12', 1, 0, '2020-08-31 19:56:07');
INSERT INTO `sys_user` VALUES (68, '', '2316161', '497b8adf0cb17000975f7d73d46d8d2b', 0, 1, 15643218945, '912', 1, 0, '2020-08-31 20:00:04');
INSERT INTO `sys_user` VALUES (70, '', '1564328945', '65b5eaca36e433a99bce8fa2d551d1da', 0, 1, 15643218945, '23', 1, 0, '2020-08-31 20:01:23');

-- ----------------------------
-- Table structure for sys_user_copy1
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_copy1`;
CREATE TABLE `sys_user_copy1`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `gender` int(11) NULL DEFAULT NULL COMMENT '性别',
  `phone` bigint(20) NULL DEFAULT NULL COMMENT '手机号',
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `is_active` int(11) NOT NULL DEFAULT 1 COMMENT '1启用/0停用',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_copy1
-- ----------------------------
INSERT INTO `sys_user_copy1` VALUES (1, '321', '321', NULL, NULL, NULL, NULL, 1, NULL);
INSERT INTO `sys_user_copy1` VALUES (2, 'root', 'e10adc3949ba59abbe56e057f20f883e', 18, NULL, NULL, NULL, 1, NULL);

-- ----------------------------
-- Table structure for ys_user
-- ----------------------------
DROP TABLE IF EXISTS `ys_user`;
CREATE TABLE `ys_user`  (
  `id` int(11) NOT NULL COMMENT '主键',
  `user_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '面',
  `age` int(11) NULL DEFAULT NULL,
  `gender` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `phone` bigint(11) NULL DEFAULT NULL,
  `addr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `creat_time` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_user
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
