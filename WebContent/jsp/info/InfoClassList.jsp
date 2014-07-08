<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息类别列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
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
<body>
	<div id="main">
		<div id="result">
			<div class="itablemdy">
				<div class="itabletitle">部门</div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td width="200" style="background-color: #F0F0F0;" valign="top">
							<div class="dtree" style="width: 200px; overflow: auto;">
								<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
								<script type="text/javascript">
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
		document.write(d);
	</script>
							</div>
						</td>
						<td valign="top"><s:form name="form1" action="class_control" namespace="/info" onsubmit="return validator(this);" method="post"
								theme="simple">
								<div class="ifromoperate">
									<input type="button" value="新增类别" onclick="setControl('add');" />
								</div>
								<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
									<colGroup width="20%" align="right" style="font-weight: bold;"></colGroup>
									<colGroup width="30%"></colGroup>
									<colGroup width="20%" align="right" style="font-weight: bold;"></colGroup>
									<colGroup width="30%"></colGroup>
									<tr>
										<td>类别ID:</td>
										<td colspan="3"><span id="uuid_text"></span>
										<s:hidden id="uuid" name="uuid" /></td>
									</tr>
									<tr>
										<td>类别名称:</td>
										<td><s:textfield id="title" name="title" require="required" controlName="类别名称" /></td>
										<td>类别别名:</td>
										<td><s:textfield id="title2" name="title2" /></td>
									</tr>
									<tr>
										<td>父类别:</td>
										<td><s:select title="父部门" id="parent_id" name="parent_id" list="iclasses" listKey="uuid" listValue="title" headerKey="0"
												headerValue="根节点" require="required" controlName="父部门" /></td>
										<td></td>
										<td></td>
									</tr>
									<!--
				<tr>
					<td>分类类别模板:</td>
					<td><s:textfield id="dept_code" name="dept_code" /></td>
					<td>资源模板:</td>
					<td><s:textfield id="dept_cname" name="dept_cname" /></td>
				</tr>
				<tr>
					<td>静态文件生成路径:</td>
					<td colspan="3"><s:textfield id="dept_cname" name="dept_cname" cssStyle="width:60%" /></td>
				</tr>
				-->
									<tr>
										<td>修改人:</td>
										<td><span id="lm_user"></span></td>
										<td>修改时间:</td>
										<td><span id="lm_time"></span></td>
									</tr>
									<tr>
										<td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span> <span id="label_add"><s:submit
													id="add" name="add" value="新增" method="add" /></span> <span id="label_save" style="display: none;"><s:submit id="save" name="save"
													value="保存" method="save" /></span> <span id="label_del" style="display: none;"><s:submit id="delete" name="delete" value="删除"
													method="del" onclick="return isDel();" /></span></td>
									</tr>
								</table>
							</s:form></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</body>
</html>
