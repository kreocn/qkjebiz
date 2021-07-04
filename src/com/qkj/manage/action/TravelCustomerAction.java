package com.qkj.manage.action;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import jxl.Cell;
import jxl.CellType;
import jxl.DateCell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;
import org.iweb.sysvip.domain.MemberStock;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.dao.TravelCustomerDAO;
import com.qkj.manage.domain.TravelCustomer;

public class TravelCustomerAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(TravelCustomerAction.class);
	private TravelCustomerDAO dao = new TravelCustomerDAO();

	private TravelCustomer travelCustomer;
	private List<TravelCustomer> travelCustomers;
	private String message;
	private String viewFlag;

	public TravelCustomer getTravelCustomer() {
		return travelCustomer;
	}

	public void setTravelCustomer(TravelCustomer travelCustomer) {
		this.travelCustomer = travelCustomer;
	}

	public List<TravelCustomer> getTravelCustomers() {
		return travelCustomers;
	}

	public void setTravelCustomers(List<TravelCustomer> travelCustomers) {
		this.travelCustomers = travelCustomers;
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

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD");
		try {
			travelCustomer.setStatus(1);
			dao.add(travelCustomer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
	
	public String addCus(byte[] in2) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		HttpSession session = ContextHelper.getRequest().getSession();
		try {
			 InputStream in = new ByteArrayInputStream(in2);
		     Workbook rwb=Workbook.getWorkbook(in);
		     Sheet st=rwb.getSheet(0);
		     int rs=st.getColumns();  //列数
	         int rows=st.getRows();//行数
	         for(int i=0;i<rows;i++){
	        	 Integer uuid=null;
	 	         String name=null;
	 	         Integer sex=null;
	 	         String company=null;
	 	         String idcard=null;
	 	         String phone=null;
	 	         Integer type=null;
	 	         String note=null;
	        	   for(int j=0;j<rs;j++){
	        		   Cell co= st.getCell(j,i); 
	        		   String content=co.getContents();
	        		   if(content==null || content.equals("")){
	        			   continue;
	        		   }
	        		   if(i>1 && j==1 && content!=null){//性别
	        			   if(content.contains("男")){
	        				  sex=0;//男
	        			   }else{
	        				   sex=1;;//女
	        			   }
	        		   }
	        		   
	        		   if(i>1 && j==5){
	        			   if(isNumeric(content)){
	        				   type=Integer.parseInt(content);//类别
	        			   }else{
	        				   message="客户类型格式不正确";
	    	        		   break;
	        			   }
	        			   
	        		   }
	        		   if((i==0 && j==2)||i==1)continue;
	        		   if(i>1 && j==0)name=content;//姓名
	        		   if(i>1 && j==2)company=content;//公司名称
	        		   if(i>1 && j==3) idcard=content;//身份证
	        		   if(i>1 && j==4) phone=content;//电话
	        		   if(i>1 && j==6) note=content;//电话
	        	   }
	        	   if(i<=1){
	        		   continue;
	        	   }
	        	   
	        	   if(i>1){
	        		   Cell zo= st.getCell(1,0); 
	        		   String zouid=zo.getContents();
	        		   uuid=Integer.parseInt(zouid);//编号
	        		   travelCustomer=new TravelCustomer();
	        		   travelCustomer.setTravel_id(uuid);
	        		   travelCustomer.setCus_name(name);
	        		   travelCustomer.setCus_sex(sex);
	        		   travelCustomer.setCus_company(company);
	        		   if(type==null){
	        			   travelCustomer.setCus_type(1);
	        		   }else{
	        			   travelCustomer.setCus_type(type);
	        		   }
	        		   travelCustomer.setCus_phone(phone);
	        		   travelCustomer.setCus_idcard(idcard);
	        		   travelCustomer.setNote(note);
	        		   travelCustomer.setStatus(1);
	       			   dao.add(travelCustomer);
	        	   	}
	        	   
	        	   if((uuid==null || uuid.equals("") || name==null || name.equals("")) && message==null&&i>1 ){
	        		   message="模板中工旅游编号及客户信息不能为空";
	        		   break;
	        	   }
	        	   Cell co= st.getCell(0,0); 
	        	   String content=co.getContents();
	        	   if(!content.equals("工业旅游编号:")){
	        			message="模板格式不正确请重新下载";
	        			break;
	        		}
	           }
	           try {
					in.close();
					in = null;
				} catch (Exception e) {
					// TODO: handle exception
					log.warn("inupload close error", e);
				}
			
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
	
	public static boolean isNumeric(String str){
		  for (int i = 0; i < str.length(); i++){
		   if (!Character.isDigit(str.charAt(i))){
		    return false;
		   }
		  }
		  return true;
		 }
	
	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELCUSTOMER_MDY");
		try {
			dao.save(travelCustomer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELCUSTOMER_DEL");
		try {
			dao.delete(travelCustomer);
			setMessage("删除成功!ID=" + travelCustomer.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}
	
	public String addClose() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD");
		try {
			travelCustomer.setStatus(2);
			dao.add(travelCustomer);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}
}
