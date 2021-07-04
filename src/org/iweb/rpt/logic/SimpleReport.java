package org.iweb.rpt.logic;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.rpt.dao.SimpleReportDAO;
import org.iweb.rpt.domain.Column;
import org.iweb.rpt.domain.ListObject;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.DateUtil;
import org.iweb.sys.NumberUtil;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

public abstract class SimpleReport {
	private static Log log = LogFactory.getLog(SimpleReport.class);

	private HashMap<String, Object> searchMap;
	private Map paramMap;
	protected SimpleReportDAO dao;

	private List<Column> list;
	private List<Map<String, Object>> rlist;

	private boolean splitPage = true;

	private int pageSize = 0;
	private int recCount;

	protected HashMap<String, Object> getSearchMap() {
		return searchMap;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public boolean isSplitPage() {
		return splitPage;
	}

	public void setSplitPage(boolean splitPage) {
		this.splitPage = splitPage;
	}

	public void init(Map parameters) {
		list = getColumns();
		dao = new SimpleReportDAO();
		searchMap = new HashMap<String, Object>();
		setSearchMap(parameters);
		searchMapOperation();
		// 生成数据内容
		try {
			setResult();
		} catch (Exception e) {
			rlist = new ArrayList<Map<String, Object>>();
			log.error("获取结果数据异常!", e);
		}
	}

	/**
	 * 在生成数据之前的操作,子类可以重载操作
	 */
	protected void searchMapOperation() {
	}

	/**
	 * 包含标题和查询表单
	 * 
	 * @return
	 */
	public String getHeadHtml() {
		StringBuffer sb = new StringBuffer();
		sb.append("<div class=\"dq_step\">").append(getSerachName()).append("</div>");
		sb.append("<form id=\"simple_search\" name=\"simple_search\" action=\"").append(Parameters.getRelativePath())
		.append("rpt/simple\" method=\"get\"> ");
		int i = 0;
		Object tmp_value;
		String tmp_str;
		for (Iterator<Column> it = list.iterator(); it.hasNext();) {
			Column col = it.next();
			if (col.getIsSearch() == 1) {
				// 得到控件的赋值
				if (searchMap != null && searchMap.containsKey(col.getColumnName())
						&& !ToolsUtil.isEmpty(searchMap.get(col.getColumnName()))) {
					tmp_value = searchMap.get(col.getColumnName());
				} else {
					tmp_value = "";
				}
				tmp_value = tmp_value == null ? "" : tmp_value;
				try {
					switch (col.getColumnType()) {
					case SimpleReport.ColumnType_String:
						tmp_str = tmp_value.toString();
						break;
					case SimpleReport.ColumnType_Date:
						if (tmp_value instanceof java.util.Date)
							tmp_str = DateUtil.getDateString((Date) tmp_value, col.getDatePatten());
						else
							tmp_str = "";
						break;
					case SimpleReport.ColumnType_Int:
						if (tmp_value instanceof java.lang.Integer)
							tmp_str = tmp_value.toString();
						else
							tmp_str = "";
						break;
					case SimpleReport.ColumnType_Double:
						if (tmp_value instanceof java.lang.Double)
							tmp_str = tmp_value.toString();
						else
							tmp_str = "";
						break;
					default:
						tmp_str = "";
						break;
					}
				} catch (Exception e) {
					log.warn("(getTmpStr)转换参数出现异常!" + col.getColumnName(), e);
					tmp_str = "";
				}
				if (i % 2 == 0)
		sb.append("<div class=\"label_main\">");
		sb.append("<div class=\"label_hang\">");
		sb.append("<div class=\"label_ltit\">").append(col.getColumnTitle()).append(":</div> ");
		sb.append("<div class=\"label_rwben label_rwb\">");
		if (col.getSearchObjType() == SimpleReport.ObjType_Text) {// 当控件为文本时 SimpleReport.ObjType_Text
			sb.append("<input type=\"text\" name=").append(col.getColumnName()).append(" value=\"")
					.append(tmp_str).append("\" />");
		} else if (col.getSearchObjType() == SimpleReport.ObjType_Date) {// 当控件为时间时 SimpleReport.ObjType_Text
			sb.append("<input type=\"text\" id=\"").append(col.getColumnName()).append("_id")
					.append("\" name=\"").append(col.getColumnName()).append("\" value=\"").append(tmp_str)
					.append("\" />");
			sb.append("<script type=\"text/javascript\">$(\"#").append(col.getColumnName()).append("_id")
					.append("\").datepicker();</script>");
		} else if (col.getSearchObjType() == SimpleReport.ObjType_Select) {
			sb.append("<select name=\"").append(col.getColumnName()).append("\">");
			sb.append("<option value=\"\">请选择</option>");
			for (Iterator<ListObject> sit = col.getSelectList().iterator(); sit.hasNext();) {
				ListObject lo = sit.next();
				sb.append("<option value=\"").append(lo.getKey()).append("\" ");
				if (lo.getKey().equals(tmp_str)) {
					sb.append(" selected=\"selected\" ");
				}
				sb.append(">").append(lo.getValue()).append("</option>");
			}
			sb.append("</select>");
		} else if (col.getSearchObjType() == SimpleReport.ObjType_Radio) {
			for (Iterator<ListObject> sit = col.getSelectList().iterator(); sit.hasNext();) {
				ListObject lo = sit.next();
				sb.append("<input name=\"").append(col.getColumnName()).append("\" ");
				sb.append("type=\"radio\" value=\"").append(lo.getKey()).append("\" ");
				if (lo.getKey().equals(tmp_str)) {
					sb.append(" checked=\"checked\" ");
				}
				sb.append(" /> ").append(lo.getValue()).append(" ");
			}
		} else if (col.getSearchObjType() == SimpleReport.ObjType_CheckBox) {
			for (Iterator<ListObject> sit = col.getSelectList().iterator(); sit.hasNext();) {
				ListObject lo = sit.next();
				sb.append("<input name=\"").append(col.getColumnName()).append("\" ");
				sb.append("type=\"checkbox\" value=\"").append(lo.getKey()).append("\" ");
				if (lo.getKey().equals(tmp_str)) {
					sb.append(" checked=\"checked\" ");
				}
				sb.append(" /> ").append(lo.getValue()).append(" ");
			}
		}
		sb.append("</div>");
		sb.append("</div>");
		sb.append("<div class=\"label_hang label_button tac\">");
		sb.append("<input name=\"initClassName\" type=\"hidden\" value=\"").append(getInitShortClassName())
		.append("\"/>");
		sb.append("<input type=\"submit\" value=\"查询\"/>");
		sb.append("<input type=\"reset\" value=\"重置\"/>");
		sb.append("</div>");
		if (i % 2 == 1)
			sb.append("</div>");
		i++;
			}
		}
		sb.append("</form>");
		
		
		sb.append("<div class=\"ilistsearch\">");

		sb.append("<form id=\"simple_search\" name=\"simple_search\" action=\"").append(Parameters.getRelativePath())
				.append("rpt/simple\" method=\"get\"> ");
		sb.append("<table class=\"ilisttable\" id=\"serach_table\" width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bordercolor=\"#8B8B8B\">");

				// 描绘控件

		return sb.toString();
	}

	/**
	 * 返回结果表
	 * 
	 * @return
	 */
	public String getResultHtml() {
		StringBuffer sb = new StringBuffer();
		sb.append("<table class=\"ilisttable\" id=\"table1\" width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bordercolor=\"#8B8B8B\">");

		// 生成表头
		sb.append("<tr>");
		for (Iterator<Column> it = list.iterator(); it.hasNext();) {
			Column col = it.next();
			if (col.getIsShow() == 1) {
				sb.append("<th>").append(col.getColumnTitle()).append("</th>");
			}
		}
		sb.append("</tr>");

		List<Map<String, Object>> resultList = getResultList();

		// 写入数据内容
		int n = 0;// 计数器

		StringBuffer tmpsb = new StringBuffer();
		String tmp_str = ""; // 临时显示字符
		String tmp_str2 = ""; // 临时col_name
		Pattern p = Pattern.compile("\\$\\S*?\\$");
		Matcher m;
		HashMap<String, Object> tmp_map = new HashMap<String, Object>();
		if (resultList != null && resultList.size() != 0)
			for (Iterator ims = resultList.iterator(); ims.hasNext();) {
				tmpsb.delete(0, tmpsb.length());
				tmp_map.clear();

				Map im = (Map) ims.next();
				upperKey(im);
				if (n % 2 == 0) {
					tmpsb.append("<tr class=\"oddStyle\">");
				} else {
					tmpsb.append("<tr class=\"evenStyle\">");
				}

				for (Iterator<Column> it = list.iterator(); it.hasNext();) {
					Column col = it.next();
					if (col.getIsShow() == 1) {
						if (im.containsKey(col.getColumnName().toUpperCase())) {
							Object tmp = im.get(col.getColumnName().toUpperCase());
							tmpsb.append("<td>");
							if (col.getIsLink() == 2) {
								tmpsb.append("<a href='").append(col.getLinkHref()).append("' target='_blank'>");
							} else if (col.getIsLink() == 1) {
								tmpsb.append("<a href='").append(col.getLinkHref()).append("'>");
							}
							if (tmp instanceof java.util.Date) {
								try {
									tmpsb.append(DateUtil.getDateString((Date) tmp, col.getDatePatten()));
									tmp_map.put(col.getColumnName(),
											DateUtil.getDateString((Date) tmp, col.getDatePatten()));
								} catch (Exception e) {
									log.warn("转换日期失败,请检查patten是否正确", e);
								}
							} else if (tmp instanceof java.lang.Double) {
								tmpsb.append(NumberUtil.formatDouble((Double) tmp, null));
								tmp_map.put(col.getColumnName(), NumberUtil.formatDouble((Double) tmp, null));
							} else if (tmp instanceof java.math.BigDecimal) {
								if (tmp.toString().indexOf(".") >= 0) {
									// 有小数点,是浮点数
									tmpsb.append(NumberUtil.roundDouble(((java.math.BigDecimal) tmp).doubleValue(), 2));
									tmp_map.put(col.getColumnName(),
											NumberUtil.roundDouble(((java.math.BigDecimal) tmp).doubleValue(), 2));
								} else {
									// 无小数点,是整数
									tmpsb.append(tmp);
									tmp_map.put(col.getColumnName(), tmp);
								}
							} else {
								tmpsb.append(tmp == null ? "" : tmp);
								tmp_map.put(col.getColumnName(), tmp == null ? "" : tmp);
							}
							if (col.getIsLink() == 1 || col.getIsLink() == 2) {
								tmpsb.append("</a>");
							}
							tmpsb.append("</td>");
						} else {
							tmpsb.append("<td></td>");
						}
					}
				}
				tmpsb.append("</tr>");

				tmp_str = tmpsb.toString();

				// 使用正则表达式替换$$之间的内容
				m = p.matcher(tmp_str);
				while (m.find()) {
					tmp_str2 = tmp_str.substring(m.start() + 1, m.end() - 1);

					//
					if (tmp_str2.indexOf(":") == -1) {
						tmp_str = tmp_str.replaceAll("\\$" + tmp_str2 + "\\$",
								tmp_str2 + "=" + ToolsUtil.getEmpty(tmp_map.get(tmp_str2)));
					} else {
						String[] tmp_arr = tmp_str2.split(":");
						tmp_str = tmp_str.replaceAll("\\$" + tmp_str2 + "\\$",
								tmp_arr[0] + "=" + ToolsUtil.getEmpty(tmp_map.get(tmp_arr[1])));
					}

					m = p.matcher(tmp_str);
				}

				sb.append(tmp_str);

				n++;
			}

		sb.append("</table>");

		// 生成分页区
		if (isSplitPage()) {
			sb.append("<table class=\"ilisttable\" id=\"table1\" width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\" bordercolor=\"#8B8B8B\">");
			sb.append("<tr><td class=\"buttonarea\">");
			sb.append("<script type=\"text/javascript\">var spage = new ShowPage();");
			sb.append("spage.show2(").append(this.getRecCount()).append(",").append(this.getPageSize()).append(",2);");
			sb.append("</script></td></tr>");
			sb.append("</table>");
		}
		return sb.toString();
	}

	protected List<Map<String, Object>> getRlist() {
		return rlist;
	}

	// 把KEY都转换成大写
	private void upperKey(Map m) {
		String o_key, n_key;
		ArrayList<String> removeList = new ArrayList<String>();
		Map putList = new HashMap<String, Object>();

		Object[] keys = m.keySet().toArray();
		for (int i = 0; i < keys.length; i++) {
			o_key = (String) keys[i];
			n_key = o_key.toUpperCase();
			if (n_key.equals(o_key)) {
				continue;
			} else {
				m.put(n_key, m.get(o_key));
				m.remove(o_key);
			}
		}
	}

	private void setResult() throws Exception {
		String conditionSqlText = "";
		String searchTypeStr = "";
		String searchselect="";
		String searselectright="";
		for (Iterator<Map.Entry<String, Object>> iterator = searchMap.entrySet().iterator(); iterator.hasNext();) {
			Map.Entry<String, Object> m = iterator.next();
			for (Iterator<Column> it = list.iterator(); it.hasNext();) {
				Column col = it.next();
				if (col.getColumnName().equals(m.getKey())) {
					switch (col.getSearchType()) {
					case SimpleReport.SearchType_Equel:
						searchTypeStr = " = ";
						break;
					case SimpleReport.SearchType_Less:
						searchTypeStr = " < ";
						break;
					case SimpleReport.SearchType_Less_Equel:
						searchTypeStr = " <= ";
						break;
					case SimpleReport.SearchType_Like:
						searchTypeStr = " LIKE ";
						break;
					case SimpleReport.SearchType_Like_Both:
						searchTypeStr = " LIKE ";
						searchselect="%";
						searselectright="%";
						break;
					case SimpleReport.SearchType_Like_Left:
						searchTypeStr = " LIKE ";
						searchselect="%";
						break;
					case SimpleReport.SearchType_Like_Right:
						searchTypeStr = " LIKE ";
						searselectright="%";
						break;
					case SimpleReport.SearchType_More:
						searchTypeStr = " > ";
						break;
					case SimpleReport.SearchType_More_Equel:
						searchTypeStr = " >= ";
						break;
					case SimpleReport.SearchType_Not_Equel:
						searchTypeStr = " <> ";
						break;
					default:
						searchTypeStr = " = ";
					}

					switch (col.getColumnType()) {
					case SimpleReport.ColumnType_String:
						conditionSqlText += " And " + m.getKey() + searchTypeStr +searchselect+ "'" + m.getValue() +searselectright+ "'";
						break;
					case SimpleReport.ColumnType_Date:
						conditionSqlText += " And " + m.getKey() + searchTypeStr + "to_date('"
								+ DateUtil.getDateString((Date) m.getValue(), "yyyy-MM-dd") + "','yyyy-mm-dd')";
						break;
					case SimpleReport.ColumnType_Int:
						conditionSqlText += " And " + m.getKey() + searchTypeStr + "" + m.getValue();
						break;
					case SimpleReport.ColumnType_Double:
						conditionSqlText += " And " + m.getKey() + searchTypeStr + "" + m.getValue();
						break;
					default:
						conditionSqlText += " And " + m.getKey() + searchTypeStr + "'" + m.getValue() + "'";
						break;
					}
				}
			}
		}

		String resultSQL = getStartSqlText() + " " + getMiddleSqlText() + " " + conditionSqlText + " "
				+ getEndSqlText();

		HashMap<String, Object> map = new HashMap<String, Object>();

		// 如果不需要分页,则不需要执行Count的SQL,直接是结果集的size
		if (isSplitPage()) {
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			if (this.getPageSize() > 0) {
				map.put(Parameters.Page_Size_Str, this.getPageSize());
			} else {
				this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			}
			map.put("sqltext", resultSQL);
			rlist = dao.getSimpleResult(map);
			map.clear();
			String countSQL = "SELECT COUNT(*) FROM ( " + resultSQL + ") A";
			map.put("sqltext", countSQL);
			this.setRecCount(dao.getSimpleResultCount(map));
		} else {
			map.put("sqltext", resultSQL);
			rlist = dao.getSimpleResult(map);
			this.setRecCount(rlist.size());
		}

		// 全部转成大写
		for (Iterator<Map<String, Object>> iterator = rlist.iterator(); iterator.hasNext();) {
			upperKey(iterator.next());
		}
	}

	public void setSearchMap(Map parameterMap) {
		for (Iterator<Column> it = list.iterator(); it.hasNext();) {
			Column col = it.next();
			if (col.getIsSearch() == 1) {
				if (parameterMap.containsKey(col.getColumnName())) {
					String[] t_1 = (String[]) parameterMap.get(col.getColumnName());
					if (t_1.length > 0 && !ToolsUtil.isEmpty(t_1[0])) {
						try {
							switch (col.getColumnType()) {
							case SimpleReport.ColumnType_String:
								searchMap.put(col.getColumnName(), t_1[0]);
								break;
							case SimpleReport.ColumnType_Date:
								searchMap.put(col.getColumnName(), DateUtil.getDate(t_1[0], "yyyy-MM-dd"));
								break;
							case SimpleReport.ColumnType_Int:
								searchMap.put(col.getColumnName(), new Integer(Integer.parseInt(t_1[0])));
								break;
							case SimpleReport.ColumnType_Double:
								searchMap.put(col.getColumnName(), new Double(Double.parseDouble(t_1[0])));
								break;
							default:
								searchMap.put(col.getColumnName(), t_1[0]);
								break;
							}
						} catch (Exception e) {
							log.warn("(setSearchMap)转换参数出现异常!" + col.getColumnName(), e);
						}
					}
				} else if (!ToolsUtil.isEmpty(col.getDefaultValue())) {
					searchMap.put(col.getColumnName(), col.getDefaultValue());
				}
			}
		}
	}

	// Column.searchType
	public static final int SearchType_Equel = 0;
	public static final int SearchType_Like = 1;
	public static final int SearchType_Like_Both = 2;
	public static final int SearchType_Like_Left = 3;
	public static final int SearchType_Like_Right = 4;
	public static final int SearchType_More = 5;
	public static final int SearchType_More_Equel = 6;
	public static final int SearchType_Less = 7;
	public static final int SearchType_Less_Equel = 8;
	public static final int SearchType_Not_Equel = 9;

	// Column.seatchObjType
	public static final int ObjType_Text = 0;
	public static final int ObjType_Select = 1;
	public static final int ObjType_Date = 2;
	public static final int ObjType_Radio = 3;
	public static final int ObjType_CheckBox = 4;

	// Column.columnType
	public static final int ColumnType_String = 0;
	public static final int ColumnType_Date = 1;
	public static final int ColumnType_Int = 2;
	public static final int ColumnType_Double = 3;

	/**
	 * 定义查询名称
	 * 
	 * @return
	 */
	public abstract String getSerachName();

	/**
	 * 赋值权限ID,设定相关访问权限
	 * 
	 * @return
	 */
	public abstract String getPrvgId();

	/**
	 * 定义查询列
	 * 
	 * @return
	 */
	public abstract List<Column> getColumns();

	/**
	 * SQL开始语句,一般定义在From之前,不包含From
	 * 
	 * @return
	 */
	public abstract String getStartSqlText();

	/**
	 * SQL中间语句,一般定义在From之后,包含From
	 * 
	 * @return
	 */
	public abstract String getMiddleSqlText();

	/**
	 * 结束语句,可包含排序和统计(MiddleSqlText 和EndSqlText中间将插入条件 )
	 * 
	 * @return
	 */
	public abstract String getEndSqlText();

	/**
	 * 子类类名的简写(去掉前面PRT的子类名次)
	 * 
	 * @return
	 */
	public abstract String getInitShortClassName();

	/**
	 * 为改变结果Map做接口
	 * 
	 * @return
	 */
	public abstract List<Map<String, Object>> getResultList();

	/**
	 * 报表注释(放在分页下作为报表的说明)
	 * 
	 * @return
	 */
	public abstract String getReportRemark();
}
