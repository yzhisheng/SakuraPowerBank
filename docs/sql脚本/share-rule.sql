/*
SQLyog Ultimate - MySQL GUI v8.2 
MySQL - 8.0.30 : Database - share-rule
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`share-rule` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `share-rule`;

/*Table structure for table `fee_rule` */

DROP TABLE IF EXISTS `fee_rule`;

CREATE TABLE `fee_rule` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(200) NOT NULL COMMENT '规则名称',
  `rule` text NOT NULL COMMENT '规则代码',
  `description` text COMMENT '规则描述',
  `status` char(1) NOT NULL DEFAULT '1' COMMENT '状态代码，1有效，2关闭',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `del_flag` char(1) NOT NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='费用规则表';

/*Data for the table `fee_rule` */

insert  into `fee_rule`(`id`,`name`,`rule`,`description`,`status`,`create_time`,`create_by`,`update_time`,`update_by`,`del_flag`,`remark`) values (1,'费用规则1.0','//package对应的不一定是真正的目录，可以任意写com.abc，同一个包下的drl文件可以相互访问\r\npackage  com.share.rules\r\n\r\nimport com.share.rules.domain.vo.FeeRuleRequest;\r\n\r\nglobal com.share.rules.domain.vo.FeeRuleResponse feeRuleResponse;\r\n\r\nrule \"前5分钟免费\"\r\n    salience 10          //指定优先级，数值越大优先级越高，不指定的情况下由上到下执行\r\n    no-loop true         //防止陷入死循环\r\n    when\r\n        /*规则条件，到工作内存中查找FeeRuleRequest对象\r\n        里面出来的结果只能是ture或者false\r\n        $rule是绑定变量名，可以任意命名，官方推荐$符号，定义了绑定变量名，可以在then部分操作fact对象*/\r\n        $rule:FeeRuleRequest(durations > 0)\r\n    then\r\n        feeRuleResponse.setFreeDescription(\"前5分钟免费\");\r\n        feeRuleResponse.setTotalAmount(0.0);\r\n        feeRuleResponse.setFreePrice(0.0);\r\n        feeRuleResponse.setExceedPrice(0.0);\r\n        System.out.println(\"前5分钟免费\");\r\nend\r\nrule \"每1小时3元，24小时35\"\r\n    salience 10          //指定优先级，数值越大优先级越高，不指定的情况下由上到下执行\r\n    no-loop true         //防止陷入死循环\r\n    when\r\n        /*规则条件，到工作内存中查找FeeRuleRequest对象\r\n        里面出来的结果只能是ture或者false\r\n        $rule是绑定变量名，可以任意命名，官方推荐$符号，定义了绑定变量名，可以在then部分操作fact对象*/\r\n        $rule:FeeRuleRequest(durations > 5 && (durations - 5) <= 24*60)\r\n    then\r\n        int hour = ($rule.getDurations() - 5)/60;\r\n        double exceedPrice = (hour + 1) * 3.0;\r\n        if(exceedPrice > 35.0) {\r\n            exceedPrice = 35.0;\r\n        }\r\n        feeRuleResponse.setFreeDescription(\"前5分钟免费\");\r\n        feeRuleResponse.setTotalAmount(exceedPrice);\r\n        feeRuleResponse.setFreePrice(0.0);\r\n        feeRuleResponse.setExceedPrice(exceedPrice);\r\n        int minute = $rule.getDurations() - 5;\r\n        feeRuleResponse.setExceedDescription(\"去除免费时长5分钟，计费时长：\"+ minute + \"分钟\");\r\n        System.out.println(\"24小时内费用：\" + exceedPrice + \"元\");\r\nend\r\n\r\nrule \"超24小时99元\"\r\n    salience 10          //指定优先级，数值越大优先级越高，不指定的情况下由上到下执行\r\n    no-loop true         //防止陷入死循环\r\n    when\r\n        /*规则条件，到工作内存中查找FeeRuleRequest对象\r\n        里面出来的结果只能是ture或者false\r\n        $rule是绑定变量名，可以任意命名，官方推荐$符号，定义了绑定变量名，可以在then部分操作fact对象*/\r\n        $rule:FeeRuleRequest((durations - 5) > 24*60)\r\n    then\r\n        feeRuleResponse.setFreeDescription(\"前5分钟免费\");\r\n        feeRuleResponse.setTotalAmount(99.0);\r\n        feeRuleResponse.setFreePrice(0.0);\r\n        feeRuleResponse.setExceedPrice(99.0);\r\n        int minute = $rule.getDurations() - 5;\r\n        feeRuleResponse.setFreeDescription(\"去除免费时长5分钟，计费时长：\"+ minute + \"分钟，超24小时\");\r\n        System.out.println(\"超24小时99元\");\r\nend\r\n','前2分钟免费，每1小时3元，24小时35，超24小时99元','1','2024-10-25 13:48:26',NULL,'2024-11-07 11:28:38',NULL,'0',NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
