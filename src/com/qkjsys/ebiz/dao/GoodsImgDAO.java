package com.qkjsys.ebiz.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.iweb.sys.AbstractDAO;
import org.iweb.sys.ContextHelper;

import com.qkjsys.ebiz.domain.GoodsImg;

public class GoodsImgDAO extends AbstractDAO {

	public void addBatch(List<GoodsImg> imgs, int goods_id) {
		if (imgs != null && imgs.size() > 0) {
			for (GoodsImg gi : imgs) {
				if (gi != null) {
					gi.setGoods_id(goods_id);
					gi.setAdd_user(ContextHelper.getUserLoginUuid());
					gi.setAdd_time(new Date());
					add(gi);
				}
			}
		}
	}

	public void add(Object parameters) {
		super.add("ebiz_addGoodImg", parameters);
	}

	public List list(Map<String, Object> map) {
		setCountMapid("ebiz_getGoodImgsCounts");
		return super.list("ebiz_getGoodImgs", map);
	}

	public int getResultCount() {
		return super.getResultCount();
	}
}
