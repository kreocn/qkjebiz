<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>换休申请单</title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="stylesheet" href="<s:url value="/css/table-check.css" />" />
</head>
<body>
<div id="main"><div id="result"><div class="itablemdy">
<s:if test="leave.leave_type==0">
<!-- 出差申请单 -->
<div class="table_title">出差申请单</div>
<div class="table_title2">制表日期：<span class="date_area">2014-01-01</span></div>
<table class="iprint-table"cellspacing="0" cellpadding="0">
	<tr height="30">
		<td class="centerRow" width="20%">部门</td>
		<td></td>
		<td class="firstRow" width="20%">姓名</td>
		<td></td>
	</tr>
	<tr height="60">
		<td class="firstRow">出差时间</td>
		<td colspan="4">从 ${it:formatDate(leave.leave_start,'yyyy-MM-dd')} 至 ${it:formatDate(leave.leave_end,'yyyy-MM-dd')} 共计 ${leave.total} 天。</td>
	</tr>
	<tr height="130">
		<td>部门负责<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh">${leave.check_note}</span>
		<span  class="st">	签字:
			<span class="sign_area"><img alt="" src="http://qkjchina.com/ckframe/userfiles/images/WebImages/qkjmanager/sign/suihua.jpg" width="100"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>分管副总经理<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">	签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>人力资源部<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">	签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>行政管理副总经理<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>总经理<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr>
		<td colspan="4" class="note al">
			<div class="ib">备注：1、《换休单》由人力资源部签发，凡未经人力资源部签发的《换休单》一律无效</div>
			<div class="ib ib2">2、换休时凭《换休单》提前一天告知主管领导，经主管领导同意后方可换休，并将《换休单》交回人力资源部给予考勤处理；</div>
			<div class="ib ib2">3、每月换休不能超过5天，签发的《换休单》在一年内有效，过期作废。</div>
		</td>
	</tr>
</table>
</s:if>
<s:if test="leave.leave_type==1">请假</s:if>
<s:if test="leave.leave_type==2">加班</s:if>
<s:if test="leave.leave_type==3">
<!-- 换休申请单 -->
<div class="table_title">换休申请单</div>
<div class="table_title2">制表日期：<span class="date_area">2014-01-01</span></div>
<table class="iprint-table"cellspacing="0" cellpadding="0">
	<tr height="30">
		<td class="centerRow" width="20%">部门</td>
		<td></td>
		<td class="firstRow" width="20%">姓名</td>
		<td></td>
	</tr>
	<tr height="60">
		<td class="firstRow">换休时间</td>
		<td colspan="4">从 2014-01-01 至 2014-02-01 共计 29 天。</td>
	</tr>
	<tr height="130">
		<td>部门负责<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">	签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area"></span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>分管副总经理<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">	签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>人力资源部<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">	签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>行政管理副总经理<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr height="130">
		<td>总经理<br />意见</td>
		<td colspan="4" class="sign_tr">
		<span class="sh"></span>
		<span  class="st">签字:
			<span class="sign_area"></span>
			 日期：<span class="date_area">2014-01-01</span>
		</span>
		</td>
	</tr>
	<tr>
		<td colspan="4" class="note al">
			<div class="ib">备注：1、《换休单》由人力资源部签发，凡未经人力资源部签发的《换休单》一律无效</div>
			<div class="ib ib2">2、换休时凭《换休单》提前一天告知主管领导，经主管领导同意后方可换休，并将《换休单》交回人力资源部给予考勤处理；</div>
			<div class="ib ib2">3、每月换休不能超过5天，签发的《换休单》在一年内有效，过期作废。</div>
		</td>
	</tr>
</table>
</s:if>
</div></div></div>
</body>
</html>