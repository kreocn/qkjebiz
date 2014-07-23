<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>职务管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">职务管理</span>
		<span class="extra1">
			<a href="<s:url namespace="/sys" action="position_load"><s:param name="viewFlag">add</s:param></s:url>" >添加职务</a>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="position_list"  method="get" namespace="/sys" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
			<tr>
				<td class="firstRow">职务名称:</td>
	    		<td class="secRow"><s:textfield title="企业注册号" name="position.position_name" /></td>
				<td class="firstRow"></td>
	    		<td class="secRow"></td>
			</tr>
			<tr>
			<td colspan="4" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>系统编号</th>
		<th>职务名称</th>
		<th>职务等级</th>
		<th>职务属性</th>
		<th>职务描述</th>
		<th>操作</th>
	  </tr>
<s:iterator value="positions" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
	    <td><s:property value="position_name" /></td>
		<td>
			<s:if test="1==position_grade">总经理</s:if>
			<s:if test="2==position_grade">副总经理</s:if>
			<s:if test="3==position_grade">总监</s:if>
			<s:if test="4==position_grade">经理</s:if>
			<s:if test="5==position_grade">主管</s:if>
			<s:if test="6==position_grade">员工</s:if>
		</td>
		<td><s:property value="position_attribute" /></td>
		<td><s:property value="position_note" /></td>
		<td align="center">
	    	[<a href="<s:url namespace="/sys" action="position_load"><s:param name="viewFlag">mdy</s:param><s:param name="position.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	[<a href="<s:url namespace="/sys" action="position_del"><s:param name="position.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage();
		spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
		</script>
		</td>	    
	  </tr>
	  <tr>
	    <td colspan="20" class="buttonarea"><span id="message"><s:property value="message" /></span></td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>