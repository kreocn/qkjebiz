package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.common.dao.CommonDAO;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.JSONUtil;
import org.iweb.sys.SendMessage;
import org.iweb.sys.ToolsUtil;
import org.iweb.sys.cache.CacheFactory;
import org.iweb.sys.cache.SysDBCacheLogic;
import org.iweb.sysvip.dao.MemberCapitalDAO;
import org.iweb.sysvip.domain.MemberCapital;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.check.CheckSkip;
import com.qkj.manage.dao.ActiveDAO;
import com.qkj.manage.dao.ActiveMemcostDAO;
import com.qkj.manage.dao.ActivePosmDAO;
import com.qkj.manage.dao.ActiveProductDAO;
import com.qkj.manage.dao.ApproveDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.domain.Active;
import com.qkj.manage.domain.ActiveMemcost;
import com.qkj.manage.domain.ActivePosm;
import com.qkj.manage.domain.ActiveProduct;
import com.qkj.manage.domain.Approve;
import com.qkj.manage.domain.MyProcess;
import com.qkj.manage.domain.Product;

public class ActiveAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ActiveAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ActiveDAO dao = new ActiveDAO();
	private ApproveDAO apdao = new ApproveDAO();
	private CheckSkip cs = new CheckSkip();
	private Active active;
	private String selectXiao;
	private List<Active> actives;
	private MyProcess myPro;
	private List<MyProcess> myPros;
    private double Posms;
	public double getPosms() {
		return Posms;
	}

	public void setPosms(double posms) {
		Posms = posms;
	}

	private List<Product> products;
	private List<ActiveProduct> activeProducts;
	private List<ActiveProduct> indActiveProducts;
	private List<ActiveProduct> otherActiveProducts;
	private List<ActiveProduct> ActiveProductsTasting;
   private double   tastingPrice=0;

	public String getSelectXiao() {
	return selectXiao;
}

public void setSelectXiao(String selectXiao) {
	this.selectXiao = selectXiao;
}

	public double getTastingPrice() {
	return tastingPrice;
}

