<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div_Imp.js" />"></script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
}
function selectDept() {
	createDeptAllSelectDiv($("user.dept_code"),$("user.dept_cname"));
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">	
	<div class="itabletitle">
		<span class="title1">会员列表</span>
		<span class="extra1">
			<s:url id="member_add_uid" value="member_add" namespace="/sys">
				<s:param name="viewFlag">add</s:param>
			</s:url>
			<s:a href="%{member_add_uid}" >添加会员</s:a>
		</span>
	</div>
	<div class="ilistsearch">
<s:form name="form_serach" action="member_list"  method="get" namespace="/sys" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
			<tr>
				<td class="firstRow">会员号:</td>
	    		<td class="secRow"><s:textfield id="user.title" title="会员号" name="user.title" /></td>
				<td class="firstRow">会员姓名:</td>
	    		<td class="secRow"><s:textfield id="user.user_name" title="姓名" name="user.user_name" />%</td>				
			</tr>
			<tr>
				<td class="firstRow">会员手机:</td>
	    		<td class="secRow"><s:textfield id="user.mobile" title="会员手机" name="user.mobile" /></td>
				<td class="firstRow">会员邮箱:</td>
	    		<td class="secRow"><s:textfield id="user.email" title="会员邮箱" name="user.email" />%</td>		
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
	<colGroup width="80"></colGroup>
	<colGroup width="150"></colGroup>
	<colGroup width="120"></colGroup>
	<colGroup width="80"></colGroup>
	<colGroup></colGroup>
	<colGroup width="80"></colGroup>
	<colGroup width="80"></colGroup>
	<colGroup width="120"></colGroup>
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>用户名</th>
		<th>会员姓名</th>
		<th>会员手机</th>
		<th>手机验证</th>
		<th>会员邮箱</th>
		<th>邮箱验证</th>
		<th>可用积分</th>
		<th>注册日期</th>
		<th>操作</th>
	  </tr>
<s:set name="_status" value="#{0:'初始',1:'正常',2:'冻结','10000':'测试'}" />
<s:iterator value="users" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="title" /></td>
	    <td><s:property value="user_name" /></td>
	    <td><s:property value="mobile" /></td>
	    <td align="center">
	    	<s:if test="0 == is_mobile_check">未验证</s:if>
	    	<s:elseif test="1 == is_mobile_check">已验证</s:elseif>
	    </td>
	    <td><s:property value="email" /></td>
	    <td align="center">
	   	 	<s:if test="0 == is_mobile_check">未验证</s:if>
	    	<s:elseif test="1 == is_mobile_check">已验证</s:elseif>
	    </td>
	    <td></td>
	    <td align="center"><s:date name="reg_time" format="yyyy-MM-dd" /></td>
	    <td align="center">
	    	[<a href="<s:url namespace="/sys" action="member_mdy"><s:param name="viewFlag">mdy</s:param><s:param name="user.uuid" value="uuid"></s:param></s:url>">修改</a>]
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
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>