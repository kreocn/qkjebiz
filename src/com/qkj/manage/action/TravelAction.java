package com.qkj.manage.action;

import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.UnderlineStyle;
import jxl.write.Alignment;
import jxl.write.Border;
import jxl.write.BorderLineStyle;
import jxl.write.Colour;
import jxl.write.Label;
import jxl.write.VerticalAlignment;
import jxl.write.WritableCellFeatures;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.CloseOrderDAO;
import com.qkj.manage.dao.ProcessDAO;
import com.qkj.manage.dao.ProductDAO;
import com.qkj.manage.dao.TravelCustomerDAO;
import com.qkj.manage.dao.TravelDAO;
import com.qkj.manage.dao.TravelProductDAO;
import com.qkj.manage.domain.CloseOrder;
import com.qkj.manage.domain.Product;
import com.qkj.manage.domain.Travel;
import com.qkj.manage.domain.TravelCustomer;
import com.qkj.manage.domain.TravelProduct;

public class TravelAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(TravelAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private TravelDAO dao = new TravelDAO();

	private Travel travel;
	private List<Travel> travels;

	private List<TravelCustomer> travelCustomers;
	private List<TravelProduct> travelProducts;
	private List<Product> products;
	
	private CloseOrder co;
	private List<CloseOrder> cos;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;工业旅游申请列表";
	// 个人工作标识
	private String perWorkF;
	private static String perWorkFlag=null;
	
	public String per = "per";

	public String getPer() {
		return per;
	}

	public void setPer(String per) {
		this.per = per;
	}
	
	public CloseOrder getCo() {
		return co;
	}

	public void setCo(CloseOrder co) {
		this.co = co;
	}

	public List<CloseOrder> getCos() {
		return cos;
	}

	public void setCos(List<CloseOrder> cos) {
		this.cos = cos;
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
		TravelAction.perWorkFlag = perWorkFlag;
	}

	public String getPath() {
		return path;
	}

	public List<Product> getProducts() {
		return products;
	}

	public List<TravelProduct> getTravelProducts() {
		return travelProducts;
	}

	public List<TravelCustomer> getTravelCustomers() {
		return travelCustomers;
	}

	public Travel getTravel() {
		return travel;
	}

	public void setTravel(Travel travel) {
		this.travel = travel;
	}

	public List<Travel> getTravels() {
		return travels;
	}

	public void setTravels(List<Travel> travels) {
		this.travels = travels;
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

	public int getCurrPage() {
		return currPage;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_LIST");
		try {
			map.clear();
			if (travel == null) travel = new Travel();
			ContextHelper.setSearchDeptPermit4Search("QKJ_QKJMANAGE_TRAVEL_LIST",map, "apply_depts", "apply_user");
			ContextHelper.SimpleSearchMap4Page("QKJ_QKJMANAGE_TRAVEL_LIST", map, travel, viewFlag);
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setTravels(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;工业旅游申请列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		if(perWorkFlag==null || perWorkFlag.equals("null") || per==null ||per.equals("null")){
			return "success";
		}else{
			perWorkFlag=null;
			return "perSuccess";
		}
	}

	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		if((perWorkF==null || perWorkF.equals("null")) && perWorkFlag==null){
			perWorkFlag=null;
		}else{
			perWorkFlag="perWork";
		}
		try {
			if ("add".equals(viewFlag)) {
				// this.setTravel(null);
				if (travel == null) {
					travel = new Travel();
				}
				travel.setApply_dept(ContextHelper.getUserLoginDept());
				travel.setApply_dept_name(ContextHelper.getUserLoginDeptName());
				travel.setApply_user(ContextHelper.getUserLoginUuid());
				travel.setApply_user_name(ContextHelper.getUserLoginInfo().getUser_name());
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/travel_list?viewFlag=relist'>工业旅游申请列表</a>&nbsp;&gt;&nbsp;增加工业旅游申请";
			} else if ("mdy".equals(viewFlag) || "print1".equals(viewFlag) || "print2".equals(viewFlag) || "print3".equals(viewFlag)) {
				if (!(travel == null || travel.getUuid() == null)) {
					this.setTravel((Travel) dao.get(travel.getUuid()));
					// checkbox专用转换
					if (!ToolsUtil.isEmpty(travel.getApply_item())) {
						travel.setApply_items(travel.getApply_item().split(","));
					}
					if (!ToolsUtil.isEmpty(travel.getCar())) {
						travel.setCars(travel.getCar().split(","));
					}

					TravelCustomerDAO cdao = new TravelCustomerDAO();
					map.clear();
					map.put("travel_id", travel.getUuid());
					map.put("status", 1);
					travelCustomers = cdao.list(map);

					TravelProductDAO pdao = new TravelProductDAO();
					travelProducts = pdao.list(map);

					ProductDAO pdao2 = new ProductDAO();
					products = pdao2.list(null);

					if ("print1".equals(viewFlag) || "print2".equals(viewFlag) || "print3".equals(viewFlag)) return viewFlag;
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/travel_list?viewFlag=relist'>工业旅游申请列表</a>&nbsp;&gt;&nbsp;修改工业旅游申请";
			} else {
				this.setMessage("参数丢失,自动转到添加申请单页面.");
				this.setViewFlag("add");
				load();
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}
	
	public String closeLoad() throws Exception {
		if((perWorkF==null || perWorkF.equals("null")) && perWorkFlag==null){
			perWorkFlag=null;
		}else{
			perWorkFlag="perWork";
		}
		try {
			if ("add".equals(viewFlag)) {
				// this.setTravel(null);
				if (travel == null) {
					travel = new Travel();
				} 
				CloseOrderDAO cod=new CloseOrderDAO();
				map.clear();
				map.put("apply_id", travel.getUuid());
				map.put("type", 1);
				this.setCos(cod.list(map));
				if(cos.size()>0){
					this.setCo(cos.get(0));
					this.setTravel((Travel) dao.get(travel.getUuid()));
					travel.setStatus(1);
					dao.mdyStatus(travel);
				}else{
					dao.startTransaction();
					this.setTravel((Travel) dao.get(travel.getUuid()));
					travel.setStatus(1);
					dao.mdyStatus(travel);
					CloseOrderAction ca=new CloseOrderAction();
					co=new CloseOrder();
					co.setMember_id(travel.getMember_id());
					co.setMember_address(travel.getMember_address());
					co.setMember_phone(travel.getMember_phone());
					co.setMember_name(travel.getMembers_names());
					co.setTheme("会员"+travel.getMembers_names()+"工业旅游结案");
					co.setClose_time(new Date());
					co.setClose_num(ca.number(travel.getApply_dept()));// 单据编号
					co.setApply_dept(travel.getApply_dept());//co.setApply_dept(ContextHelper.getUserLoginDept());20151103修改
					co.setAdd_user(travel.getApply_user());
					co.setAdd_time(new Date());
					co.setLm_user(ContextHelper.getUserLoginUuid());
					co.setLm_time(new Date());
					co.setState(0);
					co.setType(1);
					co.setApply_id(travel.getUuid());
					cod.add(co);
					addProcess("CLOSEORDER_ADD", "新增工业旅游结案单", ContextHelper.getUserLoginUuid());
					dao.commitTransaction();
				}
				
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/travel_list?viewFlag=relist'>工业旅游申请列表</a>&nbsp;&gt;&nbsp;增加工业旅游申请";
			} else if ("mdy".equals(viewFlag) || "print1".equals(viewFlag) || "print2".equals(viewFlag) || "print3".equals(viewFlag)) {
				if (!(travel == null || travel.getUuid() == null)) {
					CloseOrderDAO cod=new CloseOrderDAO();
					map.clear();
					map.put("apply_id", travel.getUuid());
					map.put("type", 1);
					this.setCos(cod.list(map));
					if(cos.size()>0)
					this.setCo((CloseOrder) cos.get(0));
					
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/travel_list?viewFlag=relist'>工业旅游申请列表</a>&nbsp;&gt;&nbsp;修改工业旅游申请";
			} else {
				this.setMessage("参数丢失,自动转到添加申请单页面.");
				this.setViewFlag("add");
				load();
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}finally{
			dao.endTransaction();
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ADD");
		try {
			travel.setCheck_status(0);
			travel.setAcheck_status(0);
			travel.setAdd_user(ContextHelper.getUserLoginUuid());
			travel.setAdd_time(new Date());
			travel.setLm_user(ContextHelper.getUserLoginUuid());
			travel.setLm_time(new Date());

			// checkbox 专用转换
			travel.setApply_item(ToolsUtil.Array2String(travel.getApply_items() == null ? new String[] {} : travel.getApply_items(), ","));
			travel.setCar(ToolsUtil.Array2String(travel.getCars() == null ? new String[] {} : travel.getCars(), ","));
			travel.setUuid((Integer) dao.add(travel));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_MDY");
		try {
			// checkbox 专用转换
			travel.setApply_item(ToolsUtil.Array2String(travel.getApply_items() == null ? new String[] {} : travel.getApply_items(), ","));
			travel.setCar(ToolsUtil.Array2String(travel.getCars() == null ? new String[] {} : travel.getCars(), ","));

			travel.setLm_user(ContextHelper.getUserLoginUuid());
			travel.setLm_time(new Date());
			dao.save(travel);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_DEL");
		try {
			dao.delete(travel);
			setMessage("删除成功!ID=" + travel.getUuid());
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
	 */
	public String mdyCheck() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK");
		try {
			mdyCheckStatus(10);
			mdyACheckStatus(10);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheck 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheck 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务审核退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK5");
		try {
			mdyCheckStatus(5);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus5 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus5 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 大区审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK10");
		try {
			mdyCheckStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus10 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus10 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总监审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK20");
		try {
			mdyCheckStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus20 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus20 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 业务副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyCheckStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_CHECK30");
		try {
			mdyCheckStatus(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyCheckStatus30 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyCheckStatus30 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政审核退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus5() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK5");
		try {
			mdyACheckStatus(5);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus5 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus5 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus10() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK10");
		try {
			mdyACheckStatus(20);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus10 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus10 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 行政副总审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus20() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK20");
		try {
			mdyACheckStatus(30);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus20 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus20 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 总经理审核通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String mdyACheckStatus30() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVEL_ACHECK30");
		try {
			mdyACheckStatus(40);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!mdyACheckStatus30 数据修改失败:", e);
			throw new Exception(this.getClass().getName() + "!mdyACheckStatus30 数据修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 改变业务审核状态通用函数
	 * 
	 * @param checkStatus
	 *            0:新单 5:已退回 10:待审核 20:大区经理已审 30:运营总监已审 40:业务副总已审
	 */
	public void mdyCheckStatus(Integer checkStatus) {
		travel.setCheck_status(checkStatus);
		travel.setCheck_user(ContextHelper.getUserLoginUuid());
		travel.setCheck_time(new Date());
		travel.setLm_user(ContextHelper.getUserLoginUuid());
		travel.setLm_time(new Date());
		dao.mdyCheckStatus(travel);
	}

	/**
	 * 改变行政审核状态通用函数
	 * 
	 * @param checkStatus
	 *            0:新单 5:已退回 10:待审核 20:行政经理已审 30:行政副总已审 40:总经理已审
	 */
	public void mdyACheckStatus(Integer checkStatus) {
		travel.setAcheck_status(checkStatus);
		travel.setAcheck_user(ContextHelper.getUserLoginUuid());
		travel.setAcheck_time(new Date());
		travel.setLm_user(ContextHelper.getUserLoginUuid());
		travel.setLm_time(new Date());
		dao.mdyACheckStatus(travel);
	}
	
	private void addProcess(String p_sign, String p_note, String userLogin) {
		ProcessDAO pdao = new ProcessDAO();
		if (co != null) {/* 单据状态，销售状态，销管状态，财务，数据中心 */
			pdao.addProcess(4, co.getUuid(), p_sign, p_note, co.getState(), co.getSd_state(), co.getSmd_status(), co.getFd_check_state(),
					co.getNd_check_state(), userLogin);
		}
	}
	
	
	
	public String traveOut() throws Exception {
		ProductDAO prodao=new ProductDAO();
		HttpServletResponse response =ServletActionContext.getResponse();  
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dt = new Date();   
        String date=sdf.format(dt); 
		try {
			WritableWorkbook wwb = null;
			 //设这输出的类型和文件格式
			   response.setContentType("application/vnd.ms-excel;charset=UTF-8");
			   //设置文件名和并且解决中文名不能下载
			   String filenames = "("+travel.getUuid()+")"+date+"%e5%ae%a2%e6%88%b7%e4%bf%a1%e6%81%af.xls";//urlencode编码
			      response.addHeader("Content-Disposition","attachment;   filename=\""+ new String(filenames.getBytes(),"UTF-8")+   "\"");    
			      //创建输出流
			      OutputStream os = response.getOutputStream();
			      wwb = Workbook.createWorkbook(os);

            // 创建工作表
            WritableSheet ws = wwb.createSheet("客户信息", 0);
            ws.setColumnView(0, 15);
            ws.setColumnView(1, 15);
            ws.setColumnView(2, 25);
            ws.setColumnView(3, 20);
            ws.setColumnView(4, 20);
            ws.setColumnView(5, 15);
            ws.setColumnView(6, 30);
            
            /*List sex=new ArrayList();
           sex.add("男");
           sex.add("女");
           Label norFormat=null;
           norFormat=new Label(1,2,"请选择");
           WritableCellFeatures wsc = new WritableCellFeatures(); 
           wsc.setDataValidationList(sex); 
           norFormat.setCellFeatures(wsc); 
           ws.addCell(norFormat); */
            
            WritableFont font1 = new WritableFont(WritableFont.ARIAL,11);  
            
            WritableCellFormat cellFormat1 = new WritableCellFormat(font1);  
            //要插入到的Excel表格的行号，默认从0开始
            Label labelId= new Label(0, 0, "工业旅游编号:",cellFormat1);//表示第1列1个
            Label labelName= new Label(1, 0, travel.getUuid().toString(),cellFormat1);//第2列1个
            
            WritableFont wf_title = new WritableFont(WritableFont.ARIAL, 11,  
                    WritableFont.NO_BOLD, false, UnderlineStyle.NO_UNDERLINE,  
                    jxl.format.Colour.RED); // 定义格式 字体 下划线 斜体 粗体 颜色 
            WritableCellFormat wcf_title1 = new WritableCellFormat(wf_title); // 单元格定义  
            
            Label title1= new Label(0, 1, "姓名",getHeadFormat());//表示第
            Label title2= new Label(1, 1, "性别",getHeadFormat());
            Label title3= new Label(2, 1, "公司名称",getHeadFormat());
            Label title4= new Label(3, 1, "身份证号",getHeadFormat());
            Label title5= new Label(4, 1, "联系电话",getHeadFormat());
            Label title6= new Label(5, 1, "客户类别",getHeadFormat());
            Label title7= new Label(6, 1, "备注",getHeadFormat());
            
            Label titleOne=new Label(2,0,"客户类别(请填写数字编号):1:政府,2:企业,3:经销商,4:潜在客户,5:终端零售,6:专卖店消费者,7:其他",wcf_title1); 
            ws.addCell(titleOne);
            ws.addCell(labelId);
            ws.addCell(labelName);
            ws.addCell(title1);
            ws.addCell(title2);
            ws.addCell(title3);
            ws.addCell(title4);
            ws.addCell(title5);
            ws.addCell(title6);
            ws.addCell(title7);
            ws.mergeCells(2, 0, 6, 0);//合并单元格，第一个参数：要合并的单元格最左上角的列号，第二个参数：要合并的单元格最左上角的行号，第三个参数：要合并的单元格最右角的列号，第四个参数：要合并的单元格最右下角的行号，
           //写进文档
            wwb.write();
           // 关闭Excel工作簿对象
            wwb.close();
            os.close();
            response.flushBuffer();
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!out 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!out 数据添加失败:", e);
		}
		return null;
	}
	
	public static WritableCellFormat getHeadFormat() throws Exception {   
        //设置字体   
        WritableFont wf = new WritableFont(WritableFont.ARIAL, 11, WritableFont.BOLD);   
           
        //创建单元格FORMAT   
        WritableCellFormat wcf = new WritableCellFormat(wf);   
        wcf.setAlignment(Alignment.CENTRE);                            
        wcf.setVerticalAlignment(VerticalAlignment.CENTRE);            
        wcf.setLocked(true);   
        wcf.setBorder(Border.ALL, BorderLineStyle.THIN, Colour.BLACK);   
        wcf.setBackground(Colour.GREY_25_PERCENT);   
        return wcf;   
    }
}
