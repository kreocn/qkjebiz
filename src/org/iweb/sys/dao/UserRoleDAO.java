package org.iweb.sys.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.RolePrvg;
import org.iweb.sys.domain.UserRole;

public class UserRoleDAO extends AbstractDAO {

	public List listSysRole(Map<String, Object> map) {
		return super.list("sys_getSysRoles", map);
	}

	public List listRolePrvgAdd() {
		return super.list("sys_SysRolePrvg_Add", null);
	}

	public List listRolePrvgAll(Map<String, Object> map) {
		return super.list("sys_SysRolePrvg_All", map);
	}

	public List listRolePrvg(Map<String, Object> map) {
		return super.list("sys_getRolePrvg", map);
	}

	/**
	 * 会员中心
	 * 
	 * @return
	 */
	public List listUserRole(Map<String, Object> map) {
		return super.list("sys_getUserRoles", map);
	}

	public List listUserRolePrvgAdd() {
		return super.list("sys_UserRolePrvg_Add", null);
	}

	public List listUserRolePrvgAll(Map<String, Object> map) {
		return super.list("sys_UserRolePrvg_All", map);
	}

	/**
	 * 增加角色
	 * 
	 * @param role
	 * @param prvg_list
	 */
	public void add(UserRole role, List<String> prvg_list) {
		ArrayList<String> map_id_list = new ArrayList<String>();
		ArrayList<Object> parameter_list = new ArrayList<Object>();
		// 角色主表
		map_id_list.add("sys_addRoles");
		parameter_list.add(role);
		// ADD权限
		// 权限列表
		List<RolePrvg> rolePrvgs = new ArrayList<RolePrvg>();
		RolePrvg rolePrvg;
		for (int i = 0, n = prvg_list.size(); i < n; i++) {
			rolePrvg = new RolePrvg();
			rolePrvg.setUuid(ToolsUtil.getUUID());
			rolePrvg.setRole_id(role.getUuid());
			rolePrvg.setPrivilege_id(prvg_list.get(i));
			rolePrvg.setType(0);
			rolePrvgs.add(rolePrvg);
		}
		map_id_list.addAll(String2List("sys_addRolePrvg", prvg_list.size()));
		parameter_list.addAll(rolePrvgs);

		batchStatment(map_id_list, parameter_list, false);
	}

	/**
	 * 修改角色
	 * 
	 * @param role
	 * @param prvg_list
	 */
	public void save(UserRole role, List<String> prvg_list) {
		// 修改角色
		ArrayList<String> map_id_list = new ArrayList<String>();
		ArrayList<Object> parameter_list = new ArrayList<Object>();
		RolePrvg rolePrvg;

		// 角色主表
		map_id_list.add("sys_mdyRoles");
		parameter_list.add(role);

		// 得到以前的权限列表
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("role_id", role.getUuid());
		List<RolePrvg> o_rolePrvgs = listRolePrvg(map);

		// 删除以前的权限列表
		rolePrvg = new RolePrvg();
		rolePrvg.setRole_id(role.getUuid());
		map_id_list.add("sys_delRolePrvg");
		parameter_list.add(rolePrvg);

		// 修改后的权限列表
		List<RolePrvg> rolePrvgs = new ArrayList<RolePrvg>();
		RolePrvg o_rolePrvg; // 以前列表的RolePrvg临时对象
		int exists_index = -1;
		for (int i = 0, n = prvg_list.size(); i < n; i++) {
			for (int j = 0, k = o_rolePrvgs.size(); j < k; j++) {
				o_rolePrvg = o_rolePrvgs.get(j);
				// System.out.println(ToolsUtil.dumpObject(o_rolePrvg));
				if (o_rolePrvg.getPrivilege_id().equals(prvg_list.get(i))) {
					exists_index = j;
					break;
				}
			}

			rolePrvg = new RolePrvg();
			if (exists_index == -1) { // 没有旧的数据
				rolePrvg.setUuid(ToolsUtil.getUUID());
				rolePrvg.setRole_id(role.getUuid());
				rolePrvg.setPrivilege_id(prvg_list.get(i));
				rolePrvg.setType(0);
			} else { // 存在旧的数据,则使用旧的数据填充
				o_rolePrvg = o_rolePrvgs.get(exists_index);
				rolePrvg.setUuid(o_rolePrvg.getUuid());
				rolePrvg.setRole_id(o_rolePrvg.getRole_id());
				rolePrvg.setPrivilege_id(o_rolePrvg.getPrivilege_id());
				rolePrvg.setType(o_rolePrvg.getType());
			}
			// System.out.println(ToolsUtil.dumpObject(rolePrvg));
			rolePrvgs.add(rolePrvg);
			// 重置参数
			o_rolePrvg = null;
			exists_index = -1;
		}
		map_id_list.addAll(String2List("sys_addRolePrvg", rolePrvgs.size()));
		parameter_list.addAll(rolePrvgs);
		super.setBatchNum(1000);
		// System.out.println("设定提交数目为1000!!");
		batchStatment(map_id_list, parameter_list, true);
	}

	/**
	 * 删除角色
	 * 
	 * @param parameters
	 */
	public void delete(Object parameters) {
		ArrayList<String> map_id_list = new ArrayList<String>();
		ArrayList<Object> parameter_list = new ArrayList<Object>();
		// 角色主表
		map_id_list.add("sys_delRoles");
		parameter_list.add(parameters);
		// 删除以前的权限列表
		RolePrvg rolePrvg = new RolePrvg();
		rolePrvg.setRole_id(((UserRole) parameters).getUuid());
		map_id_list.add("sys_delRolePrvg");
		parameter_list.add(rolePrvg);

		batchStatment(map_id_list, parameter_list, false);
	}

	public void saveRolePrvg(List<RolePrvg> prvg_list) {
		// sys_mdyRolePrvg
		List<Object> p_list = new ArrayList<Object>();
		p_list.addAll(prvg_list);
		batchStatment("sys_mdyRolePrvg", p_list, false);
	}

	public void saveRolePrvg(RolePrvg prvg) {
		super.save("sys_mdyRolePrvg", prvg);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
