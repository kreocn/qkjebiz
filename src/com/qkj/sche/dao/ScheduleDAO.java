package com.qkj.sche.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.AbstractDAO;
import org.iweb.sys.DBHelper;
import org.iweb.sys.Parameters;
import org.iweb.sys.ToolsUtil;

public class ScheduleDAO extends AbstractDAO {

	public Object add(Object parameters) {
		return super.add("sche_addSche_ss", parameters);
	}

	public int save(Object parameters) {
		return super.save("sche_saveSche_ss", parameters);
	}
	
	public int saveflag(Object parameters){
		return super.save("sche_saveschedu", parameters);
	}

	public int delete(Object parameters) {
		return super.delete("sche_delSche_ss", parameters);
	}

	public List list(Map<String, Object> map) {
		return super.list("sche_getSche_ss", map);
	}
	
	public List listpage(Map<String, Object> map) {
		return super.list("sche_getSche_page", map);
	}
	
	public List listy(Map<String, Object> map) {
		return super.list("sche_getScheY", map);
	}
	
	public List listbyr(Map<String, Object> map) {
		return super.list("sche_getSche_byr", map);
	}
	
	public List listbypage(Map<String, Object> map) {
		return super.list("sche_getSche_bypage", map);
	}
	
	public List listusercode(Map<String, Object> map) {
		return super.list("sche_getusercode", map);
	}
	//中间表
	public Object adds(Object parameters) {
		return super.add("sche_addscheduser", parameters);
	}

	public int saves(Object parameters) {
		return super.save("sche_savescheduser", parameters);
	}

	public int deletes(Object parameters) {
		return super.delete("sche_delscheduser", parameters);
	}
	
	public List lists(Map<String, Object> map) {
		return super.list("sche_getscheduser", map);
	}
	//删除发布信息
	public int deletesbyp(Object parameters) {
		return super.delete("sche_delscheduserbyp", parameters);
	}
	//删除接布信息
	public int deletesbyr(Object parameters) {
		return super.delete("sche_delscheduserbyr", parameters);
	}
	public int getResultCount() {
		return super.getResultCount();
	}
}
