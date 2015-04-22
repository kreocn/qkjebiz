<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人工作权限--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main" >
		<div class="dq_step">
			${path}
		</div>
		<s:form id="editForm" name="editForm" cssClass="validForm" action="perWorkPower_add" namespace="/person" method="post" theme="simple">
			<s:if test="null != perWorkSelect && 'mdy' == viewFlag">
				<div class="label_main">
			       <div class="label_hang">
				         <div class="label_ltit">编号:</div>
				         <div class="label_rwben2">
				         <div class="label_rwb">${ perWorkSelect.uuid}<s:hidden name="perWorkSelect.uuid" value="%{perWorkSelect.uuid}"></s:hidden></div>
				         </div>
			       	</div>
		 		</div>
			</s:if>
			<div class="label_main">
		       <div class="label_hang">
			         <div class="label_ltit">管理员:</div>
			         <div class="label_rwben2">
			         <div class="label_rwb"><s:textfield name="perWorkSelect.perUser" title="权限" cssClass="label_hang_linput validate[required,maxSize[100]]" /></div>
			         </div>
		       	</div>
	 		</div>
			<div class="label_main">
			       	<div class="label_hang">
			            <div class="label_ltit">菜单:</div>
			            <div class="label_rwben label_rwb"><s:select onchange="checkStatus();" id="status"  cssClass="selectKick" headerKey="" headerValue="-请选择-" list="#{0:'活动',1:'至事由',2:'工时',3:'工业旅游',4:'提货结案单',5:'促销活动'}" /></div>
			        </div>
			        <div class="label_hang">
			            <div class="label_ltit">职务:</div>
			            <div class="label_rwben label_rwb"><s:select onchange="checkJob();" id="job"  cssClass="selectKick" headerKey="" headerValue="-请选择-" list="#{0:'总监',1:'副总',2:'总经理'}" /></div>
			        </div>
		 	</div>
			<div class="label_main">
		       <div class="label_hang">
			         <div class="label_ltit">权限:</div>
			         <div class="label_rwben2">
			         <div class="label_rwb"><s:textfield name="perWorkSelect.roles" title="权限" cssClass="label_hang_linput validate[required,maxSize[100]]" /></div>
			         </div>
		       	</div>
	 		</div>
	 		<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">涉及表:</div>
		            <div class="label_rwbenx">
		            	<s:textarea id="table_name" name="perWorkSelect.table_name"  rows="3" title="涉及表" cssClass="label_hang_linput validate[required,maxSize[255]]" />
		            </div>
		        </div>
		      </div>
		      <div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">查询字段:</div>
		            <div class="label_rwbenx">
		            	<s:textarea id="table_field" name="perWorkSelect.table_field"  rows="3" title="查询字段" cssClass="label_hang_linput validate[required,maxSize[555]]" />
		            </div>
		        </div>
		      </div>
		      <div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">查询条件:</div>
		            <div class="label_rwbenx">
		            	<s:textarea id="condition" name="perWorkSelect.table_condition"  rows="3" title="查询字段" cssClass="label_hang_linput validate[required,maxSize[255]]" />
		            </div>
		        </div>
		      </div>
		      <div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">备注:</div>
		            <div class="label_rwbenx">
		            	<s:textarea name="perWorkSelect.remark"  rows="3" title="备注" cssClass="label_hang_linput validate[maxSize[128]]" />
		            </div>
		        </div>
		      </div>
		      <div class="label_main">
				<div class="label_hang">
		            <div class="label_ltit">相关操作:</div>
		            <div class="label_rwbenx">
		            <span id="message"><s:property value="message" /></span>
		            	<s:if test="'add' == viewFlag">
		            	<c:if test="${ it:checkPermit('QKJ_PERSONAL_POWER_ADD',null)==true}">
						<s:submit id="add" name="add" value="确定" action="perWorkPower_add" cssClass="input-blue"/>
						</c:if>
						</s:if>
						<s:elseif test="null != perWorkSelect && 'mdy' == viewFlag">
						<c:if test="${ it:checkPermit('QKJ_PERSONAL_POWER_MDY',null)==true}">
						<s:submit id="save" name="save" value="保存" action="perWorkPower_save" cssClass="input-blue"/>
						</c:if>
						<c:if test="${ it:checkPermit('QKJ_PERSONAL_POWER_DEL',null)==true}">
						<s:submit id="delete" name="delete" value="删除" action="perWorkPower_del" onclick="return isDel();" cssClass="input-red"/>
						</c:if>
						</s:elseif>
						<input type="button" value="返回" onclick="linkurl('<s:url action="perWorkPower_list" namespace="/person" />');" />
						
		            </div>
				</div>
				</div>
		</s:form>
	</div>
