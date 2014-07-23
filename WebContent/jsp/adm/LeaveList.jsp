<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请假单列表--<s:text name="APP_NAME" /></title>
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
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">申请单列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ADD')">
			<a href="javascript:;" id="AddLeaveLink">添加申请单</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="leave_list"  method="get" namespace="/adm" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow3'>编号:</td>
			<td class='secRow3'><s:textfield name="leave.uuid" title="主键自增" /></td>
			<td class='firstRow3'>类型:</td>
			<td class='secRow3'>
				<s:select id="searchLeaveType" name="leave.leave_type" title="类型"
						list="#{0:'出差',1:'请假',2:'加班',3:'换休' }" headerKey="" headerValue="--请选择--" />
				<s:select  id="searchLeaveMold" name="leave.leave_mold" list="#{'0':'年假','1':'病假','2':'事假','3':'婚假','4':'产假','5':'丧假','6':'陪产假','7':'其他' }"
					headerKey="" headerValue="--请选择--" />
			</td>
			<td class='firstRow3'>查询日期:</td>
			<td class='secRow3'>	
				<input id="leave_serach_date" name="leave.serach_date" title="查询日期" value="${it:formatDate(leave.serach_date,'yyyy-MM-dd')}" />
				<script type="text/javascript">$("#leave_serach_date").datepicker();</script>
			</td>
			</tr><tr>
			<td class='firstRow3'>申请部门/人:</td>
			<td class='secRow3' colspan="3">
				<s:textfield title="部门" id="userdept_codeid" name="leave.leave_dept" readonly="true" />
				<s:textfield title="部门名称" id="userdept_nameid" name="leave.leave_dept_name" readonly="true" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
				<span id="ajax_member_message"></span>
				<s:select id="membermanagerid" name="leave.leave_user" list="#{}" headerKey="" headerValue="--请选择--" />
			</td>
			<td class='firstRow3'>补贴状态:</td>
			<td class='secRow3'>
				<s:select name="leave.allowance_status" list="#{0:'未补贴',1:'已补贴'}" headerKey="" headerValue="--请选择--" />
			</td>
			</tr>
			<tr>
			<td class='firstRow3'>业务审核状态:</td>
			<td class='secRow3'>
				<s:select name="leave.check_status" list="#{0:'新申请',5:'已退回',10:'待审核',20:'经理/大区已审',30:'运营总监已审',40:'业务副总已审' }" headerKey="" headerValue="--请选择--"  />
			</td>
			<td class='firstRow3'>人事审核状态:</td>
			<td class='secRow3'>
				<s:select name="leave.acheck_status" list="#{0:'未审核/已退回',10:'人事经理已审',20:'行政副总已审',30:'总经理已审' }" headerKey="" headerValue="--请选择--"  />
			</td>
			<td class='buttonarea' colspan="2">
				<s:submit value="搜索" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable ilisttablex" id="table1" width="100%">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>编号</th>
	    <th>类型</th>
	    <th>申请部门</th>
		<th>申请人</th>
		<th>开始时间</th>
		<th>结束时间</th>
		<th>共计(天)</th>
		<th>事由</th>
		<th>业务部门意见</th>
		<th>人事部门意见</th>
		<th>操作</th>
	  </tr>
<s:iterator value="leaves" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
	    <td>
	    	<s:if test="leave_type==0">出差</s:if>
	    	<s:if test="leave_type==1">请假</s:if>
	    	<s:if test="leave_type==2">加班</s:if>
	    	<s:if test="leave_type==3">换休</s:if>
	    </td>
	    <td><s:property value="leave_dept_name" /></td>
		<td><s:property value="leave_user_name" /></td>
		<td><s:date name="leave_start" format="yyyy-MM-dd" /> <s:property value="leave_start_time" /></td>
		<td><s:date name="leave_end" format="yyyy-MM-dd" /> <s:property value="leave_end_time" /></td>
		<td><s:property value="totle" /></td>
		<td><a href="javascript:;" onclick="showCause('leave_cause${uuid}');">[点击查看]</a><span id="leave_cause${uuid}" style="display:none;"><s:property value="cause" /></span></td>
		<td>
			<s:if test="check_status==0">新申请</s:if>
			<s:if test="check_status==5"><span class="message_error">已退回</span></s:if>
			<s:if test="check_status==10"><span class="message_warning">待审核</span></s:if>
			<s:if test="check_status==20"><span class="message_pass">经理/大区已审</span></s:if>
			<s:if test="check_status==30"><span class="message_pass">运营总监已审</span></s:if>
			<s:if test="check_status==40"><span class="message_pass">业务副总已审</span></s:if>
		</td>
		<td>
			<s:if test="check_status==5"><span class="message_error">已退回</span></s:if>
			<s:elseif test="acheck_status==0">未审核</s:elseif>
			<s:if test="acheck_status==10"><span class="message_pass">人事经理已审</span></s:if>
			<s:if test="acheck_status==20"><span class="message_pass">行政副总已审</span></s:if>
			<s:if test="acheck_status==30"><span class="message_pass">总经理已审</span></s:if>
		</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE')">
	    	[<a href="<s:url namespace="/adm" action="leave_load"><s:param name="viewFlag">mdy</s:param><s:param name="leave.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="check_status<=5&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_DEL')">
	    	[<a href="<s:url namespace="/adm" action="leave_del"><s:param name="leave.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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
<div id="AddLeaveForm" title="请选择申请单类型" style="display: none;">
<p align="center">
<input type="button" value="出差" onclick="addLeave(0);"  />
<input type="button" value="请假" onclick="addLeave(1);"  />
<input type="button" value="加班" onclick="addLeave(2);"  />
<input type="button" value="换休" onclick="addLeave(3);"  />
</p>
</div>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_apply_dept = '${leave.leave_dept}';
var curr_apply_user = '${leave.leave_user}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	if(curr_apply_dept!='') {
		loadManagers(curr_apply_dept);
	}
	
	$("#AddLeaveForm").dialog({
	      autoOpen: false,
	      width: 250,
	      height: 100,
	      modal: true
	});
	
	$("#AddLeaveLink").click(function(){
		$("#AddLeaveForm").dialog("open");
	});
	
	showLeaveMold(${leave.leave_type});
	$("#searchLeaveType").change(function(){
		showLeaveMold($(this).val());
	});
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

function addLeave(p_type) {
	var add_url = '<s:url namespace="/adm" action="leave_load"><s:param name="viewFlag">add</s:param></s:url>';
	add_url = add_url + "&leave.leave_type="+p_type;
	//alert(add_url);
	location.href = add_url;
}

function showCause(s_id) {
	alert($("#"+s_id).text());
}

function showLeaveMold(p_type) {
	if(1==p_type){
		$("#searchLeaveMold").removeAttr("disabled");
		$("#searchLeaveMold").show();
	} else {
		$("#searchLeaveMold").attr("disabled","disabled");
		$("#searchLeaveMold").hide();
	}
}
</script>
</body>
</html>