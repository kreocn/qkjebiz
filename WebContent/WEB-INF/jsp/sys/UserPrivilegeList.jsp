<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户权限列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<style type="text/css">
.label_main{font-size:14px;}
.label_ltit{width:130px;}
.label_hang_linput {
	width: 760px !important;
}
@media screen and (max-width:1180px) {
	.label_hang_linput {
		width: 500px !important;
	}
}
@media screen and (max-width:820px) {
	.label_hang_linput {
		width: 300px !important;
	}
}
@media screen and (max-width:620px) {
	.label_hang_linput {
		width: 150px !important;
	}
}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="main">
		<div class="dq_step"><a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;用户权限</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200" style="background-color: #F0F0F0;" valign="top">
					<div id="dtree">
						<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
					</div>
				</td>
				<td width="10"></td>
				<td valign="top">
					<s:form name="form1" cssClass="validForm" action="privilege_list" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
						<div class="label_main">
							<input type="button" value="新增权限" onClick="setControl('add');" />
						</div>						
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">权限ID:<s:hidden id="privilege.uuid" name="privilege.uuid" value="privilege.uuid" /></div>
								<div class="label_rwbenx"><s:textfield id="privilege.privilege_id" name="privilege.privilege_id"  cssClass="validate[required]" title="权限ID"/></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">权限类别:</div>
								<div class="label_rwbenx"><s:radio id="privilege.privilege_type" name="privilege.privilege_type" list="#{0:'用户权限',1:'系统权限'}" value="0" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">父权限:</div>
								<div class="label_rwbenx">
									<s:select title="父权限" id="privilege.parent_privilege" name="privilege.parent_privilege" list="privileges" listKey="privilege_id" listValue="privilege_name"  headerKey="0"  headerValue="根节点" cssClass="validate[required]" />
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">权限名称:</div>
								<div class="label_rwbenx"><s:textfield id="privilege.privilege_name" name="privilege.privilege_name" cssClass="validate[required]" title="权限名称"/></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">所属模块:</div>
								<div class="label_rwbenx"><s:select title="所属模块" id="privilege.module" name="privilege.module" list="#{0:'业务系统',1:'信息系统',2:'报表系统',3:'基础数据',4:'系统设置'}" cssClass="validate[required]" /></div>
							</div>
							<div class="label_hang clear">
								<div class="label_ltit">权限描述:</div>
								<div class="label_rwbenx"><s:textfield id="privilege.descriptions" name="privilege.descriptions"  title="权限描述" cssClass="label_hang_linput" /></div>
							</div>
							<div class="label_hang clear">
								<div class="label_ltit">是否为AJAX权限:</div>
								<div class="label_rwbenx" style="width:155px;"><s:radio id="privilege.is_ajax" name="privilege.is_ajax" list="#{0:'否',1:'是'}" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">AJAX对应MAP_ID:</div>
								<div class="label_rwbenx"><s:textfield title="AJAX相关MAP_ID" id="privilege.ajax_map_id" name="privilege.ajax_map_id" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">是否是菜单:</div>
								<div class="label_rwbenx"><s:radio id="privilege.is_menu" name="privilege.is_menu" list="#{0:'否',1:'是'}" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">菜单提示文本:</div>
								<div class="label_rwbenx"><s:textfield title="菜单提示文本" id="privilege.menu_title" name="privilege.menu_title" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">菜单TARGET:</div>
								<div class="label_rwbenx"><s:textfield title="菜单TARGET" id="privilege.menu_target" name="privilege.menu_target" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">菜单优先级:</div>
								<div class="label_rwbenx"><s:textfield title="菜单优先级" id="privilege.menu_priority" name="privilege.menu_priority" cssClass="validate[custom[integer]]" /></div>
							</div>
							<div class="label_hang clear">
								<div class="label_ltit">菜单URL:</div>
								<div class="label_rwbenx"><s:textfield title="菜单URL" id="privilege.menu_url" name="privilege.menu_url"  cssClass="label_hang_linput" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">修改人:</div>
								<div class="label_rwbenx"><span id="privilege.lm_user"></span></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">修改时间:</div>
								<div class="label_rwbenx"><span id="privilege.lm_time"></span></div>
							</div>
							<div class="label_hang clear">
								<div class="label_ltit">相关操作:</div>
								<div class="label_rwbenx ">
									<span id="label_add"><s:submit id="add" name="add" value="新增" action="privilege_add" cssClass="input-blue"/></span>
							    	<span id="label_save" style="display:none;"><s:submit id="save" name="save" value="保存" action="privilege_save" cssClass="input-blue"/></span>
									<span id="label_del" style="display:none;"><s:submit id="delete" name="delete" value="删除" action="privilege_del" onclick="return isDel();" cssClass="input-red"/></span>
									&nbsp;<span id="message"><s:property value="message" /></span>
								</div>
							</div>
						</div>
					</s:form>
				</td>
			</tr>
		</table>
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
	var divID =document.getElementById("dtree");  
	d = new dTree('d');
	//d.config.isAddNoRootNode = true;
	d.icon = {
			root		: '<s:url value="/include/dtree/" />'+'img/globe.gif',
			folder		: '<s:url value="/include/dtree/" />'+'img/folder.gif',
			folderOpen	: '<s:url value="/include/dtree/" />'+'img/folderopen.gif',
			node		: '<s:url value="/include/dtree/" />'+'img/page.gif',
			empty		: '<s:url value="/include/dtree/" />'+'img/empty.gif',
			line		: '<s:url value="/include/dtree/" />'+'img/line.gif',
			join		: '<s:url value="/include/dtree/" />'+'img/join.gif',
			joinBottom	: '<s:url value="/include/dtree/" />'+'img/joinbottom.gif',
			plus		: '<s:url value="/include/dtree/" />'+'img/plus.gif',
			plusBottom	: '<s:url value="/include/dtree/" />'+'img/plusbottom.gif',
			minus		: '<s:url value="/include/dtree/" />'+'img/minus.gif',
			minusBottom	: '<s:url value="/include/dtree/" />'+'img/minusbottom.gif',
			nlPlus		: '<s:url value="/include/dtree/" />'+'img/nolines_plus.gif',
			nlMinus		: '<s:url value="/include/dtree/" />'+'img/nolines_minus.gif'
	};		
	d.add('0','-1','用户权限列表');
	<s:iterator value="privileges">
	d.add('<s:property value="privilege_id" />','<s:property value="parent_privilege" />','<s:property value="privilege_name" />',"javascript:getInfo('<s:property value="uuid" />')");
	</s:iterator>
	d.add();
	divID.innerHTML = d;
