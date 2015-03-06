<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.surebtn{margin:3px 0 0 10px; float:right;}
.f_khjl{float:left; line-height:30px; padding-left:10px;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step"><a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;会员分配</div>
	<s:form id="serachForm" name="serachForm"  method="get" namespace="/sysvip" theme="simple">
		<div class="label_con">
			<div class="label_main">
     			<div class="label_hang">
	          		<div class="label_ltit">会员号:</div>
	          		<div class="label_rwben"><s:textfield name="member.uuid" title="会员号" /></div>
 				</div>
 				<div class="label_hang">
	          		<div class="label_ltit">(%)会员姓名:</div>
	          		<div class="label_rwben"><s:textfield name="member.member_name"  title="会员姓名"/></div>
 				</div>
 				<div class="label_hang">
	          		<div class="label_ltit">会员手机:</div>
	          		<div class="label_rwben"><s:textfield name="member.mobile"  title="会员手机"/></div>
 				</div>
 				<div class="label_hang">
	          		<div class="label_ltit">所属部门:</div>
	          		<div class="label_rwben2">
		            	<span class="label_rwb">
							<s:textfield title="部门名称" id="userdept_namesearch" name="member.dept_name" readonly="true" />
							<s:hidden title="部门代码" id="userdept_codesearch" name="member.dept_code" readonly="true" />
						</span>
						<span class="lb nw">
							<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codesearch','userdept_namesearch',true);" />
							<span id="ajax_member_message"></span>
						</span>
		            </div>
 				</div>
 				<div class="label_hang">
		            <div class="label_ltit">客户经理:</div>
		            <div class="label_rwben label_rwb">
		            	<s:select id="membermanagerisearch" cssClass="selectKick" name="member.manager" list="#{}" headerKey="" headerValue="暂无" />
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
	<s:form name="form1" theme="simple" onsubmit="return validator(this);">
	<div class="tab_warp">
		<table id="table1">
			<tr id="coltr">
				<th class="td1"><input id="uuidcheck" name="uuidcheck" type="checkbox" onclick="checkAll();" /></th>
				<th class="td1">会员号</th>
				<th class="td2">会员手机</th>
				<th class="td3">会员姓名</th>
				<th class="td3">会员级别</th>
				<th class="td4">现归属部门</th>
				<th class="td4">现归属人</th>
				<th class="td0">查看</th>
			</tr>
			<s:iterator value="members" status="sta">
				<tr id="showtr${uuid}">
					<td class="td1"><input name="member.uuid" type="checkbox" value="${uuid}" /></td>
					<td class="td1">${uuid}</td>
					<td class="td2">${mobile}</td>
					<td class="td3">${member_name}</td>
					<td class="td3">${user_type_name}</td>
					<td class="td4">${dept_name}</td>
					<td class="td4">
						<s:if test="manager==null || manager==''">
						<span class="message_error">没有分配</span>
						</s:if>
						<s:else>${manager_name}</s:else>
					</td>
					<td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
				</tr>
		    </s:iterator>
		</table>		
		<div id="listpage" class="pagination"></div>
		<div class="label_main" style="font-size:14px; margin-top:10px;">
			<s:submit id="member_distribution" name="member_distribution" value="确定" action="member_distribution" cssClass="input-blue surebtn" />
			<div style="float:right;">
				<b class="f_khjl">客户经理:&nbsp;</b>
				<div class="label_rwben label_rwb">
	            	<s:select id="membermanagerid" cssClass="selectKick" name="member.manager" list="#{}" headerKey="" headerValue="暂无" />
	            </div>
			</div>
			<span class="lb nw" style="float:right;">
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept02();" />
				<span id="ajax_member_message"></span>
			</span>
			<div style="float:right;">
	   			<span id="message"><s:property value="message" /></span>
	   			<b>把选中的会员分配给&nbsp;部门:</b>
	   			<span class="label_rwb">
					<s:textfield title="部门名称" id="userdept_nameid" name="member.dept_name" readonly="true" />
					<s:hidden title="部门代码" id="userdept_codeid" name="member.dept_code" readonly="true" />
				</span>
			</div>
		</div>
	</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
});
</script>
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
};
function checkAll(){
	var check=document.getElementsByName("member.uuid");
	var a=check.length;
	if(document.getElementById("uuidcheck").checked){
		for(var i=0;i<a;i++){
			check[i].checked=true;
		};
	}else{
		for(var i=0;i<a;i++){
			check[i].checked=false;
		};
	};
};
</script>
</body>
</html>