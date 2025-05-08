<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/23
  Time: 10:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/main.css">
    <meta charset="UTF-8">
    <title>Login</title>
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

    </style>
</head>
<body class="login-page">
<div class="login-container">
    <h2>Login</h2>
    <form action="/login" method="post">
        <label for="username">🤵Username:</label>
        <input type="text" id="username" name="username" required placeholder="Enter your username"><br><br>

        <label for="password">🔒 Password:</label>
        <input type="password" id="password" name="password" required placeholder="Enter your password"><br><br>

        <input class="submitBt" type="submit" value="Login">
    </form>
</div>

<!-- 新增：可拖动的更换背景按钮 -->
<div class="change-background-btn" id="changeBackgroundBtn">
    <img src="https://img.zengxpmaster.fun/images/202505071831591.png" width="50px"/>
</div>

<img id="login-background-image" src="" alt="Background Image"/>

<script>
    const apiUrl = "https://www.loliapi.com/acg/pc/?type=url";

    function getLoliAcg() {
        fetch(apiUrl)
            .then(response => response.text())
            .then(data => {
                const imgElement = document.getElementById('login-background-image');
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
