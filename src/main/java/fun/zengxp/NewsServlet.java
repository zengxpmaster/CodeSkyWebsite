package fun.zengxp;


import fun.zengxp.pojo.News;
import fun.zengxp.service.NewsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@WebServlet("/news")
public class NewsServlet extends HttpServlet {
    public static int[] getPageAndPageSize(HttpServletRequest req) {
        String pageParam = req.getParameter("page");
        String pageSizeParam = req.getParameter("pageSize");

        int page = 1;
        int pageSize = 10;

        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1; // 默认值
            }
        }

        if (pageSizeParam != null) {
            try {
                pageSize = Integer.parseInt(pageSizeParam);
            } catch (NumberFormatException e) {
                pageSize = 10; // 默认值
            }
        }
        return new int[]{page, pageSize};
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");

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
        req.getRequestDispatcher("front/index.jsp?num=4").forward(req, resp);
    }

}
