package com.qkj.info.dao;

import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;

public class NewsRemoteAjaxDAO extends AbstractDAO {
	public List listNews(Map<String, Object> map) {
		// 判断传入参数class_id是否用,隔开而成为多个class_id
		if (map.containsKey("class_id")) {
			String class_id = (String) map.get("class_id");
			String[] class_ids = class_id.split(",");
			if (class_ids.length > 1) {
				map.put("class_ids", class_ids);
				map.remove("class_id");
			} else if (class_ids.length == 1) {
				map.put("class_id", class_ids[0]);// 为了防止"123213123,,,,"这种情况发生
			}
		}

		setCountMapid("info_NewsRemoteCount");
		return super.list("info_NewsRemote", map);
	}

	public List listClasss(Map<String, Object> map) {
		return super.list("info_getClasss", map);
	}
}
