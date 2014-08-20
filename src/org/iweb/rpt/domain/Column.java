package org.iweb.rpt.domain;

import java.util.List;

import org.iweb.rpt.logic.SimpleReport;

public class Column {
	private String columnName; // 名称
	private String columnTitle; // 标题
	private int columnType; // 类型 String Date Integer Double
	private int isShow; // 是否为显示标题 0否 1是
	private int isSearch;// 是否作为查询条件 0 否 1是
	private int searchType;// 作为查询条件时的查询类型(equal/like/left like...)
	private int searchObjType;// 查询控件类型(text,select,date...)
	private List<ListObject> selectList; // 查询控件为select/checkbox/radio时，所需的List
	private Object defaultValue; // 控件上的默认值
	private String datePatten; // 当searchObjType为date型时,显示date的格式化参数 如:yyyy-MM-dd
	private int isLink; // 是否需要链接0不需要 1需要 2新窗口
	private String linkHref; // 超链接内容,如需要替换其中的内容作为参数,使用$parametername:columnName$或者$columnName$作为替换符号

	/**
	 * 全属性初始化
	 */
	public Column(String columnName, String columnTitle, int columnType, int isShow, int isSearch, int searchType,
			int searchObjType, List<ListObject> selectList, Object defaultValue, String datePatten, int isLink,
			String linkHref) {
		this.columnName = columnName;
		this.columnTitle = columnTitle;
		this.columnType = columnType;
		this.isShow = isShow;
		this.isSearch = isSearch;
		this.searchType = searchType;
		this.searchObjType = searchObjType;
		this.selectList = selectList;
		this.datePatten = datePatten;
		this.defaultValue = defaultValue;
		this.isLink = isLink;
		this.linkHref = linkHref;
	}

	/**
	 * String属性的初始化(非查询条件属性)
	 * 
	 * @return
	 */
	public Column(String columnName, String columnTitle, int isShow) {
		this.columnName = columnName;
		this.columnTitle = columnTitle;
		this.columnType = SimpleReport.ColumnType_String;
		this.isShow = isShow;
		this.isSearch = 0;
		// this.searchType = SimpleReport.SearchType_Like;
		// this.searchObjType = SimpleReport.ObjType_Text;
		// this.selectList = null;
		// this.defaultValue = null;
		this.isLink = 0;
		// this.linkHref = null;
	}

	/**
	 * String属性的初始化(作为查询条件)
	 * 
	 * @return
	 */
	public Column(String columnName, String columnTitle, int isShow, int searchType, Object defaultValue) {
		this.columnName = columnName;
		this.columnTitle = columnTitle;
		this.columnType = SimpleReport.ColumnType_String;
		this.isShow = isShow;
		this.isSearch = 1;
		this.searchType = searchType;
		this.searchObjType = SimpleReport.ObjType_Text;
		// this.selectList = null;
		this.defaultValue = defaultValue;
		this.isLink = 0;
		// this.linkHref = null;
	}

	/**
	 * date型通用初始化
	 * 
	 */
	public Column(String columnName, String columnTitle, int isShow, int isSearch, int searchType, Object defaultValue,
			String datePatten) {
		this.columnName = columnName;
		this.columnTitle = columnTitle;
		this.columnType = SimpleReport.ColumnType_Date;
		this.isShow = isShow;
		this.isSearch = isSearch;
		this.searchType = searchType;
		this.searchObjType = SimpleReport.ObjType_Date;
		this.selectList = null;
		this.datePatten = datePatten;
		this.defaultValue = defaultValue;
		this.isLink = 0;
		this.linkHref = null;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnTitle() {
		return columnTitle;
	}

	public void setColumnTitle(String columnTitle) {
		this.columnTitle = columnTitle;
	}

	public int getColumnType() {
		return columnType;
	}

	public void setColumnType(int columnType) {
		this.columnType = columnType;
	}

	public Object getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(Object defaultValue) {
		this.defaultValue = defaultValue;
	}

	public int getIsShow() {
		return isShow;
	}

	public void setIsShow(int isShow) {
		this.isShow = isShow;
	}

	public int getIsSearch() {
		return isSearch;
	}

	public void setIsSearch(int isSearch) {
		this.isSearch = isSearch;
	}

	public int getSearchType() {
		return searchType;
	}

	public void setSearchType(int searchType) {
		this.searchType = searchType;
	}

	public int getSearchObjType() {
		return searchObjType;
	}

	public void setSearchObjType(int searchObjType) {
		this.searchObjType = searchObjType;
	}

	public List<ListObject> getSelectList() {
		return selectList;
	}

	public void setSelectList(List<ListObject> selectList) {
		this.selectList = selectList;
	}

	public String getDatePatten() {
		return datePatten;
	}

	public void setDatePatten(String datePatten) {
		this.datePatten = datePatten;
	}

	public int getIsLink() {
		return isLink;
	}

	public void setIsLink(int isLink) {
		this.isLink = isLink;
	}

	public String getLinkHref() {
		return linkHref;
	}

	public void setLinkHref(String linkHref) {
		this.linkHref = linkHref;
	}

}
