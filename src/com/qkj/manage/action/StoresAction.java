package com.qkj.manage.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.iweb.sys.JSONUtil;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysDBCacheLogic;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.UserLoginInfo;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.Member;
import org.iweb.sysvip.domain.MemberCapital;

import com.aliyun.openservices.ots.protocol.OtsProtocol.StartTransactionRequest;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.LadingItemDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.dao.StoresDao;
import com.qkj.manage.domain.LadingItem;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.StoresOrder;
import com.qkj.manage.domain.StoresOrderItem;
import com.qkj.manage.domain.StoresTicket;
import com.qkj.ware.dao.OutStockDAO;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class StoresAction  extends ActionSupport{
	private List<Member> members;
	private static final long serialVersionUID = 1L;
	private String code;
	private StoresDao dao=new StoresDao();
	private List<Product> product;
	private List<StoresOrderItem> storesorderitem;
	private StoresOrder sotresorder;
	private String id;
	private int recCount;
	private int pageSize;
	private int num;
	private String viewFlag;
	private Member member;
	private List<StoresOrder> storesorderlist;
	private Map<String, Object> map = new HashMap<String, Object>();
	private static Log log = LogFactory.getLog(StoresAction.class);
	private String result;
	private String data;
	private String storesid;
	private Double price;
	private Double totalPirce;
	private Object cb[];
	private String tick_code;


	public String getTick_code() {
		return tick_code;
	}

	public void setTick_code(String tick_code) {
		this.tick_code = tick_code;
	}

	public String getIs_li() {
		return is_li;
	}

	public void setIs_li(String is_li) {
		this.is_li = is_li;
	}

	private StoresTicket storesTicket;
	private String is_li;
	private List<StoresTicket> storesTicketList;
	   public String getViewFlag() {
			return viewFlag;
		}

		public void setViewFlag(String viewFlag) {
			this.viewFlag = viewFlag;
		}
	public List<StoresTicket> getStoresTicketList() {
		return storesTicketList;
	}

	public void setStoresTicketList(List<StoresTicket> storesTicketList) {
		this.storesTicketList = storesTicketList;
	}

	public StoresTicket getStoresTicket() {
		return storesTicket;
	}

	public void setStoresTicket(StoresTicket storesTicket) {
		this.storesTicket = storesTicket;
	}

	public Object[] getCb() {
		return cb;
	}

	public void setCb(Object[] cb) {
		this.cb = cb;
	}

	public List<Member> getMembers() {
		return members;
	}

	public void setMembers(List<Member> members) {
		this.members = members;
	}
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	public Double getTotalPirce() {
		return totalPirce;
	}

	public void setTotalPirce(Double totalPirce) {
		this.totalPirce = totalPirce;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

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
	//门店支付 >添加订单 >首页
	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_PAYMENT");
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
		map.put("userid", ulf.getUuid());
		map.put("is_liqueur_ticket", "0");
		storesorderlist=dao.listWeek(map);
		return SUCCESS;
	}

	/*public String addlist() throws Exception {
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
	}*/
	//门店支付>添加订单>添加订单
	public String insertOrder(){
		ContextHelper.isPermit("QKJ_STORES_PAYMENT");
		List<StoresOrderItem> sotr=storesorderitem;
		if(sotr.size()>0){
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
				price=price+(storesorderitem.getOrder_total_price());
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
			sto.setLogin_dept(ContextHelper.getUserLoginDept());
			sto.setLogin_name(ContextHelper.getUserLoginDeptName());
	
			for (StoresOrderItem storesorderitem : sotr) {
				storesorderitem.setOrder_total_price((double)storesorderitem.getOrder_total_price());
				storesorderitem.setOrder_id(id+"");
				String title=storesorderitem.getTitle();
				storesorderitem.setTitle(title);
			}
			if(is_li.equals("ticket")){
				sto.setIs_liqueur_ticket(1);
				sto.setLiqueur_ticket_code(tick_code);
				dao.addO(sto,storesorderitem);
			}else{
			dao.addO(sto,storesorderitem,member.getUuid());
			}
		}
		return SUCCESS;
	}
	public double sum(double d1,double d2){
		BigDecimal bd1 = new BigDecimal(Double.toString(d1));
		BigDecimal bd2 = new BigDecimal(Double.toString(d2));
		return bd1.add(bd2).doubleValue();
	} 
	//门店支付>查看订单
	public String findOrder() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_FIND_ORDER");
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
		map.clear();
		map.putAll(ContextHelper.getDefaultRequestMap4Page());
		this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
		map.put("userid", ulf.getUuid());
		map.put("is_liqueur_ticket", "0");
		ContextHelper.setSearchDeptPermit4Search("QKJ_STORES_FIND_ORDER",map, "apply_depts", "apply_user");
		if(sotresorder!=null){
			if(!sotresorder.getTime_begin().equals("")){
		map.put("time_begin", sotresorder.getTime_begin());
			}
			if(!sotresorder.getTime_end().equals("")){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟  
				java.util.Date date=sdf.parse(sotresorder.getTime_end());  
				     Calendar   calendar   =   new   GregorianCalendar(); 
				     calendar.setTime(date); 
				     calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
				     date=calendar.getTime();   //这个时间就是日期往后推一天的结果 
				     System.out.println(date);
		            map.put("time_end", date);
			}
			if(sotresorder.getId()!=0){
				map.put("id", sotresorder.getId());
			}
			if(!sotresorder.getIs_library().equals("")){
				map.put("is_library", sotresorder.getIs_library());
			}
		}
		
		
		this.setStoresorderlist(dao.listOrder(map));
		this.setRecCount(dao.getResultCount());
		return SUCCESS;
	}
	//门店支付>查看订单>订单详情
	public String updateDetails() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_FIND_ORDER");
		map.clear();
		map.put("id", this.getId());
		this.setStoresorderlist(dao.listOrder(map));
		for (int i = 0; i < storesorderlist.size(); i++) {
			sotresorder=storesorderlist.get(i);
		}
		this.setStoresorderitem(dao.listOrderItem(map));

		return SUCCESS;
	}
	//门店支付>查看订单>订单详情>删除
	public String itemDelete() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_FIND_ORDER_DEL");
		if(num==0){
			map.clear();
			map.put("id",this.getId());
			dao.delete(map);
			map.clear();
			map.put("id", this.getStoresid());
			this.setStoresorderlist(dao.listOrder(map));
			price=storesorderlist.get(0).getTotal_price()-this.getTotalPirce();
			map.put("id", this.getStoresid());
			map.put("price", this.getPrice());
			dao.saveOrderItemPrice(map);
			sotresorder=storesorderlist.get(0);
			storesorderlist.get(0).setTotal_price(this.getPrice());
			this.setStoresorderitem(dao.listOrderItem(map));
		}
		else if(num!=0){
			map.clear();
			map.put("id",this.getId());
			map.put("num",this.getNum());
			if(this.getTotalPirce()!=0.0){
				map.put("price",sub(this.getTotalPirce(),sub(this.getTotalPirce(),mul(this.getNum(),this.getPrice()))));
			}else{	
				map.put("price",0.0);
			}
			dao.saveOrderItem(map);
			map.clear();
			map.put("id", this.getStoresid());
			this.setStoresorderlist(dao.listOrder(map));
			if(this.getTotalPirce()!=0.0){
		    Object ob=div(this.getPrice(),this.getTotalPirce());
		    double subnum=sub(ob,this.getNum());
		    num=(int)subnum;
			
			}
			if(this.getTotalPirce()==0.0){
				num=0;
			}
			this.price=storesorderlist.get(0).getTotal_price()-(num*this.getPrice());
			map.put("id", this.getStoresid());
			map.put("price", this.getPrice());
			dao.saveOrderItemPrice(map);
			sotresorder=storesorderlist.get(0);
			storesorderlist.get(0).setTotal_price(this.getPrice());
			this.setStoresorderitem(dao.listOrderItem(map));
		}
		return SUCCESS;
	}
	//门店支付>查看订单>删除
	public String delete() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_FIND_ORDER_DEL");
		map.clear();
		map.put("orderid",this.getId());
		dao.deleteItemandorder(map);
		return SUCCESS;
	}
	//门店支付>财务报表
	public String financeDetails() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_FINANCE_ITEM");
		map.putAll(ContextHelper.getDefaultRequestMap4Page());
	
		if(sotresorder!=null){
			if(!sotresorder.getTime_begin().equals("")){
		map.put("time_begin", sotresorder.getTime_begin());
			}
			if(!sotresorder.getTime_end().equals("")){
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");//小写的mm表示的是分钟  
				java.util.Date date=sdf.parse(sotresorder.getTime_end());  
				     Calendar   calendar   =   new   GregorianCalendar(); 
				     calendar.setTime(date); 
				     calendar.add(calendar.DATE,1);//把日期往后增加一天.整数往后推,负数往前移动 
				     date=calendar.getTime();   //这个时间就是日期往后推一天的结果 
				     System.out.println(date);
		map.put("time_end", date);
			}
			if(sotresorder.getId()!=0){
				map.put("id", sotresorder.getId());
			}
		}
		map.put("is_library", "1");
		this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
		this.setStoresorderlist(dao.listOrder(map));
		this.setRecCount(dao.getResultCount());
		return SUCCESS;
	}
	//添加酒票
	public String addTicket(){
		ContextHelper.isPermit("QKJ_STORES_ADD_TICKET");
		
		return SUCCESS;
	}
	
	public String theLibrary() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_ORDER_OUT");
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
		ProductDAO pd = new ProductDAO();
		LadingItemDAO idao = new LadingItemDAO();
		Product pdi = new Product();
		List<Product> produs = new ArrayList<>();
		if(cb!=null){
	        for (int i = 0; i < cb.length; i++) {
	        	map.put("id", cb[i]);
	    		List<Product> pros = new ArrayList<>();
	    		sotresorder=(StoresOrder) dao.findOrder(map).get(0);
	    		this.setStoresorderitem(dao.listOrderItem(map));
	    		for (StoresOrderItem setStoresorderitem :storesorderitem) {
	    			map.clear();
		        	map.put("uuid", setStoresorderitem.getProduct_id());
		        	pros = pd.list(map);
				if (pros.size() > 0) {
					pdi = pros.get(0);
					pdi.setNum(setStoresorderitem.getOrder_num());
					pdi.setDprice(setStoresorderitem.getProduct_price());
					pdi.setDtotle(setStoresorderitem.getOrder_total_price());
					produs.add(pdi);
				}
	    		}
				map.clear();
			}
		
			//会员信息
		Member me=new Member();
		if(sotresorder.getMember_id()==""||sotresorder.getMember_id()==null){
			me.setUuid("q000500");
			me.setManager_name("门店销售散客订单订单");
			me.setMobile("门店销售散客订单订单");
			me.setAddress("门店销售散客订单订单");
		}else{
		me.setUuid(sotresorder.getMember_id()+"");
		me.setManager_name(sotresorder.getMember_name());
		me.setMobile(sotresorder.getMember_mobile());
		me.setAddress("门店销售订单");
		}
		OutStockDAO isa = new OutStockDAO();
		Integer goid=getWare(sotresorder.getLogin_dept());
		isa.addStock(sotresorder.getId(), goid, null, 0, 5, produs,me,true,ContextHelper.getUserLoginDept(),ContextHelper.getUserLoginDept());//生成销售用酒出库
		
		
		if(cb!=null){
        for (int i = 0; i < cb.length; i++) {
        	map.put("id", cb[i]);
			System.out.println(cb[i]);
			dao.saveIs_library(map);
			map.clear();
		}
 }
	}
		return SUCCESS;
	}
	public String OrderTicket() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_TICKET_ORDER");
		storesTicketList=dao.listTicket(map);
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
		map.put("userid", ulf.getUuid());
		map.put("is_liqueur_ticket", "1");
		storesorderlist=dao.listWeek(map);
		return SUCCESS;
	}
	
	
	
	public String insertTicket() throws Exception {
		
		ContextHelper.isPermit("QKJ_STORES_ADD_TICKET");
		map.put("puuid", storesTicket.getProduct_id());
		Product p=(Product) dao.list(map).get(0);
		storesTicket.setProduct_code(p.getBar_code_box());
		dao.addStoresTicket(storesTicket);
		return SUCCESS;
	}
	
	//门店支付>查看酒票订单
	public String findTicketOrder() throws Exception {
		ContextHelper.isPermit("QKJ_STORES_FIND_TICKET_ORDER");
		UserLoginInfo ulf = new UserLoginInfo();
		ActionContext context = ActionContext.getContext();  
		HttpServletRequest request = (HttpServletRequest) context.get(ServletActionContext.HTTP_REQUEST);  
		HttpServletResponse response = (HttpServletResponse) context.get(ServletActionContext.HTTP_RESPONSE);  
		ulf=(UserLoginInfo) request.getSession().getAttribute(Parameters.UserLoginInfo_Session_Str);
		map.clear();
		map.putAll(ContextHelper.getDefaultRequestMap4Page());
		this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
		map.put("userid", ulf.getUuid());
		map.put("is_liqueur_ticket", "1");
		ContextHelper.setSearchDeptPermit4Search("QKJ_STORES_FIND_TICKET_ORDER",map, "apply_depts", "apply_user");
		this.setStoresorderlist(dao.listOrder(map));
		this.setRecCount(dao.getResultCount());
		return SUCCESS;
	}
	
	
	
	
	//获得发货部门所在总仓库
	public Integer getWare(String dept){
		Integer ware=null;
		DepartmentDAO d=new DepartmentDAO();
		Department dm=new Department();
		List<Department> was=new ArrayList<>();
		List<String> a=new ArrayList<>();
		map.clear();
		map.put("type", 1);
		was=d.list(map);
		String part=null;
		String str = (String) CacheFactory.getCacheInstance().get(SysDBCacheLogic.CACHE_DEPT_PREFIX_PARENT +dept);//
		String[] s = (String[]) JSONUtil.toObject(str, String[].class);// 转换成数组
		System.out.println(str);
		if(was.size()>0){
			for(int i=0;i<was.size();i++){
				dm=was.get(i);
				Boolean iskip = ToolsUtil.isIn(dm.getDept_code(), s);// 判断在不在数组中
				if(dm.getDept_code().equals(dept)){
					part=dept;
					break;
				}else if(iskip==true){
					part=dm.getDept_code();
					break;
				}
				/*else if (iskip) {
					a.add(dm.getDept_code());
				}*/
			}
			
			/*if(dm.getDept_code().equals(dept)){
				
			}else if(a.size()>0){
				for(int i=0;i<a.size();i++){
					String l=a.get(i+1);
					if(a.get(i).length()>l.length()){
						
					}else{
						
					}
				}
			}*/
			
			if(part!=null){
				Ware w=new Ware();
				List<Ware> ws=new ArrayList<>();
				WareDAO wd=new WareDAO();
				map.clear();
				map.put("ware_instcode", part);
				ws=wd.list(map);
				if(ws.size()>0){w=ws.get(0);ware=w.getUuid();}
			}
		}
		return ware;
	}
	
	
	/** 
	 * * 两个Double数相加 * 
	 *  
	 * @param v1 * 
	 * @param v2 * 
	 * @return Double 
	 */  
	public static Object add(Object v1, Object v2) {  
		BigDecimal b1 = new BigDecimal(v1.toString());  
		BigDecimal b2 = new BigDecimal(v2.toString());  
		return new Double(b1.add(b2).doubleValue());  
	}  

	/** 
	 * * 两个Double数相减 * 
	 *  
	 * @param v1 * 
	 * @param v2 * 
	 * @return Double 
	 */  
	public static Double sub(Object v1, Object v2) {  
		BigDecimal b1 = new BigDecimal(v1.toString());  
		BigDecimal b2 = new BigDecimal(v2.toString());  
		return new Double(b1.subtract(b2).doubleValue());  
	}  

	/** 
	 * * 两个Double数相乘 * 
	 *  
	 * @param v1 * 
	 * @param v2 * 
	 * @return Double 
	 */  
	public static Object mul(Object v1, Object v2) {  
		BigDecimal b1 = new BigDecimal(v1.toString());  
		BigDecimal b2 = new BigDecimal(v2.toString());  
		return new Double(b1.multiply(b2).doubleValue());  
	}  

	/** 
	 * * 两个Double数相除 * 
	 *  
	 * @param v1 * 
	 * @param v2 * 
	 * @return Double 
	 */  
	public static double div(Object v1, Object v2) {  
		int DEF_DIV_SCALE = 2;  
		BigDecimal b1 = new BigDecimal(v1.toString());  
		BigDecimal b2 = new BigDecimal(v2.toString());  
		return new Double(b2.divide(b1,DEF_DIV_SCALE, BigDecimal.ROUND_HALF_UP)  
				.doubleValue());  
	}  

}  
