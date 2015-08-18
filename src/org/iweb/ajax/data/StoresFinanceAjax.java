package org.iweb.ajax.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.iweb.sys.ContextHelper;

import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.dao.StoresOrderDAO;
import com.qkj.manage.domain.StoresOrder;
import com.qkj.manage.domain.StoresOrderCustom;
import com.qkj.manage.domain.StoresOrderItem;

public class StoresFinanceAjax extends Ajax {


	private StoresOrderDAO dao=new StoresOrderDAO();
	private List<StoresOrderItem> sou=new ArrayList<StoresOrderItem>();
	private Map<String, Object> map = new HashMap<String, Object>();
	
	public Object getResult() {
		map.put("order_id", parameter.get("order_id").toString());
		sou=dao.listItem(map);
		return sou;
	}
}