</div>

<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">

function checkStatus(){
	var s=document.getElementById("status").value;
	if(s==0 || s=='0'){
		$("#table_name").val(" qkjm_r_active a LEFT JOIN s_sys_user u ON (a.`apply_user`=u.`UUID`)  ");
		$("#table_field").val(" a.`uuid` perUuid,a.`apply_dept` apply_dept,a.`theme` title,u.`USER_NAME` apply_user_name,'活动' AS ptype,'/qkjmanage' AS nameSpace,CASE WHEN a.`status`<3  THEN 'active_load' ELSE  'active_closeLoad' END AS upaction, 'active.uuid' AS upUuid ");
	}else if(s==1 || s=='1'){
		$("#table_name").val(" qkjm_r_apply al LEFT JOIN s_sys_user u ON (al.`apply_user`=u.`UUID`) ");
		$("#table_field").val(" al.uuid perUuid,al.apply_dept apply_dept,al.title title,u.`USER_NAME` apply_user_name,'至事由' AS ptype,'/qkjmanage' AS nameSpace,'apply_load' AS upaction, 'apply.uuid' AS upUuid ");
	}
	else if(s==2 || s=='2'){
		$("#table_name").val(" qkja_r_leave l  LEFT JOIN s_sys_user u ON (l.leave_user=u.`UUID`)  ");
		$("#table_field").val(" l.uuid perUuid,l.leave_dept apply_dept,CONCAT_WS(':',l.`leave_start`,l.`leave_start_time`,'-',l.`leave_end`,l.`leave_end_time`,'共',l.`totle`,'天') AS title,u.`USER_NAME` apply_user_name, CASE l.`leave_type` WHEN 0 THEN '出差' WHEN 1 THEN '请假' WHEN 2 THEN '加班' WHEN 3 THEN '换休' END AS ptype,'/adm' AS nameSpace,'leave_load' AS upaction, 'leave.uuid' AS upUuid ");
	}
	else if(s==3 || s=='3'){
		$("#table_name").val(" qkjm_r_travel tl LEFT JOIN s_sys_user u ON(tl.`apply_user`=u.`UUID`)  ");
		$("#table_field").val(" tl.`uuid` perUuid,tl.`apply_dept` apply_dept,tl.`members_names` title,u.`USER_NAME` apply_user_name,'工业旅游' AS ptype,'/qkjmanage' AS nameSpace,'travel_load' AS upaction, 'travel.uuid' AS upUuid ");
	}
	
	else if(s==4 || s=='4'){
		$("#table_name").val(" qkjm_r_closeorder cl LEFT JOIN s_sys_user u ON(cl.`add_user`=u.`UUID`)  ");
		$("#table_field").val(" cl.`uuid` perUuid,cl.`apply_dept` apply_dept,cl.theme title,u.`USER_NAME` apply_user_name,'提货结案单' AS ptype,'/qkjmanage' AS nameSpace,'closeOrder_load' AS upaction, 'closeOrder.uuid' AS upUuid ");
	}
	
	else if(s==5 || s=='5'){
		$("#table_name").val(" qkjm_r_salpromotion sl LEFT JOIN s_sys_user u ON(sl.`add_user`=u.`UUID`)  ");
		$("#table_field").val(" sl.`uuid` perUuid,sl.`add_user_dept` apply_dept,sl.sal_title title,u.`USER_NAME` apply_user_name,'促销活动' AS ptype,'/salpro' AS nameSpace,'salPromot_load' AS upaction, 'salPromot.uuid' AS upUuid ");
	}
}

