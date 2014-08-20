package org.iweb.sys.logic;

import java.util.HashMap;
import java.util.Map;

import org.iweb.rpt.dao.SimpleReportDAO;
import org.iweb.rpt.domain.ListObject;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

/**
 * 
 * @version 1.0
 * @author 周骏宇
 * @description
 * @date 2013-12-15 下午12:25:59
 */
public class SpecialPrivilegeExecute {
	private HashMap<String, SpecialPrivilege> specialPrivileges = new HashMap<String, SpecialPrivilege>();

	public SpecialPrivilegeExecute() {
		this.addExecuteListener("INFO_MANAGER_NEWSMANAGER", this.getNewsExecute());
		this.addExecuteListener("GLOBAL_PRVG_DEPT_FUNCTION", this.getGolbalDeptFuntionExecute());
	}

	/**
	 * 直接通过网页的request取值
	 * 
	 * @param privilege_id
	 * @return
	 */
	public String getRealFromHtml(String privilege_id) {
		return getRealFromHtml(privilege_id,
				ContextHelper.getRequest().getParameter(specialPrivileges.get(privilege_id).getForm_name()));
	}

	public String getRealFromHtml(String privilege_id, String privilege_value) {
		if (checkExecute(privilege_id)) {
			setSpecialPrivilegeShowValue(privilege_id, privilege_value);
			return this.getShowFormHtml(privilege_id);
		} else {
			return "";
		}
	}

	private boolean checkExecute(String privilege_id) {
		return specialPrivileges.containsKey(privilege_id);
	}

	private void setSpecialPrivilegeShowValue(String privilege_id, String show_value) {
		specialPrivileges.get(privilege_id).setShow_value(show_value);
	}

	/**
	 * 直接通过网页的request取值,去除列表中角色没有的特殊权限
	 * 
	 * @return HashMap &lt;privilege_id, show_value&gt;
	 */
	public HashMap<String, String> getSpecialPrivilegeShowValues() {
		HashMap<String, String> spsv = new HashMap<>();
		for (Map.Entry<String, SpecialPrivilege> entry : specialPrivileges.entrySet()) {
			SpecialPrivilege sp = entry.getValue();

			String[] sts = ContextHelper.getRequest().getParameterValues(sp.getForm_name());
			if (sts != null && sts.length > 0) {
				spsv.put(entry.getKey(), ToolsUtil.Array2String(sts, ","));
			}
		}
		return spsv;
	}

	private String getShowFormHtml(String privilege_id) {
		StringBuffer sb = new StringBuffer();

		SpecialPrivilege sp = specialPrivileges.get(privilege_id);
		sb.append("<tr><td class='specialprivilege_title'>");
		sb.append(sp.getSpecial_name());
		sb.append("</td><td>");

		String[] valueArray;
		if (ToolsUtil.isEmpty(sp.getShow_value())) {
			valueArray = new String[0];
		} else {
			valueArray = sp.getShow_value().split(",");
		}

		if (0 == sp.getShow_type()) { // 0:checkbox
			int n = 1;
			for (ListObject val : sp.getValue_list()) {
				String ele_id = sp.getForm_name() + "_" + (n++);
				sb.append("<span class='specialprivilege_list'>").append("<input type='checkbox' name='")
						.append(sp.getForm_name()).append("' value='").append(val.getKey()).append("' id='")
						.append(ele_id).append("'");

				if (ToolsUtil.isIn(val.getKey(), valueArray)) {
					sb.append("' checked='checked' ");
				}
				sb.append(" />");

				sb.append("<label for='").append(ele_id).append("'>").append(val.getValue()).append("</label>");

				sb.append("</span>");
			}
		} else if (1 == sp.getShow_type()) { // 1:radio
			for (ListObject val : sp.getValue_list()) {
				int n = 1;
				String ele_id = sp.getForm_name() + "_" + (n++);
				sb.append("<span class='specialprivilege_list'>").append("<input type='radio' name='")
						.append(sp.getForm_name()).append("' value='").append(val.getKey()).append("' id='")
						.append(ele_id).append("'");

				if (ToolsUtil.isIn(val.getKey(), valueArray)) {
					sb.append(" checked='checked' ");
				}
				sb.append(" />");

				sb.append("<label for='").append(ele_id).append("'>").append(val.getValue()).append("</label>");

				sb.append("</span>");
			}
		} else if (2 == sp.getShow_type()) { // 2:select
			sb.append("<select name='").append(sp.getForm_name()).append("'>");
			sb.append("<option value=''>-请选择-</option>");
			for (ListObject val : sp.getValue_list()) {
				sb.append("<option value='").append(val.getKey());
				if (ToolsUtil.isIn(val.getKey(), valueArray)) {
					sb.append("' selected='selected' ");
				}
				sb.append(">").append(val.getValue()).append("</option>");
			}
			sb.append("</select>");

		} else if (3 == sp.getShow_type()) { // 3:text
			sb.append("<input type='text' name='").append(sp.getForm_name()).append("' value='")
					.append(sp.getShow_value()).append("'/>");
		}

		sb.append("</td></tr>");

		return sb.toString();
	}

	private void addExecuteListener(String privilege_id, SpecialPrivilege sp) {
		specialPrivileges.put(privilege_id, sp);
	}

	private SpecialPrivilege getNewsExecute() {
		SpecialPrivilege news_sp = new SpecialPrivilege();
		news_sp.setPrivilege_id("INFO_MANAGER_NEWSMANAGER");
		news_sp.setSpecial_name("所管理的信息类别");
		news_sp.setShow_type(0);
		news_sp.setForm_name("newsmanagerclass");

		SimpleReportDAO sdao = new SimpleReportDAO();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("sqltext", "select uuid \"key\",title \"value\" from t_info_class;");
		news_sp.setValue_list(sdao.getSimpleList(map));
		return news_sp;
	}

	/**
	 * 关于配置方法,详见org.iweb.sys.logic.DeptLogin中的详细注释
	 * 
	 * @return
	 * @date 2014-1-28 下午4:46:30
	 * @see org.iweb.sys.logic.DeptLogic
	 */
	private SpecialPrivilege getGolbalDeptFuntionExecute() {
		SpecialPrivilege news_sp = new SpecialPrivilege();
		news_sp.setPrivilege_id("GLOBAL_PRVG_DEPT_FUNCTION");
		news_sp.setSpecial_name("拥有的部门权限");
		news_sp.setShow_type(3);
		news_sp.setForm_name("globaldeptfunction");
		return news_sp;
	}
}
