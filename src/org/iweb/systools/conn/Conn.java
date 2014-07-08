package org.iweb.systools.conn;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface Conn {
	public abstract ResultSet getResult(String sql) throws SQLException;

	public abstract int setUpdate(String sql) throws SQLException;
}
