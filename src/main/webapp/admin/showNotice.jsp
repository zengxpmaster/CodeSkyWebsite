
<%--
  Created by IntelliJ IDEA.
  User: 15779127661
  Date: 2025/5/12
  Time: 上午11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="fun.zengxp.pojo.Notice" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>显示公告</title>
</head>
<body>
<%
    Notice notice = (Notice) request.getAttribute("notice");
%>

<h1 style="text-align: center"><%=notice.getNoticeTitle()%></h1>
<p style="text-align: center">发布人：<%=notice.getAdminName()%>发布时间：<%=notice.getNoticeTime()%></p>
<div>
    <%=notice.getNoticeContent()%>
</div>
</body>
</html>