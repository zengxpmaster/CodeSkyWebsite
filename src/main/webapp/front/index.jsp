<%--
  Created by IntelliJ IDEA.
  User: 15779127661
  Date: 2025/4/14
  Time: 上午9:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <link rel="stylesheet" href="/css/main.css">
</head>
<body  style=" font-family: 'Arial', sans-serif; background-color: #FED2E2; line-height: 1.6; margin: 0; padding: 0;">


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
<!-- 头部导航 -->
<header>
    <div class="logo-container">
        <img src="/img/logo.png" alt="Logo">

    </div>
    <nav>
        <a href="/front/index.jsp?num=1">首页</a>
        <a href="/front/index.jsp?num=2">企业简介</a>
        <a href="/front/index.jsp?num=3">公告</a>
        <a href="../news?num=4?page=<%=currentPage%>&pageSize=<%=pageSize%>">新闻</a>
        <a href="/front/index.jsp?num=5">产品介绍</a>
        <a href="/front/index.jsp?num=6">联系我们</a>
    </nav>
</header>

<%
    String n = request.getParameter("num");
    int num = 1;
    if (n == null || n.equals("")) {
        num = 1;
    } else {
        try {
            num = Integer.parseInt(n);
        } catch (NumberFormatException e) {
            num = 1; // 如果参数不是数字，设置为默认值
        }
    }

    switch (num) {
        case 1:
%>
<!-- 主体内容 -->
<main>
    <h1>Welcome to Our Website</h1>
    <p>Explore the latest technologies and innovations.</p>
    <%@include file="center.jsp"%>
</main>
<%
        break;
    case 2:
%>
<main>
    <h1>About Us</h1>
    <p>Learn more about our mission and values.</p>
    <%@include file="about.jsp"%>
</main>
<%
        break;
    case 3:
%>
<main>
    <h1>Announcements</h1>
    <p>Stay updated with our latest announcements.</p>
    <%@include file="notice.jsp"%>
</main>
<%
        break;
    case 4:
%>
<main>
    <h1>News</h1>
    <p>Read the latest news and updates.</p>
    <%@include file="news.jsp"%>
</main>
<%
        break;
    case 5:
%>
<main>
    <h1>Products</h1>
    <p>Discover our range of products.</p>
    <%@include file="product.jsp"%>
</main>
<%
        break;
    case 6:
%>
<main>
    <h1>Contact Us</h1>
    <p>Get in touch with our team.</p>
    <%@include file="contact.jsp"%>
</main>
<%
            break;
    }
%>

<!-- 页脚 -->
<footer>
    <p>&copy; 2025 Your Company. All rights reserved.</p>
    <%@include file="foot.jsp"%>
</footer>


<!-- 创建一个容器用于显示图片 -->

<img id="background-image" src="" alt="Background Image" />
<script>
    const apiUrl = "https://www.loliapi.com/acg/pc/?type=url";

    function getLoliAcg() {
        // 检查 localStorage 中是否已经存在背景图片 URL
        const imageUrl = localStorage.getItem('imageUrl');
        if (imageUrl) {
            // 如果存在，则直接使用存储的 URL
            document.getElementById('background-image').src = imageUrl;
        } else {
            // 如果不存在，则发送 fetch 请求获取新的 URL
            fetch(apiUrl)
                .then(response => response.text())
                .then(data => {
                    // 将获取到的 URL 存储到 localStorage
                    localStorage.setItem('imageUrl', data);
                    // 设置背景图片
                    document.getElementById('background-image').src = `${data}`;
                })
                .catch(error => console.error('Error:', error));
        }
    }

    // 调用函数以获取并显示图片
    getLoliAcg();

</script>


</body>
</html>