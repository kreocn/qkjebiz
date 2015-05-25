package org.iweb.ajax.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.iweb.sys.Parameters;
import org.iweb.sys.domain.UserLoginInfo;

import com.opensymphony.xwork2.ActionContext;
import com.qkj.manage.dao.StoresDao;
import com.qkj.manage.dao.StoresOrderDAO;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.StoresOrderCustom;

public class StoresOrderAjax extends Ajax{

	private StoresDao dao=new StoresDao();
	private StoresOrderDAO sod=new StoresOrderDAO();
	private Map<String, Object> map = new HashMap<String, Object>();
	private List<StoresOrderCustom> souList=new ArrayList<StoresOrderCustom>();
	private List<Product> proList=new ArrayList<Product>();
	public Object getResult() {
	map.put("code", parameter.get("code").toString());
	this.proList=dao.list(map);
	return proList;
	}

}
