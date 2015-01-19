package org.iweb.systools.exec;

import java.io.File;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.FileUtil;
import org.iweb.sys.ToolsUtil;
import org.iweb.systools.config.DBConfig;
import org.iweb.systools.conn.Conn;
import org.iweb.systools.domain.AppInfo;
import org.iweb.systools.domain.TableColumn;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2013-12-29 下午6:11:24
 */
public abstract class AppCreate {
	protected static Log log = LogFactory.getLog(AppCreate.class);

	private AppInfo app;

	protected abstract int getDBType();

	// 默认字符集
	private final String encode = "UTF-8";

	// 存放路径
	private String savePath;

	// 标签列表
	private Map<String, String> tags = new HashMap<>();

	public Map<String, String> getTags() {
		return tags;
	}

	public void addTags(String key, String value) {
		this.tags.put(key, value);
	}

	public void delTags(String key) {
		this.tags.remove(key);
	}

	public AppInfo getApp() {
		return app;
	}

	public void setApp(AppInfo app) {
		if (ToolsUtil.isEmpty(app.getApp_code())) {
			app.setApp_code(app.getDb_name());
		}
		this.app = app;
	}

	protected abstract void SetApp();

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	protected void execute() {
		try {
			// 加载配置信息
			SetApp();
			// 初始化DB读取表信息,并完善配置信息
			DBInit();
			// 生成替换Tags标签
			SetTags();
			// 检查/生成文件保存路径
			CreatePath();
			// 开始生成文件
			CreateFiles();
		} catch (Exception e) {
			log.error("执行异常,请查看配置后在执行!!", e);
		}
	}

	/**
	 * 连接数据库,读取数据库信息
	 * 
	 * @throws Exception
	 * @date 2013-12-30 下午3:35:51
	 */
	private void DBInit() throws Exception {
		log.info("开始初始化数据库信息");
		DBConfig dc = DBConfig.getInstance(getDBType());
		Conn conn = dc.getConn();
		String column_sql = "SELECT c.COLUMN_NAME,c.COLUMN_DEFAULT,c.IS_NULLABLE,c.DATA_TYPE," + "c.NUMERIC_SCALE,c.COLUMN_COMMENT,	"
				+ "IFNULL(c.CHARACTER_MAXIMUM_LENGTH,c.NUMERIC_PRECISION) AS MAX_LENGTH " + "FROM information_schema.`COLUMNS` c WHERE c.TABLE_SCHEMA = '" + app.getDb_name()
				+ "' " + "AND c.TABLE_NAME = '" + app.getTable_name() + "'";
		System.out.println(column_sql);
		ResultSet rs = conn.getResult(column_sql);
		String t_col;
		while (rs.next()) {
			t_col = Lower(rs.getString("COLUMN_NAME"));
			TableColumn tc = app.getTcs().get(t_col);
			System.out.println("===(1):" + ToolsUtil.dumpObject(tc));
			tc.setType(Lower(rs.getString("DATA_TYPE")));
			tc.setMax(rs.getInt("MAX_LENGTH"));
			tc.setNote(rs.getString("COLUMN_COMMENT"));
			tc.setDval(rs.getString("COLUMN_DEFAULT"));
			tc.setScale(rs.getInt("NUMERIC_SCALE"));
			tc.setNullable("NO".equals(rs.getString("IS_NULLABLE")) ? 1 : 0);
			// tc.setHmax("UTF-8".equals(encode) ? tc.getMax() / 3 : tc.getMax() / 2);
			tc.setHmax(tc.getMax());
			tc.setJtype(dc.getJavaType(tc.getType()));
			System.out.println("===(2):" + ToolsUtil.dumpObject(tc));
		}
		rs.close();
		log.info("数据库配置设置完成");
	}

