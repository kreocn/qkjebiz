<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户权限列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/v0.1/spin.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/v0.1/loading.js" />"></script>
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
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">用户权限</div>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="200" style="background-color: #F0F0F0;" valign="top">
<div style="width:200px; overflow: auto;">
	<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
	<script type="text/javascript">
		d = new dTree('d');
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
		document.write(d);
	</script>
</div>
</td>
<td valign="top">
<s:form name="form1" action="privilege_list" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
<div class="ifromoperate" ><input type="button" value="新增权限" onclick="setControl('add');" /></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	<colGroup width="20%" align="right" style="font-weight: bold;"></colGroup>
	<colGroup width="30%"></colGroup>
	<colGroup width="20%" align="right" style="font-weight: bold;"></colGroup>
	<colGroup width="30%"></colGroup>
	  <tr>
		<td>权限ID:<s:hidden id="privilege.uuid" name="privilege.uuid" value="privilege.uuid" /></td>
	    <td>
			<s:textfield id="privilege.privilege_id" name="privilege.privilege_id" require="require" controlName="权限ID" cssStyle="width: 80%" /> <span style="color:red;">*</span>
		</td>
		<td>权限类别:</td>
	    <td><s:radio id="privilege.privilege_type" name="privilege.privilege_type" list="#{0:'用户权限',1:'系统权限'}" value="0" /></td>
	  </tr>
	  <tr>
	    <td>父权限:</td>
	    <td><s:select title="父权限" id="privilege.parent_privilege" 
	    	name="privilege.parent_privilege" 
	    	list="privileges" 
	    	listKey="privilege_id" 
	    	listValue="privilege_name" 
            headerKey="0"
            headerValue="根节点" require="required" controlName="父权限" /> <span style="color:red;">*</span></td>
	    <td>权限名称:</td>
	    <td><s:textfield title="权限名称" id="privilege.privilege_name" name="privilege.privilege_name" require="require" controlName="权限名称" /> <span style="color:red;">*</span></td>
	  </tr>
	  <tr>
	    <td>权限描述:</td>
	    <td colspan="3"><s:textfield title="权限描述" id="privilege.descriptions" name="privilege.descriptions" style="width: 80%" /></td>	    
	  </tr>
	  <tr>
	    <td>是否为AJAX权限:</td>
	    <td><s:radio id="privilege.is_ajax" name="privilege.is_ajax" list="#{0:'否',1:'是'}" /></td>
		<td>AJAX对应MAP_ID:</td>
	    <td><s:textfield title="AJAX相关MAP_ID" id="privilege.ajax_map_id" name="privilege.ajax_map_id" /></td>	    
	  </tr>
	  <tr>
	    <td>是否是菜单:</td>
	    <td><s:radio id="privilege.is_menu" name="privilege.is_menu" list="#{0:'否',1:'是'}" /></td>
		<td>菜单提示文本:</td>
	    <td><s:textfield title="菜单提示文本" id="privilege.menu_title" name="privilege.menu_title" /></td>	    
	  </tr>
	  <tr>
	    <td>菜单TARGET:</td>
	    <td><s:textfield title="菜单TARGET" id="privilege.menu_target" name="privilege.menu_target" /></td>
		<td>菜单优先级:</td>
	    <td><s:textfield title="菜单优先级" id="privilege.menu_priority" name="privilege.menu_priority" controlName="菜单优先级" dataType="integer" /></td>	    
	  </tr>
	  <tr>
	    <td>菜单URL:</td>
	    <td colspan="3"><s:textfield title="菜单URL" id="privilege.menu_url" name="privilege.menu_url" style="width: 80%" /></td>	    
	  </tr>
	  <tr>
	    <td>修改人:</td>
	    <td><span id="privilege.lm_user"></span></td>
		<td>修改时间:</td>
	    <td><span id="privilege.lm_time"></span></td>	    
	  </tr>
	  <tr>
	    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
			<span id="label_add"><s:submit id="add" name="add" value="新增" action="privilege_add" /></span>
	    	<span id="label_save" style="display:none;"><s:submit id="save" name="save" value="保存" action="privilege_save" /></span>
			<span id="label_del" style="display:none;"><s:submit id="delete" name="delete" value="删除" action="privilege_del" onclick="return isDel();" /></span>
		</td>	    
	  </tr>
	</table>
</s:form>
<s:fielderror />
</td></tr></table>
</div>
</div>
</div>
</body>
</html>