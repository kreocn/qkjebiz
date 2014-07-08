package org.iweb.systools.conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnMySQL implements Conn {
	private static Connection conn;
	private static Statement stmt;

	private static ConnMySQL single;

	private final static String db_driver = "com.mysql.jdbc.Driver";
	private final static String strurl = "jdbc:mysql://localhost:3306/huzhu";
	private final static String db_user = "huzhu";
	private final static String db_pwd = "huzhupwd";

	private ConnMySQL() {
		try {
			Class.forName(db_driver);
			conn = DriverManager.getConnection(strurl, db_user, db_pwd);
			stmt = conn.createStatement();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public static ConnMySQL getInstance() {
		if (single == null) {
			single = new ConnMySQL();
		}
		return single;
	}

	public ResultSet getResult(String sqlstr) throws SQLException {
		return stmt.executeQuery(sqlstr);
	}

	public int setUpdate(String sqlstr) throws SQLException {
		return stmt.executeUpdate(sqlstr);
	}

	public void startBatch() throws SQLException {
		conn.setAutoCommit(false);
	}

	public void endBatch() throws SQLException {
		try {
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
		}
		conn.setAutoCommit(true);
	}

	public void commit() throws SQLException {
		conn.commit();
	}

	public void rollback() throws SQLException {
		conn.rollback();
	}
}
