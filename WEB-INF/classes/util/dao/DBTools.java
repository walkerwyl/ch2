package util.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * JDBC工具类 包含数据库连接及关闭数据库资源
 */
public class DBTools {

	static Connection connection = null;

	static PreparedStatement preparedStatement = null;

	static ResultSet resultSet = null;

	private final static String DB_URL = "jdbc:mysql://112.74.58.75:3306/OLAS_DB?characterEncodeing=gb2312";

	private final static String DB_USER = "root";

	private final static String DB_PASSWORD = "41710020wys";

	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connection = (Connection) DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
		} catch (Exception e) {
			System.out.println("加载驱动失败!");
			e.printStackTrace();
		}
		return connection;
	}

	public static void close(Connection connection, PreparedStatement preparedStatement, ResultSet resultSet) {
		if (resultSet != null) {
			try {
				resultSet.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (preparedStatement != null) {
			try {
				preparedStatement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}