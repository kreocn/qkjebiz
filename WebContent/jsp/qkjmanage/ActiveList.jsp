<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动申请单列表--<s:text name="APP_NAME" /></title>
</head>
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
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_apply_dept = '${active.apply_dept}';
var curr_apply_user = '${active.apply_user}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	if(curr_apply_dept!='') {
		loadManagers(curr_apply_dept);
	}
	if($("#ship_pass_alert_info").length>0) {
		$("#ship_pass_alert_info").bind("click",function(){
			alert($(this).attr("title"));
		});
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
		if(curr_apply_user!='') {
			$("#membermanagerid").val(curr_apply_user);
		}
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}
</script>
<style type="text/css">
#ship_pass_alert_info {
cursor: pointer;
}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">活动申请单列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="active_load"><s:param name="viewFlag">add</s:param></s:url>" >添加活动申请单</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="active_list"  method="get" namespace="/qkjmanage" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow3'>申请编号:</td>
			<td class='secRow3'><s:textfield name="active.uuid" title="申请编号" /></td>
			<td class='firstRow3'>主题(%):</td>
			<td class='secRow3'><s:textfield name="active.theme" title="主题" /></td>
			<td class='secRow3' colspan="2">
			
			</td>
			</tr><tr>
			<td class='firstRow3'>活动状态:</td>
			<td class='secRow3'>
				<s:select name="active.status"
				 list="#{0:'新申请',1:'申请审批中',2:'申请通过',3:'开始结案',4:'结案审批中',5:'结案通过'}"
				 headerKey="" headerValue="---请选择---" />
			</td>
			<td class='firstRow3'>申请部门/办事处:</td>
			<td class='secRow3' colspan="3">
			<s:textfield title="部门" id="userdept_codeid" name="active.apply_dept" readonly="true" />
			<s:textfield title="部门名称" id="userdept_nameid" name="active.apply_dept_name" readonly="true" />
			<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
			<s:checkbox id="active_is_sub_dept" name="active.is_sub_dept" />
			<label for="active_is_sub_dept">包含子部门</label>
			<span id="ajax_member_message"></span>
			<s:select id="membermanagerid" name="active.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
			</td>
			</tr><tr>
			<td class='firstRow3'>销售(申)-状态:</td>
			<td class='secRow3'>
				<s:select name="active.sd_status"
				 list="#{0:'新单',5:'退回',10:'待审核',30:'大区经理已审',40:'运营总监已审',50:'业务副总已审',60:'总经理已审'}"
				 headerKey="" headerValue="---请选择---" />
			</td>
			<td class='firstRow3'>销售(结)-状态:</td>
			<td class='secRow3'>
				<s:select name="active.close_sd_status"
				 list="#{0:'新单',5:'退回',10:'待审核',30:'大区经理已审',40:'运营总监已审',50:'业务副总已审',60:'总经理已审'}"
				 headerKey="" headerValue="---请选择---" />
			</td>
			<td class='secRow3' colspan="2"></td>
			</tr>
			<tr>
			<td class='firstRow3'>销管(申)-状态:</td>
			<td class='secRow3'>
				<s:select name="active.smd_status"
				 list="#{0:'新单/未签收',5:'退回',10:'已签收',30:'销管经理已审',50:'销管副总已审'}"
				 headerKey="" headerValue="---请选择---" />
			</td>
			<td class='firstRow3'>销管(结)-状态:</td>
			<td class='secRow3'>
				<s:select name="active.close_smd_status"
				 list="#{0:'新单/未签收',5:'退回',10:'已签收',30:'销管经理已审',50:'销管副总已审'}"
				 headerKey="" headerValue="---请选择---" />
			</td>
			<td class='buttonarea' colspan="2"><s:submit value="搜索" /><s:reset value="重置" /></td>
			</tr>
			<tr>
			<td class='firstRow3'>申请通过时间:</td>
			<td class='secRow3'>
			从:
			<input id="active_pass_time_start" type="text" name="active.pass_time_start" title="从" value="${it:formatDate(active.pass_time_start,'yyyy-MM-dd')}" />
			<script type="text/javascript">$("#active_pass_time_start").datepicker();</script>
			<br />
			到:
			<input id="active_pass_time_end" type="text" name="active.pass_time_end" title="到" value="${it:formatDate(active.pass_time_end,'yyyy-MM-dd')}" />
			<script type="text/javascript">$("#active_pass_time_end").datepicker();</script>
			</td>
			<td class='firstRow3'>结案通过时间:</td>
			<td class='secRow3'>
			从:
			<input id="active_close_pass_time_start" type="text" name="active.close_pass_time_start" title="从" value="${it:formatDate(active.close_pass_time_start,'yyyy-MM-dd')}" />
			<script type="text/javascript">$("#active_close_pass_time_start").datepicker();</script>
			<br />
			到:
			<input id="active_close_pass_time_end" type="text" name="active.close_pass_time_end" title="到" value="${it:formatDate(active.close_pass_time_end,'yyyy-MM-dd')}" />
			<script type="text/javascript">$("#active_close_pass_time_end").datepicker();</script>
			</td>
			<td class='firstRow3'>计划开始时间:</td>
			<td class='secRow3'>
			从:
			<input id="active_plan_start_begin" type="text" name="active.plan_start_begin" title="从" value="${it:formatDate(active.plan_start_begin,'yyyy-MM-dd')}" />
			<script type="text/javascript">$("#active_plan_start_begin").datepicker();</script>
			<br />
			到:
			<input id="active_plan_start_end" type="text" name="active.plan_start_end" title="到" value="${it:formatDate(active.plan_start_end,'yyyy-MM-dd')}" />
			<script type="text/javascript">$("#active_plan_start_end").datepicker();</script>
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>申请编号</th>
		<th>申请部门</th>
		<th>申请人</th>
		<th>主题</th>
		<th>活动地点</th>
		<th>状态</th>
		<th>操作</th>
	  </tr>
