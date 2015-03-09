<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色权限细项编辑--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.treeTable.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.treeTable.js" />"></script>
<script type="text/javascript">
$(document).ready(function()  {
  $("#prvg_list_table").treeTable({
	  expandable: false
  });
});
</script>
<body>
<s:if test="'closewin' == viewFlag">
	<script type="text/javascript">
		parent.document.getElementById("message").innerHTML = '细项编辑成功!';
		parent.closeModelDiv();
	</script>
</s:if>
<div id="main" style="overflow:auto; height: 400px;">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">细项编辑(未保存角色权限修改请先保存)</div>
<s:form name="form1" action="role_prvg_save" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
	<s:hidden name="role.uuid" />
	<div style="width: 95%">
		<table id="prvg_list_table" class="treeTable" style="border-collapse: collapse;" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
			<tr id='0'>
			<th>权限名</th>
			<th width="35">全局</th>
			<th width="35">部门</th>
			<th width="35">个人</th>
			</tr>
		<s:iterator value="rolePrvgs">					
			<tr id="<s:property value="privilege_id" />" <s:if test="parent_privilege==0"></s:if><s:else>class="child-of-<s:property value="parent_privilege" />"</s:else>>
			<td><s:property value="privilege_name" /></td>
			<td><input type="radio" name="<s:property value="privilege_id" />" value="2" <s:if test="type==2">checked</s:if> /></td>
			<td><input type="radio" name="<s:property value="privilege_id" />" value="1" <s:if test="type==1">checked</s:if> /></td>
			<td><input type="radio" name="<s:property value="privilege_id" />" value="0" <s:if test="type==null||type==0">checked</s:if> /></td>
			</tr>
		</s:iterator>
		<tr>
		    <td colspan="4" align="right" ><span id="message"><s:property value="message" /></span>
				<s:submit id="role_prvg_save" name="role_prvg_save" value="保存" action="role_prvg_save" />
				<input type="button" value="关闭" onclick="parent.closeModelDiv();" >
			</td>    
	    </tr>
		</table>
	</div>		
</s:form>
	</div>
</div>
</div>
</body>
</html>