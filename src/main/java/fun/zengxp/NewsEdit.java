package fun.zengxp;

import fun.zengxp.pojo.News;
import fun.zengxp.service.NewsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static fun.zengxp.NewsServlet.getPageAndPageSize;
@WebServlet("/newsEdit")
public class NewsEdit extends HttpServlet {
    public void doGet(javax.servlet.http.HttpServletRequest req, javax.servlet.http.HttpServletResponse resp) throws javax.servlet.ServletException, java.io.IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        String choose = req.getParameter("choose");
        if (choose == null)
            choose = "selectAllNews";
        switch (choose) {
            case "selectAllNews":
        // 获取请求参数中的 page 和 pageSize，如果没有提供则使用默认值
        int[] pageAndPageSize = getPageAndPageSize(req);
        int page = pageAndPageSize[0];
        int pageSize = pageAndPageSize[1];


        // 调用服务层方法获取管理员列表
        NewsService newsService = new NewsService();
        List<News> newsList = newsService.getNewsList(page, pageSize);

        // 将管理员列表设置到请求属性中
        req.setAttribute("newsList", newsList);

        // 计算总记录数
        int totalRecords = new NewsService().getTotalNews();
        req.setAttribute("totalNewsRecords", totalRecords);

        // 转发到 index.jsp 页面
        req.getRequestDispatcher("admin/index.jsp?num=4").forward(req, resp);
        break;
            case "deleteNews":
                int newsId = Integer.parseInt(req.getParameter("newsId"));
                PrintWriter writer = resp.getWriter();
                if (new NewsService().deleteNews(newsId)) {
                    writer.print("<script>\n" +
                            "alert(\"删除成功！\");\n" +
                            "    location.href=\"../newsEdit?choose=selectAllNews\";\n" +
                            "</script>");
                }
                break;
        }

    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=UTF-8");

        try {
            // 手动获取并封装参数
            // int newsId = Integer.parseInt(req.getParameter("newsId")==null?"0":req.getParameter("newsId"));
            String newsIdStr = req.getParameter("newsId");
            int newsId = 0;
            if (newsIdStr != null && !newsIdStr.trim().isEmpty()) {
                try {
                    newsId = Integer.parseInt(newsIdStr);
                } catch (NumberFormatException e) {
                    // 可选：记录日志或设置默认值
                    newsId = 0; // 默认值
                }
            }
            String newsTitle = req.getParameter("newsTitle");
            String newsContent = req.getParameter("newsContent");
            String newsAuthor = req.getParameter("newsAuthor");
            LocalDateTime newsTime = parseLocalDateTime(req.getParameter("newsTime"));

            News news = new News(newsId, newsTitle, newsContent, newsAuthor, newsTime);

            NewsService newsService = new NewsService();

            if (news.getNewsId() == 0) {
                newsService.addNews(news);
            } else {
                newsService.updateNews(news);
            }

            resp.sendRedirect( "/newsEdit");
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("新闻保存或更新失败", e);
        }
    }
    private LocalDateTime parseLocalDateTime(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            return LocalDateTime.parse(value.trim(), formatter);
        } catch (Exception e) {
            throw new IllegalArgumentException("时间格式错误: " + value, e);
        }
    }


}