function checkJob(){
	var a=document.getElementById("job").value;
	var s=document.getElementById("status").value;
	if(a==0 || a=='0'){//总监
		if(s==0 || s=='0'){
			$("#condition").val(" (a.`status`=1 AND a.`sd_status`=30 AND a.`smd_status`=30  AND (a.`apply_dept` LIKE '220%' OR a.`apply_dept` LIKE '230')) or (a.`status`=4 AND a.`close_sd_status`=30 AND a.`close_smd_status`=30 AND (a.`apply_dept` LIKE '220%' OR a.`apply_dept` LIKE '230'))  ");
		}else if(s==1 || s=='1'){
			$("#condition").val(" al.status=20 and (al.`apply_dept` LIKE '220%' OR al.`apply_dept` LIKE '230')  ");
		}
		else if(s==2 || s=='2'){
			$("#condition").val(" l.check_status=20 and (l.`leave_dept` LIKE '220%' OR l.`leave_dept` LIKE '230')  and l.`leave_type` IN(1,3) AND l.`totle`>3  ");
		}
		else if(s==3 || s=='3'){
			$("#condition").val(" tl.check_status=20 and (tl.`apply_dept` LIKE '220%' OR tl.`apply_dept` LIKE '230')  ");
		}
		
		else if(s==4 || s=='4'){
			$("#condition").val(" cl.check_state=30  and (cl.`apply_dept` LIKE '220%' OR cl.`apply_dept` LIKE '230')  ");
		}
		
		else if(s==5 || s=='5'){
			$("#condition").val(" sl.smd_status=20 and (sl.`add_user_dept` LIKE '220%' OR sl.`add_user_dept` LIKE '230')  ");
		}
	}else if(a==1 || a=='1'){//副总
		if(s==0 || s=='0'){
			$("#condition").val(" (a.`status`=1 AND a.`sd_status`=40 AND a.`smd_status`=40) or (a.`status`=4 AND a.`close_sd_status`=40 AND a.`close_smd_status`=40)  ");
		}else if(s==1 || s=='1'){
			$("#condition").val(" al.status=30 and 1=0  ");
		}
		else if(s==2 || s=='2'){
			$("#condition").val(" l.check_status=30 and l.`leave_type` IN(1,3) AND l.`totle`>3  ");
		}
		else if(s==3 || s=='3'){
			$("#condition").val(" tl.check_status=30  ");
		}
		else if(s==4 || s=='4'){
			$("#condition").val(" cl.check_state=50  ");
		}
		
		else if(s==5 || s=='5'){
			$("#condition").val(" sl.smd_status=30  ");
		}
	}else if(a==2 || a=='2'){//总经理
		if(s==0 || s=='0'){
			$("#condition").val(" (a.`status`=1  AND a.`smd_status`=50) or (a.`status`=4  AND a.`close_smd_status`=50) ");
		}else if(s==1 || s=='1'){
			$("#condition").val(" al.status=30  ");
		}
		else if(s==2 || s=='2'){
			$("#condition").val(" l.acheck_status=20  and l.`leave_type` IN(1,3) AND l.`totle`>3  ");
		}
		
	}else if(a==3 || a=='3'){//财务
		if(s==0 || s=='0'){
			$("#condition").val(" qkjm_r_active a LEFT JOIN s_sys_user u ON (a.`apply_user`=u.`UUID`)  ");
		}else if(s==1 || s=='1'){
			$("#condition").val(" qkjm_r_active a LEFT JOIN s_sys_user u ON (a.`apply_user`=u.`UUID`)  ");
		}
		else if(s==2 || s=='2'){
			$("#condition").val(" qkjm_r_active a LEFT JOIN s_sys_user u ON (a.`apply_user`=u.`UUID`)  ");
		}
		else if(s==3 || s=='3'){
			$("#condition").val(" qkjm_r_active a LEFT JOIN s_sys_user u ON (a.`apply_user`=u.`UUID`)  ");
		}
		
		else if(s==4 || s=='4'){
			$("#condition").val(" qkjm_r_active a LEFT JOIN s_sys_user u ON (a.`apply_user`=u.`UUID`)  ");
		}
		
		else if(s==5 || s=='5'){
			$("#condition").val(" qkjm_r_active a LEFT JOIN s_sys_user u ON (a.`apply_user`=u.`UUID`)  ");
		}
	}
}
</script>

</body>
</html>