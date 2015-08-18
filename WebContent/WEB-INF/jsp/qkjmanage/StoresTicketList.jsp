<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>酒票管理列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.rating.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.rating.pack.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.MetaData.js" />"></script>

<style type="text/css">
.star-rating-control{margin-top:6px; display: inline-block;}
</style>
</head>

<body>
 <!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;酒票列表
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="stores_add_ticket"><s:param name="viewFlag">add</s:param></s:url>" >添加酒票</a></span>
	</div>
	<s:form id="ticket_list" name="serachForm" action="ticket_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">酒票编号:</div>
				       <div class="label_rwben"><s:textfield name="storesTicket.id"  title="酒票编号" value=""/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">酒票名称:</div>
				       <div class="label_rwben"><s:textfield name="storesTicket.ticket_name"  title="酒票名称" cssClass="validate[maxSize[42]]"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">生效时间:</div>
				       <div class="label_rwben"><input  class="datepicker validate[custom[date]]" type="text" name="storesTicket.start_time" title="生效时间" value="${it:formatDate(customer.add_time,'yyyy-MM-dd')}" /></div>
				</div>
						<div class="label_hang">
				       <div class="label_ltit">无效时间:</div>
				       <div class="label_rwben"><input  class="datepicker validate[custom[date]]" type="text" name="storesTicket.end_time" title="无效时间" value="${it:formatDate(customer.add_time,'yyyy-MM-dd')}" /></div>
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
	 		<table id="table1">
	 			<tr id="coltr">
	 				<th class="td1">酒票编号</th>
					<th class="td2">酒票名称</th>
					<th class="td2">酒票开始日期</th>
					<th class="td3">酒票结束日期</th>
					<th class="td3">酒票添加人</th>
					
					<th class="td5">操作</th>
	              	<th class="td0">查看</th>
	            </tr>
	            <s:iterator value="storesTicketList" status="sta">
	            	<tr id="showtr${uuid}">
	            		<td class="td1">${id}</td>
	            		<td class="td2">${ticket_name}</td>
	            		<td class="td2">${start_time }</td>
	            		<td class="td3">${end_time }</td>
	            		<td class="td3">${login_name}</td>
	            	
	            		<td class="td5 op-area">
					    		<a class="input-red" href="<s:url namespace="/qkjmanage" action="ticket_del"><s:param name="storesTicket.id" value="id"></s:param></s:url>" onclick="return isDel();">删除</a>
	            		</td>
	            	
	            	</tr>
	            </s:iterator>
	        </table>
	   </div>
	   <div id="listpage" class="pagination"></div>
</div>
</div>
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
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var manager = '${customer.manager}';
$(function(){
	if($("#customer_dept_code").val()!='') {
		loadManagers($("#customer_dept_code").val());
	}
 });
var sobj01;
var selectDept2 = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#customer_dept_code").val(val1);
		$("#customer_dept_name").val(val2);
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
		
		if(manager!='') {
			$("#membermanagerid").setSelectedValue(manager);
		};
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}
</script>
</body>
</html>