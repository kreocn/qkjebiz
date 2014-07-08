package org.iweb.root.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.opensymphony.xwork2.ActionSupport;
import com.qkjsys.ebiz.dao.GoodsDAO;
import com.qkjsys.ebiz.domain.Goods;

/**
 * @version 1.0
 * @author Kreo(QQ:303034112)
 * @description
 * @date 2014-3-12 下午10:23:06
 */
public class IWEBRootCellar extends ActionSupport {
	private static final long serialVersionUID = 1L;
	private static Log log = LogFactory.getLog(IWEBRootCellar.class);
	private Map<String, Object> map = new HashMap<String, Object>();
	private GoodsDAO dao = new GoodsDAO();

	private List<Goods> goodss;

	public List<Goods> getGoodss() {
		return goodss;
	}

	public void setGoodss(List<Goods> goodss) {
		this.goodss = goodss;
	}

	/**
	 * 藏酒介绍
	 * 
	 * @return
	 * @throws Exception
	 * @date 2014-3-16 下午1:36:01
	 */
	public String execute() throws Exception {
		map.clear();
		map.put("goods_sales", 0);
		map.put("goods_type", 1);
		this.setGoodss(dao.list(map));
		return SUCCESS;
	}
}
