<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/16
  Time: 11:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="fun.zengxp.pojo.News" %>
<%@ page import="java.util.List" %>

<%
    // 获取请求参数中的 page 和 pageSize，如果没有提供则使用默认值
    String newPageParam = request.getParameter("page");
    String newPageSizeParam = request.getParameter("pageSize");

    int newsPage = 1;
    int newsPageSize = 10;

    if (newPageParam != null) {
        try {
            newsPage = Integer.parseInt(newPageParam);
        } catch (NumberFormatException e) {
            newsPage = 1; // 默认值
        }
    }

    if (newPageSizeParam != null) {
        try {
            newsPageSize = Integer.parseInt(newPageSizeParam);
        } catch (NumberFormatException e) {
            newsPageSize = 10; // 默认值
        }
    }
    List<News> newsList = (List<News>) request.getAttribute("newsList");
    Integer totalNewsRecordsObj = (Integer) request.getAttribute("totalNewsRecords");
    int totalNewsRecords = totalNewsRecordsObj != null ? totalNewsRecordsObj : 0;

    // 计算总页数
    int totalNewsPages = (int) Math.ceil((double) totalNewsRecords / newsPageSize);
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新闻</title>
    <link rel="stylesheet" href="/css/main.css">
</head>
<body style="font-family: 'Arial', sans-serif; color: #ffffff; line-height: 1.6; margin: 0; padding: 0;">
<!-- 页面顶部的动态图片 -->
<div style="text-align: center; padding: 20px;">
    <img src="/img/news.jpg" alt="Dynamic Background" style="width: 100%; max-height: 300px; object-fit: cover; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
</div>

<!-- 新闻标题 -->
<div style="text-align: center; padding: 20px;">
    <h1 style="font-size: 24px; font-weight: bold; margin-bottom: 10px;">最新新闻</h1>
    <hr style="border: 1px solid #333; width: 50%; margin: 0 auto;">
</div>

<!-- 新闻内容 -->
<div style=" padding: 20px; border-radius: 8px; margin: 20px; ">
    <h2 style="font-size: 20px; font-weight: bold; margin-bottom: 10px; ">2025年4月14日 - 新闻标题</h2>
    <p style=" opacity: 0.8; text-align: justify;">
        这是一篇最新的新闻报道。我们很高兴地宣布，我们的网站已经正式上线。我们致力于提供最新的技术解决方案，帮助企业和个人实现数字化转型。我们的团队由一群充满激情的技术专家组成，他们不断探索新技术，以确保我们的客户始终处于行业前沿。
    </p>
    <p style="opacity: 0.8; text-align: justify;">
        我们将在未来几周内陆续推出更多功能和服务，敬请期待！如果您有任何问题或建议，请随时联系我们。
    </p>
</div>

<!-- 新闻列表 -->
<div class="news-list">
    <h2>新闻列表</h2>
    <ul>
        <%
            if (newsList != null && !newsList.isEmpty()) {
                for (News news : newsList) {
        %>
        <li>
            <a href="../newsDetail?newsId=<%=news.getNewsId()%>&page=<%=newsPage%>&pageSize=<%=newsPageSize %>"><%=news.getNewsTitle()%><span>发布者：<%=news.getNewsAuthor()%></span>&nbsp;<span>发布时间：<%=news.getNewsTime()%></span>
            </a>
        </li>
        <%
            }
        } else {
        %>
        <li>
            目前没有数据
        </li>
        <%
            }
        %>
    </ul>
    <!-- 分页导航 -->
    <div style="margin-top: 20px;">
        <a href="news?num=4&page=<%= newsPage > 1 ? newsPage - 1 : 1 %>&pageSize=<%= newsPageSize %>">上一页</a>
        <span>第 <%= newsPage %> 页 / 共 <%= totalNewsPages %> 页</span>
        <a href="news?num=4&page=<%= newsPage < totalNewsPages ? newsPage + 1 : totalNewsPages %>&pageSize=<%= newsPageSize %>">下一页</a>

        <!-- 设置 pageSize 的下拉菜单 -->
        <form action="news" method="get" style="display: inline;">
            <input type="hidden" name="num" value="2">
            <input type="hidden" name="page" value="<%= newsPage %>">
            <select name="pageSize" onchange="this.form.submit()">
                <option value="5" <%= newsPageSize == 5 ? "selected" : "" %>>5</option>
                <option value="10" <%= newsPageSize == 10 ? "selected" : "" %>>10</option>
                <option value="20" <%= newsPageSize == 20 ? "selected" : "" %>>20</option>
            </select>
        </form>
    </div>
</div>
</body>
</html>
