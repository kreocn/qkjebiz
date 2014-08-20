<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户回访记录列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">客户回访记录列表</span>
		<span class="extra1">
			<!-- 
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMERRECODE_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="customerRecode_load"><s:param name="viewFlag">add</s:param></s:url>" >添加客户回访记录</a>
			</s:if>
			 -->
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="customerRecode_list"  method="get" namespace="/qkjmanage" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>回访客户:</td>
			<td class='secRow'>
				名称:<s:textfield name="customerRecode.cus_name" title="回访客户"  cssStyle="45%" />
				ID:<s:textfield name="customerRecode.customer_id" title="回访客户" cssStyle="35%" />
			</td>
			<td class='firstRow'>回访方式:</td>
			<td class='secRow'><s:select name="customerRecode.type" title="回访方式"  list="#{0:'主动电话拜访',1:'被动电话来访',2:'主动上门拜访',3:'被动上门来访',4:'会展会场来访',5:'网络、邮件、信息形式来访',6:'其他方式'}" headerKey="" headerValue="--请选择--"  /></td>
			</tr><tr>
			<td class='firstRow'>拜访日期:</td>
			<td class='secRow'><s:textfield id="customerRecode_recode_time" name="customerRecode.recode_time" title="拜访日期" value="%{getText('global.date',{customerRecode.recode_time})=='null'?'':getText('global.date',{customerRecode.recode_time})}" dataType="date" controlName="拜访日期" /></td>
			<td class='firstRow'>下次拜访时间:</td>
			<td class='secRow'><s:textfield id="customerRecode_next_date" name="customerRecode.next_date" title="下次拜访时间" value="%{getText('global.date',{customerRecode.next_date})=='null'?'':getText('global.date',{customerRecode.next_date})}" dataType="date" controlName="下次拜访时间" /></td>
			</tr><tr>
			<td class='firstRow'>拜访部门/人员:</td>
			<td class='secRow' colspan="3">
				部门:
				<s:textfield title="部门" id="userdept_codeid" name="customerRecode.dept_code" readonly="true" />
				<s:textfield title="部门名称" id="userdept_nameid" name="customerRecode.dept_name" readonly="true" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
				人员:
				<s:select id="membermanagerid" name="customerRecode.add_user" list="#{}"
					headerKey="" headerValue="--请选择--"></s:select>
				<s:checkbox id="customer_is_sub_dept" name="customerRecode.is_sub_dept" />
				<label for="customer_is_sub_dept">包含子部门</label>
				<span id="ajax_member_message"></span>
			</td>
			</tr><tr>
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
	  <tr>
	    <th>回访客户</th>
		<th>拜访日期</th>
		<th>回访方式</th>
		<th>受访人</th>
		<th>访谈内容</th>
		<th>给予客户承诺</th>
		<th>下次拜访时间</th>
		<th>添加人</th>
	  </tr>
<s:iterator value="customerRecodes" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td>
	    <a href="javascript:;" onclick="openCustomerView(${customer_id});"><s:property value="cus_name" /></a></td>
		<td><s:date name="recode_time" format="yyyy-MM-dd" /></td>
		<td>
		<s:if test="0==type">主动电话拜访</s:if>
		<s:if test="1==type">被动电话来访</s:if>
		<s:if test="2==type">主动上门拜访</s:if>
		<s:if test="3==type">被动上门来访</s:if>
		<s:if test="4==type">会展会场来访</s:if>
		<s:if test="5==type">网络、邮件、信息形式来访</s:if>
		<s:if test="6==type">其他方式</s:if>
		</td>
		<td><s:property value="person" /></td>
		<td title="${content}">${it:subString(content,20)}</td>
		<td title="${promise}">${it:subString(promise,10)}</td>
		<td><s:date name="next_date" format="yyyy-MM-dd" /></td>
		<td><s:property value="add_user_name" /></td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage();
		spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
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
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var add_user='${customerRecode.add_user}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	$("#customerRecode_recode_time").datepicker();
	$("#customerRecode_next_date").datepicker();
	
	if($("#userdept_codeid").val()!='') {
		loadManagers($("#userdept_codeid").val());
	}
	
	createCustomerView();
 });
var sobj01;
var selectDept = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_select_all_v02" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_nameid").val(val2);
		loadManagers(val1);
	};
	sobj01.create();
	sobj01.open();
};

var sobj02;
var createCustomerView = function() {
	//http://localhost:8888/qkjmanage/customer_load?viewFlag=mdy&customer.uuid=3
	var w_width = $(window).width();
	var w_height = $(window).height();
	sobj02 = new DialogIFrame({
		src:'',
		title:"查看客户信息",
		width:w_width*0.95,
		height:w_height*0.95
	});
	sobj02.selfAction = function(val1,val2) {};
	sobj02.create();
	//sobj02.open();
};

var openCustomerView = function(customer_uuid) {
	var iframeId = sobj02.getConid() + "iframe";
	$("#"+iframeId).attr("src","/qkjmanage/customer_load?viewFlag=mdy&mode=view&customer.uuid=" + customer_uuid);
	sobj02.open();
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
		
		if(add_user!='') {
			$("#membermanagerid").setSelectedValue(add_user);
		}
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}
</script>
</body>
</html>