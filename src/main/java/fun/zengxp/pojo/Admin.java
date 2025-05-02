package fun.zengxp.pojo;

import java.time.LocalDateTime;

public class Admin {
    private String adminName;
    private String adminPwd;
    private String adminPwdHash; // 存储密码哈希值
    private int adminId;
    private int adminType;
    private LocalDateTime loginTime;

    public Admin() {
    }

    public Admin(String adminName,String adminPwd, int adminId, int adminType, LocalDateTime loginTime) {
        this.adminName = adminName;
        this.adminPwd = adminPwd;
        this.adminId = adminId;
        this.adminType = adminType;
        this.loginTime = loginTime;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPwd() {
        return adminPwd;
    }

    // 添加验证逻辑示例
    public void setAdminPwd(String adminPwd) {
        this.adminPwd = adminPwd;
    }

    public String getAdminPwdHash() {
        return adminPwdHash;
    }

    public void setAdminPwdHash(String adminPwd) {

        if (adminPwd == null || adminPwd.length() < 6) {
            throw new IllegalArgumentException("Password must be at least 6 characters long.");
        }
        this.adminPwdHash = hashPassword(adminPwd);
    }

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public int getAdminType() {
        return adminType;
    }

    public void setAdminType(int adminType) {
        this.adminType = adminType;
    }

    public LocalDateTime getLoginTime() {
        return loginTime;
    }

    public void setLoginTime(LocalDateTime loginTime) {
        this.loginTime = loginTime;
    }

    private String hashPassword(String password) {
        // 使用SHA-256进行哈希处理
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hash) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }


}
