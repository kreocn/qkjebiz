package com.qkj.manage.action;

import java.util.*;

import org.apache.commons.logging.*;
import org.iweb.sys.*;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.SalPromot;
import com.qkj.manage.dao.SalPromotDAO;

public class SalPromotAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(SalPromotAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private SalPromotDAO dao = new SalPromotDAO();

	private SalPromot salPromot;
	private List<SalPromot> salPromots;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private String checkstatus;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;促销活动";
	private int salstate;

	public int getSalstate() {
		return salstate;
	}

	public void setSalstate(int salstate) {
		this.salstate = salstate;
	}

	public String getPath() {
		return path;
	}

	public SalPromot getSalPromot() {
		return salPromot;
	}

	public void setSalPromot(SalPromot salPromot) {
		this.salPromot = salPromot;
	}

	public List<SalPromot> getSalPromots() {
		return salPromots;
	}

	public void setSalPromots(List<SalPromot> salPromots) {
		this.salPromots = salPromots;
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

	public String getCheckstatus() {
		return checkstatus;
	}

	public void setCheckstatus(String checkstatus) {
		this.checkstatus = checkstatus;
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT");
		String code=ContextHelper.getUserLoginDept();
		try {
			map.clear();
			if (salPromot != null) map.putAll(ToolsUtil.getMapByBean(salPromot));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			if (ContextHelper.isAdmin()) {// 管理员
				
			}else{
				map.put("add_user_dept", code);
			}
			this.setSalPromots(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;促销活动列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String relist() throws Exception {
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				this.setSalPromot(null);
				setMessage("你没有选择任何操作!");
				return "SUCCESS";
			} else if ("add".equals(viewFlag)) {
				this.setSalPromot(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;增加促销活动";
				return "SUCCESS";
			} else if ("mdy".equals(viewFlag)) {
				if (!(salPromot == null || salPromot.getUuid() == null)) {
					this.setSalPromot((SalPromot) dao.get(salPromot.getUuid()));
				} else {
					this.setSalPromot(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;增加促销活动";
				return "SUCCESS";
			} else if ("view".equals(viewFlag)) {
				if (!(salPromot == null || salPromot.getUuid() == null)) {
					this.setSalPromot((SalPromot) dao.get(salPromot.getUuid()));
				} else {
					this.setSalPromot(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/salpro/salPromot_relist'>促销活动列表</a>&nbsp;&gt;&nbsp;促销活动详情";
				return "VIEWSUCCESS";
			} else {
				this.setSalPromot(null);
				setMessage("无操作类型!");
				return "SUCCESS";
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}

	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_ADD");
		try {
			String adddept=salPromot.getAdd_user_dept();
			adddept=adddept.replaceAll(" ", "");
			adddept=adddept.replaceAll(",", "");
			salPromot.setAdd_user_dept(adddept);
			salPromot.setAdd_user(ContextHelper.getUserLoginUuid());
			salPromot.setAdd_time(new Date());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			if (salPromot.getPriority() == null) {
				salPromot.setPriority(0);
			}
			if (salPromot.getRebate() == null) {
				salPromot.setRebate(0);
			}
			dao.add(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_MDY");
		try {
			String adddept=salPromot.getAdd_user_dept();
			adddept=adddept.replaceAll(" ", "");
			adddept=adddept.substring(adddept.indexOf(",")+1,adddept.length());
			salPromot.setAdd_user_dept(adddept);
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.save(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_DEL");
		try {
			dao.delete(salPromot);
			setMessage("删除成功!ID=" + salPromot.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 审核总状态通用
	 */

	public int check(int smd, int state) {
		salPromot.setStatus(state);
		salPromot.setSmd_status(smd);
		salPromot.setLm_user(ContextHelper.getUserLoginUuid());
		salPromot.setLm_time(new Date());
		return dao.saveStatus1(salPromot);
	}

	/**
	 * 审核通用
	 */

	public int checksmd(int smd, int status) {
		salPromot.setStatus(status);
		salPromot.setSmd_status(smd);
		salPromot.setSmd_time(new Date());
		salPromot.setSmd_user(ContextHelper.getUserLoginUuid());
		salPromot.setLm_user(ContextHelper.getUserLoginUuid());
		salPromot.setLm_time(new Date());
		return dao.saveSmdsta(salPromot);
	}

	/**
	 * 报审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String status1() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SDSTATUS1");
		try {
			check(0, 1);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}

	// 销管经理
	public String smdstatus20() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SMDSTATUS20");
		try {
			checksmd(20, 1);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String smdstatus5() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SMDSTATUS5");
		try {
			checksmd(5, 0);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * // 总监办事处以下总监审通过222
	 * @return
	 * @throws Exception
	 */
	public String smdstatus30() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SMDSTATUS30");
		try {
			if(checkDept(salPromot.getAdd_user_dept())){//返回true则总监审参通过
				checksmd(30, 2);
			}else{
				checksmd(30, 1);
			};
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 业务副总
	 * 
	 * @return
	 * @throws Exception
	 */
	public String smdstatus40() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SMDSTATUS40");
		try {
			if(salPromot!=null && salPromot.getStatus()==2){
				checksmd(40, 2);
			}else{
				checksmd(40, 1);
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 销管副总//肯定通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String smdstatus50() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SMDSTATUS50");
		try {
				checksmd(50, 2);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}
	
	/**
	 * 总经理
	 * 
	 * @return
	 * @throws Exception
	 */
	public String smdstatus60() throws Exception {
		ContextHelper.isPermit("QKJ_SALPRO_SALPROMOT_SMDSTATUS60");
		try {
			checksmd(60, 2);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}

	/**
	 * 查询添加人是办事处以下还是大区以上
	 * @return
	 * @throws Exception
	 */
	public boolean checkDept(String dept) throws Exception{
		if(dept.length()>=5){
			return true;
		}else{
			return false;
		}
	}
	
	public String sdstatus5() throws Exception {
		try {
			salPromot.setStatus(0);
			salPromot.setSd_status(5);
			salPromot.setSd_time(new Date());
			salPromot.setSd_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_user(ContextHelper.getUserLoginUuid());
			salPromot.setLm_time(new Date());
			dao.saveSdsta(salPromot);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!status1 修改成功:", e);
			throw new Exception(this.getClass().getName() + "!status1 修改失败:", e);
		}
		return SUCCESS;
	}

}
