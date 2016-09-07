package com.qkj.manage.action;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.EntertDAO;
import com.qkj.manage.dao.EntertProductDAO;
import com.qkj.manage.domain.EntertMember;
import com.qkj.manage.domain.Entertain;
import com.qkj.manage.domain.EntertainProduct;

public class EntertAction extends ActionSupport{
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ActiveAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private EntertDAO dao=new EntertDAO();
	private EntertProductDAO pdao=new EntertProductDAO();
	private Entertain entert;
	private List<Entertain> enterts;
	private EntertainProduct entertProduct;
	private List<EntertainProduct> entertProducts;
	private EntertMember entertMem;
	private List<EntertMember> entertMems;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;招待用酒列表";
	
	public EntertMember getEntertMem() {
		return entertMem;
	}
	public void setEntertMem(EntertMember entertMem) {
		this.entertMem = entertMem;
	}
	public List<EntertMember> getEntertMems() {
		return entertMems;
	}
	public void setEntertMems(List<EntertMember> entertMems) {
		this.entertMems = entertMems;
	}
	public int getCurrPage() {
		return currPage;
	}
	public void setCurrPage(int currPage) {
		this.currPage = currPage;
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
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Entertain getEntert() {
		return entert;
	}
	public void setEntert(Entertain entert) {
		this.entert = entert;
	}
	public List<Entertain> getEnterts() {
		return enterts;
	}
	public void setEnterts(List<Entertain> enterts) {
		this.enterts = enterts;
	}
	public EntertainProduct getEntertProduct() {
		return entertProduct;
	}
	public void setEntertProduct(EntertainProduct entertProduct) {
		this.entertProduct = entertProduct;
	}
	public List<EntertainProduct> getEntertProducts() {
		return entertProducts;
	}
	public void setEntertProducts(List<EntertainProduct> entertProducts) {
		this.entertProducts = entertProducts;
	}
	
	
	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ENTERTAI");
		try {
			map.clear();
			if (entert == null) entert = new Entertain();
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_ENTERTAI", map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_ENTERTAI", map, entert, viewFlag);
			SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
			if(entert!=null && entert.getPlan_start_begin()!=null){
				map.remove("plan_start_begin");
				String str = sdf.format(entert.getPlan_start_begin());
				map.put("plan_start_begin", str);
			}
			if(entert!=null && entert.getPlan_start_end()!=null){
				map.remove("plan_start_end");
				String str = sdf.format(entert.getPlan_start_end());
				map.put("plan_start_end", str);
			}
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setEnterts(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		
		
		return SUCCESS;
	}
	
	public String listReport() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ENTERTAI");
		try {
			map.clear();
			if (entert == null) entert = new Entertain();
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_ENTERTAI", map, entert, viewFlag);
			this.setEntertProducts(pdao.listReport(map));
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		
		
		return SUCCESS;
	}
	
	public String print() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		this.setEntertProducts(pdao.list(null));
		String fileName = ContextHelper.getUserLoginName()+"汇总表格";
		if (entertProducts.size()>0) {
			WritableWorkbook wwb = null;
			// 设这输出的类型和文件格式
			response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			response.setHeader("Content-Disposition", "attachment;filename="
					+ new String((fileName + ".xls").getBytes(), "iso-8859-1"));
			// 设置文件名和并且解决中文名不能下载
			OutputStream os = response.getOutputStream();
			// 创建可写入的Excel工作簿
			wwb = Workbook.createWorkbook(os);
			// 创建工作表
			WritableSheet ws = wwb.createSheet(ContextHelper.getUserLoginName()
					+ "汇总", 0);

			ws.setColumnView(0, 20);
			ws.setColumnView(1, 25);
			ws.setColumnView(2, 15);
			ws.setColumnView(3, 15);
			ws.setColumnView(4, 15);
			ws.setColumnView(5, 15);
			WritableFont font1 = new WritableFont(WritableFont.ARIAL, 11);

			WritableCellFormat cellFormat1 = new WritableCellFormat(font1);
			
			// 查询数据库中所有的数据
			map.clear();
			map.put("notype", 1);
			// 要插入到的Excel表格的行号，默认从0开始
			Label labelId = new Label(0, 0, "部门", cellFormat1);// 表示第1列1个
			Label labelName = new Label(1, 0, "品名", cellFormat1);// 第2列1个
			Label labelMeName = new Label(2, 0, "数量", cellFormat1);// 第五列1 行
			Label labelMeName1 = new Label(3, 0, "申请日期", cellFormat1);// 第五列1 行
			Label labelMeName2 = new Label(4, 0, "编号", cellFormat1);// 第五列1 行
			Label labelMeName3 = new Label(5, 0, "申请人", cellFormat1);// 第五列1 行
			Label labelMeName4 = new Label(6, 0, "状态", cellFormat1);// 第五列1 行
			ws.addCell(labelId);
			ws.addCell(labelName);
			ws.addCell(labelMeName);
			ws.addCell(labelMeName1);
			ws.addCell(labelMeName2);
			ws.addCell(labelMeName3);
			ws.addCell(labelMeName4);

			for (short i = 0; i < entertProducts.size(); i++) {
				// 创建一行，在页sheet上
				Label labelres_i = new Label(0, i + 2, entertProducts.get(i).getApply_dept_name()==null?"无":entertProducts.get(i).getApply_dept_name());
				Label labelres_c = new Label(1, i + 2, entertProducts.get(i).getProduct_name()==null?"无": entertProducts.get(i).getProduct_name());
				Double t=(double) (entertProducts.get(i).getNum()/entertProducts.get(i).getCase_spec());
				Label labelres_d = new Label(2, i + 2, Double.toString(entertProducts.get(i).getNum())+"/"+Double.toString(t)+"件");
				
				SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
				String str = sdf.format(entertProducts.get(i).getApply_date());
				Label labelres_d1 = new Label(3, i + 2, str);
				Label labelres_d2 = new Label(4, i + 2, entertProducts.get(i).getEnter_id()==null?"无": entertProducts.get(i).getEnter_id());
				Label labelres_d3 = new Label(5, i + 2, entertProducts.get(i).getApply_user_name()==null?"无": entertProducts.get(i).getApply_user_name());
				String st="";
				if(entertProducts.get(i)!=null && entertProducts.get(i).getEstate()!=null){
					if(entertProducts.get(i).getEstate()==1){
						st="已出库";
					}else{
						st="未出库";
					}
				}else{
					st="未出库";
					
				}
				Label labelres_d4 = new Label(6, i + 2, st);
				ws.addCell(labelres_i);
				ws.addCell(labelres_c);
				ws.addCell(labelres_d);
				ws.addCell(labelres_d1);
				ws.addCell(labelres_d2);
				ws.addCell(labelres_d3);
				ws.addCell(labelres_d4);
			}
			

			// 写进文档
			wwb.write();
			// 关闭Excel工作簿对象
			wwb.close();
			os.close();
			response.flushBuffer();
		}
		return null;
	}

