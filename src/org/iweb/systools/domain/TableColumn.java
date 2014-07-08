package org.iweb.systools.domain;

import java.util.List;

import org.iweb.rpt.domain.ListObject;
import org.iweb.sys.ToolsUtil;

public class TableColumn {

	private String name; // 元素名
	private String title; // 元素表现名
	private int key; // 是否唯一ID 0 否 1 是
	private int insert; // 是否参与insert 0否 1是
	private int update;// 是否参与update 0否 1是
	private int show;// 是否在List页显示 0 否 1是
	private int search; // 是否搜索项 0 否 1 是
	private int stype;// 表现类型 0 文本 1 select 2 radio 3 checkbox 4不表现 隐藏域
						// 5直接表现+隐藏域 6直接表现,不用表单 7不表现 8ckedit
	private List<ListObject> slist;// 如上面是select/radio/checkbox的表现列表
	private String datePatten; // 如果数据库读出的type是时间 指定的Format类型 yyyy-MM-dd
								// HH:mm:ss

	// 以下是直接从数据库中读出的数据,设置时不用设置
	private String type; // 元素类型
	private String encode; // 数据类型,一般是utf-8
	private int max; // 最大长度
	private String note; // 备注
	private String dval; // 默认值default
	private int scale; // 当type为数字时.小数位数,

	// 根据数据库得出的数据
	private String jtype; // JAVA数据类型
	private int hmax; // 网页校验的最大长度,和encode有关,utf-8是max/3 gbk是max/2
	private int nullable; // 是否允许为空 0 允许 1 不允许

	// 其他配置
	private int now;// type是时间类型,是否insert和updatre时取得当前值 0否 1insert的时候是
					// 2update的时候是 3都是

	/**
	 * 普通元素初始化
	 */
	public TableColumn(String name, String title) {
		this.name = name;
		this.title = title;
		this.key = 0;
		this.insert = 1;
		this.update = 1;
		this.show = 0;
		this.search = 0;
		this.stype = 0;
	}

	/**
	 * 时间元素初始化
	 */
	public TableColumn(String name, String title, int insert, int update, int show, int search, int stype,
			String datePatten, int now) {
		this.name = name;
		this.title = title;
		this.insert = insert;
		this.update = update;
		this.show = show;
		this.search = search;
		this.stype = stype;
		this.datePatten = datePatten;
		this.now = now;
	}

	/**
	 * 通用元素初始化
	 */
	public TableColumn(String name, String title, int key, int insert, int update, int show, int search, int stype,
			List<ListObject> slist) {
		this.name = name;
		this.title = title;
		this.key = key;
		this.insert = insert;
		this.update = update;
		this.show = show;
		this.search = search;
		this.stype = stype;
		this.slist = slist;
	}

	/**
	 * 通用元素初始化
	 */
	public TableColumn(String name, String title, int key, int insert, int update, int show, int search, int stype,
			List<ListObject> slist, String datePatten) {
		this.name = name;
		this.title = title;
		this.key = key;
		this.insert = insert;
		this.update = update;
		this.show = show;
		this.search = search;
		this.stype = stype;
		this.slist = slist;
		this.datePatten = datePatten;
	}

	public String getDatePatten() {
		return datePatten;
	}

