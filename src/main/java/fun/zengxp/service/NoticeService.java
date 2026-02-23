package fun.zengxp.service;


import fun.zengxp.pojo.Notice;
import fun.zengxp.Util.DBConnection;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class NoticeService {
    public List<Notice> getNoticeList(){
        List<Notice> noticeList =  new ArrayList<Notice>();
        Connection conn = DBConnection.getConn();
        String sql = "select * from notice order by noticeid desc";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notice notice = new Notice();
                notice.setNoticeId(rs.getInt(1));
                notice.setNoticeTitle(rs.getString(2));
                notice.setNoticeContent(rs.getString(3));
                notice.setNoticeTime(rs.getString(4));
                notice.setAdminName(rs.getString(5));
                noticeList.add(notice);
            }
            ps.close();
            rs.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return noticeList;
    }
    public int addNotice(Notice notice) {
        Connection conn = DBConnection.getConn();
        String sql = "insert into notice(noticeTitle,noticeContent,noticeTime,adminName) values(?,?,?,?)";
        int num = 0;
        //公告内容太多，数据库无法保存，用输入输出流创建文件保存公告内容
        String content = notice.getNoticeContent();
        String cleanedTitle = notice.getNoticeTitle();
        String filePath = "notice/" + cleanedTitle + "_" + new Random().nextInt(100) + ".txt";
        File fileDir = new File("notice");
        if (!fileDir.exists()) {
            fileDir.mkdirs();
        }
        try (OutputStream outputStream = new FileOutputStream(filePath)) {
            byte[] bytes = content.getBytes();
            outputStream.write(bytes);
            System.out.println("文件创建成功，内容已保存！");
        } catch (IOException e) {
            e.printStackTrace();
        }
        notice.setNoticeContent(filePath);
        System.out.println(filePath);
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, notice.getNoticeTitle());
            ps.setString(2, notice.getNoticeContent());
            ps.setString(3, notice.getNoticeTime());
            ps.setString(4, notice.getAdminName());
            num = ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return num;
    }

    public Notice selectById(int noticeId) {
        Notice notice = new Notice();
        Connection conn = DBConnection.getConn();
        String sql = "select * from notice where noticeId = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, noticeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                notice.setNoticeId(rs.getInt(1));
                notice.setNoticeTitle(rs.getString(2));
                notice.setNoticeContent(rs.getString(3));
                //读取文件中的数据保存到字符串中
                try (InputStream in = new FileInputStream(notice.getNoticeContent());
                     InputStreamReader reader = new InputStreamReader(in, "UTF-8");
                     BufferedReader bufferedReader = new BufferedReader(reader)) {
                    StringBuilder stringBuilder = new StringBuilder();
                    char[] buffer = new char[1024];
                    int len;
                    while ((len = bufferedReader.read(buffer)) != -1) {
                        stringBuilder.append(buffer, 0, len);
                    }
                    notice.setNoticeContent(stringBuilder.toString());

                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
                notice.setNoticeTime(rs.getString(4));
                notice.setAdminName(rs.getString(5));
            }
            ps.close();
            rs.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return notice;
    }
    public int updateNotice(Notice notice) {
        Connection conn = DBConnection.getConn();
        String sql = "update notice set noticeTitle=?,noticeContent=?,noticeTime=?,adminName=? where noticeId=? ";
        String sqlNoticePath = "select noticeContent from notice where noticeId=?";
        int num = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sqlNoticePath);
            ps.setInt(1, notice.getNoticeId());
            ResultSet rs = ps.executeQuery();
            String filePath = "";
            while (rs.next()) {
                filePath = rs.getString(1);
            }
            //公告内容太多，数据库无法保存，用输入输出流创建文件保存公告内容
            String content = notice.getNoticeContent();
            File fileDir = new File("notice");
            if (!fileDir.exists()) {
                fileDir.mkdirs();
            }
            try (OutputStream outputStream = new FileOutputStream(filePath)) {
                byte[] bytes = content.getBytes();
                outputStream.write(bytes);
                System.out.println("文件创建成功，内容已保存！");
            } catch (IOException e) {
                e.printStackTrace();
            }
            notice.setNoticeContent(filePath);
            ps = conn.prepareStatement(sql);
            ps.setString(1, notice.getNoticeTitle());
            ps.setString(2, notice.getNoticeContent());
            ps.setString(3, notice.getNoticeTime());
            ps.setString(4, notice.getAdminName());
            ps.setInt(5, notice.getNoticeId());
            num = ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return num;
    }
    public int deleteNotice(int noticeId) {
        Connection conn = DBConnection.getConn();
        String sqlDeletePath = "select noticeContent from notice where noticeId=?";
        String sql = "delete from notice where noticeId = ?";
        int num = 0;
        try {
            PreparedStatement ps = conn.prepareStatement(sqlDeletePath);
            ps.setInt(1, noticeId);
            ResultSet rs = ps.executeQuery();
            String contentPath = "";
            while (rs.next()) {
                contentPath = rs.getString(1);
            }
            File fileDir = new File(contentPath);
            if (fileDir.exists()) {
                fileDir.delete();
            }
            ps = conn.prepareStatement(sql);
            ps.setInt(1, noticeId);
            num = ps.executeUpdate();
            ps.close();
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return num;
    }
}