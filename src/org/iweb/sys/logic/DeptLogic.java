/**
 * 
 */
package org.iweb.sys.logic;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.dao.DepartmentDAO;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-1-28 上午10:40:03
 */
public class DeptLogic {
	public static List<String> getPermitDept() {
		DepartmentDAO ddao = new DepartmentDAO();
		HashMap<String, Object> map = new HashMap<>();
		String user_dept_code = ContextHelper.getUserLoginInfo().getDept_code();
		String global_dept_function = ContextHelper.getPermitFunction("GLOBAL_PRVG_DEPT_FUNCTION");
		System.out.println("得到用户的GLOBAL_PRVG_DEPT_FUNCTION:" + global_dept_function);
		global_dept_function = ToolsUtil.isEmpty(global_dept_function) ? "0.1" : global_dept_function;
		if (ContextHelper.isAdmin()) { return ddao.listPermit(null); }

		String[] fs = global_dept_function.split("\\.");
		List<String> dlist = null;
		// 必须是长度2才能进入判断
		if (fs.length == 2) {
			String fs0 = fs[0].trim();
			String fs1 = fs[1].trim();
			if ("0".equals(fs0)) { // 0.x 以个人为基础查询
				if ("0".equals(fs1)) { // 0.0 全部门查询,最高权限
					dlist = ddao.listPermit(null);
				} else if ("1".equals(fs1)) { // 0.1 无权限部门,只能查自己
					return null;
				}
			} else if ("1".equals(fs0)) { // 1.x 以个人的部门为基础查询
				map.clear();
				if ("0".equals(fs1)) {// 1.0 列出自己及下属部门
					map.put("dept_code", user_dept_code + "%");
				} else { // 1.x 截取自己部门的x位进行like查询
					int tn = 0;
					try {
						tn = Integer.parseInt(fs1);
						map.put("dept_code", user_dept_code.substring(0, Math.min(tn, user_dept_code.length())) + "%");
					} catch (Exception e) {// 格式错误,直接返回无权限
						return null;
					}
				}
				dlist = ddao.listPermit(map);
			} else if ("2".equals(fs0)) { // 2.x 以个人的部门的父部门为基础查询下一级部门
				map.clear();
				if ("0".equals(fs1)) {// 1.0 列出自己及下属部门
					map.put("parent_dept", user_dept_code);
				} else { // 1.x 截取自己部门的x位进行like查询
					int tn = 0;
					try {
						tn = Integer.parseInt(fs1);
						map.put("parent_dept", user_dept_code.substring(0, Math.min(tn, user_dept_code.length())));
					} catch (Exception e) {// 格式错误,直接返回无权限
						return null;
					}
				}
				dlist = ddao.listPermit(map);
			} else if ("3".equals(fs0)) {// 3.xxxx 直接以xxxx作为dept_code查询
				map.clear();
				map.put("dept_code", fs1);
				dlist = ddao.listPermit(map);
			} else if ("4".equals(fs0)) {// 4.xxxx 直接以xxxx作为dept_code+%查询
				map.clear();
				map.put("dept_code", fs1 + "%");
				dlist = ddao.listPermit(map);
			} else if ("5".equals(fs0)) {// 5.xxxx 直接以xxxx作为parent_dept查询
				map.clear();
				map.put("parent_dept", fs1);
				dlist = ddao.listPermit(map);
			}
		}

		// 只要有部门权限,就加上自己的部门
		if (dlist != null && !dlist.contains(user_dept_code)) {
			dlist.add(user_dept_code);
		}
		if (dlist == null) {
			dlist = new ArrayList<>();
		}

		System.out.println("得到用户部门权限列表:" + dlist);
		return dlist;
	}

	public static String[] getPermitDeptArray() {
		List l = getPermitDept();
		if (l == null) {
			return null;
		} else {
			return (String[]) l.toArray();
		}
	}
}