public void setTastingPrice(double tastingPrice) {
	this.tastingPrice = tastingPrice;
}

	private List<ActivePosm> activePosms;
	private List<ActiveMemcost> activeMemcosts;

	private List<Active> getapply_depts;
	private String userappid;
	private String userdepta;

	private List<ActiveProduct> activeProductsClose;
	private List<ActiveProduct> indActiveProductsClose;
	private List<ActiveProduct> otherActiveProductsClose;
	private List<ActivePosm> activePosmsClose;
	private List<ActiveMemcost> activeMemcostsClose;
	private List<Active> activeSing;
	private Active activeTime;
	private Active zongActive;
	private Active guanActive;
	private Active fuActive;
	private Active caiActive;
	private Active shuActive;
	private Active dongActive;
	private Active zongjianActive;
	private Active daquActive;

	private Approve approve;
	private List<Approve> approves;
	private String isApprover;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String code;
	private String flag;
	private String state;
	private String noteflag = null;
	private String sselect;
	private double indprice;
	private CommonDAO comdao = new CommonDAO();
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;活动管理";
	private static int maxUid;
	private int befUid;
	private int minUid;
	private int up;
	private int nextFlag;
	private int nextUuid = 0;
	private Integer sd_fstauts;
	private Integer smd_fstauts;
	// 个人工作标识
	private String perWorkF;
	private static String perWorkFlag = null;
	public String per = "per";

	public Integer getSd_fstauts() {
		return sd_fstauts;
	}

	public void setSd_fstauts(Integer sd_fstauts) {
		this.sd_fstauts = sd_fstauts;
	}

	public Integer getSmd_fstauts() {
		return smd_fstauts;
	}

	public void setSmd_fstauts(Integer smd_fstauts) {
		this.smd_fstauts = smd_fstauts;
	}

	public MyProcess pro;// 门头

	public MyProcess getPro() {
		return pro;
	}

	public void setPro(MyProcess pro) {
		this.pro = pro;
	}

	public Active getDaquActive() {
		return daquActive;
	}

	public void setDaquActive(Active daquActive) {
		this.daquActive = daquActive;
	}

	public Active getZongjianActive() {
		return zongjianActive;
	}

	public void setZongjianActive(Active zongjianActive) {
		this.zongjianActive = zongjianActive;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getPer() {
		return per;
	}

	public void setPer(String per) {
		this.per = per;
	}

	public String getUserdepta() {
		return userdepta;
	}

	public void setUserdepta(String userdepta) {
		this.userdepta = userdepta;
	}

	public Active getDongActive() {
		return dongActive;
	}

	public void setDongActive(Active dongActive) {
		this.dongActive = dongActive;
	}

	public String getUserappid() {
		return userappid;
	}

	public void setUserappid(String userappid) {
		this.userappid = userappid;
	}

	public List<Active> getGetapply_depts() {
		return getapply_depts;
	}

	public void setGetapply_depts(List<Active> getapply_depts) {
		this.getapply_depts = getapply_depts;
	}

	public String getPerWorkF() {
		return perWorkF;
	}

	public void setPerWorkF(String perWorkF) {
		this.perWorkF = perWorkF;
	}

	public static String getPerWorkFlag() {
		return perWorkFlag;
	}

	
	public static void setPerWorkFlag(String perWorkFlag) {
		ActiveAction.perWorkFlag = perWorkFlag;
	}

	public List<ActiveProduct> getActiveProductsTasting() {
		return ActiveProductsTasting;
	}

	public void setActiveProductsTasting(List<ActiveProduct> activeProductsTasting) {
		ActiveProductsTasting = activeProductsTasting;
	}
	public int getNextUuid() {
		return nextUuid;
	}

	public void setNextUuid(int nextUuid) {
		this.nextUuid = nextUuid;
	}

	public int getNextFlag() {
		return nextFlag;
	}

	public void setNextFlag(int nextFlag) {
		this.nextFlag = nextFlag;
	}

	public double getIndprice() {
		return indprice;
	}

	public void setIndprice(double indprice) {
		this.indprice = indprice;
	}

	public List<ActiveProduct> getIndActiveProductsClose() {
		return indActiveProductsClose;
	}

	public void setIndActiveProductsClose(List<ActiveProduct> indActiveProductsClose) {
		this.indActiveProductsClose = indActiveProductsClose;
	}

	public List<ActiveProduct> getOtherActiveProductsClose() {
		return otherActiveProductsClose;
	}

	public void setOtherActiveProductsClose(List<ActiveProduct> otherActiveProductsClose) {
		this.otherActiveProductsClose = otherActiveProductsClose;
	}

	public List<ActiveProduct> getOtherActiveProducts() {
		return otherActiveProducts;
	}

	public void setOtherActiveProducts(List<ActiveProduct> otherActiveProducts) {
		this.otherActiveProducts = otherActiveProducts;
	}

	public List<ActiveProduct> getIndActiveProducts() {
		return indActiveProducts;
	}

	public void setIndActiveProducts(List<ActiveProduct> indActiveProducts) {
		this.indActiveProducts = indActiveProducts;
	}

	public MyProcess getMyPro() {
		return myPro;
	}

	public void setMyPro(MyProcess myPro) {
		this.myPro = myPro;
	}

	public List<MyProcess> getMyPros() {
		return myPros;
	}

	public void setMyPros(List<MyProcess> myPros) {
		this.myPros = myPros;
	}

	public String getNoteflag() {
		return noteflag;
	}

	public void setNoteflag(String noteflag) {
		this.noteflag = noteflag;
	}

	public Active getActiveTime() {
		return activeTime;
	}

	public void setActiveTime(Active activeTime) {
		this.activeTime = activeTime;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
	}

	public Active getCaiActive() {
		return caiActive;
	}

	public void setCaiActive(Active caiActive) {
		this.caiActive = caiActive;
	}

	public Active getShuActive() {
		return shuActive;
	}

	public void setShuActive(Active shuActive) {
		this.shuActive = shuActive;
	}

	public Active getZongActive() {
		return zongActive;
	}

	public void setZongActive(Active zongActive) {
		this.zongActive = zongActive;
	}

	public Active getGuanActive() {
		return guanActive;
	}

	public void setGuanActive(Active guanActive) {
		this.guanActive = guanActive;
	}

	public Active getFuActive() {
		return fuActive;
	}

	public void setFuActive(Active fuActive) {
		this.fuActive = fuActive;
	}

	public List<Active> getActiveSing() {
		return activeSing;
	}

	public void setActiveSing(List<Active> activeSing) {
		this.activeSing = activeSing;
	}

	public String getPath() {
		return path;
	}

	public String getIsApprover() {
		return isApprover;
	}

	public void setIsApprover(String isApprover) {
		this.isApprover = isApprover;
	}

	public Approve getApprove() {
		return approve;
	}

	public void setApprove(Approve approve) {
		this.approve = approve;
	}

	public List<Approve> getApproves() {
		return approves;
	}

	public void setApproves(List<Approve> approves) {
		this.approves = approves;
	}

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public List<ActiveProduct> getActiveProductsClose() {
		return activeProductsClose;
	}

	public void setActiveProductsClose(List<ActiveProduct> activeProductsClose) {
		this.activeProductsClose = activeProductsClose;
	}

	public List<ActivePosm> getActivePosmsClose() {
		return activePosmsClose;
	}

	public void setActivePosmsClose(List<ActivePosm> activePosmsClose) {
		this.activePosmsClose = activePosmsClose;
	}

	public List<ActiveMemcost> getActiveMemcostsClose() {
		return activeMemcostsClose;
	}

	public void setActiveMemcostsClose(List<ActiveMemcost> activeMemcostsClose) {
		this.activeMemcostsClose = activeMemcostsClose;
	}

	public List<ActiveMemcost> getActiveMemcosts() {
		return activeMemcosts;
	}

	public void setActiveMemcosts(List<ActiveMemcost> activeMemcosts) {
		this.activeMemcosts = activeMemcosts;
	}

	public List<ActivePosm> getActivePosms() {
		return activePosms;
	}

	public void setActivePosms(List<ActivePosm> activePosms) {
		this.activePosms = activePosms;
	}

	public List<ActiveProduct> getActiveProducts() {
		return activeProducts;
	}

	public void setActiveProducts(List<ActiveProduct> activeProducts) {
		this.activeProducts = activeProducts;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Active getActive() {
		return active;
	}

	public void setActive(Active active) {
		this.active = active;
	}

	public List<Active> getActives() {
		return actives;
	}

	public void setActives(List<Active> actives) {
		this.actives = actives;
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSselect() {
		return sselect;
	}

	public void setSselect(String sselect) {
		this.sselect = sselect;
	}

	public static int getMaxUid() {
		return maxUid;
	}

	public static void setMaxUid(int maxUid) {
		ActiveAction.maxUid = maxUid;
	}

	public int getBefUid() {
		return befUid;
	}

	public void setBefUid(int befUid) {
		this.befUid = befUid;
	}

	public int getMinUid() {
		return minUid;
	}

	public void setMinUid(int minUid) {
		this.minUid = minUid;
	}

	public int getUp() {
		return up;
	}

	public void setUp(int up) {
		this.up = up;
	}

	@Override
	public void validate() {
		// TODO Auto-generated method stub
		super.validate();
	}

	public String addPro() throws Exception {
		try {
			if (state != null && state.equals("2")) {// 结案
				this.setState("2");
			} else {
				this.setState("1");
			}
			active.setUuid(active.getUuid());
			this.setActive(active);
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/active_list?viewFlag=relist'>活动列表</a>&nbsp;&gt;&nbsp;修改活动单&nbsp;&gt;&nbsp;增加产品";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!addPro 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!addPro 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String history() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_HISTORY");
		map.clear();
		map.put("biz_id", active.getUuid());
		if (myPro != null) map.putAll(ToolsUtil.getMapByBean(myPro));
		this.setMyPros(dao.listHis(map));
		path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/active_list?viewFlag=relist'>活动列表</a>&nbsp;&gt;&nbsp;操作历史";
		return SUCCESS;
	}

	public String nextList() throws Exception {
		if (nextUuid != 0) {
			active = new Active();
			active.setUuid(nextUuid);
		} else {
			this.setUp(0);
			nextActive();
		}
		return SUCCESS;
	}

	private void nextActive() {
		List<Active> nextActives = new ArrayList<>();
		map.clear();
		this.setViewFlag("relist");
		if (active == null) active = new Active();
		ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_ACTIVE_LIST", map, "apply_depts", "apply_user");
		ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_ACTIVE_LIST", map, active, viewFlag);

		if (up == 1) {
			// 上一页
			this.setViewFlag("mdy");
			map.put("pageup", befUid);
			map.remove("Page_Size");
			map.remove("Current_Page");
			nextActives = dao.nextList(map);
			active = new Active();
			active.setUuid(nextActives.get(0).getUuid());
		} else if (up == 2) {
			map.put("pagedown", befUid);
			map.remove("Page_Size");
			map.remove("Current_Page");
			nextActives = dao.nextList(map);
			if (nextActives.size() > 0) {
				this.setNextUuid(nextActives.get(0).getUuid());
			}
		} else {
			// 下一页
			this.setViewFlag("mdy");
			map.put("pagedown", befUid);
			map.remove("Page_Size");
			map.remove("Current_Page");
			nextActives = dao.nextList(map);
			active = new Active();
			if (nextActives.size() > 0) {
				active.setUuid(nextActives.get(0).getUuid());
			} else {
				this.setViewFlag("mdy");
				active = new Active();
				active.setUuid(befUid);
				this.setMinUid(1);
				this.setMessage("已没有下一条!");
			}

		}
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_LIST");
		try {
			map.clear();
			if (active == null) active = new Active();
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_ACTIVE_LIST", map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_ACTIVE_LIST", map, active, viewFlag);
			if (flag != null && flag.equals("0")) {
				map.put("flag", "有");
			} else if (flag != null && flag.equals("10")) {
				map.put("spere", "无");
			}
			if(sd_fstauts!=null && sd_fstauts==1){
				map.put("sd_fstauts", 1);
			}
			if(smd_fstauts!=null && smd_fstauts==1){
				map.put("smd_fstauts", 1);
			}
			if(selectXiao!=null){
				if(selectXiao.equals("0")){
					map.put("sd_statused", active.getSd_status());
					map.remove("sd_status");
				}else if (selectXiao.equals("1")){
					map.put("close_sded_status", active.getClose_sd_status());
					map.remove("close_sd_status");
				}
			}
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setActives(dao.list(map));
			this.setRecCount(dao.getResultCount());
			if (recCount > 0&&actives.size()>0) {
				this.setMaxUid(actives.get(0).getUuid());
			}
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;活动列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		if (perWorkFlag == null || perWorkFlag.equals("null") || perWorkFlag.equals("") || per == null || per.equals("null")) {
			return "success";
		} else {
			perWorkFlag = null;
			return "perSuccess";
		}
	}

	public String load() throws Exception {
		if ((perWorkF == null || perWorkF.equals("null") || perWorkF.equals("")) && (perWorkFlag == null || perWorkFlag.equals(""))) {
			perWorkFlag = null;
		} else {
			this.setNextUuid(0);
			perWorkFlag = "perWork";
		}
		int activetype = 0;
		try {
			if (null == viewFlag) {
				this.setActive(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				if (active != null && active.getActiveType() != null) {
					activetype = active.getActiveType();
				}
				this.setActive(null);
				get_apply_depts();
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/active_list?viewFlag=relist'>活动列表</a>&nbsp;&gt;&nbsp;增加活动";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag)) {
				if (!(active == null || active.getUuid() == null)) {
					this.setActive((Active) dao.get(active.getUuid()));
					code = active.getApply_dept();
					activetype = active.getActiveType();
				} else {
					this.setActive(null);
				}
				get_apply_depts();// 业务部门列表
				map.clear();
				ProductDAO pdao = new ProductDAO();
				map.put("status", 0);
				this.setProducts(pdao.list(map));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				ActiveProductDAO adao = new ActiveProductDAO();
				this.setActiveProducts(adao.list(map));
				this.setIndActiveProducts(independence(map, "海拔", 1));
				this.setOtherActiveProducts(independence(map, "海拔", 2));
            
				ActivePosmDAO podao = new ActivePosmDAO();
				this.setActivePosms(podao.list(map));
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();
				this.setActiveMemcosts(amdao.list(map));

				map.clear();
				map.put("int_id", active.getUuid());
				map.put("approve_type", 1);
				map.put("ad_time_end", active.getClose_start());
				this.setApproves(apdao.list(map));
				this.setActiveSing(dao.listSing(null));
				map.clear();
				map.put("biz_id", active.getUuid());
				List<Active> activets = dao.getbaotime(map);
				if (activets.size() > 0) {
					this.setActiveTime((Active) activets.get(0));
				}
				if (nextUuid != 0) {
					this.setNextUuid(nextUuid);
				}

				/* 检查当前用户是否已经审阅 */
				if (apdao.userIsIn(approves, ContextHelper.getUserLoginUuid())) this.setIsApprover("true");
				else this.setIsApprover("false");
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/active_list?viewFlag=relist'>活动列表</a>&nbsp;&gt;&nbsp;活动申请";
			} else {
				this.setActive(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		if (activetype == 0) {
			return "SUCCESS";
		} else {
			return "DESIGN";
		}

	}

	public String loadView() throws Exception {
		int activetype = 0;
		try {
			if (!(active == null || active.getUuid() == null)) {
				this.setActive((Active) dao.get(active.getUuid()));
				activetype = active.getActiveType();
				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));
				map.clear();
				map.put("sq", "sq");
				map.put("biz_id", active.getUuid());
				this.setActiveSing(dao.listSing(map));
				if (active.getFd_status() != null && active.getFd_status() == 10) {// 财务已审
					map.clear();
					map.put("sq", "sq");
					map.put("biz_id", active.getUuid());
					map.put("cai", "zong");
					List<Active> cai = dao.listSing(map);
					if (cai.size() > 0) {
						this.setCaiActive((Active) cai.get(0));
					}
				}
				if (active.getSd_status() >= 40) {// 总监已审
					map.clear();
					map.put("sq", "sq");
					map.put("biz_id", active.getUuid());
					map.put("sd40", "zong");
					List<Active> n = dao.listSing(map);
					if (n.size() > 0) {
						this.setZongjianActive((Active) n.get(0));
					}
				}

				if (active.getSd_status() >= 60 || active.getSmd_status() >= 60) {// 总经理已审
					map.clear();
					map.put("sq", "sq");
					map.put("biz_id", active.getUuid());
					map.put("sd60", "zong");
					List<Active> n = dao.listSing(map);
					if (n.size() > 0) {
						if(n.size()>1){
							if(n.get(0).getSing()==null ||  n.get(0).getSing().equals("")){
								for(int i=1;i<n.size();i++){
									if(n.get(i).getSing()!=null){
										this.setZongActive((Active) n.get(i));
										break;
									}else{
										continue;
									}
								}
							}else{
								this.setZongActive((Active) n.get(0));
							}
							
						}else{
							this.setZongActive((Active) n.get(0));
						}
					}
				}

				if (active.getSmd_status() >= 50) {// 销管副总
					map.clear();
					map.put("sq", "sq");
					map.put("biz_id", active.getUuid());
					map.put("smd50", "zong");
					List<Active> s = dao.listSing(map);
					if (s.size() > 0) {
						this.setFuActive((Active) s.get(0));
					}

					map.clear();
					map.put("sq", "sq");
					map.put("biz_id", active.getUuid());
					map.put("smd40", "zong");
					List<Active> t = dao.listSing(map);
					if (t.size() > 0) {
						this.setGuanActive((Active) t.get(0));
					}
				}

				if (active.getSmd_status() >= 40) {// 销管部经理已审
					map.clear();
					map.put("sq", "sq");
					map.put("biz_id", active.getUuid());
					map.put("smd40", "zong");
					List<Active> t = dao.listSing(map);
					if (t.size() > 0) {
						this.setGuanActive((Active) t.get(0));
					}
				}

				if (active.getSmd_status() >= 40 || active.getSd_status()>=60) {// 董事
					map.clear();
					map.put("sq", "sq");
					map.put("biz_id", active.getUuid());
					map.put("smd70", "dong");
					List<Active> t = dao.listSing(map);
					if (t.size() > 0) {
						this.setDongActive(t.get(0));
					}
				}

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				ActiveProductDAO adao = new ActiveProductDAO();
				this.setActiveProducts(adao.list(map));
				this.setIndActiveProducts(independenceTasting(map, "海拔", 1));
				this.setOtherActiveProducts(independenceTasting(map, "海拔", 2));
				this.setActiveProductsTasting(independenceTasting(map,"品鉴",3));
				
				for (ActiveProduct activeProduct : ActiveProductsTasting) {
				
					tastingPrice=tastingPrice+activeProduct.getTotal_price();
				}
				ActivePosmDAO podao = new ActivePosmDAO();
				this.setActivePosms(podao.list(map));
				for (ActivePosm ap : activePosms) {
				     Posms=Posms+ap.getTotal_price();
			}
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();
				this.setActiveMemcosts(amdao.list(map));

				map.clear();
				map.put("biz_id", active.getUuid());
				List<Active> activets = dao.getbaotime(map);
				if (activets.size() > 0) {
					this.setActiveTime((Active) activets.get(0));
				}
			} else {
				this.setActive(null);
				this.setMessage("数据读取错误,请按照正确的方式进入页面!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		if (activetype == 0) {
			return "SUCCESS";
		} else {
			return "DESIGN";
		}
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_ADD");
		try {
			active.setUid(ToolsUtil.getCommonUUID("S"));
			active.setAdd_user(ContextHelper.getUserLoginUuid());
			// active.setApply_dept(ContextHelper.getUserLoginDept());
			active.setApply_user(ContextHelper.getUserLoginUuid());
			active.setStatus(0);
			active.setUuid((Integer) dao.add(active));
			addProcess("ACTIVE_ADD", "新增活动");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String designAdd() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_ADD");
		try {
			active.setUid(ToolsUtil.getCommonUUID("S"));
			active.setAdd_user(ContextHelper.getUserLoginUuid());
			// active.setApply_dept(ContextHelper.getUserLoginDept());
			active.setApply_user(ContextHelper.getUserLoginUuid());
			active.setUuid((Integer) dao.addDesign(active));
			active.setStatus(0);
			addProcess("ACTIVE_ADD", "新增活动");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDY");
		try {
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.save(active);
			addProcess("ACTIVE_MDY", "活动修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String designSave() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDY");
		try {
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.saveDesign(active);
			addProcess("ACTIVE_MDY", "活动修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String saveType() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDYTYPE");
		try {
			dao.mdyActiveType(active);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_DEL");
		try {
			mdyStatus(-2);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	// 审核流程

	// -1:作废 0:新申请 1:申请审批中 2:申请通过 3:开始结案 4:结案审批中 5:结案通过

	/**
	 * 作废
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus_1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS_1");
		try {
			mdyStatus(-1);

			// 作废时状态都打回初始状态
			mdyActiveSDStatus(0);
			mdyActiveSMDStatus(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS0");
		try {
			cs.checkSkip(active, 1);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审批通过,可以执行
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus1() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS1");
		try {
			// mdyStatus(2);
			active.setLm_user(ContextHelper.getUserLoginUuid());
			active.setStatus(2);// 为了addProcess而写
			dao.mdyActivePass(active);
			addProcess("ACTIVE_APPLY_PASS", "活动申请通过");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus1 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus1 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 通用改状态函数
	 * 
	 * @param status
	 * @return
	 * @date 2014-4-26 上午10:15:02
	 */
	private int mdyStatus(int status) {
		if (status == -1) {
			noteflag = "作废";
		}
		if (status == 0) {
			noteflag = "新申请";
		}
		if (status == 1) {
			noteflag = "申请审批中";
		}
		if (status == 2) {
			noteflag = "申请通过-可以执行";
		}
		if (status == 3) {
			noteflag = "开始结案";
		}
		if (status == 4) {
			noteflag = "结案审批中";
		}
		if (status == 5) {
			noteflag = "结案通过";
		}
		active.setStatus(status);
		active.setLm_user(ContextHelper.getUserLoginUuid());
		if (status == -2) {
			addProcess("ACTIVE_DEL", "活动删除");
		} else {
			String note = "活动状态变更-" + noteflag;
			addProcess("ACTIVE_MDY_STATUS", note);
		}
		return dao.mdyActiveStatus(active);
	}

	/**
	 * 审核退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS");
		try {
			mdyActiveSDStatus(5);
			mdyActiveFDStatus(1, 0);
			mdyStatus(0);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 一次申请退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatusTH() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_TH");
		try {
			mdyActiveSDStatus(5);
			mdyActiveFDStatus(1, 0);
			mdyStatus(0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 办事处审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS20");
		try {
			// mdyActiveSDStatus(30);
			cs.checkSkip(active, 0);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 区域经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus26() throws Exception {
		try {
			// mdyActiveSDStatus(30);
			cs.checkSkip(active, 26);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS10");
		try {
			// mdyActiveSDStatus(30);
			cs.checkSkip(active, 2);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 运营总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS30");
		try {
			// mdyActiveSDStatus(40);
			cs.checkSkip(active, 4);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理审核通过并送审到副总
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus30Two() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS30");
		try {
			mdyActiveSDStatus(60);
			//mdyActiveSMDStatus(40, "2");
			// cs.checkSkip(active, 4);
			active.setFstauts(0);//西北不推送副总
			dao.savefstatus(active);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
			SendMessage.sms_api1("15056617999","","商务系统活动管理有新的审批单等待您的审批！","1");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS40");
		try {
			// mdyActiveSDStatus(50);
			cs.checkSkip(active, 6);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS50");
		try {
			// mdyActiveSMDStatus(60);
			cs.checkSkip(active, 8);
			active.setFstauts(1);//西北不推送副总
			dao.savefstatus(active);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus50 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 营销中心副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:21:02
	 */
	public String mdyActiveSDStatus60() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SDSTATUS60");
		try {
			// mdyActiveSMDStatus(60);
			cs.checkSkip(active, 40);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSDStatus50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSDStatus50 数据更新失败:", e);
		}
		return SUCCESS;
	}


	/**
	 * 改销售部审批状态通用函数
	 * 
	 * @param sd_status
	 * @return
	 * @date 2014-4-26 上午10:20:39
	 */
	public int mdyActiveSDStatus(int sd_status) {
		if (sd_status == 5) {
			noteflag = "退回";
		}
		if (sd_status == 10) {
			noteflag = "待审核";
		}
		if (sd_status == 30) {
			noteflag = "大区审核通过";
		}
		if (sd_status == 40) {
			noteflag = "总监审核通过";
		}
		if (sd_status == 50) {
			noteflag = "副总审核通过";
		}
		if (sd_status == 60) {
			noteflag = "总经理审核通过";
		}
		active.setSd_status(sd_status);
		active.setSd_time(new Date());
		active.setSd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动申请-销售审核状态变更-" + noteflag;
		addProcess("ACTIVE_MDY_SDSTATUS", note);
		return dao.mdyActiveSDStatus(active);
	}

	/**
	 * 签收
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveSMDStatus0() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS0");
		try {
			mdyActiveSMDStatus(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus0 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus0 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveSMDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS");
		try {
			mdyActiveSMDStatus(5);
			mdyActiveFDStatus(1, 0);
			mdyStatus(0);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售管理经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveSMDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS10");
		try {
			// mdyActiveSMDStatus(30);
			cs.checkSkip(active, 3);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部经理已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveSMDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS50");
		try {
			// mdyActiveSMDStatus(40);
			cs.checkSkip(active, 5);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管副总已审
	 * mdyActiveSMDStatus70
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveSMDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS40");
		try {
			// mdyActiveSMDStatus(50);
			cs.checkSkip(active, 7);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 董事已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveSMDStatus70() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_SMDSTATUS60");
		try {
			// mdyActiveSMDStatus(70);
			cs.checkSkip(active, 31);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 申请财务已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDSTATUS10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_FDSTATUS10");
		try {
			cs.checkSkip(active, 9);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	
	/**
	 * 传奇财务会计
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDSTATUS901() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_FDSTATUS10");
		try {
			cs.checkSkip(active, 901);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 传奇财务经理
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDSTATUS902() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_FDSTATUS20");
		try {
			cs.checkSkip(active, 902);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	
	/**
	 * 传奇财务营销中心
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDSTATUS903() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_FDSTATUS30");
		try {
			cs.checkSkip(active, 903);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String mdyActiveFDSTATUS10Two() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_FDSTATUS10");
		try {
			//cs.checkSkip(active, 9);
			mdyActiveFDStatus(1,10);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 申请财务退回mdyActiveFDStatus5
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDStatus() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_FDSTATUS10");
		try {
			mdyActiveFDStatus(1, 5);
			mdyStatus(0);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveFDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveFDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案财务已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDCSTATUS10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10");
		try {
			cs.checkSkip(active, 19);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 结案财务已审会计
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDCSTATUS101() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10");
		try {
			cs.checkSkip(active, 101);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 结案财务已审财务经历
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDCSTATUS102() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS20");
		try {
			cs.checkSkip(active, 102);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 结案财务已审财务营销中心
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDCSTATUS103() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS30");
		try {
			cs.checkSkip(active, 103);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String mdyActiveFDCSTATUS10Two() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10");
		try {
			mdyActiveFDStatus(2,10);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案财务退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveFDCSTATUS() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10");
		try {
			mdyActiveFDStatus(2, 5);
			mdyStatus(3);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveFDCSTATUS5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveFDCSTATUS5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案数据中心已审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveNDCSTATUS10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_NDCSTATUS10");
		try {
			// mdyActiveFDStatus(3, 10);
			cs.checkSkip(active, 20);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveSMDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案数据中心退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyActiveNDCSTATUS5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_NDCSTATUS10");
		try {
			mdyActiveFDStatus(3, 5);
			mdyStatus(3);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyActiveNDCSTATUS5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyActiveNDCSTATUS5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyActiveSMDStatus(int smd_status) {
		if (smd_status == 5) {
			noteflag = "退回";
		}
		if (smd_status == 10) {
			noteflag = "已签收";
		}
		if (smd_status == 30) {
			noteflag = "销管经理审核通过";
		}
		if (smd_status == 40) {
			noteflag = "销管部经理审核通过";
		}
		if (smd_status == 50) {
			noteflag = "销管副总审核通过";
		}
		
		if (smd_status == 60) {
			noteflag = "总经理审核通过";
		}

		if (smd_status == 70) {
			noteflag = "董事审核通过";
		}
		active.setFd_status(0);
		active.setSmd_status(smd_status);
		active.setSmd_time(new Date());
		active.setSmd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动申请-销管审核状态变更-" + noteflag;
		addProcess("ACTIVE_MDY_SMDSTATUS", note);
		return dao.mdyActiveSMDStatus(active);
	}

	public int mdyActiveSMDStatus(int smd_status, String user) {
		if (smd_status == 5) {
			noteflag = "退回";
		}
		if (smd_status == 10) {
			noteflag = "已签收";
		}
		if (smd_status == 30) {
			noteflag = "销管经理审核通过";
		}
		if (smd_status == 40) {
			noteflag = "销管部经理审核通过";
		}
		if (smd_status == 50) {
			noteflag = "销管副总审核通过";
		}

		if (smd_status == 70) {
			noteflag = "董事审核通过";
		}
		active.setFd_status(0);
		active.setSmd_status(smd_status);
		active.setSmd_time(new Date());
		active.setSmd_user(user);
		active.setLm_user(user);
		String note = "活动申请-销管审核状态变更-" + noteflag;
		addProcess("ACTIVE_MDY_SMDSTATUS", note, user);
		return dao.mdyActiveSMDStatus(active);
	}

	/**
	 * 改财务审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyActiveFDStatus(int flag, int smd_status) {
		if (flag == 1) {// 申请
			if (smd_status == 5) {
				noteflag = "退回";
			}
			if (smd_status == 10) {
				noteflag = "通过";
			}
			active.setFd_status(smd_status);
			active.setFd_user(ContextHelper.getUserLoginUuid());
			active.setFd_time(new Date());
			active.setLm_user(ContextHelper.getUserLoginUuid());
			String note = "申请--财务状态变更-" + noteflag;
			addProcess("ACTIVE_MDY_FDSTATUS", note);
			return dao.mdyActiveFDStatus(active);
		} else if (flag == 2) {// 结案
			if (smd_status == 5) {
				noteflag = ContextHelper.getUserLoginName() + "退回";
			}
			if (smd_status == 10) {
				noteflag = ContextHelper.getUserLoginName() + "通过";
			}
			active.setClose_fd_status(smd_status);
			active.setClose_fd_user(ContextHelper.getUserLoginUuid());
			active.setClose_fd_time(new Date());
			active.setLm_user(ContextHelper.getUserLoginUuid());
			String note = "结案--财务状态变更-" + noteflag;
			addProcess("ACTIVE_MDY_FDCSTATUS", note);
			return dao.mdyActiveFDCStatus(active);
		} else {// 数据中心
			if (smd_status == 5) {
				noteflag = "退回";
			}
			if (smd_status == 10) {
				noteflag = "通过";
			}
			active.setClose_nd_status(smd_status);
			active.setClose_nd_user(ContextHelper.getUserLoginUuid());
			active.setClose_nd_time(new Date());
			active.setLm_user(ContextHelper.getUserLoginUuid());
			String note = "结案--数据中心状态变更-" + noteflag;
			addProcess("ACTIVE_MDY_NDCSTATUS", note);
			return dao.mdyActiveNDCStatus(active);
		}

	}

	/*********************************************************************/
	/* 开始结案流程 */
	/*********************************************************************/
	public String closeLoad() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE");
		if ((perWorkF == null || perWorkF.equals("null")) && perWorkFlag == null) {
			perWorkFlag = null;
		} else {
			this.setNextUuid(0);
			perWorkFlag = "perWork";
		}
		int activetype = 0;
		try {
			if (!(active == null || active.getUuid() == null)) {
				this.setActive((Active) dao.get(active.getUuid()));
				code = active.getApply_dept();
				activetype = active.getActiveType();
				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				ActiveProductDAO adao = new ActiveProductDAO();
				ActivePosmDAO podao = new ActivePosmDAO();
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();

				this.setActiveProducts(adao.list(map));
				this.setIndActiveProducts(independence(map, "海拔", 1));
				this.setOtherActiveProducts(independence(map, "海拔", 2));

				this.setActivePosms(podao.list(map));
				this.setActiveMemcosts(amdao.list(map));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 2);
				this.setActiveProductsClose(adao.list(map));
				this.setIndActiveProductsClose(independence(map, "海拔", 1));
				this.setOtherActiveProductsClose(independence(map, "海拔", 2));

				this.setActivePosmsClose(podao.list(map));
				this.setActiveMemcostsClose(amdao.list(map));

				map.clear();
				map.put("int_id", active.getUuid());
				map.put("approve_type", 1);
				map.put("ad_time_start", active.getClose_start());
				this.setApproves(apdao.list(map));
				map.clear();
				map.put("biz_id", active.getUuid());
				List<Active> activets = dao.getbaotime(map);
				if (activets.size() > 0) {
					this.setActiveTime((Active) activets.get(0));
				}
				/* 检查当前用户是否已经审阅 */
				if (apdao.userIsIn(approves, ContextHelper.getUserLoginUuid())) this.setIsApprover("true");
				else this.setIsApprover("false");
				if (nextUuid != 0) {
					this.setNextUuid(nextUuid);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/active_list?viewFlag=relist'>活动列表</a>&nbsp;&gt;&nbsp;活动结案";

			} else {
				this.setActive(null);
				this.setMessage("数据读取错误,请按照正确的方式进入页面!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		if (activetype == 0) {
			return "SUCCESS";
		} else {
			return "DESIGN";
		}
	}

	public String closeViewLoad() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE");
		int activetype = 0;
		try {
			if (!(active == null || active.getUuid() == null)) {
				this.setActive((Active) dao.get(active.getUuid()));
				activetype = active.getActiveType();
				ProductDAO pdao = new ProductDAO();
				this.setProducts(pdao.list(null));

				map.clear();
				map.put("ja", "ja");
				map.put("biz_id", active.getUuid());
				this.setActiveSing(dao.listSing(map));

				if (active.getClose_fd_status() != null && active.getClose_fd_status() == 10) {// 财务
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("caiClo", "zong");
					List<Active> caic = dao.listSing(map);
					if (caic.size() > 0) {
						this.setCaiActive((Active) caic.get(0));
					}
				}

				if (active.getClose_nd_status() != null && active.getClose_nd_status() == 10) {// 数据中心
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("shuClo", "zong");
					List<Active> shuC = dao.listSing(map);
					if (shuC.size() > 0) {
						this.setShuActive((Active) shuC.get(0));
					}
				}

				if (active.getClose_sd_status() >= 20) {// 总监已审
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("csd30", "zong");
					List<Active> n = dao.listSing(map);
					if (n.size() > 0) {
						this.setDaquActive((Active) n.get(0));
					}
				}

				if (active.getClose_sd_status() >= 40) {// 总监已审
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("csd40", "zong");
					List<Active> n = dao.listSing(map);
					if (n.size() > 0) {
						this.setZongjianActive((Active) n.get(0));
					}
				}

				if (active.getClose_sd_status() >= 60 || active.getClose_smd_status() >= 60) {// 总经理已审
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("csd60", "zong");
					List<Active> n = dao.listSing(map);
					if (n.size() > 0) {
						this.setZongActive((Active) n.get(0));
					}
				}

				if (active.getClose_smd_status() >= 50) {// 销管副总已审
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("csmd50", "zong");
					List<Active> s = dao.listSing(map);
					if (s.size() > 0) {
						this.setFuActive((Active) s.get(0));
					}

					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("csmd40", "zong");
					List<Active> t = dao.listSing(map);
					if (t.size() > 0) {
						this.setGuanActive((Active) t.get(0));
					}
				}

				if (active.getClose_smd_status() >= 40) {// 销管部经理已审
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("csmd40", "zong");
					List<Active> t = dao.listSing(map);
					if (t.size() > 0) {
						this.setGuanActive((Active) t.get(0));
					}
				}

				if (active.getClose_smd_status() >= 70  || active.getClose_sd_status() >= 60) {// 董事已审
					map.clear();
					map.put("ja", "sq");
					map.put("biz_id", active.getUuid());
					map.put("csd70", "dong");
					List<Active> n = dao.listSing(map);
					if (n.size() > 0) {
						this.setDongActive(n.get(0));
					}
				}

				ActiveProductDAO adao = new ActiveProductDAO();
				ActivePosmDAO podao = new ActivePosmDAO();
				ActiveMemcostDAO amdao = new ActiveMemcostDAO();

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 1);
				this.setActiveProducts(adao.list(map));
				// this.setIndActiveProducts(independence(map, "海拔", 1));
				// this.setOtherActiveProducts(independence(map, "海拔", 2));

				this.setActivePosms(podao.list(map));
				this.setActiveMemcosts(amdao.list(map));

				map.clear();
				map.put("active_id", active.getUuid());
				map.put("status", 2);
				this.setActiveProductsClose(adao.list(map));
				this.setIndActiveProductsClose(independenceTasting(map, "海拔", 1));
				this.setOtherActiveProductsClose(independenceTasting(map, "海拔", 2));
				this.setActiveProductsTasting(independenceTasting(map,"品鉴",3));
				for (ActiveProduct activeProduct : ActiveProductsTasting) {
					
					tastingPrice=tastingPrice+activeProduct.getTotal_price();
				}
				this.setActivePosmsClose(podao.list(map));
				
				for (ActivePosm ap : activePosmsClose) {
				     Posms=Posms+ap.getTotal_price();
			}
				this.setActiveMemcostsClose(amdao.list(map));
				map.clear();
				map.put("biz_id", active.getUuid());
				List<Active> activets = dao.getbaotime(map);
				if (activets.size() > 0) {
					this.setActiveTime((Active) activets.get(0));
				}

				map.clear();
				map.put("biz_id", active.getUuid());
				List<MyProcess> ps = new ArrayList<>();
				ps = dao.getDesignStartClose(map);
				if (ps.size() > 0) {
					this.setPro(ps.get(0));
				}
			} else {
				this.setActive(null);
				this.setMessage("数据读取错误,请按照正确的方式进入页面!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		if (activetype == 0) {
			return "SUCCESS";
		} else {
			return "DESIGN";
		}
	}

	/**
	 * 修改结案单(只能修改结案详情和备注)
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCloseActive() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_MDY");
		try {
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyCloseActive(active);
			addProcess("ACTIVE_CLOSE_MDY", "活动结案信息修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActive 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActive 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String mdyCloseDesign() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_MDY");
		try {
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.saveCloseDesign(active);
			addProcess("ACTIVE_CLOSE_MDY", "活动结案信息修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActive 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActive 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String saveCloseSpe() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDYSPE");
		try {
			dao.mdyCloseActiveSPE(active);
			// addProcess("ACTIVE_CLOSE_MDYSPE", "活动结案特殊备注信息修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!saveCloseSpe 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!saveCloseSpe 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 开始结案
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus2() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS2");
		try {
			active.setStatus(3);
			dao.startActiveCloseFlow(active);
			addProcess("ACTIVE_START_CLOSE", "活动开始结案");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus2 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus2 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案报审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus3() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS3");
		try {
			/*
			 * mdyStatus(4);
			 * // 同时销售部的流程变成待审核
			 * mdyCloseActiveSDStatus(10);
			 * // 同时销管部的流程变成已签收
			 * mdyCloseActiveSMDStatus(10);
			 */
			cs.checkSkip(active, 11);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 结案通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:10:19
	 */
	public String mdyStatus4() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_STATUS4");
		try {
			// mdyStatus(5);
			active.setLm_user(ContextHelper.getUserLoginUuid());
			dao.mdyCloseActivePass(active);
			// 调整随量积分
			mdyMemberCapital();
			addProcess("ACTIVE_CLOSE_PASS", "活动结案通过");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyStatus3 数据更新失败:", e);
		}
		return SUCCESS;
	}

	// 办事处经理审核流程去除
	// 销售部-审核状态 0:初始状态 5:审核退回 10:待审核 20:办事处经理审核通过
	// 30:大区经理审核通过 40:运营总监审核通过 50:业务副总审核通过 60:总经理审核通过

	/**
	 * 销售部-结案退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS5");
		try {
			mdyCloseActiveSDStatus(5);
			mdyActiveFDStatus(2, 0);
			mdyStatus(3);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 一次结案退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatusTH() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_TH");
		try {
			mdyCloseActiveSDStatus(5);
			mdyActiveFDStatus(2, 0);
			mdyActiveFDStatus(3, 0);
			mdyStatus(3);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatusT 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatusT 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 大区经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS20");
		try {
			// mdyCloseActiveSDStatus(30);
			cs.checkSkip(active, 10);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	
	/**
	 * 销售部-结案 区域经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus26() throws Exception {
		try {
			// mdyCloseActiveSDStatus(30);
			cs.checkSkip(active, 266);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 销售部-结案专员初审
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatusscs10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUSCS10");
		try {
			// mdyCloseActiveSDStatus(30);
			cs.checkSkip(active, 155);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}
	

	/**
	 * 销售部-结案 大区经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10");
		try {
			// mdyCloseActiveSDStatus(30);
			cs.checkSkip(active, 12);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 运营总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS30");
		try {
			// mdyCloseActiveSDStatus(40);
			cs.checkSkip(active, 14);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus30Two() throws Exception {
		//ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS30");
		try {
			mdyCloseActiveSDStatus(60);
			//mdyCloseActiveSMDStatus(40, "2");
			// cs.checkSkip(active, 14);
			active.setFstauts(0);//西北不推送副总
			dao.savefstatus(active);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
			SendMessage.sms_api1("15056617999","","商务系统活动管理有新的审批单等待您的审批！","1");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 销售副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus40() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS40");
		try {
			// mdyCloseActiveSDStatus(50);
			cs.checkSkip(active, 16);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus40 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus40 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销售部-结案 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS50");
		try {
			// mdyCloseActiveSMDStatus(60);
			cs.checkSkip(active, 18);
			active.setFstauts(1);//西北不推送副总
			dao.savefstatus(active);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus50 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	
	/**
	 * 销售部-结案 营销中心副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSDStatus60() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS60");
		try {
			// mdyCloseActiveSMDStatus(60);
			cs.checkSkip(active, 41);
			
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSDStatus50 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSDStatus50 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseActiveSDStatus(int close_sd_status) {
		if (close_sd_status == 5) {
			noteflag = "退回";
		}
		if (close_sd_status == 10) {
			noteflag = "待审核";
		}
		if (close_sd_status == 30) {
			noteflag = "大区审核通过";
		}
		if (close_sd_status == 40) {
			noteflag = "总监审核通过";
		}
		if (close_sd_status == 50) {
			noteflag = "副总审核通过";
		}
		if (close_sd_status == 60) {
			noteflag = "总经理审核通过";
		}
		active.setClose_fd_status(0);
		active.setClose_nd_status(0);
		active.setClose_sd_status(close_sd_status);
		active.setClose_sd_time(new Date());
		active.setClose_sd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动结案-销售审核状态变更-" + noteflag;
		addProcess("ACTIVE_CLOSE_SDSTATUS", note);

		return dao.mdyCloseActiveSDStatus(active);
	}

	// 去除销管部经理已审,没有这个流程
	// 销售管理部-审核状态 0:未签收 5:审核退回 10:已签收 20:主管已审 30:销管经理已审 40:销管部经理已审 50:副总已审

	/**
	 * 销管部-结案退回
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS5");
		try {
			mdyCloseActiveSMDStatus(5);
			mdyActiveFDStatus(2, 0);
			mdyStatus(3);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus5 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus5 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部-销管经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS10");
		try {
			// mdyCloseActiveSMDStatus(30);
			cs.checkSkip(active, 13);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部-销管部经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus50() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS50");
		try {
			// mdyCloseActiveSMDStatus(40);
			cs.checkSkip(active, 15);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus10 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus10 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部-销管副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS30");
		try {
			// mdyCloseActiveSMDStatus(50);
			cs.checkSkip(active, 17);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus30 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus30 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 销管部-董事审核通过
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyCloseActiveSMDStatus60() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS60");
		try {
			// mdyCloseActiveSMDStatus(70);
			cs.checkSkip(active, 21);
			this.setBefUid(active.getUuid());
			this.setUp(2);
			nextActive();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCloseActiveSMDStatus60 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCloseActiveSMDStatus60 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改销售管理部审核状态通用权限
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:25:25
	 */
	public int mdyCloseActiveSMDStatus(int close_sd_status) {
		if (close_sd_status == 5) {
			noteflag = "退回";
		}
		if (close_sd_status == 10) {
			noteflag = "已签收";
		}
		if (close_sd_status == 30) {
			noteflag = "销管经理审核通过";
		}
		if (close_sd_status == 40) {
			noteflag = "销管部经理审核通过";
		}
		if (close_sd_status == 50) {
			noteflag = "销管副总审核通过";
		}
		
		if (close_sd_status == 60) {
			noteflag = "总经理审核通过";
		}
		
		active.setClose_fd_status(0);
		active.setClose_nd_status(0);
		active.setClose_smd_status(close_sd_status);
		active.setClose_smd_time(new Date());
		active.setClose_smd_user(ContextHelper.getUserLoginUuid());
		active.setLm_user(ContextHelper.getUserLoginUuid());
		String note = "活动结案-销管审核状态变更" + noteflag;
		addProcess("ACTIVE_CLOSE_SMDSTATUS", note);
		return dao.mdyCloseActiveSMDStatus(active);
	}

	public int mdyCloseActiveSMDStatus(int close_sd_status, String user) {
		if (close_sd_status == 5) {
			noteflag = "退回";
		}
		if (close_sd_status == 10) {
			noteflag = "已签收";
		}
		if (close_sd_status == 30) {
			noteflag = "销管经理审核通过";
		}
		if (close_sd_status == 40) {
			noteflag = "销管部经理审核通过";
		}
		if (close_sd_status == 50) {
			noteflag = "销管副总审核通过";
		}
		active.setClose_fd_status(0);
		active.setClose_nd_status(0);
		active.setClose_smd_status(close_sd_status);
		active.setClose_smd_time(new Date());
		active.setClose_smd_user(user);
		active.setLm_user(user);
		String note = "活动结案-销管审核状态变更" + noteflag;
		addProcess("ACTIVE_CLOSE_SMDSTATUS", note, user);
		return dao.mdyCloseActiveSMDStatus(active);
	}

	/**
	 * 扣除随量积分动作(结案审核完成之后)
	 * 
	 * @date 2014-4-26 下午10:19:28
	 */
	public void mdyMemberCapital() {
		ActiveMemcostDAO amdao = new ActiveMemcostDAO();
		map.clear();
		map.put("active_id", active.getUuid());
		map.put("status", 2);
		this.setActiveMemcostsClose(amdao.list(map));
		if (!(activeMemcostsClose == null || activeMemcostsClose.size() == 0)) {
			MemberCapitalDAO mdao = new MemberCapitalDAO();
			MemberCapital memberCapital;
			for (ActiveMemcost am : activeMemcostsClose) {
				memberCapital = new MemberCapital();
				memberCapital.setMember_id(am.getMember_id());
				memberCapital.setWith_score(am.getWith_score());
				mdao.mdyCapital(memberCapital, 8, 0, "积分调整,调整编号:[" + active.getUuid() + "-" + am.getUuid() + "]");
			}
		}
	}

	/**
	 * 修改发货信息
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-4-26 上午10:29:40
	 */
	public String mdyShipInfo() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_MDYSHIPINFO");
		try {
			dao.mdyShipInfo(active);
			addProcess("ACTIVE_SHIP", "活动-出货信息修改");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyShipInfo 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审阅
	 * 
	 * @return
	 * @throws Exception
	 */
	public String approve() throws Exception {
		ContextHelper.isPermits(new String[] { "QKJ_QKJMANAGE_ACTIVE_APPROVE", "QKJ_QKJMANAGE_ACTIVECLOSE_APPROVE" }, false);
		try {
			apdao.add(approve, 1, active.getUuid());
			addProcess("ACTIVE_APPROVE", "活动-增加一条审阅信息");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approve 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approve 数据更新失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 删除审阅
	 * 
	 * @return
	 * @throws Exception
	 */
	public String approveDel() throws Exception {
		ContextHelper.isPermits(new String[] { "QKJ_QKJMANAGE_ACTIVE_APPROVEDELLAST", "QKJ_QKJMANAGE_ACTIVECLOSE_APPROVEDELLAST" }, false);
		try {
			apdao.deleteLast(approve, 1, active.getUuid());
			addProcess("ACTIVE_APPROVEDEL", "活动-删除一条审阅信息");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approveDel 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approveDel 数据更新失败:", e);
		}
		return SUCCESS;
	}

	private void addProcess(String p_sign, String p_note) {
		ProcessDAO pdao = new ProcessDAO();
		if (active != null) {
			pdao.addProcess(1, active.getUuid(), p_sign, p_note, active.getStatus(), active.getSd_status(), active.getSmd_status(), active.getClose_sd_status(),
					active.getClose_smd_status(), ContextHelper.getUserLoginUuid());
		}
	}

	private void addProcess(String p_sign, String p_note, String user) {
		ProcessDAO pdao = new ProcessDAO();
		if (active != null) {
			pdao.addProcess(1, active.getUuid(), p_sign, p_note, active.getStatus(), active.getSd_status(), active.getSmd_status(), active.getClose_sd_status(),
					active.getClose_smd_status(), user);
		}
	}

	private List<ActiveProduct> independence(Map<String, Object> map, String title, int flag) {
		ActiveProductDAO adao = new ActiveProductDAO();
		List<ActiveProduct> products = new ArrayList<>();
		ActiveProduct pri = new ActiveProduct();
		if (flag == 1) {// 是需要独立显示的商品
			map.put("title", title);
			map.remove("othertitle");
			products = adao.list(map);
			if (products.size() > 0) {
				for (int i = 0; i < products.size(); i++) {
					pri = products.get(i);
					indprice = indprice + pri.getTotal_price();
				}
			}
		} else if (flag == 2) {
			map.remove("title");
			
			map.put("othertitle", title);
			products = adao.list(map);
		}
		return products;
	}

	
	
	private List<ActiveProduct> independenceTasting(Map<String, Object> map, String title, int flag) {
		ActiveProductDAO adao = new ActiveProductDAO();
		List<ActiveProduct> products = new ArrayList<>();
		ActiveProduct pri = new ActiveProduct();
		if (flag == 1) {// 是需要独立显示的商品
			map.put("title", title);
			map.remove("othertitle");
			map.put("boobrand", "9");
			products = adao.list(map);
			if (products.size() > 0) {
				for (int i = 0; i < products.size(); i++) {
					pri = products.get(i);
					indprice = indprice + pri.getTotal_price();
				}
			}
		} else if (flag == 2) {
			map.remove("title");
			map.put("boobrand", "9");
			map.put("othertitle", title);
			products = adao.list(map);
		}else if (flag==3){
			map.remove("othertitle");
			map.remove("boobrand");
			map.put("brand", "9");
			products = adao.list(map);
		}
		return products;
	}
	
	
	public void get_apply_depts() {
		Map<String, String> newMap = new HashMap<String, String>();
		newMap = ContextHelper.getUserLoginInfo().getPermit_depts2();
		Set<String> set = newMap.keySet();
		List<Active> acs = new ArrayList<>();
		for (String s : set) {
			Active ac = new Active();
			ac.setApply_dept(s);
			String value = newMap.get(s);
			ac.setApply_dept_name(value.substring(0, value.indexOf("#")));
			acs.add(ac);
		}
		this.setGetapply_depts(acs);
		this.setUserappid(ContextHelper.getUserLoginUuid());
		this.setUserdepta(ContextHelper.getUserLoginDept());
	}

	/**
	 * 门头
	 */

	public String designList() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_LIST");
		try {
			map.clear();
			if (active == null) active = new Active();
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_ACTIVE_LIST", map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_ACTIVE_LIST", map, active, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setActives(dao.DesignList(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;门头活动列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	/**
	 * 流程定制后数据补充
	 */
	public String reinforce() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ACTIVE_REINFORCE");
		try {
			String sql = null;
			sql = "SELECT a.`uuid`,a.`active_type`,a.`apply_dept` FROM qkjm_r_active a WHERE a.`sd_status`=40 AND a.`fd_status`=0 AND a.`smd_status`<50 AND a.`status`=1 AND a.`apply_dept` LIKE '21%'";
			List<Map> activeMapBs = comdao.commonSelectMapList(sql);
			if (activeMapBs.size() > 0) {
				for (int i = 0; i < activeMapBs.size(); i++) {
					active = new Active();
					ToolsUtil.getBeanByMap(active, activeMapBs.get(i));
					cs.checkSkip2(active, 4);
				}
			}

			sql = "SELECT a.`uuid`,a.`active_type`,a.`apply_dept` FROM qkjm_r_active a WHERE a.`close_sd_status`=40 AND a.`close_fd_status`=0 AND a.`close_smd_status`<50 AND a.`status`=4 AND a.`apply_dept` LIKE '21%'";
			List<Map> activeMaps = comdao.commonSelectMapList(sql);
			if (activeMaps.size() > 0) {
				for (int i = 0; i < activeMaps.size(); i++) {
					active = new Active();
					ToolsUtil.getBeanByMap(active, activeMaps.get(i));
					cs.checkSkip2(active, 14);
				}
			}

			sql = "SELECT a.`uuid`,a.`active_type`,a.`apply_dept` FROM qkjm_r_active a WHERE a.`status`=1 AND  a.`sd_status`=30 AND a.`smd_status`<30 AND (a.`apply_dept` LIKE '2302%' OR a.`apply_dept` LIKE '22030%')";
			List<Map> activeMapXs = comdao.commonSelectMapList(sql);
			if (activeMapXs.size() > 0) {
				for (int i = 0; i < activeMapXs.size(); i++) {
					active = new Active();
					ToolsUtil.getBeanByMap(active, activeMapXs.get(i));
					cs.checkSkip2(active, 2);
				}
			}

			sql = "SELECT a.`uuid`,a.`active_type`,a.`apply_dept` FROM qkjm_r_active a WHERE a.`status`=4 AND  a.`close_sd_status`=30 AND a.`close_smd_status`<30 AND (a.`apply_dept` LIKE '2302%' OR a.`apply_dept` LIKE '22030%')";
			List<Map> activeMapJs = comdao.commonSelectMapList(sql);
			if (activeMapJs.size() > 0) {
				for (int i = 0; i < activeMapJs.size(); i++) {
					active = new Active();
					ToolsUtil.getBeanByMap(active, activeMapJs.get(i));
					cs.checkSkip2(active, 12);
				}
			}

		} catch (Exception e) {
			log.error(this.getClass().getName() + "!approveDel 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!approveDel 数据更新失败:", e);
		}
		return SUCCESS;
	}
}