</script>
<script type="text/javascript">
var puuid = '<s:property value="privilege.uuid" />';
var cflag = 0;//状态符,0代表新增状态 1代表修改状态

$(function(){
	if(puuid=='') {
		cflag = 1;
		setControl('add');
		cflag = 0;
	} else {
		getInfo(puuid);
	}	
});

function getInfo(obj) {
	var ajax = new Common_Ajax('message');
	ajax.config.action_url = '<s:url value="/common_ajax/json_ajax" />';
	ajax.config._success = function(data, textStatus) {
		var json = data[0];
		$("#privilege\\.uuid").val(json.uuid);
		$("#privilege\\.privilege_id").val(json.privilege_id);		
		//单选框,复选框,多选下拉菜单都要用数组赋值
		//单选下拉菜单用字符串直接赋值
		$(":radio[name='privilege.privilege_type']").val([json.privilege_type]);
		$("#privilege\\.privilege_name").val(json.privilege_name);
		$("#privilege\\.descriptions").val(json.descriptions);
		$("#privilege\\.parent_privilege").val(json.parent_privilege);		
		$(":radio[name='privilege.is_ajax']").val([json.is_ajax]);
		$("#privilege\\.ajax_map_id").val(json.ajax_map_id);
		$(":radio[name='privilege.is_menu']").val([json.is_menu]);
		$("#privilege\\.menu_title").val(json.menu_title);
		$("#privilege\\.menu_priority").val(json.menu_priority);
		$("#privilege\\.menu_target").val(json.menu_target);
		$("#privilege\\.menu_url").val(json.menu_url);
		$("#privilege\\.lm_user").text(json.lm_user);
		$("#privilege\\.lm_time").text(formatDate(json.lm_time));
		$("#privilege\\.module").val(json.module);
		setControl("save");
		$("#message").text("获取数据成功!");
	};
	ajax.addParameter("privilege_id","SYS_MANAGER_PRIVILEGE_AJAX_LOAD");
	ajax.addParameter("parameters","uuid="+obj);
	ajax.sendAjax();
}


function setControl(ct) {
	if("save"==ct) {
		if(cflag == 0) {
			$('#label_add').hide();
			$('#label_save').show();
			$('#label_del').show();
			$('#privilege\\.privilege_id').attr("readonly","true");
			cflag = 1;
		}		
	} else if("add"==ct) {
		if(cflag == 1) {
			$('#label_add').show();
			$('#label_save').hide();
			$('#label_del').hide();
			
			$('#message').empty();
			
			var new_parent_id = $('#privilege\\.privilege_id').val();
			
			form1.reset();
			$("#privilege\\.lm_user").empty();
			$("#privilege\\.lm_time").empty();
			
			$('#privilege\\.parent_privilege').val(new_parent_id);
			$('#privilege\\.privilege_id').val(new_parent_id + "_");
			$('#privilege\\.menu_target').val("mainFrame");
			$('#privilege\\.menu_url').val("javascript:void(0);");
			$('#privilege\\.menu_priority').val('0');
			$('#privilege\\.privilege_id').removeAttr("readonly");
			cflag = 0;
		}
	}
}
function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('message').innerHTML = str;
}
</script>
</body>
</html>
