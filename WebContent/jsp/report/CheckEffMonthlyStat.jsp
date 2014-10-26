<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动/至事由统计报表</title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<style type="text/css">
.tgroup {
clear: both;
}
.tx {
float: left;margin-bottom: 10px;margin-right: 10px;
}
.ilisttablex th,.ilisttablex td {
padding-left: 5px;padding-right: 5px;
}
</style>
</head>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">活动/至事由统计报表</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="checkeffmonthly"  method="get" namespace="/rpt" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
			<tr>
				<td class="firstRow">报表时间:</td>
	    		<td class="secRow">
	    			<s:select name="yearMonth" list="yearMonths" listKey="key" listValue="value" headerKey="" headerValue="--请选择--" />
	    		</td>
	    		<td class="firstRow">统计机构:</td>
	    		<td class="secRow">
	    			<s:select name="deptGroup" list="deptGroups" listKey="key" listValue="value" headerKey="" headerValue="合并统计" />
	    		</td>
			</tr>
			<tr>
			<td colspan="4" class="buttonarea">
				<span id="message"><s:property value="message" /></span>
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<div class="tgroup">
	<div id="activePassesArea" class="tx">
	<table class="ilisttable ilisttablex" id="table_activePasses" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	 <tr>
		<th colspan="6">活动申请数量</th>
	  </tr>
	  <tr>
		<th>部门代码</th>
		<th>部门名称</th>
		<th>数量(个)</th>
	  </tr>
<s:iterator value="activePasses" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td>${apply_dept}</td>
	    <td>${dept_cname}</td>
		<td>${cout}</td>
	  </tr>
</s:iterator>
	</table>
	</div>

	<div id="activeAvgTimeArea" class="tx">
	<table class="ilisttable ilisttablex" id="table_activeAvgTime" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <tr>
		<th colspan="6">活动申请审核平均时间(天)</th>
	  </tr>
	  <tr>
		<th>总时间</th>
		<th>方案修改时间</th>
		<th>大区审核时间</th>
		<th>销管审核时间</th>
		<th>总监审核时间</th>
		<th>申请通过时间</th>
	  </tr>
	  <s:iterator value="activeAvgTime" status="sta">
	  <tr class="oddStyle">
	    <td>${total}</td>
	    <td>${edit}</td>
		<td>${mct}</td>
		<td>${xct}</td>
	    <td>${zct}</td>
		<td>${pct}</td>
	  </tr>
	  </s:iterator>
	</table>
	</div>
	</div>
	
	<div class="tgroup">
	<div id="activeClosePassesArea" class="tx">
	<table class="ilisttable ilisttablex" id="table_activeClosePasses" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	 <tr>
		<th colspan="6">活动结案数量</th>
	  </tr>
	  <tr>
		<th>部门代码</th>
		<th>部门名称</th>
		<th>数量(个)</th>
	  </tr>
<s:iterator value="activeClosePasses" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td>${apply_dept}</td>
	    <td>${dept_cname}</td>
		<td>${cout}</td>
	  </tr>
</s:iterator>
	</table>
	</div>
	
	<div id="activeCloseAvgTimeArea" class="tx">
	<table class="ilisttable ilisttablex" id="table_activeCloseAvgTime" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <tr>
		<th colspan="6">活动结案审核平均时间(天)</th>
	  </tr>
	  <tr>
		<th>总时间</th>
		<th>方案修改时间</th>
		<th>大区审核时间</th>
		<th>销管审核时间</th>
		<th>总监审核时间</th>
		<th>申请通过时间</th>
	  </tr>
	  <s:iterator value="activeCloseAvgTime" status="sta">
	  <tr class="oddStyle">
	    <td>${total}</td>
	    <td>${edit}</td>
		<td>${mct}</td>
		<td>${xct}</td>
	    <td>${zct}</td>
		<td>${pct}</td>
	  </tr>
	  </s:iterator>
	</table>
	</div>
	</div>
	
	<div class="tgroup">
	<div id="applyPassesArea" class="tx">
	<table class="ilisttable ilisttablex" id="table_applyPasses" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	 <tr>
		<th colspan="6">至事由通过数量</th>
	  </tr>
	  <tr>
		<th>部门代码</th>
		<th>部门名称</th>
		<th>数量(个)</th>
	  </tr>
<s:iterator value="applyPasses" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td>${apply_dept}</td>
	    <td>${dept_cname}</td>
		<td>${cout}</td>
	  </tr>
</s:iterator>
	</table>
	</div>
	
	<div id="applyAvgTimeArea" class="tx">
	<table class="ilisttable ilisttablex" id="table_applyAvgTime" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <tr>
		<th colspan="6">至事由审核平均时间(天)</th>
	  </tr>
	  <tr>
		<th>总时间</th>
		<th>方案修改时间</th>
		<th>大区审核时间</th>
		<th>总监审核时间</th>
	  </tr>
	  <s:iterator value="applyAvgTime" status="sta">
	  <tr class="oddStyle">
	    <td>${total}</td>
	    <td>${edit}</td>
		<td>${mct}</td>
	    <td>${zct}</td>
	  </tr>
	  </s:iterator>
	</table>
	</div>
	</div>
</s:form>
	</div>
</div>
</div>
</body>
</html>