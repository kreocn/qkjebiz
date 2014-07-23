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
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax.js" />"></script>
<script type="text/javascript">
function getInfo(obj) {
	//alert("uuid≡"+obj);
	//var p = "uuid≡"+escape(obj);
	var ajax = new Ajax_Init("result",true,true,'','','','message');
	ajax.addParameter("privilege_id","SYS_MANAGER_DEPT_AJAX_LOAD");
	ajax.addParameter("parameters","uuid="+obj);
	//ajax.SendPost('<s:url value="/common/ajax" />');
	ajax.SendPost('<s:url namespace="/common_ajax" action="json_ajax" />');
}

function setAjaxInfo(str) {
	try {		
		//var json = eval('('+getCHTML(str)+')');
		var json = eval('('+str+')');
		$('dept.uuid_text').innerHTML = json[0].uuid;
		$('dept.uuid').value = json[0].uuid;
		$('dept.dept_code').value = json[0].dept_code;
		$('dept.dept_cname').value = json[0].dept_cname;	
		$('dept.dept_ename').value = json[0].dept_ename;	
		$('dept.descriptions').value = json[0].descriptions;
		$('dept.lm_user').innerHTML = json[0].lm_user;
		$('dept.lm_time').innerHTML = formatDate(json[0].lm_time);
		$('dept.parent_dept').value = json[0].parent_dept;
		setControl("save");
	} catch (e) {
		$('message').innerHTML = "读取失败...";
		iferror(str,e);
	}
}

function setControl(str) {
	if("save"==str) {
		if($('label_add').style)
			$('label_add').style.display='none';
		if($('label_save').style) 
			$('label_save').style.display='';
		if($('label_del').style) 
			$('label_del').style.display='';
		$('dept.dept_code').readOnly = true;
	} else if("add"==str) {
		if($('label_add').style)
			$('label_add').style.display='';
		if($('label_save').style)
			$('label_save').style.display='none';
		if($('label_del').style)
			$('label_del').style.display='none';
		$('dept.uuid_text').innerHTML='新增时不需填写!';
		$('dept.lm_user').innerHTML='&nbsp;';
		$('dept.lm_time').innerHTML='&nbsp;';
		var new_parent_id = $('dept.dept_code').value;
		form1.reset();
		//alert(new_parent_id);
		$('dept.parent_dept').value = new_parent_id;
		$('dept.dept_code').readOnly = false;
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
		<div class="dtree" style="width: 200px; overflow: auto;"><!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
		<script type="text/javascript">
		d = new dTree('d');
		d.config.isAddNoRootNode = true;
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
		d.add('0','-1','部门列表');
		<s:iterator value="depts">
		d.add('<s:property value="dept_code" />','<s:property value="parent_dept" />','<s:property value="dept_cname" />',"javascript:getInfo('<s:property value="uuid" />')");
		</s:iterator>
		d.add();
		document.write(d);
	</script></div>
		</td>
		<td valign="top">
			<s:form name="form1" action="dept_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
			<div class="ifromoperate"><input type="button" value="新增部门" onclick="setControl('add');" /></div>
			<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
				<colGroup width="20%" align="right" style="font-weight: bold;"></colGroup>
				<colGroup width="30%"></colGroup>
				<colGroup width="20%" align="right" style="font-weight: bold;"></colGroup>
				<colGroup width="30%"></colGroup>
				<tr>
					<td>部门ID:</td>
					<td colspan="3"><span id="dept.uuid_text"></span><s:hidden id="dept.uuid" name="dept.uuid" value="dept.uuid" /></td>
				</tr>
				<tr>
					<td>部门代码:</td>
					<td><s:textfield id="dept.dept_code" name="dept.dept_code" require="required" controlName="部门代码" /> <span style="color:red;">*</span></td>
					<td>父部门:</td>
					<td><s:select title="父部门" 
						id="dept.parent_dept" 
						name="dept.parent_dept"
						list="depts"
						listKey="dept_code" 
						listValue="dept_cname"
						headerKey="0" 
						headerValue="根节点" require="required" controlName="父部门" /> <span style="color:red;">*</span></td>
				</tr>
				<tr>
					<td>部门名称:</td>
					<td><s:textfield id="dept.dept_cname" name="dept.dept_cname" require="required" controlName="部门名称" /> <span style="color:red;">*</span></td>
					<td>部门名称(英文):</td>
					<td><s:textfield id="dept.dept_ename" name="dept.dept_ename" /></td>
				</tr>
				<tr>
					<td>描述:</td>
					<td colspan="3"><s:textfield id="dept.descriptions" name="dept.descriptions" cssStyle="width:60%" /></td>
				</tr>
				<tr>
					<td>修改人:</td>
					<td><span id="dept.lm_user"></span></td>
					<td>修改时间:</td>
					<td><span id="dept.lm_time"></span></td>
				</tr>
				<tr>
					<td colspan="4" class="buttonarea">
						<span id="message"><s:property value="message" /></span>
						<span id="message2"></span>
						<span id="label_add"><s:submit id="add" name="add" value="新增" action="dept_add" /></span>
						<span id="label_save" style="display: none;"><s:submit id="save" name="save" value="保存" action="dept_save" /></span>
						<span id="label_del" style="display: none;">
						<s:submit id="delete" name="delete" value="删除" action="dept_del" onclick="return isDel();" />
						</span>
					</td>
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
