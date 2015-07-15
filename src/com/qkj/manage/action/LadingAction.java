package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysDBCacheLogic;
import org.iweb.sys.dao.DepartmentDAO;
import org.iweb.sys.domain.Department;
import org.iweb.sys.domain.User;
import org.iweb.sysvip.domain.Member;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.LadingDAO;
import com.qkj.manage.dao.LadingItemDAO;
import com.qkj.manage.dao.LadingProductgDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.dao.SalPromotDAO;
import com.qkj.manage.dao.SalPromotPower;
import com.qkj.manage.domain.Lading;
import com.qkj.manage.domain.LadingItem;
import com.qkj.manage.domain.LadingPay;
import com.qkj.manage.domain.LadingProductg;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.SalPromot;
import com.qkj.ware.dao.OutStockDAO;
import com.qkj.ware.domain.InDetail;
import com.qkjsys.ebiz.dao.WareDAO;
import com.qkjsys.ebiz.domain.Ware;

public class LadingAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(LadingAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private LadingDAO dao = new LadingDAO();
	private SalPromotDAO saldao=new SalPromotDAO();
	private SalPromotPower sal=new SalPromotPower();

	private Lading lading;
	private List<Lading> ladings;
	private List<User> users;
	private List<Product> products;
	private List<LadingItem> ladingItems;
	private List<LadingProductg> ladingProductgs;
	private List<LadingPay> ladingPays;
	private List<SalPromot> salPromots;
	private List<SalPromot> salPromotsed;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;销售订单";

	public List<SalPromot> getSalPromots() {
		return salPromots;
	}

	public void setSalPromots(List<SalPromot> salPromots) {
		this.salPromots = salPromots;
	}

	public List<LadingProductg> getLadingProductgs() {
		return ladingProductgs;
	}

	public void setLadingProductgs(List<LadingProductg> ladingProductgs) {
		this.ladingProductgs = ladingProductgs;
	}

	public List<LadingPay> getLadingPays() {
		return ladingPays;
	}

	public void setLadingPays(List<LadingPay> ladingPays) {
		this.ladingPays = ladingPays;
	}

	public List<LadingItem> getLadingItems() {
		return ladingItems;
	}

	public void setLadingItems(List<LadingItem> ladingItems) {
		this.ladingItems = ladingItems;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

	public Lading getLading() {
		return lading;
	}

	public void setLading(Lading lading) {
		this.lading = lading;
	}

	public List<Lading> getLadings() {
		return ladings;
	}

	public void setLadings(List<Lading> ladings) {
		this.ladings = ladings;
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

	public List<SalPromot> getSalPromotsed() {
		return salPromotsed;
	}

	public void setSalPromotsed(List<SalPromot> salPromotsed) {
		this.salPromotsed = salPromotsed;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_LIST");
		try {
			map.clear();
			if (lading == null) {
				lading = new Lading();
			}
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_LADING_LIST",map, "dept_codes", "manager");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_LADING_LIST", map, lading, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setLadings(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;销售订单列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String checkList() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_CHECKLIST");
		String dept=ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (lading == null) {
				lading = new Lading();
			}
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_LADING_LIST",map, "dept_chekCodes", "chekCodes");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_LADING_LIST", map, lading, viewFlag);
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			this.setLadings(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setLading(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setLading(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/lading_list?viewFlag=relist'>销售订单列表</a>&nbsp;&gt;&nbsp;增加销售订单";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag) || "print".equals(viewFlag)) {
				map.clear();
				map.put("uuid", lading.getUuid());
				String salid=null;
				if (null == map.get("uuid")) this.setLading(null);
				else {
					if ("view".equals(viewFlag)) {
						//map.put("status", 2);
					}
					this.setLading((Lading) dao.list(map).get(0));
					salid=lading.getPromotions();

					if (!ToolsUtil.isEmpty(lading.getFd_type())) {
						lading.setFd_typesx(ToolsUtil.split2Integer(lading.getFd_type()));
					}

					ProductDAO pdao = new ProductDAO();
					this.setProducts(pdao.list(null));

					LadingItemDAO idao = new LadingItemDAO();
					map.clear();
					map.put("lading_id", lading.getUuid());
					this.setLadingItems(idao.list(map));

					LadingProductgDAO gdao = new LadingProductgDAO();
					map.clear();
					map.put("lading_id", lading.getUuid());
					this.setLadingProductgs(gdao.list(map));
					
					List<SalPromot> salps=new ArrayList<>();
					if(salid!=null){
						String stringarray[]=salid.split(",");  
						for(int i=0;i<stringarray.length;i++){
							SalPromot sp=new SalPromot();
							sp.setUuid(Integer.parseInt(stringarray[i]));
							sp=(SalPromot) saldao.get(sp.getUuid());
							salps.add(sp);
						}
						this.setSalPromotsed(salps);//已经选择的促销活动
					}
					this.setSalPromots(sal.salProPower(lading.getMember_id()));//可选的促销活动
					
					//SalPromotDAO sdao = new SalPromotDAO();
					//map.clear();
					//this.setSalPromots(sdao.list(map));
					path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/lading_list?viewFlag=relist'>销售订单列表</a>&nbsp;&gt;&nbsp;修改销售订单";
				}
			} else {
				this.setLading(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_ADD");
		try {
			Date d = new Date();
			String u = ContextHelper.getUserLoginUuid();
			// lading.setUuid(ToolsUtil.getCommonUUID("T"));
			lading.setApplicant(u);
			lading.setApply_dept(ContextHelper.getUserLoginDept());
			lading.setApply_time(d);
			lading.setFd_check(0);
			lading.setStatus(0);
			lading.setAdd_time(d);
			lading.setAdd_user(u);
			lading.setLm_user(u);
			lading.setUuid((Integer) dao.add(lading));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String addProd() throws Exception {
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_MDY");
		try {
			if (lading != null && !ToolsUtil.isEmpty(lading.getPromotions())) {
				lading.setPromotions(lading.getPromotions().replaceAll(" ", ""));
			}
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_DEL");
		try {
			dao.delete(lading);
			setMessage("删除成功!ID=" + lading.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-27 下午1:51:52
	 */
	public String saveLadingStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_STATUS0");
		try {
			saveLadingStatus(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveLadingStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveLadingStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 财务退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-27 下午1:51:52
	 */
	public String saveLadingStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_STATUS5");
		try {
			saveLadingStatus(5);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveLadingStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveLadingStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 财务确认
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-1-27 下午1:51:52
	 */
	public String saveLadingStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_STATUS10");
		try {
			dao.startTransaction();
			saveLadingStatus(20);
			//生成出库单
			ProductDAO pd = new ProductDAO();
			LadingItemDAO idao = new LadingItemDAO();
			
			Product pdi = new Product();
			List<Product> produs = new ArrayList<>();
			map.clear();
			map.put("lading_id", lading.getUuid());
			ladingItems = idao.list(map);
			if (ladingItems != null && ladingItems.size() > 0) {
				for (int i = 0; i < ladingItems.size(); i++) {
					LadingItem ladingItem=new LadingItem();
					ladingItem = ladingItems.get(i);
					List<Product> pros = new ArrayList<>();
					map.clear();
					map.put("uuid", ladingItem.getProduct_id());
					pros = pd.list(map);
					if (pros.size() > 0) {
						pdi = pros.get(0);
						pdi.setNum(ladingItem.getNum());
						pdi.setDprice(ladingItem.getPer_price());
						pdi.setDtotle(ladingItem.getTotal_price());
						produs.add(pdi);
					}
				}
			}
				//会员信息
			Member me=new Member();
			me.setUuid(lading.getMember_id());
			me.setManager_name(lading.getMember_name());
			me.setMobile(lading.getMember_mobile());
			me.setAddress(lading.getAddress());
			OutStockDAO isa = new OutStockDAO();
			Integer goid=getWare(lading.getDis_dept());
			isa.addStock(lading.getUuid(), goid, null, 0, 2, produs,me);//生成销售用酒出库
			dao.commitTransaction();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveLadingStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveLadingStatus10 数据更新失败:", e);
		}finally {
			dao.endTransaction();
		}
		return SUCCESS;
	}

	/**
	 * 修改订单状态 0新单 10财务待审 20待出货 30已出货
	 * 
	 * @param status
	 * @throws Exception
	 */
	public void saveLadingStatus(Integer status) throws Exception {
		if (status == null) return;
		lading.setCheck_time(new Date());
		lading.setStatus(status);
		lading.setCheck_user(ContextHelper.getUserLoginUuid());
		lading.setLm_user(ContextHelper.getUserLoginUuid());
		dao.mdyLadingStatus(lading);
	}

	public String mdyLadingFDCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_FDCHECK");
		try {
			lading.setFd_check_user(ContextHelper.getUserLoginUuid());
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			lading.setFd_check_time(new Date());
			lading.setFd_type(ToolsUtil.Array2String(lading.getFd_typesx() == null ? new Integer[] {} : lading.getFd_typesx(), ","));
			dao.mdyLadingFDCheck(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingFDCheck 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingFDCheck 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String mdyLadingOutFlag1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_LADING_OUTFLAG1");
		try {
			lading.setOut_flag(1);
			lading.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyLadingOutFlag(lading);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyLadingOutFlag1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyLadingOutFlag1 数据更新失败:", e);
		}
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
}
