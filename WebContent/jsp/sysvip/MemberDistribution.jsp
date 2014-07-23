<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	//setStyle("table1");
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
});

var sobj01;
var selectDept = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_select_all_v02" />?objname=sobj01',title:'选择部门'});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codesearch").val(val1);
		$("#userdept_namesearch").val(val2);
		loadManagers("membermanagerisearch",val1);
	};
	sobj01.create();
	sobj01.open();
};

var sobj02;
var selectDept02 = function() {
	sobj02 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_select_all_v02" />?objname=sobj02',title:'选择部门'});
	sobj02.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_nameid").val(val2);
		loadManagers("membermanagerid",val1);
	};
	sobj02.create();
	sobj02.open();
};

function loadManagers(selectId,dept_code) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#"+selectId).clearAllOption();
		$("#"+selectId).addOption("暂无","");
		$.each(data, function(i, n){
			$("#"+selectId).addOption(n.user_name,n.uuid);
		});
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">会员分配</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="distribution_list"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
				<td class='firstRow3'>会员号:</td>
				<td class='secRow3'><s:textfield name="member.uuid" title="会员号" /></td>
				<td class='firstRow3'>(%)会员姓名:</td>
				<td class='secRow3'><s:textfield name="member.member_name" title="会员姓名"  /></td>
				<td class='firstRow3'>会员手机:</td>
				<td class='secRow3'><s:textfield name="member.mobile" title="会员手机"  /></td>
				</tr><tr>
				<td class='firstRow3'>会员所属:</td>
				<td class='secRow3' colspan="6">
				部门:
				<s:textfield title="部门" id="userdept_codesearch" name="member.dept_code" readonly="true" />
				<s:textfield title="部门名称" id="userdept_namesearch" name="member.dept_name" readonly="true" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
				<span id="ajax_member_message"></span>
				客户经理:
				<s:select id="membermanagerisearch" name="member.manager" list="#{}"
					headerKey="" headerValue="暂无"></s:select>
				</td>
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
<s:form name="form1" theme="simple" onsubmit="return validator(this);">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>会员号</th>
		<th>会员手机</th>
		<th>会员姓名</th>
		<th>会员级别</th>
		<th>现归属部门</th>
		<th>现归属人</th>
	  </tr>
<s:iterator value="members" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="member.uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
		<td><s:property value="mobile" /></td>
		<td><s:property value="member_name" /></td>
		<td align="center"><s:property value="user_type_name" /></td>
		<td align="center"><s:property value="dept_name" /></td>
		<td align="center">
			<s:if test="manager==null || manager==''">
			<span class="message_error">没有分配</span>
			</s:if>
			<s:else><s:property value="manager_name" /></s:else>
		</td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="showpagearea">
		<script type="text/javascript">
		var spage = new ShowPage();
		spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
		</script>
		</td>	    
	  </tr>
	  <tr>
	    <td colspan="20" class="showpagearea">
	    <span id="message"><s:property value="message" /></span>
	    把选中的会员分配给
	    部门:
		<s:textfield title="部门" id="userdept_codeid" name="member.dept_code" readonly="true" require="required" controlName="部门代码" />
		<s:textfield title="部门名称" id="userdept_nameid" name="member.dept_name" readonly="true" require="required" controlName="部门名称" />
		<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept02();" />
		<span id="ajax_member_message"></span>
		客户经理:
		<s:select id="membermanagerid" name="member.manager" list="#{}"	headerKey="" headerValue="暂无" />
		<s:submit id="member_distribution" name="member_distribution" value="确定" action="member_distribution" />
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>