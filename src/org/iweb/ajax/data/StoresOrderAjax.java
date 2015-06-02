package org.iweb.ajax.data;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
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
	ContextHelper.isPermit("QKJ_QKJMANAGE_STORES");
	map.put("code", parameter.get("code").toString());
	this.proList=dao.list(map);
	UserLoginInfo ulf = new UserLoginInfo();
	ActionContext context = ActionContext.getContext();  
	HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
	HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
	ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
    map.clear();
    map.put("logindept", ContextHelper.getUserLoginDept());
    map.put("barcode", parameter.get("code").toString());
	this.souList=sod.list(map);
	for (int i = 0; i < proList.size(); i++) {
		for (int j = 0; j < souList.size(); j++) {
			int productid=Integer.parseInt(souList.get(j).getProduct_id());
			if(proList.get(i).getUuid()==productid){
				proList.get(i).setMarket_price(souList.get(j).getPrice());
			}
		}
	}
	return proList;
	}

}
