package com.qkj.manage.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ActionAttr;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.IWebConfig;
import org.iweb.sys.OSSUtil_IMG;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.MarketDAO;
import com.qkj.manage.domain.Market;

public class MarketAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(MarketAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private MarketDAO dao = new MarketDAO();
	private Market market;
	private List<Market> markets;
	private String viewFlag;
	private String message;
	private int recCount;
	private int pageSize;
	private String flag;

	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;网络营销管理";
	
	
	public String getFlag() {
		return flag;
	}

	public void setFlag(String flag) {
		this.flag = flag;
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
	public Market getMarket() {
		return market;
	}

	public void setMarket(Market market) {
		this.market = market;
	}

	public List<Market> getMarkets() {
		return markets;
	}

	public void setMarkets(List<Market> markets) {
		this.markets = markets;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}
	
	public String writejs() throws Exception{
		ContextHelper.isPermit("QKJ_QKJMANAGE_MARKET");
		String p=IWebConfig.getConfigMap().get("WebAbsolutePath");
		OutputStreamWriter out =new OutputStreamWriter(new FileOutputStream(p+"/js/Info.js"),"UTF-8");
		this.setMarkets(dao.list(null));
		String info=null;
		info="var bmap = new Map();"+'\n';
        out.write(info);
        if(markets.size()>0){
        	for(int i=0;i<markets.size();i++){
        		market=markets.get(i);
        		info="bmap.put('qkj"+market.getUuid()+"', { x : "+market.getAbs()+", y : "+market.getYaxis()+", name : '"+market.getName()+"', area : '"+market.getArea()+"', lead : '"+market.getLead()+"', msg : '"+market.getAddress()+"<br />";
        		if(market.getPeople()!=null && !market.getPeople().equals("")){
        			info+="联系人："+market.getPeople()+"<br />联系电话："+market.getPhone()+"',img : '";
        		}else{
        			info+="联系电话："+market.getPhone()+"',img : '";
        		}
        		if(market.getImg()!=null && !market.getImg().equals("")){
        			info+=market.getImg()+"' });"+'\n';
        		}else{
        			info+="'"+" });"+'\n';
        		}
        		out.write(info);
        	}
        }
        info="var areas = [ '西北', '华北', '东北', '华东', '中南', '西南' ];";
        out.write(info);
        out.flush();
 	    out.close();
 	    
 	    ObjectMetadata meta = new ObjectMetadata();
		File f = new File(p+"/js/Info.js");
		// InputStream in = new FileInputStream(f);
		meta.setContentLength(f.length());
		OSSUtil_IMG.uploadFile("qkjbj01", "CacheFiles/Marketing_network_map_info.js", f, meta);
		
		return SUCCESS;
	}
	
	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_MARKET");
		String code=ContextHelper.getUserLoginDept();
		try {
				map.clear();
				if (market != null)
					map.putAll(ToolsUtil.getMapByBean(market));
				map.putAll(ContextHelper.getDefaultRequestMap4Page());
				this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
				if (ContextHelper.isAdmin()) {// 管理员
					
				}else{
					map.put("deptcode", code);
				}
				
				this.setMarkets(dao.list(map));
				this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;网络营销管理";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
			
			return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setMarket(null);
				setMessage("你没有选择任何操作!");
				return "Success";
			} else if ("add".equals(viewFlag)) {
				this.setMarket(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/market_list?viewFlag=relist'>网络营销管理</a>&nbsp;&gt;&nbsp;增加信息";
				return "Success";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag)) {
				if (!(market == null || market.getUuid() == null)) {
					this.setMarket((Market) dao.get(market.getUuid()));
				} else {
					this.setMarket(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/market_list?viewFlag=relist'>网络营销管理</a>&nbsp;&gt;&nbsp;修改信息";
				if(flag!=null && flag.equals("1")){
					return "addSuccess";
				}else{
					return "Success";
				}
				
			} else {
				this.setMarket(null);
				setMessage("无操作类型!");
				return "Success";
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
	}


	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_MARKET_ADD");
		try {
			market.setLm_user(ContextHelper.getUserLoginUuid());
			market.setDeptcode(ContextHelper.getUserLoginDept());
			market.setUuid((Integer) dao.add(market));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_MARKET_MDY");
		try {
			market.setLm_user(ContextHelper.getUserLoginUuid());
			market.setLm_time(new Date());
			dao.save(market);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String saveab()throws Exception {
		market.setUuid(market.getUuid());
		return SUCCESS;
	}
	
	public String saveay() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_MARKET_MDY");
		try {
			System.out.println(market.getUuid()+"aa"+market.getAbs());
			dao.saveay(market);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_MARKET_DEL");
		try {
			dao.delete(market);
			setMessage("删除成功!ID=" + market.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

}
