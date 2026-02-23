<%--
  Created by IntelliJ IDEA.
  User: 15779127661
  Date: 2025/5/7
  Time: 上午10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增公告</title>
</head>
<link
        href="https://unpkg.com/@wangeditor/editor@latest/dist/css/style.css"
        rel="stylesheet"
/>
<style>
    #editor—wrapper {
        border: 1px solid #ccc;
        z-index: 100; /* 按需定义 */
    }
    #toolbar-container {
        border-bottom: 1px solid #ccc;
    }
    #editor-container {
        height: 500px;
    }
</style>
<body>
<form method="post" action="/notices">
    <input type="text" name="choose" value="addNotice" style="display: none">
    公告标题：<input name="noticeTitle" type="text">
    <div id="editor—wrapper">
        <div id="toolbar-container"><!-- 工具栏 --></div>
        <div id="editor-container"><!-- 编辑器 --></div>
    </div>
    <textarea id="content" name="noticeContent" style="display: none"></textarea>
    <div>
        <input type="submit" value="发布公告">
    </div>
</form>
<script src="https://unpkg.com/@wangeditor/editor@latest/dist/index.js"></script>
<script>

    const { createEditor, createToolbar } = window.wangEditor

    const editorConfig = {
        placeholder: '编写公告',
        onChange(editor) {
            const html = editor.getHtml()
            console.log('editor content', html)
            //同步到 <textarea>
            document.getElementById("content").value=html;
        },
    }

    const editor = createEditor({
        selector: '#editor-container',
        html: '<p><br></p>',
        config: editorConfig,
        mode: 'default', // or 'simple'
    })

    const toolbarConfig = {}

    const toolbar = createToolbar({
        editor,
        selector: '#toolbar-container',
        config: toolbarConfig,
        mode: 'default', // or 'simple'
    })

</script>
</body>
</html>