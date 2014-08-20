package org.iweb.info.dao;

import java.util.List;
import java.util.Map;

import org.iweb.info.domain.InfoNews;
import org.iweb.sys.AbstractDAO;

public class InfoNewsDAO extends AbstractDAO {
	public List list(Map<String, Object> map) {
		return super.list("info_getNews", map);
	}

	public InfoNews get(Map<String, Object> map) {
		return (InfoNews) super.get("info_getNews", map);
	}

	public void add(Object parameters) {
		super.add("info_addNews", parameters);
	}

	public void save(Object parameters) {
		super.save("info_mdyNews", parameters);
	}

	public void delete(Object parameters) {
		super.delete("info_delNews", parameters);
	}

	/**
	 * 修改新闻置顶状态
	 * 
	 * @param parameters
	 */
	public void saveTop(Object parameters) {
		super.save("info_mdyNewsTop", parameters);
	}

	public void saveAddLevel(Object parameters) {
		super.save("info_mdyNewsAddLevel", parameters);
	}

	public void saveDownLevel(Object parameters) {
		super.save("info_mdyNewsDownLevel", parameters);
	}

	/**
	 * 初审操作
	 * 
	 * @param parameters
	 */
	public void saveFirstCheck(Object parameters) {
		super.save("info_mdyNewsFirstCheck", parameters);
	}

	/**
	 * 初审操作
	 * 
	 * @param parameters
	 */
	public void saveFinalCheck(Object parameters) {
		super.save("info_mdyNewsFinalCheck", parameters);
	}

	/**
	 * 修改新闻删除标记
	 * 
	 * @param parameters
	 */
	public void saveDel(Object parameters) {
		super.save("info_mdyNewsDel", parameters);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
