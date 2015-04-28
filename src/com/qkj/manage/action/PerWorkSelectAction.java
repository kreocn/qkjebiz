package com.qkj.manage.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.iweb.sys.ContextHelper;

import com.opensymphony.xwork2.ActionSupport;
import com.qkj.manage.check.SkipStep;
import com.qkj.manage.dao.PerWorkDao;
import com.qkj.manage.domain.PerWork;
import com.qkj.manage.domain.PerWorkSelect;

public class PerWorkSelectAction extends ActionSupport {
	private  List<PerWorkSelect> selectList = new ArrayList<>();
	private static List<PerWorkSelect> selectPowerList = new ArrayList<>();
	private Map<String, Object> map = new HashMap<String, Object>();
	public String getSelWork(){
		PerWorkDao pdao=new PerWorkDao();
		map.clear();
		map.put("perUser", ContextHelper.getUserLoginUuid());
		selectPowerList=pdao.list(map);
		String sql="";
		PerWorkSelect ws=new PerWorkSelect();
		if(selectPowerList.size()>0){
			for(int i=0;i<selectPowerList.size();i++){
				ws=selectPowerList.get(i);
				if (ContextHelper.checkPermit(ws.getRoles())) {
					if(sql!=null && !sql.equals("")){
						sql+="union all ";
					}
					sql+="select  "+ws.getTable_field()+" from "+ws.getTable_name()+" where "+ws.getTable_condition()+" ";
				}
			}
		}
		return sql;
	}

}
