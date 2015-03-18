<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>请假单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.show_dialog {
}
.ui-tooltip {
max-width: 650px !important;
}
</style>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
 	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ADD')">
			<span class="opb lb op-area"><a href="javascript:;" id="AddLeaveLink">添加申请单</a></span>
		</s:if>
	</div>
 	<s:form id="serachForm" name="serachForm" action="leave_list"  method="get" namespace="/adm" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name="leave.uuid" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">类型:</div>
            <div class="label_rwben2">
            	<span class="label_rwb">
            	<s:select id="searchLeaveType" name="leave.leave_type" title="类型"
						list="#{0:'出差',1:'请假',2:'加班',3:'换休',4:'补签' }" headerKey="" headerValue="--请选择--" />
				</span>
				<span class="label_rwb">
				<s:select  id="searchLeaveMold" name="leave.leave_mold" list="#{'0':'年假','1':'病假','2':'事假','3':'婚假','4':'产假','5':'丧假','6':'陪产假','7':'其他' }"
					headerKey="" headerValue="--请选择--" />
				</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">查询日期:</div>
            <div class="label_rwben"><input type="text" name="leave.serach_date" class="datepicker" value="${it:formatDate(leave.serach_date,'yyyy-MM-dd')}" /></div>
        </div>
         <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben2 nw">
				<span class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="leave.leave_dept_name" readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="leave.leave_dept" readonly="true" />
				</span>
				<span class="lb nw">
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
				<s:checkbox id="leave_is_sub_dept" name="leave.is_sub_dept" cssClass="regular-checkbox" />
				<label for="leave_is_sub_dept"></label>包含子部门
				<span id="ajax_member_message"></span>
				</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="leave.leave_user" list="#{}" headerKey="" headerValue="--请选择--" />
            </div>
		</div>
        <div class="label_hang">
            <div class="label_ltit">补贴状态:</div>
            <div class="label_rwben label_rwb"><s:select name="leave.allowance_status" list="#{0:'未补贴',1:'已补贴',2:'其他'}" headerKey="" headerValue="--请选择--" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">业务审核状态:</div>
            <div class="label_rwben label_rwb"><s:select name="leave.check_status" list="#{0:'新申请',5:'已退回',10:'待审核',15:'主管/办事处已审',20:'经理/大区已审',30:'运营总监已审',40:'业务副总已审' }" headerKey="" headerValue="--请选择--"  /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">人事审核状态:</div>
            <div class="label_rwben label_rwb"><s:select name="leave.acheck_status" list="#{0:'未审核/已退回',8:'已受理',10:'人事经理已审',20:'行政副总已审',30:'总经理已审' }" headerKey="" headerValue="--请选择--"  /></div>
        </div>
        <div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        </div>
    </div>
    </div>
    </s:form>
<div class="tab_warp">
<table>
<tr id="coltr">
	<th class="td1">编号</th>
    <th class="td1">类型</th>
    <th class="td2">申请部门</th>
	<th class="td1">申请人</th>
	<th class="td4">开始时间</th>
	<th class="td4">结束时间</th>
	<th class="td2">共计(天)</th>
	<th class="td5">事由</th>
	<th class="td3">业务部门意见</th>
	<th class="td3">人事部门意见</th>
	<th class="td5">补贴?</th>
	<th class="td4">操作</th>
	<th class="td0">查看</th>
</tr>
<s:iterator value="leaves" status="sta">
	  <tr id="showtr${uuid}">
	    <td class="td1"><s:property value="uuid" /></td>
	    <td class="td1">
	    	<s:if test="leave_type==0">出差</s:if>
	    	<s:if test="leave_type==1">请假</s:if>
	    	<s:if test="leave_type==2">加班</s:if>
	    	<s:if test="leave_type==3">换休</s:if>
	    	<s:if test="leave_type==4">补签</s:if>
	    </td>
	    <td class="td2"><s:property value="leave_dept_name" /></td>
		<td class="td1"><s:property value="leave_user_name" /></td>
		<td class="td4 longnote"><s:date name="leave_start" format="yyyy-MM-dd" /> <s:property value="leave_start_time" /></td>
		<td class="td4 longnote"><s:date name="leave_end" format="yyyy-MM-dd" /> <s:property value="leave_end_time" /></td>
		<td class="td2"><s:property value="totle" /></td>
		<td class="td5 nsd">
			<a href="javascript:;"  class="leave_cause_show" data="${uuid}">[移此查看]</a>
			<span id="leave_cause${uuid}" style="display:none;" class="leave_cause_shows">
				<s:if test="leave_type==0">出差地点:${leave_mold}<br/> 同行人员：${peer}</s:if>
				${cause}
			</span>
		</td>
		<td class="td3">
			<s:if test="check_status==0">新申请</s:if>
			<s:if test="check_status==5"><span class="message_error" title="${check_user_name}">已退回</span></s:if>
			<s:if test="check_status==10"><span class="message_warning">待审核</span></s:if>
			<s:if test="check_status==15"><span class="message_pass" title="${check_user_name}">主管/办事处已审</span></s:if>
			<s:if test="check_status==20"><span class="message_pass" title="${check_user_name}">经理/大区已审</span></s:if>
			<s:if test="check_status==30"><span class="message_pass" title="${check_user_name}">运营总监已审</span></s:if>
			<s:if test="check_status==40"><span class="message_pass" title="${check_user_name}">业务副总已审</span></s:if>
		</td>
		<td class="td3">
			<s:if test="check_status==5"><span class="message_error">已退回</span></s:if>
			<s:elseif test="acheck_status==0">未审核</s:elseif>
			<s:if test="acheck_status==8"><span class="message_pass">已受理</span></s:if>
			<s:if test="acheck_status==10"><span class="message_pass">人事经理已审</span></s:if>
			<s:if test="acheck_status==20"><span class="message_pass">行政副总已审</span></s:if>
			<s:if test="acheck_status==30"><span class="message_pass">总经理已审</span></s:if>
		</td>
		<td  class="td5">
		<s:if test="leave_type==0 || leave_type==3">
    	<s:if test="allowance_status==0"><span class="allowance_action message_error" uid="${uuid}" stat="${allowance_status}" title="${it:formatDate(allowance_date,'yyyy-MM-dd')}">未补贴</span></s:if>
    	<s:if test="allowance_status==1"><span class="allowance_action message_pass" uid="${uuid}" stat="${allowance_status}" title="${it:formatDate(allowance_date,'yyyy-MM-dd')}">已补贴</span></s:if>
    	<s:if test="allowance_status==2"><span class="allowance_action message_warn" uid="${uuid}" stat="${allowance_status}" title="${it:formatDate(allowance_date,'yyyy-MM-dd')}">其他</span></s:if>
    	</s:if>
		</td>
		<td  class="td4 op-area">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE')">
	    	<a class="input-blue" href="<s:url namespace="/adm" action="leave_load"><s:param name="viewFlag">mdy</s:param><s:param name="leave.uuid" value="uuid"></s:param></s:url>">修改</a>
	    	</s:if>
	    	<s:if test="check_status>=20">
	    	<a class="input-gray" href="<s:url namespace="/adm" action="leave_print"><s:param name="leave.uuid" value="uuid" /><s:param name="leave.leave_type" value="leave_type" /></s:url>">打印</a>
	    	</s:if>
	    	<s:if test="check_status<=5&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_DEL')">
	    	<a class="input-red" href="<s:url namespace="/adm" action="leave_del"><s:param name="leave.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	    	</s:if>	   
	    </td>
	    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	  </tr>
