package com.qkjsys.ebiz.dao;
import java.util.*;
import org.iweb.sys.AbstractDAO;
public class GoodsInfoDAO extends AbstractDAO {

	public List list(Map<String, Object> map) {
		setCountMapid("sysebiz_getGoodsInfosCounts");
		return super.list("sysebiz_getGoodsInfos", map);
	}

	public Object add(Object parameters) {
		return super.add("sysebiz_addGoodsInfo", parameters);
	}

	public int save(Object parameters) {
		return super.save("sysebiz_mdyGoodsInfo", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sysebiz_delGoodsInfo", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
