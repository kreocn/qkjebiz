<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
};

var sobj01;
var selectDept2 = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01'});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_cnameid").val(val2);
	};
	sobj01.create();
	sobj01.open();
};
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">	
	<div class="itabletitle">
		<span class="title1">管理员列表</span>
		<span class="extra1">
			<a href="<s:url namespace="/sys" action="user_load"><s:param name="viewFlag">add</s:param></s:url>" >添加管理员</a>
		</span>
	</div>
	<div class="ilistsearch">
<s:form name="form_serach" action="user_list"  method="get" namespace="/sys" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
			<tr>
				<td class="firstRow">工号:</td>
	    		<td class="secRow"><s:textfield id="user.work_id" title="工号" name="user.work_id" /></td>
				<td class="firstRow">姓名:</td>
	    		<td class="secRow"><s:textfield id="user.user_name" title="姓名" name="user.user_name" /></td>				
			</tr>
			<tr>
				<td class="firstRow">所属部门:</td>
	    		<td class="secRow" colspan="3">
			    	<s:textfield title="部门" id="userdept_codeid" name="user.dept_code" readonly="true" />
					<s:textfield title="部门名称" id="userdept_cnameid" name="user.dept_cname" readonly="true" />
					<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept2();" />
				</td>
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
	<colGroup width="12"></colGroup>
	<colGroup width="20%"></colGroup>
	<colGroup width=""></colGroup>
	<colGroup width="20%"></colGroup>
	<colGroup width="20%"></colGroup>
	<colGroup width="48"></colGroup>
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>用户名</th>
		<th>姓名</th>
		<th>部门</th>
		<th>职务</th>
		<th>状态</th>
		<th>操作</th>
	  </tr>
<s:set name="_status" value="#{0:'初始',1:'正常',2:'冻结','10000':'测试'}" />
<s:iterator value="users" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="title" /></td>
	    <td><s:property value="user_name" /></td>
	    <td><s:property value="dept_cname" /></td>		
	    <td><s:property value="position_name" /></td>
	    <td align="center">
			<s:set var="_status" value="%{status}" />
		    <s:if test="#_status == 0">初始</s:if>
		    <s:elseif test="#_status == 1">正常</s:elseif>
		    <s:elseif test="#_status == 2">冻结</s:elseif>
			<s:else>其他</s:else>
		</td>
		<td align="center">
	    	[<a href="<s:url namespace="/sys" action="user_load"><s:param name="viewFlag">mdy</s:param><s:param name="user.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	[<a href="<s:url namespace="/sys" action="user_del"><s:param name="user.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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
	    <td colspan="7" class="buttonarea"><span id="message"><s:property value="message" /></span></tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>