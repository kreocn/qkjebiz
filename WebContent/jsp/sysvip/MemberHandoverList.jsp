<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员转移列表--<s:text name="APP_NAME" /></title>
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
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	$( "#handover_tabs" ).tabs();
	SimpleLoadMember(ajax_url_action,$.noop);
	setStyle("table_in");
	setStyle("table_out");
	
	CommonUtil.pickrow('table_in');
	CommonUtil.pickrowAll('table_in','uuidcheck');
	
	CommonUtil.pickrow('table_out');
	CommonUtil.pickrowAll('table_out','uuidcheck');
 });


var sobj01;
var selectDept = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01'});
	sobj01.selfAction = function(val1,val2) {
		$("#memberHandoverdept_codeid").val(val1);
		$("#memberHandoverdept_nameid").val(val2);
		loadManagers("memberHandoverapplicantid",val1);
	};
	sobj01.create();
	sobj01.open();
};

var sobj02;
var selectDept02 = function() {
	sobj02 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj02'});
	sobj02.selfAction = function(val1,val2) {
		$("#memberHandovertarget_deptid").val(val1);
		$("#memberHandovertarget_dept_nameid").val(val2);
		loadManagers("memberHandovertarget_managerid",val1);
	};
	sobj02.create();
	sobj02.open();
};

var sobj03;
var selectDept03 = function() {
	sobj03 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_select_all_v02" />?objname=sobj03'});
	sobj03.selfAction = function(val1,val2) {
		$("#memberHandovertarget_deptid_add").val(val1);
		$("#memberHandovertarget_dept_nameid_add").val(val2);
		loadManagers("memberHandovertarget_managerid_add",val1);
	};
	sobj03.create();
	sobj03.open();
};

function loadManagers(selectId,dept_code) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#"+selectId).clearAllOption();
		$("#"+selectId).addOption("--请选择--","");
		$.each(data, function(i, n){
			$("#"+selectId).addOption(n.user_name,n.uuid);
		});
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}

function checkValue(checkbox_name) {
	var value = getCheckBox(checkbox_name);
	if (value[0] == 0) {
		alert("你没有选择任何记录!");
		return false;
	} else {
		return true;
	}
}
</script>
<body>
<div id="main">
<div id="result">
<div class="itablemdy">
	<div class="ilistsearch">
