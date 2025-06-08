/*
SQLyog Ultimate - MySQL GUI v8.2 
MySQL - 8.0.30 : Database - share-user
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`share-user` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `share-user`;

/*Table structure for table `gen_table` */

DROP TABLE IF EXISTS `gen_table`;

CREATE TABLE `gen_table` (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表';

/*Data for the table `gen_table` */

insert  into `gen_table`(`table_id`,`table_name`,`table_comment`,`sub_table_name`,`sub_table_fk_name`,`class_name`,`tpl_category`,`tpl_web_type`,`package_name`,`module_name`,`business_name`,`function_name`,`function_author`,`gen_type`,`gen_path`,`options`,`create_by`,`create_time`,`update_by`,`update_time`,`remark`) values (7,'user_info','用户表',NULL,NULL,'UserInfo','crud','','com.share.user','user','userInfo','用户','atguigu','0','/',NULL,'admin','2024-10-25 13:53:00','',NULL,NULL),(8,'user_login_log','用户登录记录',NULL,NULL,'UserLoginLog','crud','','com.share.user','user','userLoginLog','用户登录记录','atguigu','0','/',NULL,'admin','2024-10-25 13:53:02','',NULL,NULL);

/*Table structure for table `gen_table_column` */

DROP TABLE IF EXISTS `gen_table_column`;

CREATE TABLE `gen_table_column` (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`)
) ENGINE=InnoDB AUTO_INCREMENT=112 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成业务表字段';

/*Data for the table `gen_table_column` */

insert  into `gen_table_column`(`column_id`,`table_id`,`column_name`,`column_comment`,`column_type`,`java_type`,`java_field`,`is_pk`,`is_increment`,`is_required`,`is_insert`,`is_edit`,`is_list`,`is_query`,`query_type`,`html_type`,`dict_type`,`sort`,`create_by`,`create_time`,`update_by`,`update_time`) values (88,7,'id','主键','bigint(20)','Long','id','1','1',NULL,'1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-10-25 13:53:01','',NULL),(89,7,'wx_open_id','微信openId','varchar(200)','String','wxOpenId','0','0','1','1','1','1','1','EQ','input','',2,'admin','2024-10-25 13:53:01','',NULL),(90,7,'nickname','会员昵称','varchar(200)','String','nickname','0','0',NULL,'1','1','1','1','LIKE','input','',3,'admin','2024-10-25 13:53:01','',NULL),(91,7,'gender','性别','char(1)','String','gender','0','0','1','1','1','1','1','EQ','input','',4,'admin','2024-10-25 13:53:01','',NULL),(92,7,'avatar_url','头像','varchar(200)','String','avatarUrl','0','0',NULL,'1','1','1','1','EQ','input','',5,'admin','2024-10-25 13:53:01','',NULL),(93,7,'phone','电话','char(11)','String','phone','0','0',NULL,'1','1','1','1','EQ','input','',6,'admin','2024-10-25 13:53:01','',NULL),(94,7,'status','1有效，2禁用','char(1)','String','status','0','0',NULL,'1','1','1','1','EQ','radio','',7,'admin','2024-10-25 13:53:01','',NULL),(95,7,'create_time','创建时间','timestamp','Date','createTime','0','0','1','1',NULL,NULL,NULL,'EQ','datetime','',8,'admin','2024-10-25 13:53:01','',NULL),(96,7,'create_by','创建者','varchar(64)','String','createBy','0','0',NULL,'1',NULL,NULL,NULL,'EQ','input','',9,'admin','2024-10-25 13:53:01','',NULL),(97,7,'update_time','更新时间','timestamp','Date','updateTime','0','0','1','1','1',NULL,NULL,'EQ','datetime','',10,'admin','2024-10-25 13:53:01','',NULL),(98,7,'update_by','更新者','varchar(64)','String','updateBy','0','0',NULL,'1','1',NULL,NULL,'EQ','input','',11,'admin','2024-10-25 13:53:01','',NULL),(99,7,'del_flag','删除标志（0代表存在 2代表删除）','char(1)','String','delFlag','0','0','1','1',NULL,NULL,NULL,'EQ','input','',12,'admin','2024-10-25 13:53:01','',NULL),(100,7,'remark','备注','varchar(255)','String','remark','0','0',NULL,'1','1','1',NULL,'EQ','input','',13,'admin','2024-10-25 13:53:01','',NULL),(101,8,'id','访问ID','bigint(20)','Long','id','1','1',NULL,'1',NULL,NULL,NULL,'EQ','input','',1,'admin','2024-10-25 13:53:02','',NULL),(102,8,'user_id','用户id','bigint(20)','Long','userId','0','0',NULL,'1','1','1','1','EQ','input','',2,'admin','2024-10-25 13:53:02','',NULL),(103,8,'ipaddr','登录IP地址','varchar(128)','String','ipaddr','0','0',NULL,'1','1','1','1','EQ','input','',3,'admin','2024-10-25 13:53:02','',NULL),(104,8,'status','登录状态','tinyint(1)','Integer','status','0','0',NULL,'1','1','1','1','EQ','radio','',4,'admin','2024-10-25 13:53:02','',NULL),(105,8,'msg','提示信息','varchar(255)','String','msg','0','0',NULL,'1','1','1','1','EQ','input','',5,'admin','2024-10-25 13:53:02','',NULL),(106,8,'create_time','创建时间','timestamp','Date','createTime','0','0','1','1',NULL,NULL,NULL,'EQ','datetime','',6,'admin','2024-10-25 13:53:02','',NULL),(107,8,'create_by','创建者','varchar(64)','String','createBy','0','0',NULL,'1',NULL,NULL,NULL,'EQ','input','',7,'admin','2024-10-25 13:53:02','',NULL),(108,8,'update_time','更新时间','timestamp','Date','updateTime','0','0','1','1','1',NULL,NULL,'EQ','datetime','',8,'admin','2024-10-25 13:53:02','',NULL),(109,8,'update_by','更新者','varchar(64)','String','updateBy','0','0',NULL,'1','1',NULL,NULL,'EQ','input','',9,'admin','2024-10-25 13:53:02','',NULL),(110,8,'del_flag','删除标志（0代表存在 2代表删除）','char(1)','String','delFlag','0','0','1','1',NULL,NULL,NULL,'EQ','input','',10,'admin','2024-10-25 13:53:02','',NULL),(111,8,'remark','备注','varchar(255)','String','remark','0','0',NULL,'1','1','1',NULL,'EQ','input','',11,'admin','2024-10-25 13:53:03','',NULL);

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `wx_open_id` varchar(200) NOT NULL DEFAULT '' COMMENT '微信openId',
  `nickname` varchar(200) DEFAULT '' COMMENT '会员昵称',
  `gender` char(1) NOT NULL DEFAULT '1' COMMENT '性别',
  `avatar_url` varchar(200) DEFAULT NULL COMMENT '头像',
  `phone` char(11) DEFAULT NULL COMMENT '电话',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后一次登录ip',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后一次登录时间',
  `deposit_status` char(1) DEFAULT '0' COMMENT '押金状态（0：未验证 1：免押金 2：已交押金）',
  `status` char(1) DEFAULT '1' COMMENT '1有效，2禁用',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

/*Data for the table `user_info` */

insert  into `user_info`(`id`,`wx_open_id`,`nickname`,`gender`,`avatar_url`,`phone`,`last_login_ip`,`last_login_time`,`deposit_status`,`status`,`create_time`,`create_by`,`update_time`,`update_by`,`del_flag`,`remark`) values (1,'odo3j4q2KskkbbW-krfE-cAxUnzU','晴天','1','https://thirdwx.qlogo.cn/mmopen/vi_32/hFKeRpRQU4wG…axvke5nueicggowdBricR4pspWbp6dwFtLSCWJKyZGJoQ/132',NULL,'222.212.104.118','2024-11-11 00:00:00','0','1','2024-10-25 10:34:40',NULL,'2024-11-11 11:56:34',NULL,'0',NULL),(2,'odo3j4h1w7CiRcaayhm-TYUEsm5w','1731315409605','1','https://oss.aliyuncs.com/aliyun_id_photo_bucket/default_handsome.jpg',NULL,'113.89.102.94','2024-11-11 00:00:00','0','1','2024-10-11 16:56:49',NULL,'2025-03-07 21:32:38',NULL,'0',NULL),(3,'odo3j4i6KdS4jVu5667WGokoSrAQ','1735781788460','1','https://oss.aliyuncs.com/aliyun_id_photo_bucket/default_handsome.jpg',NULL,'127.0.0.1','2025-01-07 00:00:00','1','1','2024-01-02 09:36:28',NULL,'2025-03-07 21:18:03',NULL,'0',NULL),(4,'','','1',NULL,NULL,NULL,NULL,'0','1','2024-03-07 21:33:15',NULL,'2025-03-07 21:33:25',NULL,'0',NULL),(5,'','','1',NULL,NULL,NULL,NULL,'0','1','2024-10-07 21:33:29',NULL,'2025-03-07 21:34:07',NULL,'0',NULL),(6,'','','1',NULL,NULL,NULL,NULL,'0','1','2024-04-07 21:33:30',NULL,'2025-03-07 21:33:53',NULL,'0',NULL),(7,'','','1',NULL,NULL,NULL,NULL,'0','1','2024-01-07 21:34:19',NULL,'2025-03-07 21:34:41',NULL,'0',NULL),(8,'','','1',NULL,NULL,NULL,NULL,'0','1','2024-03-07 21:34:21',NULL,'2025-03-07 21:34:43',NULL,'0',NULL),(9,'','','1',NULL,NULL,NULL,NULL,'0','1','2024-09-07 21:34:23',NULL,'2025-03-07 21:34:59',NULL,'0',NULL);

/*Table structure for table `user_login_log` */

DROP TABLE IF EXISTS `user_login_log`;

CREATE TABLE `user_login_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_id` bigint DEFAULT '0' COMMENT '用户id',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `status` tinyint(1) DEFAULT '1' COMMENT '登录状态',
  `msg` varchar(255) DEFAULT '' COMMENT '提示信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户登录记录';

/*Data for the table `user_login_log` */

insert  into `user_login_log`(`id`,`user_id`,`ipaddr`,`status`,`msg`,`create_time`,`create_by`,`update_time`,`update_by`,`del_flag`,`remark`) values (1,1,'222.212.104.118',1,'小程序登录','2024-11-11 11:56:34',NULL,'2024-11-11 11:56:34',NULL,'0',NULL),(2,2,'113.89.101.110',1,'小程序登录','2024-11-11 16:56:50',NULL,'2024-11-11 16:56:50',NULL,'0',NULL),(3,2,'113.89.102.94',1,'小程序登录','2024-11-11 16:57:27',NULL,'2024-11-11 16:57:27',NULL,'0',NULL),(4,2,'113.89.101.110',1,'小程序登录','2024-11-11 16:59:54',NULL,'2024-11-11 16:59:54',NULL,'0',NULL),(5,2,'113.89.101.110',1,'小程序登录','2024-11-11 17:00:05',NULL,'2024-11-11 17:00:05',NULL,'0',NULL),(6,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:00:20',NULL,'2024-11-11 17:00:20',NULL,'0',NULL),(7,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:00:54',NULL,'2024-11-11 17:00:54',NULL,'0',NULL),(8,2,'113.89.101.106',1,'小程序登录','2024-11-11 17:01:59',NULL,'2024-11-11 17:01:59',NULL,'0',NULL),(9,2,'113.89.101.106',1,'小程序登录','2024-11-11 17:05:42',NULL,'2024-11-11 17:05:42',NULL,'0',NULL),(10,2,'113.89.101.106',1,'小程序登录','2024-11-11 17:06:06',NULL,'2024-11-11 17:06:06',NULL,'0',NULL),(11,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:07:53',NULL,'2024-11-11 17:07:53',NULL,'0',NULL),(12,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:08:04',NULL,'2024-11-11 17:08:04',NULL,'0',NULL),(13,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:09:37',NULL,'2024-11-11 17:09:37',NULL,'0',NULL),(14,2,'113.89.100.176',1,'小程序登录','2024-11-11 17:28:04',NULL,'2024-11-11 17:28:04',NULL,'0',NULL),(15,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:31:05',NULL,'2024-11-11 17:31:05',NULL,'0',NULL),(16,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:32:16',NULL,'2024-11-11 17:32:16',NULL,'0',NULL),(17,2,'113.89.100.16',1,'小程序登录','2024-11-11 17:34:53',NULL,'2024-11-11 17:34:53',NULL,'0',NULL),(18,2,'113.89.100.16',1,'小程序登录','2024-11-11 17:35:38',NULL,'2024-11-11 17:35:38',NULL,'0',NULL),(19,2,'113.89.103.37',1,'小程序登录','2024-11-11 17:43:13',NULL,'2024-11-11 17:43:13',NULL,'0',NULL),(20,2,'113.89.103.37',1,'小程序登录','2024-11-11 17:44:21',NULL,'2024-11-11 17:44:21',NULL,'0',NULL),(21,2,'113.89.103.37',1,'小程序登录','2024-11-11 17:47:48',NULL,'2024-11-11 17:47:48',NULL,'0',NULL),(22,2,'113.89.103.37',1,'小程序登录','2024-11-11 17:48:16',NULL,'2024-11-11 17:48:16',NULL,'0',NULL),(23,2,'113.89.102.94',1,'小程序登录','2024-11-11 17:50:57',NULL,'2024-11-11 17:50:57',NULL,'0',NULL),(24,2,'113.89.101.82',1,'小程序登录','2024-11-11 17:52:51',NULL,'2024-11-11 17:52:51',NULL,'0',NULL),(25,2,'113.89.101.82',1,'小程序登录','2024-11-11 17:53:26',NULL,'2024-11-11 17:53:26',NULL,'0',NULL),(26,2,'113.89.101.82',1,'小程序登录','2024-11-11 17:59:06',NULL,'2024-11-11 17:59:06',NULL,'0',NULL),(27,2,'113.89.101.82',1,'小程序登录','2024-11-11 17:59:46',NULL,'2024-11-11 17:59:46',NULL,'0',NULL),(28,2,'113.89.101.82',1,'小程序登录','2024-11-11 18:00:31',NULL,'2024-11-11 18:00:31',NULL,'0',NULL),(29,2,'113.89.101.82',1,'小程序登录','2024-11-11 18:00:44',NULL,'2024-11-11 18:00:44',NULL,'0',NULL),(30,2,'113.89.102.94',1,'小程序登录','2024-11-11 18:01:26',NULL,'2024-11-11 18:01:26',NULL,'0',NULL),(31,2,'113.89.102.94',1,'小程序登录','2024-11-11 18:02:13',NULL,'2024-11-11 18:02:13',NULL,'0',NULL),(32,2,'113.89.102.94',1,'小程序登录','2024-11-11 18:02:16',NULL,'2024-11-11 18:02:16',NULL,'0',NULL),(33,2,'113.89.102.94',1,'小程序登录','2024-11-11 18:02:53',NULL,'2024-11-11 18:02:53',NULL,'0',NULL),(34,2,'113.89.103.33',1,'小程序登录','2024-11-11 18:06:39',NULL,'2024-11-11 18:06:39',NULL,'0',NULL),(35,2,'113.89.101.40',1,'小程序登录','2024-11-11 18:13:21',NULL,'2024-11-11 18:13:21',NULL,'0',NULL),(36,2,'113.89.101.40',1,'小程序登录','2024-11-11 18:13:52',NULL,'2024-11-11 18:13:52',NULL,'0',NULL),(37,2,'113.89.101.40',1,'小程序登录','2024-11-11 18:15:49',NULL,'2024-11-11 18:15:49',NULL,'0',NULL),(38,2,'113.89.102.94',1,'小程序登录','2024-11-11 18:21:15',NULL,'2024-11-11 18:21:15',NULL,'0',NULL),(39,2,'113.89.101.48',1,'小程序登录','2024-11-11 18:22:16',NULL,'2024-11-11 18:22:16',NULL,'0',NULL),(40,2,'113.89.101.48',1,'小程序登录','2024-11-11 18:23:57',NULL,'2024-11-11 18:23:57',NULL,'0',NULL),(41,2,'113.89.102.160',1,'小程序登录','2024-11-11 18:33:53',NULL,'2024-11-11 18:33:53',NULL,'0',NULL),(42,2,'113.89.102.160',1,'小程序登录','2024-11-11 18:34:27',NULL,'2024-11-11 18:34:27',NULL,'0',NULL),(43,2,'113.89.102.160',1,'小程序登录','2024-11-11 18:38:11',NULL,'2024-11-11 18:38:11',NULL,'0',NULL),(44,2,'113.89.102.160',1,'小程序登录','2024-11-11 18:39:37',NULL,'2024-11-11 18:39:37',NULL,'0',NULL),(45,2,'113.89.102.160',1,'小程序登录','2024-11-11 18:39:38',NULL,'2024-11-11 18:39:38',NULL,'0',NULL),(46,2,'113.89.103.115',1,'小程序登录','2024-11-11 18:49:03',NULL,'2024-11-11 18:49:03',NULL,'0',NULL),(47,2,'113.89.102.122',1,'小程序登录','2024-11-11 19:04:50',NULL,'2024-11-11 19:04:50',NULL,'0',NULL),(48,2,'113.89.102.122',1,'小程序登录','2024-11-11 19:05:22',NULL,'2024-11-11 19:05:22',NULL,'0',NULL),(49,2,'113.89.102.122',1,'小程序登录','2024-11-11 19:05:57',NULL,'2024-11-11 19:05:57',NULL,'0',NULL),(50,2,'113.89.101.68',1,'小程序登录','2024-11-11 19:31:35',NULL,'2024-11-11 19:31:35',NULL,'0',NULL),(51,2,'113.89.100.225',1,'小程序登录','2024-11-11 19:38:27',NULL,'2024-11-11 19:38:27',NULL,'0',NULL),(52,2,'113.89.100.225',1,'小程序登录','2024-11-11 19:41:56',NULL,'2024-11-11 19:41:56',NULL,'0',NULL),(53,2,'113.89.102.206',1,'小程序登录','2024-11-11 19:43:17',NULL,'2024-11-11 19:43:17',NULL,'0',NULL),(54,2,'113.89.102.206',1,'小程序登录','2024-11-11 19:43:26',NULL,'2024-11-11 19:43:26',NULL,'0',NULL),(55,2,'113.89.102.206',1,'小程序登录','2024-11-11 19:43:44',NULL,'2024-11-11 19:43:44',NULL,'0',NULL),(56,2,'113.89.102.206',1,'小程序登录','2024-11-11 19:44:48',NULL,'2024-11-11 19:44:48',NULL,'0',NULL),(57,2,'113.89.102.206',1,'小程序登录','2024-11-11 19:48:24',NULL,'2024-11-11 19:48:24',NULL,'0',NULL),(58,2,'113.89.102.206',1,'小程序登录','2024-11-11 19:49:03',NULL,'2024-11-11 19:49:03',NULL,'0',NULL),(59,2,'113.89.101.167',1,'小程序登录','2024-11-11 19:55:23',NULL,'2024-11-11 19:55:23',NULL,'0',NULL),(60,2,'113.89.101.167',1,'小程序登录','2024-11-11 19:55:36',NULL,'2024-11-11 19:55:36',NULL,'0',NULL),(61,2,'113.89.101.167',1,'小程序登录','2024-11-11 19:55:59',NULL,'2024-11-11 19:55:59',NULL,'0',NULL),(62,2,'113.89.101.167',1,'小程序登录','2024-11-11 19:57:00',NULL,'2024-11-11 19:57:00',NULL,'0',NULL),(63,2,'113.89.102.19',1,'小程序登录','2024-11-11 20:14:31',NULL,'2024-11-11 20:14:31',NULL,'0',NULL),(64,2,'113.89.102.19',1,'小程序登录','2024-11-11 20:14:54',NULL,'2024-11-11 20:14:54',NULL,'0',NULL),(65,2,'113.89.102.94',1,'小程序登录','2024-11-11 20:16:08',NULL,'2024-11-11 20:16:08',NULL,'0',NULL),(66,2,'113.89.102.94',1,'小程序登录','2024-11-11 20:16:38',NULL,'2024-11-11 20:16:38',NULL,'0',NULL),(67,2,'113.89.102.94',1,'小程序登录','2024-11-11 20:17:16',NULL,'2024-11-11 20:17:16',NULL,'0',NULL),(68,2,'113.89.102.94',1,'小程序登录','2024-11-11 20:17:28',NULL,'2024-11-11 20:17:28',NULL,'0',NULL),(69,3,'127.0.0.1',1,'小程序登录','2025-01-02 09:36:31',NULL,'2025-01-02 09:36:31',NULL,'0',NULL),(70,3,'127.0.0.1',1,'小程序登录','2025-01-02 09:36:32',NULL,'2025-01-02 09:36:32',NULL,'0',NULL),(71,3,'127.0.0.1',1,'小程序登录','2025-01-02 13:59:25',NULL,'2025-01-02 13:59:25',NULL,'0',NULL),(72,3,'127.0.0.1',1,'小程序登录','2025-01-03 09:16:21',NULL,'2025-01-03 09:16:21',NULL,'0',NULL),(73,3,'127.0.0.1',1,'小程序登录','2025-01-03 14:02:29',NULL,'2025-01-03 14:02:29',NULL,'0',NULL),(74,3,'127.0.0.1',1,'小程序登录','2025-01-03 14:52:08',NULL,'2025-01-03 14:52:08',NULL,'0',NULL),(75,3,'127.0.0.1',1,'小程序登录','2025-01-03 15:46:26',NULL,'2025-01-03 15:46:26',NULL,'0',NULL),(76,3,'127.0.0.1',1,'小程序登录','2025-01-06 14:00:16',NULL,'2025-01-06 14:00:16',NULL,'0',NULL),(77,3,'127.0.0.1',1,'小程序登录','2025-01-06 14:01:50',NULL,'2025-01-06 14:01:50',NULL,'0',NULL),(78,3,'127.0.0.1',1,'小程序登录','2025-01-06 14:20:08',NULL,'2025-01-06 14:20:08',NULL,'0',NULL),(79,3,'127.0.0.1',1,'小程序登录','2025-01-07 09:28:17',NULL,'2025-01-07 09:28:17',NULL,'0',NULL),(80,3,'127.0.0.1',1,'小程序登录','2025-01-07 09:29:51',NULL,'2025-01-07 09:29:51',NULL,'0',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
