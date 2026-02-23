<%@ page import="fun.zengxp.pojo.Notice" %><%--
  Created by IntelliJ IDEA.
  User: 15779127661
  Date: 2025/5/7
  Time: 上午10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>公告页面</title>
    <link rel="stylesheet" href="/css/main.css">
<style>
    .notice td{
        width: 250px;

        font-size: 20px;
    }
</style>
</head>
<body>
<button><a href="../admin/index.jsp?num=7">新增公告</a></button>
<table border="1" style="text-align: center;" class="notice">
    <tr>
        <td>
            公告标题
        </td>
        <td>
            公告发布时间
        </td>
        <td>
            公告发布人
        </td>
        <td>
            操作
        </td>
    </tr>
    <%
        List<Notice> noticeList = (List<Notice>) request.getAttribute("noticeList");
        if (noticeList != null && noticeList.size()!=0) {
            for (Notice notice : noticeList) {
    %>

    <tr>

        <td> <a href="../notices?choose=selectById&noticeId=<%=notice.getNoticeId()%>"><%=notice.getNoticeTitle()%></a></td>
        <td><%=notice.getNoticeTime()%></td>
        <td><%=notice.getAdminName()%></td>

        <td>
            <a href="/notices?choose=selectByUpdateId&noticeId=<%=notice.getNoticeId()%>">修改</a>
            <a href="/notices?choose=deleteNotice&noticeId=<%=notice.getNoticeId()%>">删除</a>
        </td>
    </tr>
    <%
        }
    }else {
    %>
    <tr>
        <td colspan="4"> 目前没有任何公告信息 </td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>