<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
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
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
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
			<s:if test="leave.leave_type==4">补签</s:if>
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
		<s:if test="'mdy'==viewFlag">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 申请编号:</td>
		<td class='secRow'><s:property value="leave.uuid" /><s:hidden name="leave.uuid" title="申请编号" /></td>
		<td class='firstRow'>当前状态:</td>
		<td class='secRow'>
			<span class="span_label">
			业务:
			<s:if test="leave.check_status==0">新申请</s:if>
			<s:if test="leave.check_status==5"><span class="message_error">已退回(${leave.check_user_name})</span></s:if>
			<s:if test="leave.check_status==10"><span class="message_warning">待审核</span></s:if>
			<s:if test="leave.check_status==20"><span class="message_pass">经理/大区已审(${leave.check_user_name})</span></s:if>
			<s:if test="leave.check_status==30"><span class="message_pass">运营总监已审(${leave.check_user_name})</span></s:if>
			<s:if test="leave.check_status==40"><span class="message_pass">业务副总已审(${leave.check_user_name})</span></s:if>
			</span>
			<span class="span_label">
			人事:
			<s:if test="leave.check_status==5"><span class="message_error">已退回</span></s:if>
			<s:elseif test="leave.acheck_status==0">未审核</s:elseif>
			<s:if test="leave.acheck_status==10"><span class="message_pass">人事经理已审(${leave.acheck_user_name})</span></s:if>
			<s:if test="leave.acheck_status==20"><span class="message_pass">行政副总已审(${leave.acheck_user_name})</span></s:if>
			<s:if test="leave.acheck_status==30"><span class="message_pass">总经理已审(${leave.acheck_user_name})</span></s:if>
			</span>
		</td>
		</tr>
		<!-- 
		<tr>
		<td class='firstRow'>已补贴:</td>
		<td class='secRow'><s:property value="leave.allowance_status" /></td>
		</tr>
		<tr>
		<td class='firstRow'>补贴时间:</td>
		<td class='secRow'><s:date name="leave.allowance_date" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		 -->
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
			<input id="leave_leave_start" type="text" name="leave.leave_start" title="开始日期" value="${it:formatDate(leave.leave_start,'yyyy-MM-dd')}" dataType="date" controlName="开始日期" />
			<s:textfield id="leave_leave_start_time" name="leave.leave_start_time" title="开始时间" dataLength="0,15" controlName="开始时间" cssClass="time_input" />
			
			<span class="message_prompt nowrap">如果是一整天,时间请选00:00</span>
		</td>
		<td class='firstRow'>结束时间:</td>
		<td class='secRow'>
			<input id="leave_leave_end" type="text" name="leave.leave_end" title="结束日期" value="${it:formatDate(leave.leave_end,'yyyy-MM-dd')}" dataType="date" controlName="结束日期" />
			<s:textfield id="leave_leave_end_time" name="leave.leave_end_time" title="结束时间" dataLength="0,15" controlName="结束时间" cssClass="time_input" />
			<span class="message_prompt nowrap">如果是一整天,时间请选00:00</span>
		</td>
		</tr>
		<!-- 补签单没有共计 -->
		<s:if test="leave.leave_type!=4">
		<tr>
		<td class='firstRow'>共计:</td>
		<td class='secRow'><s:textfield name="leave.totle" title="共计" dataLength="0,10" dataType="number" controlName="共计"  cssClass="time_input" /> 天</td>
		<s:if test="leave.leave_type==1">
		<td class='firstRow'><span style="color:red;">*</span> 请假类型:</td>
		<td class='secRow'>
			<s:select name="leave.leave_mold" list="#{'0':'年假','1':'病假','2':'事假','3':'婚假','4':'产假','5':'丧假','6':'陪产假','7':'其他' }"
			headerKey="" headerValue="--请选择--"
			 require="required"  controlName="请假类型" />
		</td>
		</s:if>
		<s:elseif test="leave.leave_type==0">
		<td class='firstRow'><span style="color:red;">*</span> 出差地点:</td>
		<td class='secRow'>
			<s:textfield name="leave.leave_mold" require="required"  controlName="出差地点" />
		</td>
		</s:elseif>
		<s:else>
		<td class='firstRow'></td>
		<td class='secRow'></td>
		</s:else>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'>事由:</td>
		<td class='secRow' colspan="3">
			<s:if test="leave.check_status>=10">
			${leave.cause}
			</s:if>
			<s:else>
			<s:textarea id="leave_cause" name="leave.cause" rows="10" title="事由" dataLength="0,65535" controlName="事由" />
			</s:else>
		</td>
		</tr>
		<s:if test="leave.check_status>=10">
		<tr>
		<td class='firstRow'>审核意见:</td>
		<td class='secRow' colspan="3"><s:textarea name="leave.check_note"  rows="5" title="审核意见" dataLength="0,65535" controlName="审核意见" cssStyle="width:80%;" /></td>
		</tr>
		</s:if>
		<tr>
			<td class='firstRow'>相关操作:</td>
		    <td class='secRow' colspan="3">
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ADD')">
					<s:submit id="add" name="add" value="确定" action="leave_add" />
					</s:if>
				</s:if>
				<s:elseif test="leave.check_status<10 && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_MDY')">
					<s:submit id="save" name="save" value="保存" action="leave_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK0')">
					<s:submit id="check0" name="check0" value="报审" action="leave_check0"  onclick="return isOp('确定执行此操作?');" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="leave_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<!-- {0:'新申请',5:'已退回',10:'待审核',20:'经理/大区已审',30:'运营总监已审',40:'业务副总已审' } -->
				<s:if test="leave.check_status==10&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK10')">
					<s:submit id="leave_check10" name="leave_check10" value="经理/大区-审核通过" action="leave_check10" onclick="return isOp('确定执行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
						<s:submit name="leave_check5" value="经理/大区-审核不通过" action="leave_check5" onclick="return isOp('确定执行此操作?');" />
					</s:if>
				</s:if>
				<s:if test="leave.check_status==20&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK20')">
					<s:submit id="leave_check20" name="leave_check20" value="总监-审核通过" action="leave_check20" onclick="return isOp('确定执行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
						<s:submit name="leave_check5" value="总监-审核不通过" action="leave_check5" onclick="return isOp('确定执行此操作?');" />
					</s:if>
				</s:if>
				<s:if test="leave.check_status==30&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK30')">
					<s:submit id="leave_check30" name="leave_check30" value="业务副总-审核通过" action="leave_check30" onclick="return isOp('确定执行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
						<s:submit name="leave_check5" value="业务副总-审核不通过" action="leave_check5" onclick="return isOp('确定执行此操作?');" />
					</s:if>
				</s:if>
				<!-- {0:'未审核',10:'人事经理已审',20:'人事副总已审',30:'总经理已审' } -->
				<s:if test="leave.check_status>=20">
					<s:if test="leave.acheck_status==0&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ACHECK0')">
						<s:submit id="leave_acheck0" name="leave_acheck0" value="人事经理-审核通过" action="leave_acheck0" onclick="return isOp('确定执行此操作?');" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
							<s:submit name="leave_check5" value="人事经理-审核不通过" action="leave_check5" onclick="return isOp('确定执行此操作?');" />
						</s:if>
					</s:if>
					<s:if test="leave.acheck_status==10&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ACHECK10')">
						<s:submit id="leave_acheck10" name="leave_acheck10" value="行政副总-审核通过" action="leave_acheck10" onclick="return isOp('确定执行此操作?');" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
							<s:submit name="leave_check5" value="行政副总-审核不通过" action="leave_check5" onclick="return isOp('确定执行此操作?');" />
						</s:if>
					</s:if>
					<s:if test="leave.acheck_status==20&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ACHECK20')">
						<s:submit id="leave_acheck20" name="leave_acheck20" value="总经理-审核通过" action="leave_acheck20" onclick="return isOp('确定执行此操作?');" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
							<s:submit name="leave_check5" value="总经理-审核不通过" action="leave_check5" onclick="return isOp('确定执行此操作?');" />
						</s:if>
					</s:if>
				</s:if>
				<s:if test="leave.check_status>=10&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5X')">
					<s:submit name="leave_check5" value="直接退回" action="leave_check5" onclick="return isOp('确定执行此操作?');" />
				</s:if>
				<input type="button" value="返回" onclick="linkurl('<s:url action="leave_relist" namespace="/adm" />');" />
				<span id="message"><s:property value="message" /></span>
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
var infoeditor01;
$(function(){
	if($("#leave_cause").length>0) {
		infoeditor01 = new widget_textarea();
		infoeditor01.init("leave_cause");
	}
	if(curr_dept!='') {
		loadManagers(curr_dept);
	}
	$('#leave_leave_end').datetimepicker({<s:if test="leave.leave_type!=4">stepMinute: 15,</s:if>altField: "#leave_leave_end_time"});
	$('#leave_leave_start').datetimepicker({<s:if test="leave.leave_type!=4">stepMinute: 15,</s:if>altField: "#leave_leave_start_time"});
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