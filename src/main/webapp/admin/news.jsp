<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/25
  Time: 14:10
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
    <title>newsEdit</title>
    <link rel="stylesheet" href="/css/main.css">
    <style>

    </style>
</head>
<body>
<a href="#" class="createModal" id="addNews">添加新闻</a>
<div class="news-edit">

<ul >

    <%
        if (newsList != null && !newsList.isEmpty()) {
            for (News news : newsList) {
    %>

    <li>
        <input type="hidden" name="NewsId" value="<%=news.getNewsId()%>">
        <input type="hidden" name="NewsTitle" value="<%=news.getNewsTitle()%>">
        <input type="hidden" name="NewsTime" value="<%=news.getNewsTime()%>">
        <input type="hidden" name="NewsAuthor"
               value="<%=(news.getNewsAuthor() == null || news.getNewsAuthor().isEmpty()) ? (user != null ? user.getAdminName() : "未知作者") : news.getNewsAuthor()%>">
        <input type="hidden" name="NewsContent" value="<%=news.getNewsContent()%>">

        <span class="NewsTitle"><%=news.getNewsTitle()%></span>&nbsp;&nbsp;&nbsp;
        <span class="NewsAuthor">发布者：<%=news.getNewsAuthor()%></span>&nbsp;
        <span class="NewsTime">发布时间：<%=news.getNewsTime()%></span>

        <a id="viewNewsDetail" href="newsDetail?newsId=<%=news.getNewsId()%>">查看</a>
        <a href="#" class="createModal">编辑</a>
        <a id="DelNews" href="newsEdit?choose=deleteNews&newsId=<%=news.getNewsId()%>">删除</a>
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
</div>
<div id="modal" style="display:none;">
    <h3>编辑新闻</h3>
    <form id="modalForm" action="/newsEdit" method="post">
        <input type="hidden" name="newsId" id="modalNewsId">
        <label>标题：<input type="text" name="newsTitle" id="modalTitle"></label><br>
        <label>时间：<input type="datetime-local" name="newsTime" id="modalTime"></label><br>
        <label><input type="hidden" name="newsAuthor" id="modalAuthor"></label><br>
        <label>内容：<textarea name="newsContent" id="modalContent"></textarea></label><br>
        <button type="submit" id="submitModal">保存</button>
        <button type="reset" id="closeModal">关闭</button>
    </form>

</div>
<div id="overlay" style="display:none;"></div>

<script>
    const modal = document.getElementById('modal');
    const overlay = document.getElementById('overlay');
    const closeModal = document.getElementById('closeModal');
    const form = document.getElementById('modalForm');
    const newsIdInput = document.getElementById('modalNewsId');
    const titleInput = document.getElementById('modalTitle');
    const timeInput = document.getElementById('modalTime');
    const authorInput = document.getElementById('modalAuthor');
    const contentInput = document.getElementById('modalContent');

    let isEditMode = true; // 标识是否为编辑模式

    document.querySelectorAll('.createModal').forEach((link) => {
        const newsItem = link.closest('li');
        if (newsItem) {
            // 编辑模式：从 li 中获取数据
            const newsId = newsItem.querySelector('[name="NewsId"]').value;
            const title = newsItem.querySelector('[name="NewsTitle"]').value;
            const time = newsItem.querySelector('[name="NewsTime"]').value;
            const author = newsItem.querySelector('[name="NewsAuthor"]').value;
            const content = newsItem.querySelector('[name="NewsContent"]').value;

            link.addEventListener('click', (e) => {
                e.preventDefault();
                isEditMode = true;

                // 填充表单
                newsIdInput.value = newsId;
                titleInput.value = title;
                timeInput.value = time;
                authorInput.value = author;
                contentInput.value = content;

                // 显示模态框
                modal.style.display = 'block';
                overlay.style.display = 'block';
            });
        } else {
            // 新增模式：清空表单
            link.addEventListener('click', (e) => {
                e.preventDefault();
                isEditMode = false;

                // 清空输入框
                newsIdInput.value = '';
                titleInput.value = '';
                timeInput.value = '';
                authorInput.value = '<%=(user != null ? user.getAdminName() : "未知作者")%>>';
                contentInput.value = '';

                // 显示模态框
                modal.style.display = 'block';
                overlay.style.display = 'block';
            });
        }
    });

    document.getElementById('submitModal').addEventListener('click', () => {

        // location.reload();

    });

    closeModal.addEventListener('click', () => {
        modal.style.display = 'none';
        overlay.style.display = 'none';
    });
    //点击遮罩层关闭模态框
    // overlay.addEventListener('click', () => {
    //     modal.style.display = 'none';
    //     overlay.style.display = 'none';
    // });

</script>

<!-- 分页导航 -->
<div style="margin-top: 20px;">
    <a href="newsEdit?num=4&page=<%= newsPage > 1 ? newsPage - 1 : 1 %>&pageSize=<%= newsPageSize %>">上一页</a>
    <span>第 <%= newsPage %> 页 / 共 <%= totalNewsPages %> 页</span>
    <a href="newsEdit?num=4&page=<%= newsPage < totalNewsPages ? newsPage + 1 : totalNewsPages %>&pageSize=<%= newsPageSize %>">下一页</a>

    <!-- 设置 pageSize 的下拉菜单 -->
    <form action="newsEdit" method="get" style="display: inline;">
        <input type="hidden" name="num" value="2">
        <input type="hidden" name="page" value="<%= newsPage %>">
        <select name="pageSize" onchange="this.form.submit()">
            <option value="5" <%= newsPageSize == 5 ? "selected" : "" %>>5</option>
            <option value="10" <%= newsPageSize == 10 ? "selected" : "" %>>10</option>
            <option value="20" <%= newsPageSize == 20 ? "selected" : "" %>>20</option>
        </select>
    </form>
</div>
</body>
</html>
