package fun.zengxp;


import fun.zengxp.pojo.Admin;
import fun.zengxp.pojo.Notice;
import fun.zengxp.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/notices")
public class NoticeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");
        String choose = req.getParameter("choose");
        switch (choose) {
            case "selectAllNotice":
                List<Notice> noticeList = selectAllNotice();
                req.setAttribute("noticeList", noticeList);
                req.getRequestDispatcher("admin/index.jsp?num=3").forward(req, resp);
                break;
            case "selectById":
                int id =Integer.parseInt(req.getParameter("noticeId"));
                Notice notice = selectById(id);
                req.setAttribute("notice", notice);
                req.getRequestDispatcher("admin/index.jsp?num=5").forward(req, resp);
                break;
            case "selectByUpdateId":
                id =Integer.parseInt(req.getParameter("noticeId"));
                Notice notice1 = selectById(id);
                req.setAttribute("notice1", notice1);
                req.getRequestDispatcher("admin/index.jsp?num=6").forward(req, resp);
                break;
            case "deleteNotice":
                id =Integer.parseInt(req.getParameter("noticeId"));
                deleteNotice(id);
                resp.getWriter().println("   <script>\n" +
                        "        alert(\"删除公告成功！\")\n" +
                        "        location.href=\"../notices?choose=selectAllNotice\"\n" +
                        "    </script>"
                );
                break;
            case "selectAllNoticeFront":
                List<Notice> noticeList1 = selectAllNotice();
                req.setAttribute("noticeList1", noticeList1);
                //转发
                req.getRequestDispatcher("front/index.jsp?num=3").forward(req, resp);
                break;
            case "showNoticeFront":
                int noticeId =Integer.parseInt(req.getParameter("noticeId"));
                Notice notice2 = selectById(noticeId);
                req.setAttribute("notice", notice2);
                req.getRequestDispatcher("front/index.jsp?num=7").forward(req, resp);
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");
        String choose = req.getParameter("choose");
        switch (choose) {
            case "addNotice":
                Notice notice = new Notice();
                notice.setNoticeTitle(req.getParameter("noticeTitle"));
                notice.setNoticeContent(req.getParameter("noticeContent"));
                notice.setNoticeTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                Admin admin = (Admin)req.getSession().getAttribute("admin");
                notice.setAdminName(admin.getAdminName());
                addNotice(notice);
                resp.getWriter().println("   <script>\n" +
                        "        alert(\"发布公告成功！\")\n" +
                        "        location.href=\"../notices?choose=selectAllNotice\"\n" +
                        "    </script>"
                );
                break;
            case "updateNotice":
                int id = Integer.parseInt(req.getParameter("noticeId"));
                Notice notice2 = selectById(id);
                notice2.setNoticeTitle(req.getParameter("noticeTitle"));
                notice2.setNoticeContent(req.getParameter("noticeContent"));
                notice2.setNoticeTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                Admin admin1 = (Admin)req.getSession().getAttribute("admin");
                notice2.setAdminName(admin1.getAdminName());
                updateNotice(notice2);
                resp.getWriter().println("   <script>\n" +
                        "        alert(\"修改公告成功！\")\n" +
                        "        location.href=\"../notices?choose=selectAllNotice\"\n" +
                        "    </script>"
                );
                break;
        }
    }

    public Notice selectById(int id) {
        NoticeService noticeService = new NoticeService();
        return noticeService.selectById(id);
    }
    public int addNotice(Notice notice) {
        NoticeService noticeService = new NoticeService();
        return noticeService.addNotice(notice);
    }
    public int updateNotice(Notice notice) {
        NoticeService noticeService = new NoticeService();
        return noticeService.updateNotice(notice);
    }
    public int deleteNotice(int id) {
        NoticeService noticeService = new NoticeService();
        return noticeService.deleteNotice(id);
    }
    public List<Notice> selectAllNotice() {
        NoticeService noticeService = new NoticeService();
        return noticeService.getNoticeList();
    }
}