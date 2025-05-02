package fun.zengxp;

import fun.zengxp.pojo.News;
import fun.zengxp.service.NewsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/newsDetail")
public class NewsDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        NewsService newsService = new NewsService();
        try {
            int newsId = Integer.parseInt(req.getParameter("newsId"));
            if (newsId > 0) {
                News news = newsService.getNewsById(newsId);
                // System.out.println("news:" + news.getNewsContent());
                if (news != null) {
                    req.setAttribute("newsDetail", news);
                    req.getRequestDispatcher("/front/newsDetail.jsp").forward(req, resp);
                }
            } else {
                News news = newsService.getNewsLatest();
                if (news != null) {
                    req.setAttribute("newsDetail", news);
                    req.getRequestDispatcher("/front/newsDetail.jsp").forward(req, resp);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}
