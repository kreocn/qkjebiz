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
.label_ltit{width:110px;}
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
		<div class="dq_step"><a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;部门</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200" style="background-color: #F0F0F0;" valign="top">
					<div id="dtree">
						<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
					</div>
				</td>
				<td width="10"></td>
				<td valign="top">
					<s:form name="form1" cssClass="validForm" action="assetstype_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
						<div class="label_main">
							<input type="button" value="新增资产类型" onClick="setControl('add');" />
						</div>	
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">编号ID:</div>
								<div class="label_rwbenx"><span id="assetstype.uuid_text"></span>
								
								<s:hidden id="assetstype.uuid" name="assetstype.uuid" value="%{assetstype.uuid}"></s:hidden>
								</div>
							</div>
							<div class="label_hang clear">
								<div class="label_ltit">资产种类:</div>
								<div class="label_rwbenx"><s:textfield id="assetstype.typea" name="assetstype.typea" cssClass="validate[required]" /></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">父类:</div>
								<div class="label_rwbenx"><s:select title="父部门" 	id="assetstype.parent_type" name="assetstype.parent_type" list="assetstypes" listKey="uuid" listValue="typea"	headerKey="0"	headerValue="根节点" cssClass="validate[required]" /></div>
							</div>
							
							
							<div class="label_hang clear">
								<div class="label_ltit">修改人:</div>
								<div class="label_rwbenx"><span id="assetstype.lm_user"></span></div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">修改时间:</div>
								<div class="label_rwbenx"><span id="assetstype.lm_time"></span></div>
							</div>
							<div class="label_hang clear">
								<div class="label_ltit">相关操作:</div>
								<div class="label_rwbenx">
									<span id="label_add"><s:submit id="add" name="add" value="新增" action="assetstype_add" cssClass="input-blue"/></span>
									<span id="label_save" style="display: none;"><s:submit id="save" name="save" value="保存" action="assetstype_save" cssClass="input-blue"/></span>
									<span id="label_del" style="display: none;"><s:submit id="delete" name="delete" value="删除" action="assetstype_del" onclick="return isDel();" cssClass="input-red"/></span>
									&nbsp;<span id="message"><s:property value="message" /></span>
									<span id="message2"></span>
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
	d.add('0','-1','资产类型列表');
	<s:iterator value="assetstypes">
	d.add('<s:property value="uuid" />','<s:property value="parent_type" />'+'','<s:property value="typea" />',"javascript:getInfo('<s:property value="uuid" />')");
	</s:iterator>
	d.add();
	divID.innerHTML = d;
</script>


<script type="text/javascript">
var puuid = '<s:property value="assetstype.uuid" />';
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
		$("#assetstype\\.uuid_text").text(json.uuid);
		$("#assetstype\\.uuid").val(json.uuid);
		$("#assetstype\\.typea").val(json.typea);		
		$("#assetstype\\.parent_type").val(json.parent_type);
		$("#assetstype\\.lm_user").text(json.lm_user);
		$("#assetstype\\.lm_time").text(formatDate(json.lm_time));
		
		setControl("save");
		$("#message").text("获取数据成功!");
	};
	ajax.addParameter("privilege_id","QKJ_ADM_ASSETSTYPE");
	ajax.addParameter("parameters","uuid="+obj);
	ajax.sendAjax();
}
function setControl(ct) {
	if("save"==ct) {
		if(cflag == 0) {
			$('#label_add').hide();
			$('#label_save').show();
			$('#label_del').show();
			$('#assetstype\\.uuid').attr("readonly","true");
			cflag = 1;
		}		
	} else if("add"==ct) {
		if(cflag == 1) {
			$('#label_add').show();
			$('#label_save').hide();
			$('#label_del').hide();
			
			$('#message').empty();

			var new_parent_id = $('#assetstype\\.uuid').val();
			form1.reset();
			
			$("#assetstype\\.lm_user").empty();
			$("#assetstype\\.lm_time").empty();
			$("#assetstype\\.parent_type").val(new_parent_id);
			$("#assetstype\\.uuid").removeAttr("readonly");
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
function viewx(obj) {
	alert(obj);
	$('message').innerHTML = obj;
}
</script>
</body>
</html>
