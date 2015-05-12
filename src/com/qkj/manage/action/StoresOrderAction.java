package com.qkj.manage.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.StoresOrderItem;

public class StoresOrderAction   extends ActionSupport{
	private Product product;
	private ProductDAO dao = new ProductDAO();
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	private List<Product> products;
	private Map<String, Object> map = new HashMap<String, Object>();
	private static Log log = LogFactory.getLog(StoresOrderAction.class);
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;产品列表";
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
		try {
			map.clear();
			if (product != null)
				map.putAll(ToolsUtil.getMapByBean(product));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setProducts(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;产品列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
}
