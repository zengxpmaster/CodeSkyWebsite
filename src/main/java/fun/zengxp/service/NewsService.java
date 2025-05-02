package fun.zengxp.service;

import fun.zengxp.Util.DBConnection;

import fun.zengxp.pojo.News;

import java.sql.*;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class NewsService {
    public List<News> getNewsList(int page, int pageSize) {
        Connection conn = DBConnection.getConn();
        String sql = "select * from news order by newsTime DESC LIMIT ?,?";
        List<News> list = new ArrayList<News>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                News news = new News();
                news.setNewsId(rs.getInt(1));
                news.setNewsTitle(rs.getString(2));
                news.setNewsContent(rs.getString(3));
                news.setNewsAuthor(rs.getString(4));
                news.setNewsTime(rs.getTimestamp(5).toLocalDateTime());
                list.add(news);
            }
            rs.close();
            ps.close();
            conn.close();
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int getTotalNews() {
        Connection conn = DBConnection.getConn();
        String sql = "SELECT COUNT(*) FROM news";
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


    public News getNewsById(int newsId) {
        Connection conn = DBConnection.getConn();
        String sql = "select * from news where newsId=?";
        News news = new News();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newsId);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                return null;
            } else {
                news.setNewsId(rs.getInt(1));
                news.setNewsTitle(rs.getString(2));
                news.setNewsContent(rs.getString(3));
                news.setNewsAuthor(rs.getString(4));
                news.setNewsTime(rs.getTimestamp(5).toLocalDateTime());
            }
            rs.close();
            ps.close();
            conn.close();
            return news;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public News getNewsLatest() {
        Connection conn = DBConnection.getConn();
        String sql = "select * from news order by newsTime DESC LIMIT 1";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            News news = new News();
            if (!rs.next()) {
                return null;
            } else {
                news.setNewsId(rs.getInt(1));
                news.setNewsTitle(rs.getString(2));
                news.setNewsContent(rs.getString(3));
                news.setNewsAuthor(rs.getString(4));
                news.setNewsTime(rs.getTimestamp(5).toLocalDateTime());
            }
            rs.close();
            ps.close();
            conn.close();
            return news;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Boolean addNews(News news) {
        Connection conn = DBConnection.getConn();
        String sql = "insert into news(newsTitle,newsContent,newsAuthor,newsTime) values(?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, news.getNewsTitle());
            ps.setString(2, news.getNewsContent());
            ps.setString(3, news.getNewsAuthor());

            LocalDateTime newsTime = news.getNewsTime();
            if (newsTime != null) {
                // 直接转换为 Timestamp
                ps.setTimestamp(4, Timestamp.valueOf(newsTime));
            } else {
                // 使用当前时间
                ps.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now().withSecond(0).withNano(0)));
            }

            ps.executeUpdate();
            ps.close();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public Boolean updateNews( News news) {
        Connection conn = DBConnection.getConn();
        String sql = "update news set newsTitle=?,newsContent=?,newsAuthor=?,newsTime=? where newsId=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, news.getNewsTitle());
            ps.setString(2, news.getNewsContent());
            ps.setString(3, news.getNewsAuthor());
            LocalDateTime newsTime = news.getNewsTime();
            if (newsTime != null) {
                // 将 LocalDateTime 转换为 Timestamp
                Timestamp sqlTimestamp = Timestamp.from(newsTime.atZone(ZoneId.systemDefault()).toInstant());
                ps.setTimestamp(4, sqlTimestamp);
            } else {
                // 如果 newsTime 为 null，可以设置为 null 或抛出异常
                LocalDateTime currentTime = LocalDateTime.now();
                // 将 LocalDateTime 转换为 Timestamp
                Timestamp sqlTimestamp = Timestamp.from(currentTime.atZone(ZoneId.systemDefault()).toInstant());
                ps.setTimestamp(4, sqlTimestamp);
            }
            ps.setInt(5, news.getNewsId());
            ps.executeUpdate();
            ps.close();
            conn.close();
            return true;
        }
        catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public Boolean deleteNews(int newsId) {
        Connection conn = DBConnection.getConn();
        String sql = "delete from news where newsId=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, newsId);
            ps.executeUpdate();
            ps.close();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
