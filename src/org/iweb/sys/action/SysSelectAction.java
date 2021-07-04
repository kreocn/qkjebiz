package org.iweb.sys.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.UserLoginInfo;

import com.opensymphony.xwork2.ActionSupport;

/**
 * 系统选择项Action,包含部门列表/角色列表/用户列表
 * 
 * @author Kreo
 */
public class SysSelectAction extends ActionSupport {
	private static final long serialVersionUID = -3585352950575438601L;
	private static Log log = LogFactory.getLog(SysSelectAction.class);

	private Map<String, Object> map = new HashMap<String, Object>();

	private List<Department> depts;
	// dept_code为当先登录人的部门代码
	// 为空时表示以{dept_code}为起始部门,
	// 当dept_mode=0时,则代表以{dept_code的父部门}作为起始部门,如dept_code的父部门为空,则此参数无效
	private Integer dept_mode;
	private String user_pri;
	private String special;//=1查询全部部门

	// 起始部门代码,为以后集团化运营打下基础
	private String dept_code;
	private String check_code;// 订单发货部门

	public String getSpecial() {
		return special;
	}

	public void setSpecial(String special) {
		this.special = special;
	}

	public String getUser_pri() {
		return user_pri;
	}

	public void setUser_pri(String user_pri) {
		this.user_pri = user_pri;
	}

	public List<Department> getDepts() {
		return depts;
	}

	public void setDepts(List<Department> depts) {
		this.depts = depts;
	}

