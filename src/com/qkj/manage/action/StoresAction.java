package com.qkj.manage.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.domain.UserLoginInfo;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.StoresDao;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.StoresOrder;
import com.qkj.manage.domain.StoresOrderItem;
public class StoresAction  extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private String code;
	private StoresDao dao=new StoresDao();
	private List<Product> product;
	private List<StoresOrderItem> storesorderitem;
	private StoresOrder sotresorder;
	private String id;
	private int recCount;
	private int pageSize;
	private List<StoresOrder> storesorderlist;
	private Map<String, Object> map = new HashMap<String, Object>();
	private static Log log = LogFactory.getLog(StoresAction.class);
	private String result;
	private String data;


	private String storesid;
	private Double price;
	public Double getPrice() {
		return price;
	}

	public void setPrice(Double price) {
		this.price = price;
	}
	public String getStoresid() {
		return storesid;
	}

	public void setStoresid(String storesid) {
		this.storesid = storesid;
	}

	public StoresOrder getSotresorder() {
		return sotresorder;
	}

	public void setSotresorder(StoresOrder sotresorder) {
		this.sotresorder = sotresorder;
	}
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public List<StoresOrder> getStoresorderlist() {
		return storesorderlist;
	}

	public void setStoresorderlist(List<StoresOrder> storesorderlist) {
		this.storesorderlist = storesorderlist;
	}
	public List<StoresOrderItem> getStoresorderitem() {
		return storesorderitem;
	}

	public void setStoresorderitem(List<StoresOrderItem> storesorderitem) {
		this.storesorderitem = storesorderitem;
	}
	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public List<Product> getProduct() {
		return product;
	}

	public void setProduct(List<Product> product) {
		this.product = product;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	public int getRecCount() {
		return recCount;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setRecCount(int recCount) {
		this.recCount = recCount;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String list() throws Exception {
		return SUCCESS;
	}
	public String addlist() throws Exception {
		try {
			map.clear();
			map.put("code", code);
			this.setProduct(dao.list(map));
			Map<String,Object> resultmap = new HashMap<String,Object>();
			JSONArray array = new JSONArray();
			JSONObject json = new JSONObject();
			for (Product product2 : product) {
				resultmap.put("title", product2.getTitle());
				resultmap.put("procode", product2.getProd_code());
				resultmap.put("spec", product2.getSpec());
				resultmap.put("flavor", product2.getFlavor());
				resultmap.put("barcode", product2.getBar_code());
				resultmap.put("dealerprice", product2.getDealer_price());
				resultmap.put("id", product2.getUuid());
				array.add(resultmap);
			}
			json.element("list", array);
			ActionContext context = ActionContext.getContext();  
			HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
			HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
			writerJsonObject(json, response);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return null;
	}
	public String insertOrder(){
		List<StoresOrderItem> sotr=storesorderitem;
		Collection nuCon = new Vector();
		nuCon.add(null);
		sotr.removeAll(nuCon);
		Double price=0.00;
		StoresOrder sto=new StoresOrder();
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);

		for (StoresOrderItem storesorderitem : sotr) {
			price=price+(storesorderitem.getProduct_price()*storesorderitem.getOrder_num());
		}
		DecimalFormat df =new DecimalFormat("#####0.00");
		SimpleDateFormat   formatter=new SimpleDateFormat   ("yyyy-MM-dd   HH:mm:ss");  
		Date   curDate   =   new   Date(System.currentTimeMillis());//获取当前时间       
		String   date   =   formatter.format(curDate);  
		price=price.valueOf(df.format(price));
		sto.setTotal_price(price);
		sto.setAdd_time(date);
		sto.setUser_id(ulf.getUuid());
		sto.setUser_name(ulf.getUser_name());
		int id=(int) dao.addO(sto);
		for (StoresOrderItem storesorderitem : sotr) {
			storesorderitem.setOrder_total_price((double)storesorderitem.getOrder_total_price());
			storesorderitem.setOrder_id(id+"");
			String title=storesorderitem.getTitle();
			storesorderitem.setTitle(title);
		}
		dao.add(storesorderitem);
		return SUCCESS;
	}
	public static void writerJsonObject(Object obj,HttpServletResponse response) throws IOException{ 
		PrintWriter out = null;
		try {
			//response.setCharacterEncoding("UTF-8");
			response.setContentType("application/json;charset=UTF-8");
			out = response.getWriter(); 
			JSONObject jobj = JSONObject.fromObject(obj);
			out.write(jobj.toString());
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if(out!=null){
				out.flush();
				out.close();
				out = null;
			}
		}
	} 
	public double sum(double d1,double d2){
		BigDecimal bd1 = new BigDecimal(Double.toString(d1));
		BigDecimal bd2 = new BigDecimal(Double.toString(d2));
		return bd1.add(bd2).doubleValue();
	} 
	public String update() throws Exception {
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
		map.clear();
		map.putAll(ContextHelper.getDefaultRequestMap4Page());
		this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
		map.put("userid", ulf.getUuid());
		this.setStoresorderlist(dao.listOrder(map));
		this.setRecCount(dao.listOrder(map).size());
		return SUCCESS;
	}
	public String updateDetails() throws Exception {
		map.clear();
		map.put("id", this.getId());
		this.setStoresorderlist(dao.listOrder(map));
		for (int i = 0; i < storesorderlist.size(); i++) {
			sotresorder=storesorderlist.get(i);
		}
		this.setStoresorderitem(dao.listOrderItem(map));
		return SUCCESS;
	}

	public String itemDelete() throws Exception {
		map.clear();
		map.put("id",this.getId());
		dao.delete(map);
		map.clear();
		map.put("id", this.getStoresid());
		this.setStoresorderlist(dao.listOrder(map));
		price=storesorderlist.get(0).getTotal_price()-this.getPrice();
		map.put("id", this.getStoresid());
		map.put("price", this.getPrice());
		dao.saveOrderItem(map);
		sotresorder=storesorderlist.get(0);
		storesorderlist.get(0).setTotal_price(this.getPrice());
		this.setStoresorderitem(dao.listOrderItem(map));	
		return SUCCESS;
	}
}
