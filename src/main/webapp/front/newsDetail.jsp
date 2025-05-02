<%@ page import="fun.zengxp.pojo.News" %>

<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/26
  Time: 12:22
  To change this template use File | Settings | File Templates.
--%>
<%@include file="head.jsp"%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  News news = (News) request.getAttribute("newsDetail");

  if (news == null) {
%>
<html>
<head>
  <link rel="stylesheet" href="/css/main.css">
  <title>错误</title>
</head>
<body>
<main>
<h1>新闻不存在或加载失败！</h1>
  <a href="/front/index.jsp?num=4">返回</a>
  </main>
</body>
</html>
<%
} else {
%>
<html>
<head>
  <link rel="stylesheet" href="/css/main.css">
  <title><%=news.getNewsTitle()%></title>
</head>
<body>
<img id="background-image" src="" alt="Background Image" />
<main>
<h1><%=news.getNewsTitle()%></h1>
<%=news.getNewsContent()%>
  <a href="javascript:void(0)" onclick="goBack()">返回</a>

</main>
<script>
function goBack() {
    window.history.back();
}

  function getLoliAcg() {
    // 检查 localStorage 中是否已经存在背景图片 URL
    const imageUrl = localStorage.getItem('imageUrl');
    if (imageUrl) {
      // 如果存在，则直接使用存储的 URL
      document.getElementById('background-image').src = imageUrl;
    }

  }
  getLoliAcg();
</script>
  </body>
<%
  }
%>

<footer>
  <p>&copy; 2025 Your Company. All rights reserved.</p>
  <%@include file="foot.jsp"%>
</footer>
</html>
