package org.iweb.ajax.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.dao.StoresOrderDAO;
import com.qkj.manage.domain.StoresOrder;
import com.qkj.manage.domain.StoresOrderCustom;

public class StoresAjax extends Ajax {

	private ProductDAO dao = new ProductDAO();
	private StoresOrderDAO sod=new StoresOrderDAO();
	private List<StoresOrderCustom> sou=new ArrayList<StoresOrderCustom>();
	private Map<String, Object> map = new HashMap<String, Object>();
	public Object getResult() {
		map.put("productid", parameter.get("productid").toString());
		map.put("userid", parameter.get("userid").toString());
		map.put("price", parameter.get("price").toString());
		map.put("barcode", parameter.get("barcode").toString());
		sou=sod.list(map);
		System.out.println(sou);
		if(sod.list(map).size()==0){
			sod.add(map);
		}else if(sod.list(map).size()>0){
			sod.save(map);
		}
		return "S";
	}
}