	public void SetTags() {
		log.info("开始初始化Tags...");
		// 原有参数
		addTags("package_name", app.getPackage_name()); // com.qkjsys.ebiz
		addTags("table_name", app.getTable_name()); // qkj_t_warehouse
		addTags("app_name", app.getApp_name()); // 仓库
		addTags("app_code", app.getApp_code()); // 应用前缀 qkjcj
		addTags("db_name", app.getDb_name()); // 数据库名,主要用来查Column,不指定app_code时,此将作为app_code qkjcj
		addTags("jsp_path", app.getJsp_path()); // sysebiz
		addTags("name_space", app.getName_space()); // ebiz

		// 计算参数
		addTags("class_alias", ToolsUtil.UpperFirst2(app.getApp_en())); // ware
		addTags("file_s_name", ToolsUtil.UpperFirst(tags.get("class_alias"))); // Ware

		// 判断参数
		String pkey = null;

		// domain 特殊Tag
		StringBuffer domain_column_area = new StringBuffer();
		StringBuffer domain_bean_area = new StringBuffer();

		// sqlmapxml 特殊Tag
		StringBuffer sqlmap_search_area = new StringBuffer();
		StringBuffer sqlmap_insert_column_area = new StringBuffer();
		StringBuffer sqlmap_insert_value_area = new StringBuffer();
		StringBuffer sqlmap_update_set_area = new StringBuffer();

		// dao 特殊Tag

		// action 特殊Tag

		// jsplist 特殊Tag
		StringBuffer jsplist_search_area = new StringBuffer();
		StringBuffer jsplist_columns = new StringBuffer();
		StringBuffer jsplist_columnValues = new StringBuffer();
		int search_num = 0; // 记录元素参与search的个数

		// jspedit 特殊Tag
		StringBuffer jspedit_noedit_area = new StringBuffer();
		StringBuffer jspedit_edit_area = new StringBuffer();
		StringBuffer jspedit_hidden_area = new StringBuffer();

		for (Map.Entry<String, TableColumn> entry : app.getTcs().entrySet()) {
			TableColumn tc = entry.getValue();

			domain_column_area.append("private ").append(tc.getJtype()).append(" ").append(tc.getName()).append(";//(").append(tc.getType()).append(")").append(tc.getNote())
					.append("\n");
			domain_bean_area.append("public ").append(tc.getJtype()).append(" get").append(ToolsUtil.UpperFirst(tc.getName())).append("(){\nreturn ").append(tc.getName())
					.append(";\n}").append("public void set").append(ToolsUtil.UpperFirst(tc.getName())).append("(").append(tc.getJtype()).append(" ").append(tc.getName())
					.append(")").append("{\n").append("this.").append(tc.getName()).append("=").append(tc.getName()).append(";\n}\n");

			if (pkey == null && tc.getKey() == 1) {
				pkey = tc.getName();
			}

			if (tc.getSearch() == 1) {
				search_num++;
				sqlmap_search_area.append("<isNotEmpty prepend=\"AND\" property=\"").append(tc.getName()).append("\">").append("<![CDATA[ ").append(tc.getName()).append("=#")
						.append(tc.getName()).append("# ]]>").append("</isNotEmpty>\n");
				jsplist_search_area.append("<div class='label_hang'><div class='label_ltit'>").append(tc.getTitle()).append(":</div><div class='label_rwben'>")
						.append(tc.getFormField(tags.get("class_alias"), 1)).append("</div></div>");
			}

			if (tc.getShow() == 1) {
				jsplist_columns.append("<th>").append(tc.getTitle()).append("</th>\n");
				jsplist_columnValues.append("<td>" + tc.getFormField(tags.get("class_alias"), 2) + "</td>\n");
			}

			if (tc.getInsert() == 1) {
				sqlmap_insert_column_area.append(tc.getName()).append(",");
				sqlmap_insert_value_area.append("#").append(tc.getName()).append("#,");
			}

			if (tc.getUpdate() == 1) {
				sqlmap_update_set_area.append(tc.getName()).append("=").append("#").append(tc.getName()).append("#,\n");
			}

			String form_title = "";
			if (tc.getNullable() == 0) {
				form_title = tc.getTitle();
			} else {
				form_title = "<span class='cr'>*</span>" + tc.getTitle();
			}
			if (tc.getStype() == 5 || tc.getStype() == 6) {
				jspedit_noedit_area.append("<div class='label_hang'><div class='label_ltit'>").append(tc.getTitle()).append(":</div><div class='label_rwben'>")
						.append(tc.getFormField(tags.get("class_alias"), 0)).append("</div></div>");

			} else if (tc.getStype() == 4) {
				jspedit_hidden_area.append(tc.getFormField(tags.get("class_alias"), 0)).append("\n");
			} else if (tc.getStype() == 8) {
				jspedit_edit_area.append("</div><div class='label_main'><div class='label_hang'><div class='label_ltit'>").append(form_title)
						.append(":</div><div class='label_rwbenx'></div></div></div><div class='label_main'><div class='note_area'>")
						.append(tc.getFormField(tags.get("class_alias"), 0)).append("</div></div><div class='label_main'>");
			} else {
				jspedit_edit_area.append("<div class='label_hang'><div class='label_ltit'>").append(form_title).append(":</div><div class='label_rwben'>")
						.append(tc.getFormField(tags.get("class_alias"), 0)).append("</div></div>");
			}
		}
		// 循环后操作
		// sqlmapxml - 删除最后一个
		sqlmap_insert_column_area.deleteCharAt(sqlmap_insert_column_area.length() - 1);
		sqlmap_insert_value_area.deleteCharAt(sqlmap_insert_value_area.length() - 1);
		// 需要减2个字符,因为最后一个字符是\n
		// System.out.println("sqlmap_update_set_area:" + sqlmap_update_set_area);
		sqlmap_update_set_area.deleteCharAt(sqlmap_update_set_area.length() - 1).deleteCharAt(sqlmap_update_set_area.length() - 1);

		// 添加生成特殊Tag
		addTags("pkey", pkey); // 主键Tag

		// 添加domain 特殊Tag
		addTags("domain_package", tags.get("package_name") + ".domain");
		addTags("domain_import", "import java.util.*;");
		addTags("domain_column_area", domain_column_area.toString());
		addTags("domain_bean_area", domain_bean_area.toString());
		// sqlmapxml 特殊Tag
		addTags("sqlmap_search_area", sqlmap_search_area.toString());
		addTags("sqlmap_insert_column_area", sqlmap_insert_column_area.toString());
		addTags("sqlmap_insert_value_area", sqlmap_insert_value_area.toString());
		addTags("sqlmap_update_set_area", sqlmap_update_set_area.toString());
		// dao 特殊Tag
		addTags("dao_package", tags.get("package_name") + ".dao");
		addTags("dao_import", "import java.util.*;\nimport org.iweb.sys.AbstractDAO;");
		// action 特殊Tag
		addTags("action_package", tags.get("package_name") + ".action");
		addTags("action_import", "import java.util.*;\nimport org.apache.commons.logging.*;\n" + "import org.iweb.sys.*;\nimport com.opensymphony.xwork2.ActionSupport;\n"
				+ "import " + tags.get("domain_package") + "." + tags.get("file_s_name") + ";\n" + "import " + tags.get("dao_package") + "." + tags.get("file_s_name") + "DAO;\n");
		addTags("action_privilege_flag", (tags.get("app_code") + "_" + tags.get("name_space") + "_" + tags.get("class_alias")).toUpperCase());
		// jsplist 特殊Tag
		addTags("jsplist_search_area", jsplist_search_area.toString());
		addTags("jsplist_columns", jsplist_columns.toString());
		addTags("jsplist_columnValues", jsplist_columnValues.toString());
		// jspedit 特殊Tag
		addTags("jspedit_noedit_area", jspedit_noedit_area.toString());
		addTags("jspedit_edit_area", jspedit_edit_area.toString());
		addTags("jspedit_hidden_area", jspedit_hidden_area.toString());

		log.info("初始化Tags成功!");
	}

