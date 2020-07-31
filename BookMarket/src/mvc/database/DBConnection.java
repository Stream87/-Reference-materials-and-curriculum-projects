package mvc.database;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.DriverManager;

import javax.naming.NamingException;

public class DBConnection {

	public static Connection getConnection() throws SQLException, NamingException, ClassNotFoundException {

		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/BookMarketDB";
		String user = "root";
		String password = "1234";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);

		return conn;
	}

}
