package fun.zengxp.service;


import fun.zengxp.Util.DBConnection;
import fun.zengxp.pojo.Admin;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


public class AdminService {
    public static String getUserHashPwdById(int adminId) {
        Connection conn = DBConnection.getConn();
        String sql = "select AdminPwd from admin where adminId=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, adminId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String password = rs.getString(1);
                return password;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return "";
    }

    public Admin login(String adminName, String adminPwd) {
        String sql = "select * from admin where adminName=?";
        Connection conn = DBConnection.getConn();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, adminName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString(3);

                if (verifyPassword(adminPwd, storedHashedPassword)) {
                    Admin admin = new Admin();
                    admin.setAdminId(rs.getInt(1));
                    admin.setAdminName(rs.getString(2));
                    admin.setAdminPwd(adminPwd);
                    admin.setAdminType(rs.getInt(4));
                    String loginTimeStr = rs.getString(5);
                    LocalDateTime loginTime = null;
                    if (loginTimeStr != null && !loginTimeStr.isEmpty()) {
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                        loginTime = LocalDateTime.parse(loginTimeStr, formatter);
                    } else {
                        // 如果数据库中的时间字段为空，可以设置一个默认值或保持为 null
                        loginTime = LocalDateTime.now();
                    }
                    String updateTimeSql = "UPDATE admin SET LastLoginTime = ? WHERE adminName = ?";
                    try (PreparedStatement updatePs = conn.prepareStatement(updateTimeSql)) {
                        updatePs.setString(1, LocalDateTime.now().toString());
                        updatePs.setString(2, adminName);
                        updatePs.executeUpdate();
                    }
                    admin.setLoginTime(loginTime);

                    return admin;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private boolean verifyPassword(String password, String storedHash) {
        String hashedPassword = hashPassword(password);
        return hashedPassword.equals(storedHash);
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("哈希算法不可用", e);
        }
    }

    public List<Admin> getAdmins(int page, int pageSize) {
        Connection conn = DBConnection.getConn();
        String sql = "select * from admin order by adminId LIMIT ?,?";
        List<Admin> list = new ArrayList<Admin>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Admin admin = new Admin();
                admin.setAdminId(rs.getInt(1));
                admin.setAdminName(rs.getString(2));
                admin.setAdminPwd(rs.getString(3));
                admin.setAdminType(rs.getInt(4));
                String loginTimeStr = rs.getString(5);
                LocalDateTime loginTime = null;
                if (loginTimeStr != null && !loginTimeStr.isEmpty()) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                    loginTime = LocalDateTime.parse(loginTimeStr, formatter);
                } else {
                    // 如果数据库中的时间字段为空，可以设置一个默认值或保持为 null
                    loginTime = null;
                }
                admin.setLoginTime(loginTime);
                list.add(admin);
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }
    public int getTotalAdmins() {
        Connection conn = DBConnection.getConn();
        String sql = "SELECT COUNT(*) FROM admin";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
    //新增管理员
    public int addAdmin(Admin admin) {
        Connection conn = DBConnection.getConn();
        String sql = "insert into admin(adminname,adminpwd,AdminType) values(?,?,?)";
        int num = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, admin.getAdminName());
            ps.setString(2, admin.getAdminPwdHash());
            ps.setInt(3, admin.getAdminType());
            num = ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return num;
    }

    //修改管理员
    public int updateAdmin(Admin admin) {
        Connection conn = DBConnection.getConn();
        String sql = "update admin set adminname=?,adminpwd=?,AdminType=? where adminId=?";
        int num = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, admin.getAdminName());
            ps.setString(2, admin.getAdminPwdHash());
            ps.setInt(3, admin.getAdminType());
            ps.setInt(4,admin.getAdminId());
            num = ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return num;
    }
    //删除管理员
    public int deleteAdmin(int adminId) {
        Connection conn = DBConnection.getConn();
        String sql = "delete from admin where adminId=?";
        int num = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, adminId);
            num = ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return num;
    }
}
