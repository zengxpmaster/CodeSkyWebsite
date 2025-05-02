package fun.zengxp.pojo;

import java.time.LocalDateTime;

public class AdminTest  {
    public static void main(String[] args) {
        Admin admin = new Admin();
        admin.setAdminName("admin");
        admin.setAdminPwdHash("123456");
        admin.setAdminId(1);
        admin.setAdminType(1);
        admin.setLoginTime(LocalDateTime.now());

        System.out.println("Admin Name: " + admin.getAdminName());
        System.out.println("Admin Password Hash: " + admin.getAdminPwdHash());
        System.out.println("Admin ID: " + admin.getAdminId());
        System.out.println("Admin Type: " + admin.getAdminType());
        System.out.println("Login Time: " + admin.getLoginTime());
    }
}
