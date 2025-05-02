package fun.zengxp.Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static int DBType;
    private static Connection conn;

    public DBConnection() {
        conn = null;
    }

    public static Connection getConn() {
        DBType = 1;
        switch (DBType) {
            case 1: return getConnToMySql();
            default: return null;
        }
    }

    private static Connection getConnToMySql() {
        String MySqlDriver = "com.mysql.cj.jdbc.Driver";
        String MySqlUrl = "jdbc:mysql://localhost:3306/website?user=root&password=123456&useUnicode=true&characterEncoding=utf-8";
        try {
            Class.forName(MySqlDriver);
            conn = DriverManager.getConnection(MySqlUrl);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    public void closeConnection() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
