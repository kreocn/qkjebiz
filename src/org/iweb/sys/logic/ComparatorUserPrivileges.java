package org.iweb.sys.logic;

import java.util.Comparator;

import org.iweb.sys.domain.UserPrivilege;

public class ComparatorUserPrivileges implements Comparator<UserPrivilege> {

	@Override
	public int compare(UserPrivilege o1, UserPrivilege o2) {
		Integer o1_c = o1.getMenu_priority();
		Integer o2_c = o2.getMenu_priority();
		if (o1_c == null) o1_c = 0;
		if (o2_c == null) o2_c = 0;
		return o1_c.compareTo(o2_c);
	}

}
