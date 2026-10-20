-- ---------------------------------------------------------------
-- CodeSkyWebsite 初始数据（演示用，正式部署请改掉口令）
-- 用法：mysql -u root -p < sql/seed.sql
-- ---------------------------------------------------------------

USE `website`;

-- 默认后台账号：root / 123456
-- AdminPwd 存的是 SHA-256("123456") 的十六进制摘要（无盐）。
-- 部署到公网前请务必在「管理员管理」里改掉，或直接删掉这一行。
INSERT INTO `admin` (`AdminId`, `AdminName`, `AdminPwd`, `AdminType`, `LastLoginTime`)
VALUES (1, 'root', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 1, NULL)
ON DUPLICATE KEY UPDATE `AdminName` = VALUES(`AdminName`);

-- 三条演示新闻（首页新闻列表用）
INSERT INTO `news` (`newsTitle`, `newsContent`, `newsAuthor`, `newsTime`) VALUES
  ('公司官网改版上线', '<p>新版官网已完成改版，产品、新闻、公告三个栏目全部迁移。</p>', 'root', '2025-05-01 10:00:00'),
  ('关于国庆假期值班安排的通知', '<p>假期期间技术与客服保留每日值班人员，联系方式见「联系我们」。</p>', 'root', '2025-05-02 09:30:00'),
  ('V2.0 版本发布说明', '<p>后台新增公告管理、管理员分页，前台新增新闻详情页。</p>', 'root', '2025-05-03 16:00:00');

-- 一条演示公告
INSERT INTO `notice` (`noticeTitle`, `noticeContent`, `noticeTime`, `adminName`) VALUES
  ('系统维护通知', '<p>本周日 02:00-04:00 进行数据库维护，期间后台不可用。</p>', '2025-05-03 18:00:00', 'root');
