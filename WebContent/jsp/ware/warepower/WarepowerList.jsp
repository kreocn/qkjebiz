<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库管理权限列表--<s:text name="APP_NAME" /></title>
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
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">仓库管理权限列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_ADD')">
			<a href="<s:url namespace="/warepower" action="warepower_load"><s:param name="viewFlag">add</s:param></s:url>" >添加仓库管理权限</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="warepower_list"  method="get" namespace="/warepower" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
				<td class='firstRow'>部门/管理员:</td>
				<td class='secRow'>
					<s:textfield title="部门" id="userdept_codeid" name="warepower.dept_code" readonly="true" />
				<s:textfield title="部门名称" id="userdept_nameid"  name="warepower.dept_name"  readonly="true" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
				<span id="ajax_member_message"></span>
				<s:select id="membermanagerid" name="warepower.username" list="#{}" headerKey="" headerValue="--请选择--" />
				</td>
			</tr>
			<tr>
			<td class='firstRow'>仓库:</td>
			<td class='secRow'><s:select name="warepower.ware_id" title="仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" /></td>
			
			</tr>
			<tr>
			<td colspan="4" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
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
	    <th>主键</th>
	    <th>管理员</th>
		<th>仓库</th>
		<th>权限</th>
		<th>操作</th>
	  </tr>
<s:iterator value="warepowers" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
	     <td>
	     <s:if test="%{username!=null&&username!=''}"><s:property value="user_name" /></s:if>
	     <s:else><s:property value="dept_name" /></s:else>
	     </td>
	    <td><s:property value="ware_name" /></td>
	    <td>
	    <s:if test="%{prvg.indexOf('1')>=0}">入库&nbsp;</s:if>
	    <s:if test="%{prvg.indexOf('2')>=0}">出库&nbsp;</s:if>
	    <s:if test="%{prvg.indexOf('3')>=0}">调库&nbsp;</s:if>
	    <s:if test="%{prvg.indexOf('4')>=0}">查询&nbsp;</s:if>
	    </td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_MDY')">
	    	[<a href="<s:url namespace="/warepower" action="warepower_load"><s:param name="viewFlag">mdy</s:param><s:param name="warepower.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_DEL')">
	    	[<a href="<s:url namespace="/warepower" action="warepower_del"><s:param name="warepower.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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