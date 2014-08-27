<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库管理权限管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>


<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>仓库管理权限</span>
		<span class="extra1">
			<a href="<s:url action="warepower_list" namespace="/warepower" />" >仓库管理权限列表</a>
		</span>	
	</div>
<s:form name="form1" action="warepower_add" namespace="/warepower" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="warepower!=null">
		<tr>
		<td class='firstRow3'>申请部门/人:</td>
			<td class='secRow3' colspan="3">
				<s:textfield title="部门" id="userdept_codeid" name="warepower.dept_code" readonly="true" />
				<s:textfield title="部门名称" id="userdept_nameid" name="warepower.dept_name" readonly="true" />
				<span id="ajax_member_message"></span>
				<s:textfield name="warepower.user_name" readonly="true"></s:textfield>
			</td>
		
		</tr>
		<tr>
			<td width="30%"><s:property value="warepower.ware_name" />(<s:property value="warepower.address" />)
			<s:hidden name="warepower.uuid" />
			</td>
			<td >  
			<input type="checkbox" name="warepower.prvg"  value="1"  <s:if test="%{warepower.prvg.indexOf('1')>=0}">checked="checked"</s:if> >增加&nbsp;&nbsp;
			<input type="checkbox" name="warepower.prvg"  value="2"  <s:if test="%{warepower.prvg.indexOf('2')>=0}">checked="checked"</s:if> > 删除&nbsp;&nbsp;
			<input type="checkbox" name="warepower.prvg"  value="3"  <s:if test="%{warepower.prvg.indexOf('3')>=0}">checked="checked"</s:if> > 修改&nbsp;&nbsp;
			<input type="checkbox" name="warepower.prvg"  value="4"  <s:if test="%{warepower.prvg.indexOf('4')>=0}">checked="checked"</s:if> > 查询&nbsp;&nbsp;
			</td>
		  </tr>
		</s:if>
		
		<s:else>
		<tr>
		<td class='firstRow3'>申请部门/人:</td>
			<td class='secRow3' colspan="3">
				<s:textfield title="部门" id="userdept_codeid" name="warepower.dept_code" readonly="true" />
				<s:textfield title="部门名称" id="userdept_nameid"  name="warepower.dept_name"  readonly="true" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
				<span id="ajax_member_message"></span>
				<s:select id="membermanagerid" name="warepower.username" list="#{}" headerKey="" headerValue="--请选择--" />
			</td>
		
		</tr>
		<s:iterator value="wares" status="sta">
		<tr>
			<td width="30%"><s:property value="ware_name" />(<s:property value="address" />)
			<s:hidden name="warepowers[%{#sta.index}].ware_id" value="%{uuid}" />
			</td>
			<td >
			<s:checkbox name="warepowers[%{#sta.index}].prvg" 
			  fieldValue="1"  /> 增加&nbsp;&nbsp;
			<s:checkbox name="warepowers[%{#sta.index}].prvg"
			  fieldValue="2"/> 删除&nbsp;&nbsp;
			<s:checkbox name="warepowers[%{#sta.index}].prvg" 
			 fieldValue="3"/> 修改&nbsp;&nbsp;
			<s:checkbox name="warepowers[%{#sta.index}].prvg"  
			fieldValue="4"/> 查询&nbsp;&nbsp;
			</td>
		  </tr>
		</s:iterator>
		
		</s:else>
		
		

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_ADD')">
					<s:submit id="add" name="add" value="确定" action="warepower_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_MDY')">
					<s:submit id="save" name="save" value="保存" action="warepower_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="warepower_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="warepower_relist" namespace="/warepower" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
<script type="text/javascript">
function check(){
	
}
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
	      width: 300,
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
	
	$(".leave_cause_show").tooltip({
		items: "[data]",
		content: function() {
			//alert($(this).attr("data"));
			return "<div class='show_dialog'>" + $("#leave_cause" + $(this).attr("data")).html() + "</div>";
	  }
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


</script>
</html>