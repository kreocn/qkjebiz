package org.iweb.info.action;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.info.dao.InfoClassDAO;
import org.iweb.info.dao.InfoNewsDAO;
import org.iweb.info.domain.InfoClass;
import org.iweb.info.domain.InfoNews;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

public class InfoNewsAction extends ActionSupport {

	private static final long serialVersionUID = 1307611324046395835L;
	private static Log log = LogFactory.getLog(InfoNewsAction.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private InfoNewsDAO dao = new InfoNewsDAO();
	private InfoClassDAO dao2 = new InfoClassDAO();

	private HttpServletRequest request;
	private InfoNews news;
	private List<InfoNews> newsx;
	private List<InfoClass> iclasses;
	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;
	private String acname;
    private String path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;信息列表";
	
	public String getPath() {
		return path;
	}

	public String getAcname() {
		return acname;
	}

	public void setAcname(String acname) {
		this.acname = acname;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

	public InfoNews getNews() {
		return news;
	}

	public void setNews(InfoNews news) {
		this.news = news;
	}

	public List<InfoNews> getNewsx() {
		return newsx;
	}

	public void setNewsx(List<InfoNews> newsx) {
		this.newsx = newsx;
	}

	public List<InfoClass> getIclasses() {
		return iclasses;
	}

	public void setIclasses(List<InfoClass> iclasses) {
		this.iclasses = iclasses;
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

	/**
	 * 普通操作列表,按照信息的分类进行区分,没有部门限制
	 * 
	 * @return
	 * @throws Exception
	 */
	public String list() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_LIST");
		try {

			// 先确定可以查看的新闻种类
			String pf = ContextHelper.getPermitFunction("INFO_MANAGER_NEWSMANAGER");
			this.setIclasses(dao2.InfoClassFilter(dao2.list(null), pf));

			String[] classes = null;

			if (this.getIclasses().size() > 0 && !"admin".equals(pf)) {
				int ti = 0;
				classes = new String[this.getIclasses().size()];
				for (Iterator<InfoClass> cs = this.getIclasses().iterator(); cs.hasNext();) {
					InfoClass ic = (InfoClass) cs.next();
					classes[ti++] = ic.getUuid();
				}
				// System.out.println("###classes:" + classes.length);
			}

			// classes = new String[0];

			map.clear();
			if (news == null)
				news = new InfoNews();
			map.putAll(ToolsUtil.getMapByBean(news));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			map.put("isdel", 0);
			map.put("classes", classes);
			this.setNewsx(dao.list(map));
			this.setRecCount(dao.getResultCount());
			path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;信息列表";
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String listRecycle() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_RECYCLE");
		try {
			// 先确定可以查看的新闻种类
			String pf = ContextHelper.getPermitFunction("INFO_MANAGER_NEWSMANAGER");
			this.setIclasses(dao2.InfoClassFilter(dao2.list(null), pf));

			String[] classes = null;

			if (this.getIclasses().size() > 0 && !"admin".equals(pf)) {
				int ti = 0;
				classes = new String[this.getIclasses().size()];
				for (Iterator<InfoClass> cs = this.getIclasses().iterator(); cs.hasNext();) {
					InfoClass ic = (InfoClass) cs.next();
					classes[ti++] = ic.getUuid();
				}
				// System.out.println("###classes:" + classes.length);
			}

			// classes = new String[0];

			map.clear();
			if (news == null)
				news = new InfoNews();
			map.putAll(ToolsUtil.getMapByBean(news));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			map.put("isdel", 1);
			map.put("classes", classes);
			this.setNewsx(dao.list(map));
			this.setRecCount(dao.getResultCount());
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String load() throws Exception {
		try {
			if (null == viewFlag) {
				setNews(null);
				setMessage("你没有选择任何操作!");
			} else if ("add".equals(viewFlag)) {
				setNews(null);
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/info/news_list'>信息列表</a>&nbsp;&gt;&nbsp;添加信息";
			} else if ("mdy".equals(viewFlag) || "view".equals(viewFlag)) {
				map.clear();
				map.put("uuid", news.getUuid());
				if (null == map.get("uuid"))
					this.setNews(null);
				else
					this.setNews((InfoNews) dao.list(map).get(0));
				path = "<a href='/manager/default'>首页</a>&nbsp;&gt;&nbsp;<a href='/info/news_list'>信息列表</a>&nbsp;&gt;&nbsp;修改信息";
			} else {
				setNews(null);
				setMessage("无操作类型!");
			}
			this.setIclasses(dao2.InfoClassFilter(dao2.list(null),
					ContextHelper.getPermitFunction("INFO_MANAGER_NEWSMANAGER")));
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!load 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String add() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_ADD");
		try {
			if (news != null) {
				news.setUuid(ToolsUtil.getUUID());
				news.setAdd_ip(ContextHelper.getRealIP());
				news.setAdd_user(ContextHelper.getUserLoginUuid());
				news.setAdd_time(new Date());
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.add(news);
				setMessage("添加成功!");
			} else {
				setMessage("参数为空!");
				log.warn("UserPrivilegeAction!add 写入失败:参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String addsave() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_ADDSAVE");
		try {
			if (news != null) {
				news.setUuid(ToolsUtil.getUUID());
				news.setIschecked(-1);
				news.setAdd_ip(ContextHelper.getRealIP());
				news.setAdd_user(ContextHelper.getUserLoginUuid());
				news.setAdd_time(new Date());
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.add(news);

				dao.saveFirstCheck(news);

				setMessage("添加成功!");
			} else {
				setMessage("参数为空!");
				log.warn("UserPrivilegeAction!add 写入失败:参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!add 写入失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!add 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String savetmp() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_TMPMDY");
		try {
			if (news != null) {
				news.setIschecked(-1);
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.save(news);

				dao.saveFirstCheck(news);
				setMessage("保存成功!ID=" + news.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String save() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_MDY");
		try {
			if (news != null) {
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.save(news);

				news.setIschecked(0);
				dao.saveFirstCheck(news);
				setMessage("保存成功!ID=" + news.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String saveTop() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_SMDYTOP");
		try {
			if (news != null) {
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveTop(news);
				setMessage("修改置顶状态成功!ID=" + news.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String saveAddLevel() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_SMDYTOP");
		try {
			if (news != null) {
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveAddLevel(news);
				setMessage("提高置顶等级成功!ID=" + news.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String saveDownLevel() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_SMDYTOP");
		try {
			if (news != null) {
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveDownLevel(news);
				setMessage("降低置顶等级成功!ID=" + news.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	/**
	 * 初审,没有分类概念,而是添加人的部门,只要是同一个部门或者子部门下的,都可以进行初审
	 * 
	 * @return
	 * @throws Exception
	 */
	public String listFirstCheck() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_FIRSTCHECKLIST");
		try {
			map.clear();
			if (news == null)
				news = new InfoNews();
			map.putAll(ToolsUtil.getMapByBean(news));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			map.put("isdel", 0);

			if (!map.containsKey("ischecked")) {
				if (ContextHelper.isFromLeftMenu()) {
					news.setIschecked(0);
					map.put("ischecked", 0);
					news.setIschecked(0);
				} else {
					map.put("ischeckeds", new int[] { 0, 1, 2, 3, 4 });
				}
			}

			// map.put("add_dept", ContextHelper.getUserLoginInfo().getDept_code() + "%");
			this.setNewsx(dao.list(map));
			this.setRecCount(dao.getResultCount());

			this.setIclasses(dao2.list(null));
			this.setAcname("news_firstCheckedList");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	/**
	 * 审核界面读取
	 * 
	 * @return
	 * @throws Exception
	 */
	public String loadCheck() throws Exception {
		try {
			if (null == viewFlag) {
				setNews(null);
				setMessage("你没有选择任何操作!");
			} else if ("first".equals(viewFlag) || "final".equals(viewFlag) || "view".equals(viewFlag)) {
				map.clear();
				map.put("uuid", news.getUuid());
				if (null == map.get("uuid"))
					this.setNews(null);
				else
					this.setNews((InfoNews) dao.list(map).get(0));
			} else {
				setNews(null);
				setMessage("无操作类型!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!loadCheck 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!loadCheck 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	/**
	 * 初审通过
	 * 
	 * @return
	 * @throws Exception
	 */
	public String saveFirstPass() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_FIRSTPASS");
		try {
			if (news != null) {
				news.setIschecked(2);
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveFirstCheck(news);
				setMessage("新闻初审成功!ID=" + news.getUuid());
				log.info("新闻初审成功!\n[NEWSINFO][ID=" + news.getUuid() + "][IP:" + news.getLm_ip() + "][USER:"
						+ news.getLm_user() + "]");
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	/**
	 * 初审退回
	 * 
	 * @return
	 * @throws Exception
	 */
	public String saveFirstFail() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_FIRSTFAIL");
		try {
			if (news != null) {
				news.setIschecked(1);
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveFirstCheck(news);
				setMessage("新闻初审成功!ID=" + news.getUuid());
				log.info("新闻初审成功!\n[NEWSINFO][ID=" + news.getUuid() + "][IP:" + news.getLm_ip() + "][USER:"
						+ news.getLm_user() + "]");
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	/**
	 * 终审列表,列出所有新闻
	 * 
	 * @return
	 * @throws Exception
	 */
	public String listFinalCheck() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_FINALCHECKLIST");
		try {
			map.clear();
			if (news == null)
				news = new InfoNews();
			map.putAll(ToolsUtil.getMapByBean(news));
			map.putAll(ContextHelper.getDefaultRequestMap4Page());
			this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
			map.put("isdel", 0);

			if (!map.containsKey("ischecked")) {
				if (ContextHelper.isFromLeftMenu()) {
					news.setIschecked(0);
					map.put("ischecked", 2);
					news.setIschecked(2);
				} else {
					map.put("ischeckeds", new int[] { 2, 3, 4 });
				}
			}

			this.setNewsx(dao.list(map));
			this.setRecCount(dao.getResultCount());
			this.setIclasses(dao2.list(null));
			this.setAcname("news_finalCheckedList");
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!list 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String saveFinalPass() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_FINALPASS");
		try {
			if (news != null) {
				news.setIschecked(4);
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveFinalCheck(news);
				setMessage("新闻终审成功!ID=" + news.getUuid());
				log.info("新闻终审成功!\n[NEWSINFO][ID=" + news.getUuid() + "][IP:" + news.getLm_ip() + "][USER:"
						+ news.getLm_user() + "]");
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String saveFinalFail() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_FINALFAIL");
		try {
			if (news != null) {
				news.setIschecked(3);
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveFinalCheck(news);
				setMessage("新闻终审成功!ID=" + news.getUuid());
				log.info("新闻终审成功!\n[NEWSINFO][ID=" + news.getUuid() + "][IP:" + news.getLm_ip() + "][USER:"
						+ news.getLm_user() + "]");
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String saveDel() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_MDYDEL");
		try {
			if (news != null) {
				news.setLm_ip(ContextHelper.getRealIP());
				news.setLm_user(ContextHelper.getUserLoginUuid());
				news.setLm_time(new Date());
				dao.saveDel(news);
				setMessage("修改删除标记成功!ID=" + news.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!save 数据更新失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!save 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}

	public String del() throws Exception {
		ContextHelper.isPermit("INFO_MANAGER_NEWS_DEL");
		try {
			if (news != null) {
				dao.delete(news);
				setMessage("删除成功!ID=" + news.getUuid());
			} else {
				setMessage("参数为空!");
			}
		} catch (Exception e) {
			log.error(this.getClass().getName() + "!del 数据删除失败:" + ToolsUtil.getStackTrace(e));
			throw new Exception(this.getClass().getName() + "!del 读取数据错误:" + ToolsUtil.getStackTraceHTML(e));
		}
		return SUCCESS;
	}
}
