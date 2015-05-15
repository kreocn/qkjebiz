package org.iweb.systools.conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class ConnSQLite implements Conn {
	private static Connection conn;
	private static Statement stmt;

	private static ConnSQLite single;
	private final static String dbpath = "/u01/sqlite_data/ejournal.db";
	private final static String db_driver = "org.sqlite.JDBC";
	private final static String strurl = "jdbc:sqlite:" + dbpath;
	private final static String db_user = "";
	private final static String db_pwd = "";

	private ConnSQLite() {
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

	public static ConnSQLite getInstance() {
		if (single == null) {
			single = new ConnSQLite();
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
