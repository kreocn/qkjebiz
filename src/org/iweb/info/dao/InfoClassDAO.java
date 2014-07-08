package org.iweb.info.dao;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.iweb.info.domain.InfoClass;
import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ToolsUtil;

public class InfoClassDAO extends AbstractDAO {
	public void add(Object parameters) {
		super.add("info_addClass", parameters);
	}

	public void save(Object parameters) {
		super.save("info_mdyClass", parameters);
	}

	public void delete(Object parameters) {
		super.delete("info_delClass", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("info_getClass", map);
	}

	public List<InfoClass> InfoClassFilter(List<InfoClass> list, String classes) {
		if (!"admin".equals(classes)) { // 如果是admin,则不用检查
			List<InfoClass> tmp = new ArrayList<InfoClass>();
			String[] classArray = classes.split(",");

			for (Iterator<InfoClass> ic = list.iterator(); ic.hasNext();) {
				InfoClass infoClass = (InfoClass) ic.next();
				if (!ToolsUtil.isIn(infoClass.getUuid(), classArray)) {
					tmp.add(infoClass);
					// list.remove(infoClass);
				}
			}

			list.removeAll(tmp);
		}
		return list;
	}
}
