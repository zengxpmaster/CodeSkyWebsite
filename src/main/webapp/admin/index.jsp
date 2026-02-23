<%@ page import="fun.zengxp.pojo.Admin" %>
<%@ page import="java.time.LocalDateTime" %>
<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/23
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/css/main.css">
</head>
<body class="admin-page">
<%
    Admin user = (Admin) session.getAttribute("admin");
    if (user == null) {
%>
<script>
    alert("请先登录再访问后台管理页面！！！");
    location.href = "/admin/login.jsp";
</script>
<%
    }
%>

<h1>天马行空后台页面，欢迎您，<%
    if (user != null) {
        out.print(user.getAdminName());
    } else {
        out.print("未知用户");
    }

%>
    <a href="/exit">退出登录</a>&nbsp;&nbsp;<a href="/front/index.jsp?num=1">前台</a></h1>

<div class="admin-nav" style="width: 150px;float: left">
    <table>
        <tr>
            <td><a href="../admin/index.jsp?num=1">个人中心</a></td>
        </tr>
        <tr>
            <td>
                <%
                    // 获取 currentPage 和 pageSize 参数，并设置默认值
                    String pageParam = request.getParameter("page");
                    String pageSizeParam = request.getParameter("pageSize");

                    int currentPage = 1; // 重命名变量为 currentPage
                    int pageSize = 10;

                    if (pageParam != null) {
                        try {
                            currentPage = Integer.parseInt(pageParam);
                        } catch (NumberFormatException e) {
                            currentPage = 1; // 默认值
                        }
                    }

                    if (pageSizeParam != null) {
                        try {
                            pageSize = Integer.parseInt(pageSizeParam);
                        } catch (NumberFormatException e) {
                            pageSize = 10; // 默认值
                        }
                    }
                %>
                <a href="../admins?num=2&page=<%= currentPage %>&pageSize=<%= pageSize %>">管理员管理</a>
            </td>
        </tr>
        <tr>
            <td><a href="../notices?choose=selectAllNotice">公告管理</a></td>
        </tr>
        <tr>
            <td><a href="../newsEdit?num=4&page=<%= currentPage %>&pageSize=<%= pageSize %>">新闻管理</a></td>
        </tr>
    </table>
</div>
<div style="float: left">
    <%
        String num = request.getParameter("num");
        int n = 1;
        if (num != null) {
            n = Integer.parseInt(num);
        }
        switch (n) {
            case 1:
    %>
    <%@include file="profile.jsp" %>
    <%
            break;
        case 2:
    %>
    <%@include file="admins.jsp" %>
    <%
            break;


        case 4:
    %>
    <%@include file="news.jsp" %>
    <%
            break;
        case 3:
    %>
    <%@include file="notice.jsp" %>
    <%
            break;
        case 7:
    %>
    <%@include file="addNotice.jsp" %>
    <%
            break;
        case 5:
    %>
    <%@include file="showNotice.jsp" %>
    <%
            break;
        case 6:
    %>
    <%@include file="updateNotice.jsp" %>
    <%
                break;
        }
    %>


</div>
</body>
<script>
    document.addEventListener("keydown", function (e) {
        // 判断按键是否为 Backspace (keyCode == 8)
        if (e.key === "Backspace" || e.keyCode === 8) {
            const activeElement = document.activeElement;
            if (activeElement.hasAttribute('data-prevent-backspace')) {
                e.preventDefault();
            }
        }

    });
</script>
</html>
