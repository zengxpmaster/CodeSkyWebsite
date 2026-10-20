-- ---------------------------------------------------------------
-- CodeSkyWebsite 建库脚本（MySQL 5.7 / 8.0）
-- 用法：mysql -u root -p < sql/schema.sql
--
-- 说明：三张表分别是管理员、新闻、公告。
--       原仓库里只有 Navicat 导出的 admin / news 两份 dump，
--       notice 表缺失（公告模块会直接报错），这里补齐并改为
--       MySQL 8 严格模式可以导入的写法（DATETIME + CURRENT_TIMESTAMP，
--       不再使用 '0000-00-00 00:00:00' 这种零值默认时间）。
-- ---------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS `website`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE `website`;

-- 管理员 ---------------------------------------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `AdminId`       INT          NOT NULL AUTO_INCREMENT COMMENT '主键',
  `AdminName`     VARCHAR(64)  NOT NULL COMMENT '登录名',
  `AdminPwd`      VARCHAR(255) NOT NULL COMMENT '口令的 SHA-256 十六进制摘要（无盐，见 README 已知限制）',
  `AdminType`     INT          NOT NULL DEFAULT 0 COMMENT '0 普通管理员 / 1 超级管理员',
  `LastLoginTime` DATETIME     NULL DEFAULT NULL COMMENT '最近登录时间',
  PRIMARY KEY (`AdminId`),
  UNIQUE KEY `uk_admin_name` (`AdminName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='后台管理员';

-- 新闻 -----------------------------------------------------------
DROP TABLE IF EXISTS `news`;
CREATE TABLE `news` (
  `newsId`      INT          NOT NULL AUTO_INCREMENT COMMENT '主键',
  `newsTitle`   TEXT         NULL COMMENT '标题',
  `newsContent` LONGTEXT     NULL COMMENT '正文（JSP 渲染时按 HTML 处理）',
  `newsAuthor`  VARCHAR(255) NULL COMMENT '作者',
  `newsTime`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
                            ON UPDATE CURRENT_TIMESTAMP COMMENT '发布时间',
  PRIMARY KEY (`newsId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='新闻';

-- 公告 -----------------------------------------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice` (
  `noticeId`      INT          NOT NULL AUTO_INCREMENT COMMENT '主键',
  `noticeTitle`   VARCHAR(255) NULL COMMENT '标题',
  `noticeContent` LONGTEXT     NULL COMMENT '正文',
  `noticeTime`    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
                               ON UPDATE CURRENT_TIMESTAMP COMMENT '发布时间',
  `adminName`     VARCHAR(255) NULL COMMENT '发布人（登录名）',
  PRIMARY KEY (`noticeId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='公告';
