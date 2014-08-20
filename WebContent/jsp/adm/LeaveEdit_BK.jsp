<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请假单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == leave && 'add' == viewFlag">增加</s:if><s:elseif test="null != leave && 'mdy' == viewFlag">修改</s:elseif>请假单</span>
		<span class="extra1">
			<a href="<s:url action="leave_list" namespace="/adm" />" >请假单列表</a>
		</span>	
	</div>
<s:form name="form1" action="leave_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != leave">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键自增:</td>
<td class='secRow'><s:property value="leave.uuid" /><s:hidden name="leave.uuid" title="主键自增" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 类型 0出差 1请假 2加班 3换休:</td>
<td class='secRow'><s:property value="leave.leave_type" /><s:hidden name="leave.leave_type" title="类型 0出差 1请假 2加班 3换休" /></td>
</tr>
<tr>
<td class='firstRow'>审核状态:</td>
<td class='secRow'><s:property value="leave.check_status" /></td>
</tr>
<tr>
<td class='firstRow'>审核人:</td>
<td class='secRow'><s:property value="leave.check_user" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核状态:</td>
<td class='secRow'><s:property value="leave.acheck_status" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核人:</td>
<td class='secRow'><s:property value="leave.acheck_user" /></td>
</tr>
<tr>
<td class='firstRow'>最后修改时间:</td>
<td class='secRow'><s:date name="leave.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>最后修改人:</td>
<td class='secRow'><s:property value="leave.lm_user" /></td>
</tr>
<tr>
<td class='firstRow'>已补贴:</td>
<td class='secRow'><s:property value="leave.allowance_status" /></td>
</tr>
<tr>
<td class='firstRow'>补贴时间:</td>
<td class='secRow'><s:date name="leave.allowance_date" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 申请部门:</td>
<td class='secRow'><s:textfield name="leave.leave_dept" title="申请部门" require="required" dataLength="0,45" controlName="申请部门" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 申请人:</td>
<td class='secRow'><s:textfield name="leave.leave_user" title="申请人" require="required" dataLength="0,45" controlName="申请人" /></td>
</tr>
<tr>
<td class='firstRow'>开始日期:</td>
<td class='secRow'><s:textfield name="leave.leave_start" title="开始日期" value="%{getText('global.date',{leave.leave_start})=='null'?'':getText('global.date',{leave.leave_start})}" dataType="date" controlName="开始日期" /></td>
</tr>
<tr>
<td class='firstRow'>开始时间:</td>
<td class='secRow'><s:textfield name="leave.leave_start_time" title="开始时间" dataLength="0,15" controlName="开始时间" /></td>
</tr>
<tr>
<td class='firstRow'>结束日期:</td>
<td class='secRow'><s:textfield name="leave.leave_end" title="结束日期" value="%{getText('global.date',{leave.leave_end})=='null'?'':getText('global.date',{leave.leave_end})}" dataType="date" controlName="结束日期" /></td>
</tr>
<tr>
<td class='firstRow'>结束时间:</td>
<td class='secRow'><s:textfield name="leave.leave_end_time" title="结束时间" dataLength="0,15" controlName="结束时间" /></td>
</tr>
<tr>
<td class='firstRow'>共计:</td>
<td class='secRow'><s:textfield name="leave.totle" title="共计" dataLength="0,10" dataType="number" controlName="共计" /></td>
</tr>
<tr>
<td class='firstRow'>事由:</td>
<td class='secRow'><s:textfield name="leave.cause" title="事由" dataLength="0,255" controlName="事由" /></td>
</tr>
<tr>
<td class='firstRow'>审核时间:</td>
<td class='secRow'><s:textfield name="leave.check_time" title="审核时间" value="%{getText('global.date',{leave.check_time})=='null'?'':getText('global.date',{leave.check_time})}" dataType="date" controlName="审核时间" /></td>
</tr>
<tr>
<td class='firstRow'>审核意见:</td>
<td class='secRow'><s:textfield name="leave.check_note" title="审核意见" dataLength="0,65535" controlName="审核意见" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核时间:</td>
<td class='secRow'><s:textfield name="leave.acheck_time" title="行政审核时间" value="%{getText('global.date',{leave.acheck_time})=='null'?'':getText('global.date',{leave.acheck_time})}" dataType="date" controlName="行政审核时间" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核意见:</td>
<td class='secRow'><s:textfield name="leave.acheck_note" title="行政审核意见" dataLength="0,65535" controlName="行政审核意见" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == leave && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ADD')">
					<s:submit id="add" name="add" value="确定" action="leave_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != leave && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_MDY')">
					<s:submit id="save" name="save" value="保存" action="leave_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="leave_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="leave_relist" namespace="/adm" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>