<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/23
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="fun.zengxp.pojo.Admin" %>
<%@ page import="java.util.List" %>
<%
    // 获取请求参数中的 page 和 pageSize，如果没有提供则使用默认值
    String adminPageParam = request.getParameter("page");
    String adminPageSizeParam = request.getParameter("pageSize");

    int adminsPage = 1;
    int adminsPageSize = 10;

    if (adminPageParam != null) {
        try {
            adminsPage = Integer.parseInt(adminPageParam);
        } catch (NumberFormatException ignored) {

        }
    }

    if (adminPageSizeParam != null) {
        try {
            adminsPageSize = Integer.parseInt(adminPageSizeParam);
        }catch (NumberFormatException ignored){

        }

    }
    List<Admin> adminList = (List<Admin>) request.getAttribute("adminList");

    Integer totalAdminsRecordsObj = (Integer) request.getAttribute("totalAdminsRecords");
    int totalAdminsRecords = totalAdminsRecordsObj != null ? totalAdminsRecordsObj : 0;

    // 计算总页数
    int totalAdminPages = (int) Math.ceil((double) totalAdminsRecords / adminsPageSize);
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员管理</title>
</head>
<body>
<table border="1">
    <tr>
        <form action="/admins" method="post">
            <td colspan="6">管理员名称：<input name="adminName" type="text">
            管理员密码：<input name="adminPwd" type="password">
            <input name="choose" type="text" value="addAdmin" style="display: none">
            <input type="submit" value="新增"></td>
        </form>
    </tr>
    <tr>
        <td>用户id</td>
        <td>管理员姓名</td>
        <td>管理员密码</td>
        <td>管理员权限</td>
        <td>上次登录时间</td>
        <td>操作</td>
    </tr>
    <%
        if (adminList != null && !adminList.isEmpty()) {
            for (Admin admin1 : adminList) {
    %>
    <form action="/admins" method="post">
        <input name="choose" type="text" value="updateAdmin" style="display: none">
        <tr>
            <td><input type="text" name="adminId" value="<%=admin1.getAdminId()%>" readonly></td>
            <td><input type="text" name="adminName" value="<%=admin1.getAdminName()%>"> </td>
            <td> <input type="text" name="adminPwd" placeholder="******** 已加密"> </td>
            <td>
                <select name="type">
                    <option value="0" <%=admin1.getAdminType()==0?"selected":""%>>超级管理员</option>
                    <option value="1" <%=admin1.getAdminType()==1?"selected":""%>>普通管理员</option>
                </select>
            </td>
            <td><input type="text" name="loginTime" value="<%=admin1.getLoginTime()%>"></td>
            <td>
                <input type="submit" value="修改">
                <a href="admins?choose=deleteAdmin&adminId=<%=admin1.getAdminId()%>">删除</a>
            </td>
        </tr>
    </form>

<%--    <tr>--%>
<%--        <td><%=admin1.getAdminId()%></td>--%>
<%--        <td><%=admin1.getAdminName()%></td>--%>
<%--        <td>******</td> <!-- 隐藏密码 -->--%>
<%--        <td><%=admin1.getAdminType() == 0 ? "超级管理员" : "普通管理员"%></td>--%>
<%--        <td><%=admin1.getLoginTime()%></td>--%>
<%--        <td>操作</td>--%>
<%--    </tr>--%>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6" style="text-align: center; color: red;">目前没有数据</td>
    </tr>
    <%
        }
    %>
</table>

<!-- 分页导航 -->
<div style="margin-top: 20px;">
    <a href="admins?num=2&page=<%= adminsPage > 1 ? adminsPage - 1 : 1 %>&pageSize=<%= adminsPageSize %>">上一页</a>
    <span>第 <%= adminsPage %> 页 / 共 <%= totalAdminPages %> 页</span>
    <a href="admins?num=2&page=<%= adminsPage < totalAdminPages ? adminsPage + 1 : totalAdminPages %>&pageSize=<%= adminsPageSize %>">下一页</a>

    <!-- 设置 pageSize 的下拉菜单 -->
    <form action="admins" method="get" style="display: inline;">
        <input type="hidden" name="num" value="2">
        <input type="hidden" name="page" value="<%= adminsPage %>">
        <select name="pageSize" onchange="this.form.submit()">
            <option value="5" <%= adminsPageSize == 5 ? "selected" : "" %>>5</option>
            <option value="10" <%= adminsPageSize == 10 ? "selected" : "" %>>10</option>
            <option value="20" <%= adminsPageSize == 20 ? "selected" : "" %>>20</option>
        </select>
    </form>
</div>
</body>

</html>