<s:iterator value="actives" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td>${uuid}</td>
		<td class="nowrap">${apply_dept_name}</td>
		<td class="nowrap">${apply_user_name}</td>
		<td title="${theme}">${it:subString(theme,22)}</td>
		<td title="${address}" class="nowrap">${it:subString(address,6)}</td>
		<td class="nowrap" align="center">
			<span class="span_label">
			<s:if test="status==0">新申请</s:if>
			<s:if test="status==1"><font class="message_warning">申请审批中</font></s:if>
			<s:if test="status==2"><font class="message_pass" title="${it:formatDate(pass_time,'yyyy-MM-dd HH:mm:ss')}">申请通过</font></s:if>
			<s:if test="status==3">开始结案</s:if>
			<s:if test="status==4"><font class="message_warning">结案审批中</font></s:if>
			<s:if test="status==5"><font class="message_pass" title="${it:formatDate(close_pass_time,'yyyy-MM-dd HH:mm:ss')}">结案通过</font></s:if>
			</span>
			<s:if test="status<=2">
			<span class="span_label">
			销售(申):
			<s:if test="sd_status==0">新单</s:if>
			<s:if test="sd_status==5"><font class="message_error" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
			<s:if test="sd_status==10"><font class="message_warning">待审核</font></s:if>
			<s:if test="sd_status==30"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">大区经理已审</font></s:if>
			<s:if test="sd_status==40"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已审</font></s:if>
			<s:if test="sd_status==50"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">业务副总已审</font></s:if>
			<s:if test="sd_status==60"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审</font></s:if>
			</span>
			<span class="span_label">
				销管(申):
				<s:if test="smd_status==0">未签收</s:if>
				<s:if test="smd_status==5"><font class="message_error" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
				<s:if test="smd_status==10"><font class="message_warning">已签收</font></s:if>
				<s:if test="smd_status==30"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审</font></s:if>
				<s:if test="smd_status==50"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审</font></s:if>
			</span>
			</s:if>
			<s:if test="status>2 && status<5">
			<span class="span_label">
			销售(结):
			<s:if test="close_sd_status==0">新单</s:if>
			<s:if test="close_sd_status==5"><font class="message_error" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
			<s:if test="close_sd_status==10"><font class="message_warning">待审核</font></s:if>
			<s:if test="close_sd_status==30"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">大区经理已审</font></s:if>
			<s:if test="close_sd_status==40"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已审</font></s:if>
			<s:if test="close_sd_status==50"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">业务副总已审</font></s:if>
			<s:if test="close_sd_status==60"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审</font></s:if>
			</span>
			<span class="span_label">
			销管(结):
			<s:if test="close_smd_status==0">新单</s:if>
			<s:if test="close_smd_status==5"><font class="message_error" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
			<s:if test="close_smd_status==10"><font class="message_warning">已签收</font></s:if>
			<s:if test="close_smd_status==30"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审</font></s:if>
			<s:if test="close_smd_status==50"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审</font></s:if>
			</span>
			</s:if>
			<s:if test="status==5">
			<span class="span_label">
			<s:if test="ship_status==0"><font class="message_error">未发货</font></s:if>
			<s:if test="ship_status==10"><font id="ship_pass_alert_info" class="message_pass" title="发货时间:${it:formatDate(ship_date,'yyyy-MM-dd')}|运单号:${ship_no}|物流公司:${ship_type}|物流电话:${ship_phone}">已发货</font></s:if>
			</span>
			</s:if>
		</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_APPLY')">
			<s:if test="status < 2">
	    	<span class="nowrap">[<a href="<s:url namespace="/qkjmanage" action="active_load"><s:param name="viewFlag">mdy</s:param><s:param name="active.uuid" value="uuid"></s:param></s:url>">申请单修改</a>]</span>
	    	</s:if>
	    	<s:else>
	    	<span class="nowrap">[<a href="<s:url namespace="/qkjmanage" action="active_view"><s:param name="active.uuid" value="uuid" /></s:url>">申请单查看</a>]</span>
	    	</s:else>
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE')">
	    	<s:if test="status == 2">
	    	<span class="nowrap">[<a href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="uuid"></s:param></s:url>">开始结案</a>]</span>
	    	</s:if>
	    	<s:if test="status > 2 && status < 5">
	    	<span class="nowrap">[<a href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="uuid"></s:param></s:url>">结案单修改</a>]</span>
	    	</s:if>
	    	<s:if test="status >= 4">
	    	<span class="nowrap">[<a href="<s:url namespace="/qkjmanage" action="active_closeView"><s:param name="active.uuid" value="uuid"></s:param></s:url>">结案单查看</a>]</span>
	    	</s:if>
	    	</s:if>
	    	<s:if test="status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_DEL')">
	    	<span class="nowrap">[<a href="<s:url namespace="/qkjmanage" action="active_del"><s:param name="active.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]</span>
	    	</s:if>	   
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
		</script>
		</td>	    
	  </tr>
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