	public String getDept_code() {
		return dept_code;
	}

	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}

	public Integer getDept_mode() {
		return dept_mode;
	}

	public void setDept_mode(Integer dept_mode) {
		this.dept_mode = dept_mode;
	}

	public String getCheck_code() {
		return check_code;
	}

	public void setCheck_code(String check_code) {
		this.check_code = check_code;
	}

	public String dept_select_limit() throws Exception {
		// ContextHelper.isPermits(new String[]{"SYS_SELECT_DEPT_LIMIT_LIST","SYS_SELECT_DEPT_LIST_ALL"}, false);
		// ContextHelper.isPermit("SYS_SELECT_DEPT_LIMIT_LIST");
		// Integer permitType = ContextHelper.getPermitType("SYS_SELECT_DEPT_LIMIT_LIST");
		ContextHelper.isPermit("SYS_MANAGER_DEPT_LIST");
		boolean flag = ContextHelper.checkPermit2("SYS_SELECT_DEPT_LIST_ALL", null);
		List<Department> dd = new ArrayList<>();
		try {
			DepartmentDAO dao = new DepartmentDAO();
			if (ContextHelper.isAdmin() || flag == true) {
				this.setDepts(dao.list(null));
			} else {
				map.clear();
				map.put("check_code", ContextHelper.getUserLoginInfo().getDept_code());
				this.setDepts(dao.list(map));
			}
			/*
			 * else if (permitType == 1) {
			 * // 则只显示自己对应的下级部门及直属上级部门
			 * if (dept_mode == 0) { // 以{dept_code的父部门}作为起始部门
			 * map.clear();
			 * map.put("dept_code", ContextHelper.getUserLoginInfo().getDept_code());
			 * this.setDepts(dao.list(map));
			 * String p_dept = ((Department) this.getDepts().get(0)).getParent_dept();
			 * if (ToolsUtil.isEmpty(p_dept)) { // 如父部门为空,则还是以本身作为起始
			 * this.setDepts(ToolsUtil.getTreeNode(dao.list(null), "dept_code", "parent_dept", ContextHelper
			 * .getUserLoginInfo().getDept_code(), 2, true));
			 * } else {
			 * this.setDepts(ToolsUtil.getTreeNode(dao.list(null), "dept_code", "parent_dept", p_dept, 2, true));
			 * }
			 * }
			 * else { // 以自身部门为起始部门
			 * this.setDepts(ToolsUtil.getTreeNode(dao.list(null), "dept_code", "parent_dept", ContextHelper
			 * .getUserLoginInfo().getDept_code(), 3, true));
			 * }
			 * } else if (permitType == 0) {
			 * map.clear();
			 * map.put("dept_code", ContextHelper.getUserLoginInfo().getDept_code());
			 * this.setDepts(dao.list(map));
			 * }
			 */
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!limit_dept_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!limit_dept_select 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String dept_select_all() throws Exception {
		// ContextHelper.isPermit("SYS_SELECT_DEPT_LIST");
		try {
			if (ContextHelper.checkPermit("SYS_SELECT_DEPT_LIST")) {
				DepartmentDAO dao = new DepartmentDAO();
				this.setDepts(dao.list(null));
			} else {
				return dept_permit_select();
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!all_dept_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!all_dept_select 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String dept_permit_select() throws Exception {
		// ContextHelper.isPermit("GLOBAL_PRVG_DEPT_FUNCTION");
		try {
			DepartmentDAO dao = new DepartmentDAO();
			map.clear();
			boolean flag = ContextHelper.checkPermit2("SYS_SELECT_DEPT_LIST_ALL", null);
			if (ContextHelper.isAdmin() || flag == true || (special!=null && !special.equals(""))) {
			}else{
				if (ContextHelper.getUserLoginInfo().getPermit_depts() == null) {
					map.put("dept_code", ContextHelper.getUserLoginDept()); // 能选到自己的部门
				} else {
					if(user_pri!=null&& !user_pri.equals("")){
						dept_permit_select2(user_pri);
					}else{
						String str = ContextHelper.getUserLoginPermitDepts().toString();
						// String s1[] = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
						str = str.replaceAll("\\[", "");
						str = str.replace("\\]", "");
						str = str.replace("]", "");
						String s2[] = str.split(",");
						if (str.contains("#")) {
							Set<String> dset = new HashSet<>();
							Set<String> dsetall = new HashSet<>();
							if (s2 != null) {
								for (int i = 0; i < s2.length; i++) {
									if (s2[i].contains("#")) {
										dset.add(s2[i].substring(s2[i].indexOf("#") + 1, s2[i].length()).trim());
									} else {
										if (dset.size() > 0) {
											if (!dsetall.contains(s2[i].trim() + ",") && !dsetall.contains(s2[i].trim() + "]")) {
												dsetall.add(s2[i].trim());
											}
										} else {
											dsetall.add(s2[i].trim());
										}
									}

								}
							} else {
								String code = str.substring(str.indexOf("#") + 1, str.length());
								dset.add(code.trim());
							}
							List<String> dlist = new ArrayList<>();
							if (dset.size() > 0) {
								dlist.addAll(dset);
							}
							if (dsetall.size() > 0) {
								dlist.addAll(dsetall);
							}
							map.put("dept_codes", dlist);
						} else {
							map.put("dept_codes", ContextHelper.getUserLoginPermitDepts());
						}
					}
				}
			}
			
			if (check_code != null) {
				map.remove("dept_code");
				map.remove("dept_codes");
			}
			this.setDepts(dao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!dept_permit_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!dept_permit_select 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	
	public String dept_permit_select2(String p_id) throws Exception {
		// ContextHelper.isPermit("GLOBAL_PRVG_DEPT_FUNCTION");
		try {
			DepartmentDAO dao = new DepartmentDAO();
			map.clear();
			if (ContextHelper.getUserLoginInfo().getPermit_depts() == null) {
				map.put("dept_code", ContextHelper.getUserLoginDept()); // 能选到自己的部门
			} else {
				UserLoginInfo ulf = ContextHelper.getUserLoginInfo();
				// String str = ulf.getUser_prvg_map().get(p_id);
				// String s1[] = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
				Set<String> dset = new HashSet<>();
				Set<String> dsetall = new HashSet<>();

				String value = ulf.getUser_prvg_map().get(p_id);
				if (value.contains(",")) {
					String s1[] = (String[]) JSONUtil.toObject(value, String[].class);// 转换成数组
					for (int i = 0; i < s1.length; i++) {
						if (s1[i].contains("#")) {
							dset.add(s1[i].substring(s1[i].indexOf("#") + 1, s1[i].length()).trim());
						} else {
							dsetall.add(s1[i].trim());
						}
					}
				} else {
					String s1[] = (String[]) JSONUtil.toObject(value, String[].class);// 转换成数组
					if (s1 != null) {
						for (int i = 0; i < s1.length; i++) {
							if (s1[i].contains("#")) {
								dset.add(s1[i].substring(s1[i].indexOf("#") + 1, s1[i].length()).trim());
							} else {
								dsetall.add(s1[i].trim());
							}
						}
					} else {
						if (value.contains("#")) {
							dset.add(value.substring(value.indexOf("#") + 1, value.length()).trim());
						} else {
							dsetall.add(value);
						}
					}

				}
				List<String> dlist = new ArrayList<>();
				if (dset.size() > 0) {
					dlist.addAll(dset);
				}
				if (dsetall.size() > 0) {
					dlist.addAll(dsetall);
				}
				map.put("dept_codes", dlist);
			}

			if (check_code != null) {
				map.remove("dept_code");
				map.remove("dept_codes");
			}
			this.setDepts(dao.list(map));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!dept_permit_select 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!dept_permit_select 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
