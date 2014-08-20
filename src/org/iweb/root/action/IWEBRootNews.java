package org.iweb.root.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.info.dao.InfoNewsDAO;
import org.iweb.info.domain.InfoNews;
import org.iweb.sys.ContextHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-3-12 下午10:23:06
 */
public class IWEBRootNews extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(IWEBRootNews.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private InfoNewsDAO dao = new InfoNewsDAO();

	private InfoNews news;
	private List<InfoNews> newsx;
	private String refid;

	private String message;
	private String viewFlag;
	private int recCount;
	private int pageSize;

	public String getRefid() {
		return refid;
	}

	public void setRefid(String refid) {
		this.refid = refid;
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

	@Override
	public String execute() throws Exception {
		map.clear();
		map.putAll(ContextHelper.getDefaultRequestMap4Page());
		// 藏酒动态的class_id
		map.put("class_id", Parameters.CELLAR_NEWS_CLASSID);
		map.put("ischecked", 4);
		this.setPageSize(Integer.parseInt(map.get(Parameters.Page_Size_Str).toString()));
		this.setNewsx(dao.list(map));
		this.setRecCount(dao.getResultCount());
		return SUCCESS;
	}

	public String view() throws Exception {
		if (news == null || ToolsUtil.isEmpty(news.getUuid())) {
			return INPUT;
		}
		map.put("uuid", news.getUuid());
		this.setNews(dao.get(map));
		return SUCCESS;
	}

	/**
	 * 帮助中心
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-3-26 下午8:36:42
	 */
	public String help() throws Exception {
		map.clear();
		map.put("class_id", Parameters.CELLAR_HELP_CLASSID);
		map.put("ischecked", 4);
		map.put("orderby", "top");
		this.setNewsx(dao.list(map));
		if (this.getNewsx() != null && this.getNewsx().size() > 0) {
			if (ToolsUtil.isEmpty(refid)) {
				refid = this.getNewsx().get(0).getUuid();
				this.setNews(this.getNewsx().get(0));
			} else {
				for (InfoNews n : this.getNewsx()) {
					if (refid.equals(n.getUuid())) {
						this.setNews(n);
						break;
					}
				}
			}
		}
		return SUCCESS;
	}

}
