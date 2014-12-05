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
import com.qkj.manage.dao.ProTypeDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.ProType;
import com.qkj.manage.domain.Product;

public class ProductAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ProductAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ProductDAO dao = new ProductDAO();

	private Product product;
	private List<Product> products;
	private List<ProType> proTypes;
	private ProType proType;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;产品列表";
	
	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	
	public List<ProType> getProTypes() {
		return proTypes;
	}

	public void setProTypes(List<ProType> proTypes) {
		this.proTypes = proTypes;
	}

	public ProType getProType() {
		return proType;
	}

	public void setProType(ProType proType) {
		this.proType = proType;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getViewFlag() {
		return viewFlag;
	}

	public void setViewFlag(String viewFlag) {
		this.viewFlag = viewFlag;
	}

	public int getRecCount() {
		return recCount;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PRODUCT_LIST");
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

	public String load() throws Exception {
		try {
			ProTypeDAO ptd=new ProTypeDAO();
			if (null == viewFlag) {
				this.setProduct(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setProduct(null);
				this.setProTypes(ptd.list(null));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/product_list?viewFlag=relist'>产品列表</a>&nbsp;&gt;&nbsp;增加产品";
			} else if ("mdy".equals(viewFlag)) {
				map.clear();
				map.put("uuid", product.getUuid());
				if (null == map.get("uuid"))
					this.setProduct(null);
				else
				this.setProduct((Product) dao.list(map).get(0));
				this.setProTypes(ptd.list(null));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/product_list?viewFlag=relist'>产品列表</a>&nbsp;&gt;&nbsp;修改产品";
			} else {
				this.setProduct(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PRODUCT_ADD");
		try {
			product.setLm_user(ContextHelper.getUserLoginUuid());
			dao.add(product);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PRODUCT_MDY");
		try {
			product.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(product);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PRODUCT_DEL");
		try {
			dao.delete(product);
			setMessage("删除成功!ID=" + product.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
}