</s:iterator>
</table>
</div>
<div id="listpage" class="pagination"></div>
</div>
</div>

 <!-- HIDDEN AREA BEGIN -->
 <div class="dn">
<div id="AddLeaveForm" class="label_con idialog" title="请选择申请单类型">
<p align="center">
<input type="button" value="出差" onclick="addLeave(0);" class="xm15 ym10" />
<input type="button" value="请假" onclick="addLeave(1);" class="xm15 ym10"   />
<input type="button" value="加班" onclick="addLeave(2);" class="xm15 ym10"   />
</p>
<p align="center">
<input type="button" value="换休" onclick="addLeave(3);" class="xm15 ym10"   />
<input type="button" value="补签" onclick="addLeave(4);" class="xm15 ym10"   />
</p>
</div>

<div id="AddAllowanceForm" title="修改补贴状态" class="label_con idialog">
<s:form name="form1" action="leave_list_allowance" namespace="/adm" method="post" theme="simple">
<div class="label_main">
	<div class="label_hang">
	    <div class="label_ltit">补贴状态:</div>
	    <div class="label_rwben"><s:select id="allowance_status_allowance" name="leave.allowance_status" list="#{0:'未补贴',1:'已补贴',2:'其他'}" headerKey="" headerValue="--请选择--" /></div>
	</div>
	<div class="label_hang">
	    <div class="label_ltit">补贴时间:</div>
	    <div class="label_rwben"><input id="allowance_date_allowance" class="datepicker" type="text" name="leave.allowance_date" title="查询日期" value="${it:formatDate(leave.allowance_date,'yyyy-MM-dd')}" /></div>
	</div>
	<div class="label_hang label_button tac">
		<s:hidden id="leave_uuid_allowance" name="leave.uuid" />
		<s:submit id="leave_list_allowance" name="leave_list_allowance" value="确定" action="leave_list_allowance" />
	</div>
</div>
</s:form>
</div>
<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
</div>
<!-- HIDDEN AREA END -->
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"${assets.typea}",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none",
		required:false
	});
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
 });
</script>

<script type="text/javascript">
var curr_apply_dept ='${leave.leave_dept}';
$(function(){
	if(curr_apply_dept!='') {
		loadManagers(curr_apply_dept,'${leave.leave_user}');
	}
	$("#AddLeaveForm").dialog({
	      autoOpen: false,
	      modal: true
	});
	$("#AddAllowanceForm").dialog({
	      autoOpen: false,
	      modal: true
	});
	addAllowance();
	$("#AddLeaveLink").click(function(){
		$("#AddLeaveForm").dialog("open");
	});
	showLeaveMold(${leave.leave_type});
	$("#searchLeaveType").change(function(){
		showLeaveMold($(this).val());
	});
	$(".leave_cause_show").tooltip({
		items: "[data]",
		content: function() {
			return "<div class='show_dialog'>" + $("#leave_cause" + $(this).attr("data")).html() + "</div>";
	  }
	});
});

function addLeave(p_type) {
	var add_url = '<s:url namespace="/adm" action="leave_load"><s:param name="viewFlag">add</s:param></s:url>';
	add_url = add_url + "&leave.leave_type="+p_type;
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

function addAllowance() {
	//<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ALLOWANCE')">
	$(".allowance_action").css("cursor","pointer");
	$(".allowance_action").click(function(){
		$("#leave_uuid_allowance").val($(this).attr("uid"));
		$("#allowance_status_allowance").val($(this).attr("stat"));
		$("#allowance_date_allowance").val($(this).attr("title"));
		$("#AddAllowanceForm").dialog("open");
	});
	//</s:if>
}
</script>
</body>
</html>