<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息类别列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
</head>

<style type="text/css">
.label_main{font-size:14px;}
</style>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="main">
		<div class="dq_step"><a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;新闻类别</div>
		<div id="dtree" class="left_flsort dtree">
			<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
		</div>
		<div style="float: left;">
			<s:form name="form1" action="class_control" cssClass="validForm" namespace="/info" onsubmit="return validator(this);" method="post" theme="simple">
				<div class="label_main">
					<input type="button" value="新增类别" onclick="setControl('add');" />
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">类别ID:</div>
						<div class="label_rwbenx">
							<span id="uuid_text"></span><s:hidden id="uuid" name="uuid" />
						</div>
					</div>
					<div class="label_hang clear">
						<div class="label_ltit">类别名称:</div>
						<div class="label_rwbenx"><s:textfield id="title" name="title" title="类别名称" cssClass="validate[required]"/></div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">类别别名:</div>
						<div class="label_rwbenx"><s:textfield id="title2" name="title2" title="类别别名" /></div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">父类别:</div>
						<div class="label_rwbenx">
							<s:select title="父部门" id="parent_id" name="parent_id" list="iclasses" listKey="uuid" listValue="title" headerKey="0" headerValue="根节点" require="required" controlName="父部门" />
						</div>
					</div>
					<div class="label_hang clear">
						<div class="label_ltit">修改人:</div>
						<div class="label_rwbenx"><span id="lm_user"></span></div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">修改时间:</div>
						<div class="label_rwbenx"><span id="lm_time"></span></div>
					</div>
					<div class="label_hang clear">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<span id="label_add"><s:submit	id="add" name="add" value="新增" method="add"  cssClass="input-blue"/></span>
							<span id="label_save" style="display: none;"><s:submit id="save" name="save"  value="保存" method="save" cssClass="input-blue"/></span>
							<span id="label_del" style="display: none;"><s:submit id="delete" name="delete" value="删除" method="del" onclick="return isDel();" cssClass="input-red"/></span>
							&nbsp;<span id="message"><s:property value="message" /></span>
						</div>
					</div>
				</div>
		</s:form>
	</div>
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
						d.add('0','-1','信息类别列表');
						<s:iterator value="iclasses">
						d.add('<s:property value="uuid" />','<s:property value="parent_id" />','<s:property value="title" />',"javascript:getInfo('<s:property value="uuid" />')");
						</s:iterator>
						d.add();
						divID.innerHTML = d;
						</script>
</body>
<script type="text/javascript">
function getInfo(obj) {
	//var ajax = new Ajax_Init("result",true,true,'','','','message');
	//ajax.addParameter("privilege_id","INFO_MANAGER_CLASS_AJAX_LOAD");
	//ajax.addParameter("parameters","uuid="+obj);
	//ajax.SendPost('<s:url value="/common/ajax" />');
	var ajax = new Common_Ajax('message');
	ajax.config.action_url = '<s:url value="/common_ajax/json_ajax" />';
	ajax.config._success = function(data, textStatus) {
		try {	
			var json = data[0];
			$("#uuid_text").html(json.uuid);
			$('#uuid').val(json.uuid);
			$('#title').val(json.title);
			$('#title2').val(json.title2);
			$('#parent_id').val(json.parent_id);
			$('#lm_user').html(json.lm_user);
			$('#lm_time').html(formatDate(json.lm_time));		
			setControl("save");
		} catch (e) {
			$('#message').html("读取失败...");
			iferror(data[0],e);
		}
	};
	ajax.addParameter("privilege_id","INFO_MANAGER_CLASS_AJAX_LOAD");
	ajax.addParameter("parameters","uuid="+obj);
	ajax.sendAjax();
}

function setControl(str) {
	if("save"==str) {
		$('#label_add').css({"display":"none"});
		$('#label_save').css({"display":""});
		$('#label_del').css({"display":""});
	} else if("add"==str) {
		$('#label_add').css({"display":""});
		$('#label_save').css({"display":"none"});
		$('#label_del').css({"display":"none"});
		
		$('#uuid_text').html('新增时不需填写!');
		$('#lm_user').html('&nbsp;');
		$('#lm_time').html('&nbsp;');
		var new_parent_id = $('#uuid').val();
		form1.reset();
		if(new_parent_id!="")
			$('#parent_id').val(new_parent_id);
		else $('#parent_id').val('0');
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
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
});
</script>
</html>
