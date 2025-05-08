<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/23
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="/css/main.css">
    <meta charset="UTF-8">
    <style>
        .change-background-btn {
            position: absolute;
            top: 10px;
            left: 10px;
            /*padding: 10px 20px;*/
            /*background-color: rgba(255, 255, 255, 0.9);*/
            /*border: 1px solid #ccc;*/
            /*border-radius: 6px;*/
            /*cursor: move;*/
            user-select: none;
            z-index: 1000;
            text-align: center;
        }

        .change-background-btn img {
            pointer-events: auto; /* 确保点击事件仍有效 */
            user-select: none;
            -webkit-user-drag: none; /* 禁止 Chrome 拖拽图片 */
        }
        .index-container {
            background-color: rgba(255, 255, 255, 0.1); /* 调整背景颜色透明度 */
            backdrop-filter: blur(2px);
            padding: 2em;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);

        }
        .index-container a{

            margin-bottom: 1em;
            color: #333;
            font-size: 2em;
            font-weight: bold;
            transition: color 0.3s;
            border-bottom: 2px solid transparent;
            text-decoration: none;
        }
    </style>
    <title>引导页</title>
</head>
<body class="login-page">
<div class="index-container">
<a href="/admin/login.jsp">login</a>&nbsp;&nbsp;&nbsp;
<a href="/front/index.jsp">前台</a>
</div>
<!-- 新增：可拖动的更换背景按钮 -->
<div class="change-background-btn" id="changeBackgroundBtn">
    <img src="https://img.zengxpmaster.fun/images/202505071831591.png" width="50px"/>
</div>

<img id="index-background-image" src="" alt="Background Image"/>

<script>
    const apiUrl = "https://www.loliapi.com/acg/pc/?type=url";

    function getLoliAcg() {
        fetch(apiUrl)
            .then(response => response.text())
            .then(data => {
                const imgElement = document.getElementById('index-background-image');
                imgElement.src = data;
            })
            .catch(error => console.error('Error:', error));
    }

    // 调用函数以获取初始背景图片
    getLoliAcg();

    // 拖动功能实现
    const dragElem = document.getElementById("changeBackgroundBtn");
    let offsetX = 0, offsetY = 0;
    let isDragging = false;

    dragElem.addEventListener("mousedown", (e) => {
        isDragging = true;
        offsetX = e.clientX - dragElem.offsetLeft;
        offsetY = e.clientY - dragElem.offsetTop;
        document.body.style.cursor = "default";
    });

    document.addEventListener("mousemove", (e) => {
        if (isDragging) {
            dragElem.style.left = `${e.clientX - offsetX}px`;
            dragElem.style.top = "10px"; // 固定在顶部高度
        }
    });

    document.addEventListener("mouseup", () => {
        isDragging = false;
        document.body.style.cursor = "default";
    });

    // 点击更换背景
    dragElem.addEventListener("click", (e) => {
        e.stopPropagation(); // 防止触发拖动事件
        getLoliAcg();
    });
</script>
</body>
</html>
