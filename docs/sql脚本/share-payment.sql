/*
SQLyog Ultimate - MySQL GUI v8.2 
MySQL - 8.0.30 : Database - share-payment
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`share-payment` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `share-payment`;

/*Table structure for table `payment_info` */

DROP TABLE IF EXISTS `payment_info`;

CREATE TABLE `payment_info` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '编号',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `order_no` varchar(50) NOT NULL DEFAULT '0' COMMENT '订单号',
  `pay_way` tinyint NOT NULL DEFAULT '0' COMMENT '付款方式：1-微信',
  `transaction_id` varchar(50) DEFAULT NULL COMMENT '微信支付订单号',
  `amount` decimal(10,2) DEFAULT NULL COMMENT '支付金额',
  `content` varchar(200) DEFAULT NULL COMMENT '交易内容',
  `payment_status` tinyint DEFAULT NULL COMMENT '支付状态：0-未支付 1-已支付',
  `callback_time` datetime DEFAULT NULL COMMENT '回调时间',
  `callback_content` text COMMENT '回调信息',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='付款信息表';

/*Data for the table `payment_info` */

insert  into `payment_info`(`id`,`user_id`,`order_no`,`pay_way`,`transaction_id`,`amount`,`content`,`payment_status`,`callback_time`,`callback_content`,`create_time`,`create_by`,`update_time`,`update_by`,`del_flag`,`remark`) values (1,3,'7npvbpd5',0,NULL,'3.00','共享充电宝租借',0,NULL,NULL,'2025-01-02 10:19:30',NULL,'2025-01-02 10:19:30',NULL,'0',NULL),(2,3,'0xx3olhp',0,NULL,'3.00','共享充电宝租借',0,NULL,NULL,'2025-01-03 14:10:44',NULL,'2025-01-03 14:10:44',NULL,'0',NULL),(3,3,'gu5dzoib',0,NULL,'3.00','共享充电宝租借',0,NULL,NULL,'2025-02-28 22:36:45',NULL,'2025-02-28 22:36:45',NULL,'0',NULL),(4,3,'8urfmowh',0,'4200002548202503013231390695','3.00','共享充电宝租借',1,'2025-03-01 00:03:39','{\"amount\":{\"currency\":\"CNY\",\"payerCurrency\":\"CNY\",\"payerTotal\":1,\"total\":1},\"appid\":\"wxcc651fcbab275e33\",\"attach\":\"\",\"bankType\":\"OTHERS\",\"mchid\":\"1631833859\",\"outTradeNo\":\"8urfmowh\",\"payer\":{\"openid\":\"odo3j4i6KdS4jVu5667WGokoSrAQ\"},\"promotionDetail\":[],\"successTime\":\"2025-03-01T00:03:35+08:00\",\"tradeState\":\"SUCCESS\",\"tradeStateDesc\":\"支付成功\",\"tradeType\":\"JSAPI\",\"transactionId\":\"4200002548202503013231390695\"}','2025-03-01 00:03:21',NULL,'2025-03-01 00:03:21',NULL,'0',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
