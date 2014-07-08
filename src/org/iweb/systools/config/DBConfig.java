/**
 * 
 */
package org.iweb.systools.config;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.systools.conn.Conn;
import org.iweb.systools.conn.ConnMySQL;
import org.iweb.systools.conn.ConnOracle;
import org.iweb.systools.exec.AppCreate;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-30 上午9:47:06
 */
public class DBConfig {
	protected static Log log = LogFactory.getLog(AppCreate.class);
	public final static int DBTYPE_MYSQL = 1;
	public final static int DBTYPE_ORACLE = 2;

	private int dbType;
	private static DBConfig dbConfig;

	private Conn conn;
	private Map<String, String> stype;

	public Map<String, String> getStype() {
		return stype;
	}

	public void setStype(Map<String, String> stype) {
		this.stype = stype;
	}

	public void setConn(Conn conn) {
		this.conn = conn;
	}

	public Conn getConn() {
		return conn;
	}

	private DBConfig(int dbType) {
		this.dbType = dbType;
		this.config();
	}

	public static DBConfig getInstance(int dbType) {
		if (dbConfig == null) {
			return new DBConfig(dbType);
		} else {
			return dbConfig;
		}
	}

	private void config() {
		HashMap<String, String> m;
		if (dbType == DBConfig.DBTYPE_MYSQL) {
			this.setConn(ConnMySQL.getInstance());
			m = new HashMap<>();
			m.put("tinyint", "Integer");
			m.put("smallint", "Integer");
			m.put("mediumint", "Integer");
			m.put("int", "Integer");
			m.put("integer", "Integer");
			m.put("bigint", "Integer");
			m.put("real", "Double");
			m.put("double", "Double");
			m.put("float", "Float");
			m.put("decimal", "Double");
			m.put("numeric", "Double");
			m.put("char", "String");
			m.put("varchar", "String");
			m.put("date", "Date");
			m.put("timestamp", "Date");
			m.put("datetime", "Date");
			m.put("blob", "byte[]");
			m.put("text", "String");
			m.put("bit", "Boolean");
			m.put("enum", "String");
			m.put("other", "String");
			this.setStype(m);
		} else if (dbType == DBConfig.DBTYPE_ORACLE) {
			this.setConn(ConnOracle.getInstance());
			m = new HashMap<>();
			m.put("other", "String");
			this.setStype(m);
		} else {
			this.setConn(null);
			this.setStype(null);
		}
		log.info("初始化了dbType为:【" + dbType + "】 的数据库配置");
	}

	public String getJavaType(String sqlType) {
		if (this.getStype().containsKey(sqlType))
			return this.getStype().get(sqlType);
		else
			return this.getStype().get("other");
	}
}