	public String load() throws Exception {
		int activetype = 0;
		try {
			if (null == viewFlag) {
				this.setEntert(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setEntert(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/entert_list?viewFlag=relist'>活动列表</a>&nbsp;&gt;&nbsp;增加";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag)) {
				if (!(entert == null || entert.getUuid() == null)) {
					this.setEntert((Entertain) dao.get(entert.getUuid()));
				} else {
					this.setEntert(null);
				}
				map.clear();
				map.put("enter_id", entert.getUuid());
				EntertProductDAO adao = new EntertProductDAO();
				this.setEntertProducts(adao.list(map));
				this.setEntertMems(adao.listmem(map));
				/* 检查当前用户是否已经审阅 */
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/entert_list?viewFlag=relist'>活动列表</a>&nbsp;&gt;&nbsp;活动申请";
			} else {
				this.setEntert(null);
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

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ENTERTAI_ADD");
		try {
			entert.setAdd_user(ContextHelper.getUserLoginUuid());
			// active.setApply_dept(ContextHelper.getUserLoginDept());
			entert.setUuid((Integer) dao.add(entert));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ENTERTAI_MDY");
		try {
			entert.setLm_user(ContextHelper.getUserLoginUuid());
			entert.setLm_time(new Date());
			dao.save(entert);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String savestate() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ENTERTAI_MDY");
		try {
			entert.setLm_user(ContextHelper.getUserLoginUuid());
			entert.setLm_time(new Date());
			dao.savestate(entert);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}
	
	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_ENTERTAI_DEL");
		try {
			dao.delete(entert);
			setMessage("删除成功!ID=" + entert.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

}
