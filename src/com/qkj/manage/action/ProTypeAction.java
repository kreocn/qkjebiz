package com.qkj.manage.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.*;
import org.apache.http.HttpRequest;
import org.iweb.sys.*;

import sun.misc.Request;

import com.aliyun.openservices.oss.model.ObjectMetadata;
import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.domain.ProType;
import com.qkj.manage.domain.Product;
import com.qkj.manage.dao.ProTypeDAO;
import com.qkj.manage.dao.ProductDAO;

public class ProTypeAction extends ActionSupport implements ActionAttr {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(ProTypeAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private ProTypeDAO dao = new ProTypeDAO();

	private ProType proType;
	private List<ProType> proTypes;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private int currPage;
	private static List<Product> products;
	private static Product product;
	private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;产品类型";
	String wpath = System.getProperty("user.dir");

	public String getPath() {
		return path;
	}

	public ProType getProType() {
		return proType;
	}

	public void setProType(ProType proType) {
		this.proType = proType;
	}

	public List<ProType> getProTypes() {
		return proTypes;
	}

	public void setProTypes(List<ProType> proTypes) {
		this.proTypes = proTypes;
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

	public String lista() throws Exception {
		ProTypeDAO ptdao = new ProTypeDAO();
		proTypes = ptdao.list(null);
		ProductDAO pdao = new ProductDAO();
		products = pdao.list(null);
		ArrayList<StringBuffer> sbl = new ArrayList<>();

		String p = IWebConfig.getConfigMap().get("WebAbsolutePath");
		OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(p + "/js/zTreeJs/Result.js"), "UTF-8");
		String info = null;
		info = "var zNodes =[";
		out.write(info);
		for (int i = 0; i < proTypes.size(); i++) {
			proType = proTypes.get(i);
			info = "{id:" + proType.getUuid() + "" + "," + " pId:0, name:" + "'" + proType.getName() + "'" + ", open:false}," + '\n';
			out.write(info);
			for (int j = 0; j < products.size(); j++) {
				product = products.get(j);
				String uuid = proType.getUuid() + "";
				if (uuid.equals(product.getBrand())) {
					info = "{id:" + uuid + product.getUuid() + "," + " pId:" + uuid + ", name:" + "'" + product.getTitle() + "',puuid:" + product.getUuid() + ",mp:'"
							+ ToolsUtil.getEmpty(product.getMarket_price()) + "',gp:'" + ToolsUtil.getEmpty(product.getGroup_price()) + "',dp:'"
							+ ToolsUtil.getEmpty(product.getDealer_price()) + "',a1:'" + ToolsUtil.getEmpty(product.getAgree_price_1()) + "',a2:'"
							+ ToolsUtil.getEmpty(product.getAgree_price_2()) + "',a3:'" + ToolsUtil.getEmpty(product.getAgree_price_3()) + "',case_spec:"
							+ ToolsUtil.getEmpty(product.getCase_spec()) + "}," + '\n';
					out.write(info);
				}
			}
		}
		info = " ];";
		out.write(info);
		out.flush();
		out.close();

		ObjectMetadata meta = new ObjectMetadata();
		File f = new File(p + "/js/zTreeJs/Result.js");
		// InputStream in = new FileInputStream(f);
		meta.setContentLength(f.length());
		// OSSUtil_IMG.uploadFile("qkjbj01", "qkjebiz01/zTree_result.js", f, meta);

		return "success";
	}

	public String listr() throws Exception {
		BufferedReader bufferredReader = null;
		try {
			System.out.println("以字符为单位读取文件内容，一次读一个字节：");
			// 一次读一个字符
			bufferredReader = new BufferedReader(new FileReader("D:\\Result.txt"));
			String tempchar;
			while ((tempchar = bufferredReader.readLine()) != null) {
				// 对于windows下，\r\n这两个字符在一起时，表示一个换行。
				// 但如果这两个字符分开显示时，会换两次行。
				// 因此，屏蔽掉\r，或者屏蔽\n。否则，将会多出很多空行。
				System.out.print(tempchar);
			}
			bufferredReader.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "success";
	}

	public String list() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_LIST");
		try {
			map.clear();
			if (proType != null) map.putAll(ToolsUtil.getMapByBean(proType));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(ContextHelper.getPageSize(map));
			this.setCurrPage(ContextHelper.getCurrPage(map));
			this.setProTypes(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;产品类型列表";
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
				this.setProType(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				this.setProType(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/proType_relist'>产品类型列表</a>&nbsp;&gt;&nbsp;增加产品类型";
			} else if ("mdy".equals(viewFlag)) {
				if (!(proType == null || proType.getUuid() == null)) {
					this.setProType((ProType) dao.get(proType.getUuid()));
				} else {
					this.setProType(null);
				}
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/qkjmanage/proType_relist'>产品类型列表</a>&nbsp;&gt;&nbsp;增加产品类型";
			} else {
				this.setProType(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:", e);
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:", e);
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_ADD");
		try {
			proType.setLm_user(ContextHelper.getUserLoginUuid());
			proType.setLm_time(new Date());
			dao.add(proType);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 数据添加失败:", e);
			throw new Exception(this.getClass().getName() + "!add 数据添加失败:", e);
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_MDY");
		try {
			proType.setLm_user(ContextHelper.getUserLoginUuid());
			proType.setLm_time(new Date());
			dao.save(proType);
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:", e);
			throw new Exception(this.getClass().getName() + "!save 数据更新失败:", e);
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("QKJ_QKJMANAGE_PROTYPE_DEL");
		try {
			dao.delete(proType);
			setMessage("删除成功!ID=" + proType.getUuid());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:", e);
			throw new Exception(this.getClass().getName() + "!del 数据删除失败:", e);
		}
		return SUCCESS;
	}

	public static void main(String[] args) throws Exception {
		System.out.println(Thread.currentThread().getContextClassLoader().getResource(""));
		System.out.println(ProTypeAction.class.getClassLoader().getResource(""));

		System.out.println(ClassLoader.getSystemResource(""));
		System.out.println(ProTypeAction.class.getResource(""));
		System.out.println(ProTypeAction.class.getResource("/"));
		// Class文件所在路径
		System.out.println(new File("/").getAbsolutePath());
		System.out.println(System.getProperty("user.dir"));
		File file = new File(System.getProperty("user.dir"));
		File directory = new File("");// 参数为空
		String courseFile = directory.getCanonicalPath();
		System.out.println(courseFile);
	}
}
