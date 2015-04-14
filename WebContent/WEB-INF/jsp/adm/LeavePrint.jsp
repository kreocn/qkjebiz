<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>换休申请单</title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="stylesheet" href="<s:url value="/css/table-check.css" />" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main"><div id="result"><div class="itablemdy">
<div class="printarea buttonarea">
	<input type="button" value="打印本页" onclick="window.print();" />
	<input type="button" value="返回" onclick="location.href='<s:url action="leave_relist" namespace="/adm" />';" />
</div>
<s:if test="leave.leave_type==0">
<!-- 出差申请单 -->
<div class="table_title">出差申请单</div>
<div class="table_title2">制表日期：<span class="date_area">${it:formatDate(leave.leave_time,'yyyy-MM-dd')}</span></div>
<table class="iprint-table"cellspacing="0" cellpadding="0">
	<tr height="30">
		<td class="centerRow" width="20%">部门</td>
		<td>${leave.leave_dept_name}</td>
		<td class="firstRow" width="20%">姓名</td>
		<td>${leave.leave_user_name}</td>
	</tr>
	<tr height="30">
		<td class="firstRow">出差时间</td>
		<td colspan="3">从 ${it:formatDate(leave.leave_start,'yyyy-MM-dd')} 至 ${it:formatDate(leave.leave_end,'yyyy-MM-dd')} 共计 ${leave.totle} 天。</td>
	</tr>
	<tr height="30">
		<td class="firstRow">出差地点</td>
		<td colspan="3">${leave.leave_mold}</td>
	</tr>
	<tr height="30">
		<td class="firstRow">同行人员</td>
		<td colspan="3">${leave.peer}</td>
	</tr>
	<tr height="130">
		<td class="firstRow">出差事由</td>
		<td colspan="3" style="text-align: left;">${leave.cause}</td>
	</tr>
	<tr height="110">
		<td>部门负责人<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==30">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>分管副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==40">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>人力资源部<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==10">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>行政管理副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==20">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:	
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==30">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr>
		<td colspan="4" class="note al">
			<div class="ib">备注：1、主管级以下人员出差由人力资源部经理审批；</div>
			<div class="ib ib2">2、经理级人员出差由人力资源主管副总经理审批。</div>
			<div class="ib ib2">3、副总级出差由总经理审批。</div>
		</td>
	</tr>
</table>
</s:if>
<s:if test="leave.leave_type==1">
<!-- 请假申请单 -->
<div class="table_title">请假申请单</div>
<div class="table_title2">制表日期：<span class="date_area">${it:formatDate(leave.leave_time,'yyyy-MM-dd')}</span></div>
<table class="iprint-table"cellspacing="0" cellpadding="0">
	<tr height="30">
		<td class="centerRow" width="20%">部门</td>
		<td>${leave.leave_dept_name}</td>
		<td class="firstRow" width="20%">姓名</td>
		<td>${leave.leave_user_name}</td>
	</tr>
	<tr height="30">
		<td class="firstRow">请假时间</td>
		<td colspan="3">从 ${it:formatDate(leave.leave_start,'yyyy-MM-dd')} ${leave.leave_start_time} 至 ${it:formatDate(leave.leave_end,'yyyy-MM-dd')} ${leave.leave_end_time} 共计 ${leave.totle} 天。</td>
	</tr>
	<tr height="30">
		<td class="firstRow">请假类型</td>
		<td colspan="3">
			<s:if test="leave.leave_mold==0">年假</s:if>
			<s:if test="leave.leave_mold==1">病假</s:if>
			<s:if test="leave.leave_mold==2">事假</s:if>
			<s:if test="leave.leave_mold==3">婚假</s:if>
			<s:if test="leave.leave_mold==4">产假</s:if>
			<s:if test="leave.leave_mold==5">丧假</s:if>
			<s:if test="leave.leave_mold==6">陪产假</s:if>
			<s:if test="leave.leave_mold==7">其他</s:if>
		</td>
	</tr>
	<tr height="130">
		<td class="firstRow">请假事由</td>
		<td colspan="3" style="text-align: left;">${leave.cause}</td>
	</tr>
	<tr height="110">
		<td>部门负责人<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==30">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>分管副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==40">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>人力资源部<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==10">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>行政管理副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==20">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==30">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr>
		<td colspan="4" class="note al">
			<div class="ib">备注：1、主管级以下员工请假3天以内由人力资源部经理审批；</div>
			<div class="ib ib2">2、经理级请假或员工请假4-10天由人力资源主管副总经理审批。</div>
			<div class="ib ib2">3、副总级请假或员工请假10天以上由总经理审批。</div>
		</td>
	</tr>
