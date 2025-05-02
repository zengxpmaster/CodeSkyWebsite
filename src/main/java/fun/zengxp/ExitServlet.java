package fun.zengxp;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import java.io.PrintWriter;
@WebServlet("/exit")
public class ExitServlet extends HttpServlet {
    @Override
    public void doGet(javax.servlet.http.HttpServletRequest req, javax.servlet.http.HttpServletResponse resp) throws javax.servlet.ServletException, java.io.IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html;charset=utf-8");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter writer = resp.getWriter();
        req.getSession().removeAttribute("admin");
        writer.print("<script>\n" +
                "    alert(\"退出成功！！！\");\n" +

                "    location.href=\"../login\";\n" +
                "</script>");

    }
}