	private Map<String, String> path = new HashMap<>();

	/**
	 * 生成存放目录
	 * 
	 * @throws Exception
	 * @date 2013-12-30 下午12:04:43
	 */
	private void CreatePath() throws Exception {
		this.setSavePath(getBaseDir() + "/" + tags.get("file_s_name") + "/");
		File f = new File(this.getSavePath());
		if (!f.exists()) {
			f.mkdirs();
		}
		path.put("ROOT", this.getSavePath());
		log.info("根路径目录准备完成:" + this.getSavePath());

		String jspFilePath = this.savePath + app.getJsp_path();
		f = new File(jspFilePath);
		if (!f.exists()) {
			f.mkdirs();
		}
		path.put("JSPROOT", jspFilePath);
		log.info("虚拟jsp路径准备完成:" + jspFilePath);

		String srcFilePathRoot = app.getPackage_name().replaceAll("\\.", "/");
		path.put("SRCROOT", srcFilePathRoot);
		File f1, f2, f3, f4, f5;
		f1 = new File(this.getSavePath() + srcFilePathRoot + "/domain/");
		f2 = new File(this.getSavePath() + srcFilePathRoot + "/dao/");
		f3 = new File(this.getSavePath() + srcFilePathRoot + "/action/");
		f4 = new File(this.getSavePath() + "org/iweb/resource/action/");
		f5 = new File(this.getSavePath() + "org/iweb/resource/map/");
		if (!f1.exists()) {
			f1.mkdirs();
		}
		path.put("DOMAIN", this.getSavePath() + srcFilePathRoot + "/domain/");
		if (!f2.exists()) {
			f2.mkdirs();
		}
		path.put("DAO", this.getSavePath() + srcFilePathRoot + "/dao/");
		if (!f3.exists()) {
			f3.mkdirs();
		}
		path.put("ACTION", this.getSavePath() + srcFilePathRoot + "/action/");
		if (!f4.exists()) {
			f4.mkdirs();
		}
		path.put("ACTIONXML", this.getSavePath() + "org/iweb/resource/action/");
		if (!f5.exists()) {
			f5.mkdirs();
		}
		path.put("MAPXML", this.getSavePath() + "org/iweb/resource/map/");
	}

