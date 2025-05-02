package fun.zengxp;

import fun.zengxp.pojo.Admin;
import fun.zengxp.service.AdminService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;


import static fun.zengxp.NewsServlet.getPageAndPageSize;

@WebServlet("/admins")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        Admin admin = (Admin) req.getSession().getAttribute("admin");
        if (admin == null) {
            resp.sendRedirect("admin/index.jsp?num=1");
            return;
        }
        String choose = req.getParameter("choose");
        if (choose == null)
            choose = "selectAllAdmin";
        // 获取请求参数中的 page 和 pageSize，如果没有提供则使用默认值
        int[] pageAndPageSize = getPageAndPageSize(req);
        int page = pageAndPageSize[0];
        int pageSize = pageAndPageSize[1];
        switch (choose) {
            case "selectAllAdmin":

                // 调用服务层方法获取管理员列表
                AdminService adminService = new AdminService();
                List<Admin> adminList = adminService.getAdmins(page, pageSize);

                // 将管理员列表设置到请求属性中
                req.setAttribute("adminList", adminList);

                // 计算总记录数
                int totalRecords = new AdminService().getTotalAdmins();
                req.setAttribute("totalAdminsRecords", totalRecords);

                // 转发到 admins.jsp 页面
                req.getRequestDispatcher("admin/index.jsp?num=2").forward(req, resp);
                break;
            case "deleteAdmin":
                if (admin == null || admin.getAdminType() != 0) {
                    resp.getWriter().println("<script>\n" +
                            "    alert(\"您没有访问权限！！！\");\n" +
                            "    location.href=\"admin/index.jsp?num=1\";\n" +
                            "</script>");
                } else {
                    int adminId = Integer.parseInt(req.getParameter("adminId"));
                    deleteAdmin(adminId);
                    PrintWriter writer = resp.getWriter();
                    writer.print("<script>\n" +
                            "    location.href=\"../admins?choose=selectAllAdmin\";\n" +
                            "</script>");
                }
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setContentType("text/html;charset=utf-8");
        Admin admin = (Admin) req.getSession().getAttribute("admin");
        if (admin == null) {
            resp.getWriter().println("<script>\n" +
                    "    alert(\"您没有访问权限！！！\");\n" +
                    "    location.href=\"admin/index.jsp?num=1\";\n" +
                    "</script>");
        } else {
            String choose = req.getParameter("choose");
            switch (choose) {
                case "addAdmin":
                    if (admin.getAdminType() != 0) {
                        resp.getWriter().println("<script>\n" +
                                "    alert(\"您没有访问权限！！！\");\n" +
                                "    location.href=\"admin/index.jsp?num=1\";\n" +
                                "</script>");
                    }else {
                        Admin admin1 = new Admin();
                        admin1.setAdminName(req.getParameter("adminName"));
                        admin1.setAdminPwdHash(req.getParameter("adminPwd"));
                        admin1.setAdminType(1);
                        addAdmin(admin1);
                        PrintWriter writer = resp.getWriter();
                        writer.print("<script>\n" +
                                "    location.href=\"../admins?choose=selectAllAdmin\";\n" +
                                "</script>");
                    }
                    break;
                case "updateAdmin":
                    Admin admin2 = new Admin();
                    PrintWriter writer = resp.getWriter();
                    admin2.setAdminId(Integer.parseInt(req.getParameter("adminId")));
                    if (admin.getAdminType() == 0 || admin.getAdminId() == admin2.getAdminId()) {
                        // System.out.println(admin2.getAdminId());
                        admin2.setAdminName(req.getParameter("adminName"));
                        admin2.setAdminPwdHash(req.getParameter("adminPwd"));
                        admin2.setAdminType(Integer.parseInt(req.getParameter("type")));
                        // admin2.setLoginTime(LocalDateTime.parse(req.getParameter("loginTime")));
                        updateAdmin(admin2);

                        writer = resp.getWriter();
                        if (admin.getAdminId() != admin2.getAdminId()) {
                            writer.print("<script>\n" +
                                    "    location.href=\"../admins?choose=selectAllAdmin\";\n" +
                                    "</script>");
                            writer.close();
                        } else {
                            writer.print("<script>\n" +
                                    "    alert(\"当前用户信息已更改，请重新登录！！！\");\n" +
                                    "</script>");
                            req.getSession().removeAttribute("admin");
                            writer.print("<script>\n" +
                                    "    location.href=\"../login\";\n" +
                                    "</script>");
                        }
                    }
                    break;
            }
        }
    }

    public int addAdmin(Admin admin) {
        AdminService adminService = new AdminService();
        return adminService.addAdmin(admin);
    }

    public int updateAdmin(Admin admin) {
        AdminService adminService = new AdminService();
        return adminService.updateAdmin(admin);
    }

    public int deleteAdmin(int adminId) {
        AdminService adminService = new AdminService();
        return adminService.deleteAdmin(adminId);
    }

}