<s:form name="form_serach" action="memberHandover_list"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow3'>客户ID:</td>
			<td class='secRow3' colspan="3"><s:textfield name="memberHandover.member_id" title="客户ID" dataLength="0,85" controlName="客户ID" /></td>
			<td class='firstRow3'>状态:</td>
			<td class='secRow3'><s:select name="memberHandover.status" list="#{0:'待接收',1:'已拒收',2:'已接收' }" headerKey="" headerValue="--请选择--" /></td>
			</tr><tr>
			<td class='firstRow3'>申请部门:</td>
			<td class='secRow3' colspan="3">
				<s:textfield id="memberHandoverdept_codeid" name="memberHandover.dept_code" title="申请部门" />
				<s:textfield id="memberHandoverdept_nameid" name="memberHandover.dept_name" title="申请部门" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
			</td>
			<td class='firstRow3'>申请人:</td>
			<td class='secRow3'>
				<s:select id="memberHandoverapplicantid" title="申请人" name="member.manager" list="#{}"	headerKey="" headerValue="--请选择--" />
			</td>
			</tr><tr>
			<td class='firstRow3'>目标部门:</td>
			<td class='secRow3' colspan="3">
				<s:textfield id="memberHandovertarget_deptid" name="memberHandover.target_dept" title="申请部门" />
				<s:textfield id="memberHandovertarget_dept_nameid" name="memberHandover.target_dept_name" title="申请部门" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept02();" />
			</td>
			<td class='firstRow3'>目标人:</td>
			<td class='secRow3'>
				<s:select id="memberHandovertarget_managerid" title="申请人" name="memberHandover.target_manager" list="#{}"	headerKey="" headerValue="--请选择--" />
			</td>
			</tr>
			<tr>
			<td colspan="20" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<div id="handover_tabs">
	<ul>
		<li><a href="#tabs_in">转入请求</a></li>
		<li><a href="#tabs_out">转出事件列表</a></li>
		<li><a href="#tabs_able">添加转出事件</a></li>
	</ul>
	<div id="tabs_in">
	<!--##转入请求列表START##-->
	<s:form id="form_memberHandoverInId" name="form_memberHandoverIns" theme="simple" onsubmit="return checkValue('memberHandover.uuids');" method="post">
		<table class="ilisttable" id="table_in" width="100%">
		<col width="30" />
		  <tr>
		    <th><input name="uuidcheck" type="checkbox" /></th>
		    <th>客户名称</th>
			<th>申请人</th>
			<th>原部门</th>
			<th>目标部门</th>
			<th>目标人</th>
			<th>状态</th>
			<th>操作</th>
		  </tr>
		<s:iterator value="memberHandoverIns" status="sta">
		  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
		    <td align="center"><input name="memberHandover.uuids" type="checkbox" value="<s:property value="uuid" />" /></td>
		    <td align="center"><s:property value="member_name" /></td>
			<td align="center"><s:property value="applicant_name" />(<s:date name="applicant_time" format="yyyy-MM-dd HH:mm:ss" />)</td>
			<td align="center"><s:property value="dept_name" />(<s:property value="dept_code" />)</td>
			<td align="center"><s:property value="target_dept_name" /></td>
			<td align="center"><s:property value="target_manager" /></td>
			<td align="center">
				<s:if test="status==0"><span class="message_error">待接收</span></s:if>
				<s:if test="status==1"><span class="message_warning">拒绝接收</span></s:if>
				<s:if test="status==2">已接收(<s:date name="accept_time" format="yyyy-MM-dd HH:mm:ss" />)</s:if>
			</td>
			<td align="center">
			<s:if test="status==0">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_SAVE1')">
			[<a href="<s:url namespace="/sysvip" action="memberHandover_save1"><s:param name="memberHandover.uuids" value="uuid" /></s:url>">拒绝</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_SAVE2')">
	    	[<a href="<s:url namespace="/sysvip" action="memberHandover_save2"><s:param name="memberHandover.uuids" value="uuid" /></s:url>">接收</a>]
	    	</s:if>
	    	</s:if>
			</td>
		  </tr>
		</s:iterator>
			<tr>
			<td colspan="20" class="buttonarea">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_SAVE1')">
			<s:submit id="save1" name="save1" value="批量拒绝接收" action="memberHandover_save1" />
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_SAVE2')">
	    	<s:submit id="save2" name="save2" value="批量同意接收" action="memberHandover_save2" />
	    	</s:if>
			</td>
			</tr>
		</table> 
	</s:form>
	<!--##转入请求列表END##-->
	</div>
	<div id="tabs_out">
	<!--##转出请求列表START##-->
	<s:form name="form_memberHandoverOuts" theme="simple">
		<table class="ilisttable" id="table_out" width="100%">
		<col width="30" />
		  <tr>
		   <th><input name="uuidcheck" type="checkbox" /></th>
		    <th>客户名称</th>
			<th>申请人</th>
			<th>原部门</th>
			<th>目标部门</th>
			<th>目标人</th>
			<th>状态</th>
			<th>操作</th>
		  </tr>
		<s:iterator value="memberHandoverOuts" status="sta">
		  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
		     <td align="center"><input name="memberHandover.uuids" type="checkbox" value="<s:property value="uuid" />" /></td>
		    <td align="center"><s:property value="member_name" /></td>
			<td align="center"><s:property value="applicant_name" />(<s:date name="applicant_time" format="yyyy-MM-dd HH:mm:ss" />)</td>
			<td align="center"><s:property value="dept_name" />(<s:property value="dept_code" />)</td>
			<td align="center"><s:property value="target_dept_name" /></td>
			<td align="center"><s:property value="target_manager" /></td>
			<td align="center">
				<s:if test="status==0"><span class="message_error">待接收</span></s:if>
				<s:if test="status==1"><span class="message_warning">拒绝接收</span></s:if>
				<s:if test="status==2">已接收(<s:date name="accept_time" format="yyyy-MM-dd HH:mm:ss" />)</s:if>
			</td>
			<td align="center">
			<s:if test="status==0 || status==1">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_DEL')">
		    	[<a href="<s:url namespace="/sysvip" action="memberHandover_del"><s:param name="memberHandover.uuids" value="uuid" /></s:url>">取消请求</a>]
		    	</s:if>
		    </s:if>
		    </td>
		  </tr>
		</s:iterator>
		<tr>
			<td colspan="20" class="buttonarea">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_DEL')">
			<s:submit id="del" name="del" value="批量取消" action="memberHandover_del" />
	    	</s:if>
			</td>
		</tr>
		</table> 
	</s:form>
	<!--##转出请求列表END##-->
	</div>
	<div id="tabs_able">
	<!-- tabs_able start################################# -->
	<s:form name="form_add" action="memberHandover_add" namespace="/sysvip" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
	<tr>
	<td class='firstRow3'><span style="color:red;">*</span> 待移交会员:</td>
	<td class='secRow3'>
		会员编号:
		<s:textfield id="order_user_id" name="memberHandover.member_id" title="会员号" require="required" dataLength="0,85" controlName="待移交会员" />
		手机:
		<s:textfield id="order_user_mobile" name="memberHandover.member_mobile" title="手机" controlName="待移交会员" />
		姓名:
		<s:textfield id="order_user_name" name="memberHandover.member_name" title="姓名" controlName="待移交会员" />
		<span id="ajax_member_message" style="display:none;"></span>
	</td>
	</tr>
	<tr>
	<td class='firstRow3'><span style="color:red;">*</span> 移交部门:</td>
	<td class='secRow3'>
		<s:textfield id="memberHandovertarget_deptid_add" name="memberHandover.target_dept" title="申请部门" />
		<s:textfield id="memberHandovertarget_dept_nameid_add" name="memberHandover.target_dept_name" title="申请部门" />
		<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept03();" />
		客户经理:
		<s:select id="memberHandovertarget_managerid_add" title="申请人" name="memberHandover.target_manager" list="#{}"	headerKey="" headerValue="--请选择--" />
		(客户经理可不指定)
	</td>
	</tr>
	<tr>
		<td  colspan="20" class="buttonarea">
		<s:submit id="add" name="add" value="提交事件" action="memberHandover_add" />
		</td>
	</tr>
	</table>
	</s:form>
	<!-- tabs_able end################################## -->
	</div>
</div>
	</div>
</div>
</div>
</body>
</html>