</table>
</s:if>
<s:if test="leave.leave_type==2">
<!-- 加班申请单 -->
<div class="table_title">加班申请单</div>
<div class="table_title2">制表日期：<span class="date_area">${it:formatDate(leave.leave_time,'yyyy-MM-dd')}</span></div>
<table class="iprint-table"cellspacing="0" cellpadding="0">
	<tr height="30">
		<td class="centerRow" width="20%">部门</td>
		<td>${leave.leave_dept_name}</td>
		<td class="firstRow" width="20%">姓名</td>
		<td>${leave.leave_user_name}</td>
	</tr>
	<tr height="30">
		<td class="firstRow">加班时间</td>
		<td colspan="3">从 ${it:formatDate(leave.leave_start,'yyyy-MM-dd')} ${leave.leave_start_time} 至 ${it:formatDate(leave.leave_end,'yyyy-MM-dd')} ${leave.leave_end_time } 共计 ${leave.totle} 天。</td>
	</tr>
	<tr height="130">
		<td class="firstRow">加班事由</td>
		<td colspan="3" style="text-align: left;">${leave.cause}</td>
	</tr>
	<tr height="110">
		<td>部门负责人<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==30">
				<span class="sh">${leave.check_note}</span>
				<span class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>分管副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==40">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>人力资源部<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==10">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>行政管理副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==20">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="110">
		<td>总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==30">
				<span class="sh">${leave.acheck_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr>
		<td colspan="4" class="note al">
			<div class="ib">备注：1、主管级以下员工请假3天以内由人力资源部经理审批；</div>
			<div class="ib ib2">2、经理级请假或员工请假4-10天由人力资源主管副总经理审批。</div>
			<div class="ib ib2">3、副总级请假或员工请假10天以上由总经理审批。</div>
		</td>
	</tr>
</table>
</s:if>
<s:if test="leave.leave_type==3">
<!-- 换休申请单 -->
<div class="table_title">换休申请单</div>
<div class="table_title2">制表日期：<span class="date_area">${it:formatDate(leave.leave_time,'yyyy-MM-dd')}</span></div>
<table class="iprint-table"cellspacing="0" cellpadding="0">
	<tr height="30">
		<td class="centerRow" width="20%">部门</td>
		<td>${leave.leave_dept_name}</td>
		<td class="firstRow" width="20%">姓名</td>
		<td>${leave.leave_user_name}</td>
	</tr>
	<tr height="60">
		<td class="firstRow">换休时间</td>
		<td colspan="3">从 ${it:formatDate(leave.leave_start,'yyyy-MM-dd')} 至 ${it:formatDate(leave.leave_end,'yyyy-MM-dd')} 共计 ${leave.totle} 天。</td>
	</tr>
	<tr height="130">
		<td>部门负责人<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==30">
				<span class="sh">${leave.check_note}</span>
				<span class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="130">
		<td>分管副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==40">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="130">
		<td>人力资源部<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==10">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="130">
		<td>行政管理副总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==20">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="130">
		<td>总经理<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==30">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
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
<s:if test="leave.leave_type==4">
<!-- 补签申请单 -->
<div class="table_title">补签(到/退)申请单</div>
<div class="table_title2">制表日期：<span class="date_area">${it:formatDate(leave.leave_time,'yyyy-MM-dd')}</span></div>
<table class="iprint-table"cellspacing="0" cellpadding="0">
	<tr height="30">
		<td class="centerRow" width="20%">部门</td>
		<td>${leave.leave_dept_name}</td>
		<td class="firstRow" width="20%">姓名</td>
		<td>${leave.leave_user_name}</td>
	</tr>
	<tr height="60">
		<td class="firstRow">补签时间</td>
		<td colspan="3">从 ${it:formatDate(leave.leave_start,'yyyy-MM-dd')} ${leave.leave_start_time} 至 ${it:formatDate(leave.leave_end,'yyyy-MM-dd')} ${leave.leave_end_time}</td>
	</tr>
	<tr height="130">
		<td class="firstRow">补签事由</td>
		<td colspan="3" style="text-align: left;">${leave.cause}</td>
	</tr>
	<tr height="130">
		<td>部门负责人<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.check_status==30">
				<span class="sh">${leave.check_note}</span>
				<span class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.check_user_sign==null">
				<span class="uname">${leave.check_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.check_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.check_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:			
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
	<tr height="130">
		<td>人力资源部<br />意见</td>
		<td colspan="3" class="sign_tr">
			<s:if test="leave.acheck_status==10">
				<span class="sh">${leave.check_note}</span>
				<span  class="st">	签字:			
				<span class="sign_area">
				<s:if test="leave.acheck_user_sign==null">
				<span class="uname">${leave.acheck_user_name}</span>
				</s:if>
				<s:else>
				<span class="user_sign">
				<img alt="" src="${leave.acheck_user_sign}" />
				</span>
				</s:else>
				</span>
				 日期：<span class="date_area">${it:formatDate(leave.acheck_time,'yyyy-MM-dd')}</span>
				 </span>
			</s:if>
			<s:else>
				<span class="sh"></span>
				<span  class="st">	签字:	
				<span class="sign_area">
				</span>
				 日期：<span class="date_area"></span>
				 </span>
			</s:else>
		</td>
	</tr>
</table>
</s:if>
<div class="printarea buttonarea">
	<input type="button" value="打印本页" onclick="window.print();" />
	<input type="button" value="返回" onclick="location.href='<s:url action="leave_relist" namespace="/adm" />';" />
</div>
</div></div></div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>