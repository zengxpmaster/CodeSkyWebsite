/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50730
Source Host           : localhost:3306
Source Database       : website

Target Server Type    : MYSQL
Target Server Version : 50730
File Encoding         : 65001

Date: 2025-05-07 10:23:54
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for news
-- ----------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `newsId` int(11) NOT NULL AUTO_INCREMENT,
  `newsTitle` text,
  `newsContent` longtext,
  `newsAuthor` varchar(255) DEFAULT NULL,
  `newsTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of news
-- ----------------------------
INSERT INTO `news` VALUES ('1', 'test测试', '<h4>此条新闻为测试</h4><hr><p>这是一个段落 </p><b>加粗文本</b><br><br>\r\n<i>斜体文本</i><br><br>\r\n<code>电脑自动输出</code><br><br>\r\n这是 <sub> 下标</sub> 和 <sup> 上标</sup>', 'test', '2025-04-24 21:47:04');
INSERT INTO `news` VALUES ('5', 'test测试', '<h4>此条新闻为测试</h4><hr><p>这是一个段落 </p><b>加粗文本</b><br><br>\r\n<i>斜体文本</i><br><br>\r\n<code>电脑自动输出</code><br><br>\r\n这是 <sub> 下标</sub> 和 <sup> 上标</sup>', 'test', '2025-04-24 21:47:04');
INSERT INTO `news` VALUES ('10', 'qeeq', 'saewase', 'root', '2025-05-02 23:28:00');
INSERT INTO `news` VALUES ('12', 'test', '001', 'root', '2025-05-02 23:38:00');
INSERT INTO `news` VALUES ('13', 'wan', 'wqn', 'root', '2025-05-02 23:39:00');
INSERT INTO `news` VALUES ('18', '12313144', '41141141', 'root', '2025-05-03 00:33:00');