	public void setDatePatten(String datePatten) {
		this.datePatten = datePatten;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getScale() {
		return scale;
	}

	public void setScale(int scale) {
		this.scale = scale;
	}

	public int getNullable() {
		return nullable;
	}

	public void setNullable(int nullable) {
		this.nullable = nullable;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getKey() {
		return key;
	}

	public void setKey(int key) {
		this.key = key;
	}

	public int getInsert() {
		return insert;
	}

	public void setInsert(int insert) {
		this.insert = insert;
	}

	public int getUpdate() {
		return update;
	}

	public void setUpdate(int update) {
		this.update = update;
	}

	public int getShow() {
		return show;
	}

	public void setShow(int show) {
		this.show = show;
	}

	public int getSearch() {
		return search;
	}

	public void setSearch(int search) {
		this.search = search;
	}

	public int getStype() {
		return stype;
	}

	public void setStype(int stype) {
		this.stype = stype;
	}

	public List<ListObject> getSlist() {
		return slist;
	}

	public void setSlist(List<ListObject> slist) {
		this.slist = slist;
	}

	public int getNow() {
		return now;
	}

	public void setNow(int now) {
		this.now = now;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getMax() {
		return max;
	}

	public void setMax(int max) {
		this.max = max;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getJtype() {
		return jtype;
	}

	public void setJtype(String jtype) {
		this.jtype = jtype;
	}

	public String getEncode() {
		return encode;
	}

	public void setEncode(String encode) {
		this.encode = encode;
	}

	public int getHmax() {
		return hmax;
	}

	public void setHmax(int hmax) {
		this.hmax = hmax;
	}

	public String getDval() {
		return dval;
	}

	public void setDval(String dval) {
		this.dval = dval;
	}

	/**
	 * 得到Column在网页中的表单HTML
	 * 
	 * @param class_alias
	 * @param ctx
	 *            使用场合 0:Edit页面 1:List的查询模块页面 2:List的数据列表模块
	 * @return
	 * @date 2014-1-1 下午12:34:48
	 */
	public String getFormField(String class_alias, int ctx) {
		StringBuffer sb = new StringBuffer();
		if (ctx == 2) {
			if (stype == 1 || stype == 2 || stype == 3) {
				if (slist == null || slist.size() == 0) {
					sb.append(this.getName()).append(".").append(this.getName()).append("list");
				} else {
					boolean isNumber = false;
					if ("Integer".equals(this.getJtype()) || "Float".equals(this.getJtype())
							|| "Double".equals(this.getJtype())) {
						isNumber = true;
					}

					for (ListObject l : slist) {
						sb.append("<s:if test=\"").append(isNumber ? "" : "'").append(l.getKey())
								.append(isNumber ? "" : "'").append("==").append(this.getName() + "\">")
								.append(l.getValue()).append("</s:if>");
					}
				}
			} else if ("Date".equals(jtype)) {
				sb.append("<s:date name=\"").append(this.getName()).append("\" format=\"").append(this.getDatePatten())
						.append("\" />");
			} else {
				sb.append("<s:property value=\"").append(this.getName()).append("\" />");
			}
		} else {
			String inputName = class_alias + "." + this.getName(); // 表单名称
			if (this.getStype() == 0) {
				sb.append("<s:textfield name=\"").append(inputName).append("\" ").append("title=\"")
						.append(this.getTitle()).append("\"").append(getValidForm(class_alias, ctx)).append(" />");
			} else if (this.getStype() == 1) {
				sb.append("<s:select name=\"").append(inputName).append("\" ").append("title=\"")
						.append(this.getTitle()).append("\" headerKey=\"\" headerValue=\"--请选择--\" ").append("list=\"")
						.append(getListFrom()).append("\" />");
			} else if (this.getStype() == 2) {
				sb.append("<s:radio name=\"").append(inputName).append("\" ").append("title=\"")
						.append(this.getTitle()).append("\"  ").append("list=\"").append(getListFrom()).append("\" />");
			} else if (this.getStype() == 3) {
				sb.append("<s:checkboxlist name=\"").append(inputName).append("\" ").append("title=\"")
						.append(this.getTitle()).append("\"  ").append("list=\"").append(getListFrom()).append("\" />");
			} else if (this.getStype() == 4) {
				sb.append("<s:hidden name=\"").append(inputName).append("\" ").append("title=\"")
						.append(this.getTitle()).append("\"").append(" />");
			} else if (this.getStype() == 5 || this.getStype() == 6) {
				if ("Date".equals(this.getJtype())) {
					sb.append("<s:date name=\"").append(inputName).append("\" format=\"").append(this.getDatePatten())
							.append("\" />");
				} else {
					sb.append("<s:property value=\"").append(inputName).append("\" />");
				}
				if (this.getStype() == 5) sb.append("<s:hidden name=\"").append(inputName).append("\" ")
						.append("title=\"").append(this.getTitle()).append("\"").append(" />");
			} else if (this.getStype() == 8) {
				sb.append("<textarea id=\"")
						.append(class_alias)
						.append(this.getName())
						.append("id\" name=\"")
						.append(inputName)
						.append("\" > <s:property value=\"")
						.append(inputName)
						.append("\" /></textarea>\n")
						.append("<script type=\"text/javascript\">\n")
						.append("CKEDITOR.editorConfig = function(config) {\n")
						.append("config.language = 'zh-cn';config.toolbar = 'Full';\n")
						.append("config.filebrowserBrowseUrl='<s:url value=\"/include/ckfinder/ckfinder.html\" />';\n")
						.append("config.filebrowserImageBrowseUrl='<s:url value=\"/include/ckfinder/ckfinder.html?type=Images\" />';\n")
						.append("config.filebrowserFlashBrowseUrl='<s:url value=\"/include/ckfinder/ckfinder.html?type=Flash\" />';\n")
						.append("config.filebrowserUploadUrl='<s:url value=\"/include/ckfinder/core/connector/java/connector.java\" />?type=Files&command=QuickUpload';\n")
						.append("config.filebrowserImageUploadUrl='<s:url value=\"/include/ckfinder/core/connector/java/connector.java\" />?type=Images&command=QuickUpload';\n")
						.append("config.filebrowserFlashUploadUrl='<s:url value=\"/include/ckfinder/core/connector/java/connector.java\" />?type=Flash&command=QuickUpload';\n")
						.append("config.filebrowserWindowWidth = '1000';\n")
						.append("config.filebrowserWindowHeight = '700';};\n").append("var ").append(class_alias)
						.append(this.getName()).append("id_editor = CKEDITOR.replace('")
						.append(class_alias + this.getName()).append("id');\n").append("CKFinder.setupCKEditor(")
						.append(class_alias).append(this.getName()).append("id_editor, '/ckfinder/');\n</script>");
			}
		}
		return sb.toString();
	}

	/**
	 * JS校验,或者其他功能(比如Date选择控件)
	 * 
	 * @param class_alias
	 * @param ctx
	 * @return
	 * @date 2014-1-1 下午12:59:17
	 */
	private String getValidForm(String class_alias, int ctx) {
		StringBuffer sb = new StringBuffer();
		if (this.getNullable() == 1 && ctx == 0) {
			sb.append(" require=\"required\"");
		}
		if (this.getHmax() > 0) {
			if (ToolsUtil.isIn(this.getJtype(), new String[] { "Integer", "Float", "Double" })) {
				sb.append(" dataLength=\"0,").append(this.getMax()).append("\"");
			} else {
				sb.append(" dataLength=\"0,").append(this.getHmax()).append("\"");
			}
		}
		// System.out.println(this.getName() + ":" + this.getJtype());
		switch (this.getJtype()) {
		case "Integer":
			sb.append(" dataType=\"integer\"");
			break;
		case "Float":
			sb.append(" dataType=\"float\"");
			break;
		case "Double":
			sb.append(" dataType=\"number\"");
			break;
		case "Date":
			sb.append(" value=\"%{getText('global.date',{").append(class_alias + ".").append(this.getName())
					.append("})=='null'?'':getText('global.date',{").append(class_alias).append(".")
					.append(this.getName()).append("})}\"").append(" dataType=\"date\"");
			break;
		default:
			break;
		}

		if (sb.length() > 0) {
			sb.append(" controlName=\"").append(this.getTitle()).append("\"");
		}

		return sb.toString();
	}

	/**
	 * 当数据类型是数据指定的List的时候,在Edit或者Serach页面中,List的ognl格式
	 * 
	 * @return
	 * @date 2014-1-1 下午12:56:34
	 */
	private String getListFrom() {
		StringBuffer sb = new StringBuffer();
		if (slist == null || slist.size() == 0) {
			sb.append(this.getName()).append(".").append(this.getName()).append("list");
		} else {
			boolean isNumber = false;
			if ("Integer".equals(this.getJtype()) || "Float".equals(this.getJtype())
					|| "Double".equals(this.getJtype())) {
				isNumber = true;
			}

			sb.append("#{");
			for (ListObject l : slist) {
				sb.append(isNumber ? "" : "'").append(l.getKey()).append(isNumber ? "" : "'").append(":").append("'")
						.append(l.getValue()).append("',");
			}
			sb.replace(sb.length() - 1, sb.length(), "}");
		}
		return sb.toString();
	}
}
