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

import com.opensymphony.xwork2.ActionSupport;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-3-12 下午10:23:06
 */
public class IWEBRoot extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(IWEBRoot.class);
	private Map<String, Object> map = new HashMap<String, Object>();

	private InfoNewsDAO dao = new InfoNewsDAO();

	private List<InfoNews> newsx;

	public List<InfoNews> getNewsx() {
		return newsx;
	}

	public void setNewsx(List<InfoNews> newsx) {
		this.newsx = newsx;
	}

	/**
	 * 首页Action
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-3-12 下午10:23:59
	 */
	public String index() throws Exception {
		map.clear();
		map.put("class_id", Parameters.CELLAR_NEWS_CLASSID);
		map.put("ischecked", 4);
		map.put("orderby", "top");
		map.put("limit", 7);
		this.setNewsx(dao.list(map));
		return SUCCESS;
	}

	/**
	 * 藏酒介绍
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-3-16 下午1:36:01
	 */
	public String cellar() throws Exception {
		return SUCCESS;
	}
}
