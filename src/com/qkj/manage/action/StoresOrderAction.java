package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.domain.UserLoginInfo;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.dao.StoresOrderDAO;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.StoresOrder;
import com.qkj.manage.domain.StoresOrderCustom;
import com.qkj.manage.domain.StoresOrderItem;

public class StoresOrderAction   extends ActionSupport{
	private Product product;
	private ProductDAO dao = new ProductDAO();
	private StoresOrderDAO storesorderdao=new StoresOrderDAO();
	private StoresOrder storyit;
	
	public StoresOrder getStoryit() {
		return storyit;
	}
	public void setStoryit(StoresOrder storyit) {
		this.storyit = storyit;
	}
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	
	private List<Product> products;
	private List<StoresOrderCustom> storesOrderCustoms=new ArrayList<StoresOrderCustom>();
	private Map<String, Object> map = new HashMap<String, Object>();
	private static Log log = LogFactory.getLog(StoresOrderAction.class);
	private int recCount;
	private int pageSize;
	public Product getProduct() {
		return product;
	}
	public int getRecCount() {
		return recCount;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_STORES_ORDER");
		try {
			map.clear();
			if (product != null)
			map.putAll(ToolsUtil.getMapByBean(product));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setProducts(dao.listdb1(map));
			UserLoginInfo ulf = new UserLoginInfo();
			map.clear();
			ActionContext context = ActionContext.getContext();  
			HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
			HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
			ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
			map.put("logindept",ContextHelper.getUserLoginDept());
			storesOrderCustoms=storesorderdao.list(map);
			for (int i = 0; i < this.products.size(); i++) {
				for (int j = 0; j < storesOrderCustoms.size(); j++) {
					int productid=Integer.parseInt(storesOrderCustoms.get(j).getProduct_id());
					if(products.get(i).getUuid()==productid){
						products.get(i).setUpdate_price(storesOrderCustoms.get(j).getPrice());
					}
				}
			}
			this.setRecCount(dao.getResultCount());
		
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	public String update() throws Exception{
		System.out.println("=====");
		storesorderdao.update(storyit);
		return SUCCESS;
	}
}
