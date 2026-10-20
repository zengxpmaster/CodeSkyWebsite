package fun.zengxp.Util;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * JDBC 连接工厂。
 *
 * <p>连接参数按以下优先级解析，前者覆盖后者：
 * <ol>
 *   <li>环境变量 {@code DB_URL} / {@code DB_USER} / {@code DB_PASSWORD}</li>
 *   <li>JVM 系统属性 {@code -Djdbc.url} / {@code -Djdbc.user} / {@code -Djdbc.password}</li>
 *   <li>classpath 下的 {@code db.properties}</li>
 *   <li>本类中的默认值（只指向本地数据库，不含真实口令）</li>
 * </ol>
 *
 * <p>每次调用返回一个新连接，调用方负责关闭（推荐 try-with-resources）。
 */
public final class DBConnection {

    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/website?useUnicode=true&characterEncoding=utf-8"
                    + "&serverTimezone=Asia/Shanghai&useSSL=false";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "";

    private static final String URL = resolve("DB_URL", "jdbc.url", DEFAULT_URL);
    private static final String USER = resolve("DB_USER", "jdbc.user", DEFAULT_USER);
    private static final String PASSWORD = resolve("DB_PASSWORD", "jdbc.password", DEFAULT_PASSWORD);

    private static Properties fileConfig;

    private DBConnection() {
    }

    /**
     * 打开一个新连接。
     *
     * @throws IllegalStateException 驱动缺失或连接失败时抛出，便于在页面上暴露真实原因
     */
    public static Connection getConn() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("未找到 MySQL JDBC 驱动 com.mysql.cj.jdbc.Driver", e);
        } catch (SQLException e) {
            throw new IllegalStateException("数据库连接失败：" + URL, e);
        }
    }

    private static String resolve(String envKey, String propertyKey, String fallback) {
        String value = System.getenv(envKey);
        if (isBlank(value)) {
            value = System.getProperty(propertyKey);
        }
        if (isBlank(value)) {
            value = loadFileConfig().getProperty(propertyKey);
        }
        return isBlank(value) ? fallback : value.trim();
    }

    private static synchronized Properties loadFileConfig() {
        if (fileConfig == null) {
            Properties properties = new Properties();
            try (InputStream in = DBConnection.class.getClassLoader()
                    .getResourceAsStream("db.properties")) {
                if (in != null) {
                    properties.load(new InputStreamReader(in, StandardCharsets.UTF_8));
                }
            } catch (IOException e) {
                System.err.println("[DBConnection] 读取 db.properties 失败，使用默认连接参数：" + e.getMessage());
            }
            fileConfig = properties;
        }
        return fileConfig;
    }

    private static boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
