<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户回访记录列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.ui-corner-all{z-index:999;}
</style>
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
	</div>
	<s:form id="serachForm" name="serachForm" action="customerRecode_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">回访客户名称:</div>
				       <div class="label_rwben"><s:textfield name="customerRecode.cus_name" title="回访客户名称"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">回访客户ID:</div>
				       <div class="label_rwben"><s:textfield name="customerRecode.customer_id" title="回访客户编号"  /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">回访方式:</div>
				       <div class="label_rwben">
				       			<s:select name="customerRecode.type" title="回访方式" headerKey="" headerValue="--请选择--" list="#{0:'主动电话拜访',1:'被动电话来访',2:'主动上门拜访',3:'被动上门来访',4:'会展会场来访',5:'网络、邮件、信息形式来访',6:'其他方式'}" />
				       </div>
				</div>
				<div class="label_hang">
		            	<div class="label_ltit">拜访日期:</div>
		            	<div class="label_rwben"><input type="text" name="customerRecode.recode_time" class="datepicker" value="${it:formatDate(customerRecode.recode_time,'yyyy-MM-dd')}" /></div>
		        </div>
		        <div class="label_hang">
		            	<div class="label_ltit">下次拜访时间:</div>
		            	<div class="label_rwben"><input type="text" name="customerRecode.next_date" class="datepicker" value="${it:formatDate(customerRecode.next_date,'yyyy-MM-dd')}" /></div>
		        </div>
		        <div class="label_hang">
		        		<div class="label_ltit">拜访部门:</div>
		        		<div class="label_rwben2">
			            	<span class="label_rwb">
							<s:textfield title="部门名称" id="userdept_nameid" name="customerRecode.dept_name" readonly="true" />
							<s:hidden title="部门代码" id="userdept_codeid" name="customerRecode.dept_code" readonly="true" />
							</span>
							<span class="lb nw">
							<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" />
							<s:checkbox id="apply_is_sub_dept" name="active.is_sub_dept" cssClass="regular-checkbox" />
							<label for="apply_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
							</span>
			            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">拜访人员:</div>
		            <div class="label_rwben label_rwb">
		            	<s:select id="membermanagerid" cssClass="selectKick" name="customerRecode.add_user" list="#{}" headerKey="" headerValue="--请选择--" />
		            </div>
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
						    <th class="td1">回访客户</th>
							<th class="td2">拜访日期</th>
							<th class="td3">回访方式</th>
							<th class="td1">受访人</th>
							<th class="td5">访谈内容</th>
							<th class="td4">给予客户承诺</th>
							<th class="td3">下次拜访时间</th>
							<th class="td2">添加人</th>
							<th class="td0">查看</th>
				  	</tr>
				  	<s:iterator value="customerRecodes" status="sta">
			  		<tr id="showtr${uuid}">
					    <td class="td1"><a href="javascript:;" onclick="openCustomerView(${customer_id});">${cus_name}</a></td>
						<td class="td2">${it:formatDate(recode_time,"yyyy-MM-dd")}</td>
						<td class="td3">
							<s:if test="0==type">主动电话拜访</s:if>
							<s:if test="1==type">被动电话来访</s:if>
							<s:if test="2==type">主动上门拜访</s:if>
							<s:if test="3==type">被动上门来访</s:if>
							<s:if test="4==type">会展会场来访</s:if>
							<s:if test="5==type">网络、邮件、信息形式来访</s:if>
							<s:if test="6==type">其他方式</s:if>
						</td>
						<td class="td1">${person}</td>
						<td class="td5" title="${content}">${it:subString(content,20)}</td>
						<td class="td4 title="${promise}">${it:subString(promise,10)}</td>
						<td class="td3">${it:formatDate(next_date,"yyyy-MM-dd")}</td>
						<td class="td2">${add_user_name}</td>
						<td class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
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
	$("#"+iframeId).attr("src","/qkjmanage/customer_loadt?viewFlag=mdy&mode=view&customer.uuid=" + customer_uuid);
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