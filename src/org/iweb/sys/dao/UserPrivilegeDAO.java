package org.iweb.sys.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.domain.RolePrvg;
import org.iweb.sys.domain.UserPrivilege;

public class UserPrivilegeDAO extends AbstractDAO {

	public void add(Object parameters) {
		super.add("sys_addPrivileges", parameters);
	}

	public void delete(Object parameters) {
		super.startTransaction();
		try {
			super.delete("sys_delPrivileges", parameters);

			UserPrivilege up = (UserPrivilege) parameters;
			RolePrvg rp = new RolePrvg();
			rp.setPrivilege_id(up.getPrivilege_id());
			super.delete("sys_delRolePrvg", rp);

			super.commitTransaction();
		} catch (Exception e) {

		} finally {
			super.endTransaction();
		}

	}

	public void save(Object parameters) {
		super.save("sys_mdyPrivileges", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("sys_getPrivileges", map);
	}
}
