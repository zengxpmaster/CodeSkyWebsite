package fun.zengxp.service;

import fun.zengxp.pojo.Admin;

import java.sql.SQLException;

public class logintest {
    public static void main(String[] args) throws SQLException {
        AdminService adminService = new AdminService();
        Admin admin = adminService.login("root", "123456");
        System.out.println(admin);
    }
}