	/**
	 * 生成文件
	 * 
	 * @date 2013-12-30 上午11:24:21
	 */
	private void CreateFiles() throws Exception {
		// 模版文件
		final String domain_template = "src/org/iweb/systools/template/domain";
		final String sqlmap_template = "src/org/iweb/systools/template/sqlmap";
		final String dao_template = "src/org/iweb/systools/template/dao";
		final String action_template = "src/org/iweb/systools/template/action";
		final String actionxml_template = "src/org/iweb/systools/template/actionxml";
		final String jsplist_template = "src/org/iweb/systools/template/jsplist";
		final String jspedit_template = "src/org/iweb/systools/template/jspedit";

		LinkedHashMap<String, String> filesInfo = new LinkedHashMap<>();
		// Domain File
		filesInfo.put(path.get("DOMAIN") + tags.get("file_s_name") + ".java", domain_template);
		// SQLMAPXML File
		filesInfo.put(path.get("MAPXML") + tags.get("app_code") + "_" + tags.get("name_space") + "_" + tags.get("file_s_name") + "Map.xml", sqlmap_template);
		// DAO File
		filesInfo.put(path.get("DAO") + tags.get("file_s_name") + "DAO.java", dao_template);
		// Action File
		filesInfo.put(path.get("ACTION") + tags.get("file_s_name") + "Action.java", action_template);
		// Action XML File
		filesInfo.put(path.get("ACTIONXML") + tags.get("app_code") + "_" + tags.get("name_space") + "_" + tags.get("file_s_name") + "Action.xml", actionxml_template);
		// JSP 2 Files
		filesInfo.put(path.get("JSPROOT") + "/" + tags.get("file_s_name") + "List.jsp", jsplist_template);
		filesInfo.put(path.get("JSPROOT") + "/" + tags.get("file_s_name") + "Edit.jsp", jspedit_template);

		// 临时文件
		String fileName;
		String template;

		String rootPath = "";
		// 开始循环生成文件
		for (Map.Entry<String, String> entry : filesInfo.entrySet()) {
			fileName = rootPath + entry.getKey();
			log.info("开始生成:" + fileName);
			// 获取模版
			template = FileUtil.readFileAsString(entry.getValue(), encode);
			// 开始替换通用标签
			template = replaceTags(template);
			// 开始生成文件
			FileUtil.writeFileString(fileName, template, encode);
			log.info("文件生成成功:" + fileName);
		}
	}

	private String replaceTags(String template) {
		for (Map.Entry<String, String> entry : this.tags.entrySet()) {
			// System.out.println("===:" + entry.getKey());
			template = template.replace("$" + entry.getKey() + "$", entry.getValue());
		}
		return template;
	}

	/**
	 * 设置生成路径,默认为D:/tmp/app
	 * 
	 * @param createDir
	 * @date 2013-12-29 下午6:14:49
	 */
	protected String getBaseDir() {
		return "D:/tmp/app";
	}

	private String Lower(String s) {
		return s == null ? "" : s.toLowerCase();
	}
}
