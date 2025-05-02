<%@ page import="fun.zengxp.pojo.Admin" %><%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/25
  Time: 14:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>个人中心</title>
</head>
<body>
<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
%>
<script>
    alert("请先登录再访问后台管理页面！！！");
    location.href = "/admin/login.jsp";
</script>
<%
    }else {
%>

<form method="post" action="/admins?choose=updateAdmin">
    <table style=" border-collapse: collapse;">
        <tr>
            <td >用户编号：</td>
            <td>
                <input type="text" name="adminId" value="<%=admin.getAdminId() %>" readonly>
            </td>
        </tr>
        <tr>
            <td >用户名：</td>
            <td >
                <input type="text" name="adminName" value="<%=admin.getAdminName()%>">
            </td>
        </tr>
        <tr>
            <td >用户密码：</td>
            <td >
                <input type="text" name="adminPwd" value="<%=admin.getAdminPwd()%>">
            </td>
        </tr>
        <tr>
            <td >用户权限：</td>
            <td>
<%--                <input type="text" name="type"  value="<%=admin.getAdminType() == 0 ? "超级管理员" : "普通管理员"); } %>" readonly>--%>
    <select name="type">
        <option value="0" <%=admin.getAdminType()==0?"selected":""%>>超级管理员</option>
        <option value="1" <%=admin.getAdminType()==1?"selected":""%>>普通管理员</option>
    </select>
            </td>
        </tr>
        <tr>
            <td >用户登录时间：</td>
            <td >
                <input type="text" name="loginTime" placeholder="<%=admin.getLoginTime()%>" readonly>

            </td>
        </tr>
        <tr>
            <td colspan="2" >
                <input type="submit" value="修改">
            </td>
        </tr>
    </table>
</form>
<%
        }
    %>

</body>
</html>
