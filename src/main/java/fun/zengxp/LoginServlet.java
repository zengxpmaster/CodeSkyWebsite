package fun.zengxp;

import fun.zengxp.pojo.News;
import fun.zengxp.service.AdminService;
import fun.zengxp.pojo.Admin;
import fun.zengxp.service.NewsService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 设置请求和响应的编码
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html;charset=utf-8");
            resp.setCharacterEncoding("UTF-8");

            // 从请求中获取用户名和密码
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            AdminService adminService = new AdminService();
            Admin admin = adminService.login(username, password);
            if (admin != null) {
                // 创建会话保存登录的管理员信息
                req.getSession().setAttribute("admin", admin);
              // 转发
                req.getRequestDispatcher("admin/index.jsp").forward(req, resp);
            } else {
                PrintWriter out = resp.getWriter();
                out.println("<script>");
                out.println("alert('用户名或密码不正确！！！请重新输入！！！');");

                out.println("location.href='admin/login.jsp'");
                out.println("</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("/admin/login.jsp");

        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 处理GET请求，跳转到 admin/login.jsp 页面
        resp.sendRedirect("/admin/login.jsp");
    }


}
