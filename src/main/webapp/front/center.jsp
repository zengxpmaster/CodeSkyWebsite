<%--
  Created by IntelliJ IDEA.
  User: zengx
  Date: 2025/4/16
  Time: 11:26
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>科技感页面</title>
    <style>
        /* 轮播图样式 */
        .carousel {
            position: relative;
            width: 100%;
            max-height: 300px;
            overflow: hidden;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            margin: 20px 0;
        }

        .carousel img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 确保图片覆盖整个容器 */
            display: none;
            border-radius: 8px;
        }

        .carousel img.active {
            display: block;
        }

        /* 轮播图控制按钮 */
        .carousel-controls {
            position: absolute;
            bottom: 10px;
            width: 100%;
            text-align: center;
        }

        .carousel-controls button {
            background-color: rgba(255, 255, 255, 0.5);
            border: none;
            border-radius: 50%;
            width: 10px;
            height: 10px;
            margin: 0 5px;
            cursor: pointer;
            outline: none;
        }

        .carousel-controls button.active {
            background-color: #ffffff;
        }
    </style>
</head>
<body style="font-family: 'Arial', sans-serif; background-color: #121212; line-height: 1.6; margin: 0; padding: 0;">
<!-- 页面顶部的轮播图 -->
<div class="carousel">
    <img src="/img/1.gif" style="width: 100%; max-height: 300px;" alt="Slide 1" class="active">
    <img src="/img/4.gif" style="width: 100%; max-height: 300px;" alt="Slide 2">
    <img src="/img/5.gif" style="width: 100%; max-height: 300px;" alt="Slide 3">
    <div class="carousel-controls">
        <button class="active" onclick="changeSlide(0)"></button>
        <button onclick="changeSlide(1)"></button>
        <button onclick="changeSlide(2)"></button>
    </div>
</div>

<!-- 页面内容 -->
<div style="padding: 30px; border-radius: 8px; margin: 20px; ">
    <h1 style=" font-weight: bold; margin-bottom: 20px; text-align: center;">欢迎来到我们的网站</h1>
    <p style="opacity: 0.8; text-align: justify;">
        这是一个充满科技感的页面，展示我们对创新和科技的追求。我们致力于提供最新的技术解决方案，帮助企业和个人实现数字化转型。我们的团队由一群充满激情的技术专家组成，他们不断探索新技术，以确保我们的客户始终处于行业前沿。
    </p>
</div>

<script>
    // 轮播图切换逻辑
    let currentSlide = 0;
    const slides = document.querySelectorAll('.carousel img');
    const controls = document.querySelectorAll('.carousel-controls button');

    function changeSlide(index) {
        slides[currentSlide].classList.remove('active');
        controls[currentSlide].classList.remove('active');
        currentSlide = index;
        slides[currentSlide].classList.add('active');
        controls[currentSlide].classList.add('active');
    }

    // 自动播放轮播图
    let autoPlayInterval = setInterval(nextSlide, 3000); // 每3秒自动切换到下一张图片

    function nextSlide() {
        let nextSlide = (currentSlide + 1) % slides.length;
        changeSlide(nextSlide);
    }

    // 停止自动播放
    function stopAutoPlay() {
        clearInterval(autoPlayInterval);
    }

    // 重新开始自动播放
    function startAutoPlay() {
        autoPlayInterval = setInterval(nextSlide, 2000);
    }

    // 添加鼠标悬停时停止自动播放的功能
    document.querySelector('.carousel').addEventListener('mouseover', stopAutoPlay);
    document.querySelector('.carousel').addEventListener('mouseout', startAutoPlay);

    // 初始化控制按钮
    controls.forEach((button, index) => {
        button.addEventListener('click', () => {
            changeSlide(index);
            stopAutoPlay();
            startAutoPlay();
        });
    });
</script>
</body>
</html>
