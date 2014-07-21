<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工时管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-timepicker-addon.js" />"></script>
<body>
<!--  0出差 1请假 2加班 3换休 -->
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">
			<span class="message_error">
			<s:if test="leave.leave_type==0">出差</s:if>
			<s:if test="leave.leave_type==1">请假</s:if>
			<s:if test="leave.leave_type==2">加班</s:if>
			<s:if test="leave.leave_type==3">换休</s:if>
			</span>
			申请单
		</span>
		<span class="extra1">
			<a href="<s:url action="leave_relist" namespace="/adm" />" >申请单列表</a>
		</span>	
	</div>
<s:form name="form1" action="leave_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
	<s:hidden name="leave.leave_type" />
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'add'==viewFlag">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 申请编号:</td>
		<td class='secRow'><s:property value="leave.uuid" /><s:hidden name="leave.uuid" title="申请编号" /></td>
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
		</s:if>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 申请部门:</td>
		<td class='secRow' colspan="3">
			<s:textfield id="userdept_codeid" name="leave.leave_dept" readonly="true"  title="申请部门" require="required" dataLength="0,45" controlName="申请部门" />
			<s:textfield id="userdept_nameid" name="leave.leave_dept_name" readonly="true"  title="申请人" require="required" dataLength="0,45" controlName="申请人" />
			<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
			<span id="ajax_member_message"></span>
			<s:select id="membermanagerid" name="leave.leave_user" list="#{}" headerKey="" headerValue="--请选择--" />
		</td>
		</tr>
		<tr>
		<td class='firstRow'>开始时间:</td>
		<td class='secRow'>
			<s:textfield id="leave_leave_start" name="leave.leave_start" title="开始日期" value="" dataType="date" controlName="开始日期" cssClass="date_input" />
			<s:textfield id="leave_leave_start_time" name="leave.leave_start_time" title="开始时间" dataLength="0,15" controlName="开始时间" cssClass="time_input" />
			<script type="text/javascript">$('#leave_leave_start').datetimepicker({stepMinute: 15,altField: "#leave_leave_start_time"});</script>
		</td>
		<td class='firstRow'>结束时间:</td>
		<td class='secRow'>
			<s:textfield id="leave_leave_end" name="leave.leave_end" title="结束日期" value="" dataType="date" controlName="结束日期"  cssClass="date_input" />
			<s:textfield id="leave_leave_end_time" name="leave.leave_end_time" title="结束时间" dataLength="0,15" controlName="结束时间" cssClass="time_input" />
			<script type="text/javascript">$('#leave_leave_end').datetimepicker({stepMinute: 15,altField: "#leave_leave_end_time"});</script>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>共计:</td>
		<td class='secRow' colspan="3"><s:textfield name="leave.totle" title="共计" dataLength="0,10" dataType="number" controlName="共计"  cssClass="time_input" /> 天</td>
		</tr>
		<tr>
		<td class='firstRow'>事由:</td>
		<td class='secRow' colspan="3"><s:textarea name="leave.cause" rows="10" title="事由" dataLength="0,255" controlName="事由" cssStyle="width:80%;" /></td>
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
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_dept = '${leave.leave_dept}';
var curr_user = '${leave.leave_user}';
$(function(){
	if(curr_dept!='') {
		loadManagers(curr_dept);
	}
});

var sobj01;
var selectDept = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_nameid").val(val2);
		loadManagers(val1);
	};
	sobj01.create();
	sobj01.open();
};

function loadManagers(dept_code) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#membermanagerid").clearAllOption();
		$("#membermanagerid").addOption("--请选择--","");
		$.each(data, function(i, n){
			$("#membermanagerid").addOption(n.user_name,n.uuid);
		});
		if(curr_user!='') {
			$("#membermanagerid").val(curr_user);
		}
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}
</script>
</body>
</html>