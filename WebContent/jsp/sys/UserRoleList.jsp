<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员组列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
};
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">会员组列表</span>
		<span class="extra1">
			<a href="<s:url value="/sys/userrole_load_add" />" >添加系统角色</a>
		</span>
	</div>	
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	<colGroup width="12"></colGroup>
	<colGroup width="20%"></colGroup>
	<colGroup width=""></colGroup>
	<colGroup width="30%"></colGroup>
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>名称</th>
	    <th>等级</th>
		<th>描述</th>
		<th>添加时间</th>
		<th>操作</th>
	  </tr>
<s:iterator value="roles" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="role_name" /></td>
	    <td><s:property value="role_rank" /></td>
	    <td><s:property value="descriptions" /></td>
	    <td><s:date name="lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
	    <td align="center">
	    	[<a href="<s:url namespace="/sys" action="userrole_load_mdy"><s:param name="viewFlag">mdy</s:param><s:param name="role.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	[<a href="<s:url namespace="/sys" action="userrole_del"><s:param name="role.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
	    <span id="message"><s:property value="message" /></span>
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>