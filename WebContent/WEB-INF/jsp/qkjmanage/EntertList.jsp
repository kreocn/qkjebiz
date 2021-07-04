<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.ship_info {
cursor: pointer;
}
</style>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ENTERTAI_ADD',null)==true}">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="entert_load"><s:param name="viewFlag">add</s:param></s:url>">添加</a>
			<a 	href="<s:url namespace="/qkjmanage" action="entert_report"></s:url>">报表</a>
			</span>
		</c:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="entert_list"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
 		<div class="label_hang">
            <div class="label_ltit">数字编号:</div>
            <div class="label_rwben"><s:textfield name="entert.uuid" title="数字编号" /></div>
        </div>
        
        <%-- <div class="label_hang">
            <div class="label_ltit">客户名称:</div>
            <div class="label_rwben"><s:textfield id="order_user_id" name="entert.member_id"/></div>
        </div> --%>
        
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben2">
            	<span class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="entert.apply_dept_name" readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="entert.apply_dept" readonly="true" />
				</span>
				<span class="lb nw">
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
				<s:checkbox id="apply_is_sub_dept" name="entert.is_sub_dept" cssClass="regular-checkbox" />
				<label for="apply_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
				</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="entert.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
            </div>
		</div>
        <div class="label_hang">
            <div class="label_ltit">申请日期:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="datepicker iI iI-f" type="text" name="entert.plan_start_begin" title="从" value="${it:formatDate(entert.plan_start_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="datepicker iI iI-t" type="text" name="entert.plan_start_end" title="到" value="${it:formatDate(entert.plan_start_end,'yyyy-MM-dd')}" />
            	</span>
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
	    <th class="td1">编号</th>
		<th class="td1">所属部门</th>
		<th class="td1">申请人</th>
		<th class="td2">申请日期</th>
		<th class="td1">状态</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="enterts" status="sta">
	  	<tr id="showtr${uuid}">
		    <td class="td1 nw">${uuid}</td>
			<td class="td1 nw">${apply_dept_name}</td>
			<td class="td1 nw">${apply_user_name}</td>
			<td class="td2 nw">${it:formatDate(apply_date,'yyyy-MM-dd')}</td>
			<td  class="td1">
				<span class="op-area">
				<s:if test="state==0"><a class="ship_info input-nostyle"  data="${uuid}">未出库</a></s:if>
				<s:if test="state==1"><a class="ship_info input-nostyle"  data="${uuid}"><span class="message_pass">已出库</span></a></s:if>
				</span>
				<span class="ship_hidden_info" style="display:none;">
					<span id="ship_no_${uuid}">${ship_no}</span>
					<span id="ship_cloud_${uuid }">${ship_cloud}</span>
					<span id="ship_type_${uuid}">${ship_type}</span>
					<span id="ship_date_${uuid}">${it:formatDate(ship_date,"yyyy-MM-dd")}</span>
					<span id="ship_phone_${uuid}">${ship_phone}</span>
					<span id="ship_status_${uuid}">${ship_status}</span>
					<span id="active_remark_${uuid}">${remark}</span>
				</span>
			</td>
			<td class="td4 op-area nw">
				<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ENTERTAI_MDY',null)==true}">
		    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="entert_load"><s:param name="viewFlag">mdy</s:param><s:param name="entert.uuid" value="uuid"></s:param></s:url>">修改</a>
		    	</c:if>
		    	<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ENTERTAI_DEL',null)==true}">
		    	<a class="input-red" href="<s:url namespace="/qkjmanage" action="entert_del"><s:param name="entert.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
		    	</c:if>  
		    </td>
		    <td class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	  	</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div id="listpage" class="pagination"></div>
</div>

<div id="mdyActiveShipInfoForm" class="label_con idialog" title="修改状态">
<s:form name="form_mdyActiveShipInfoForm" action="entert_savestate" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben"><s:select id="e_active_ship_status" name="entert.state" list="#{0:'未出库',1:'已出库'}" /></div>
        </div>
        <div class="label_hang label_button tac">
           	<s:hidden id="e_active_uuid" name="entert.uuid" value="%{entert.uuid}" />
				<s:submit id="mdyActiveShipInfo" name="mdyActiveShipInfo" value="确定" action="entert_savestate" />
        </div>
    </div>
</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
	
	if($(".ship_info").length>0) {
		$(".ship_info").bind("click",function(){
			setShipVal($(this).attr("data"));
			$("#mdyActiveShipInfoForm").dialog("open");
		});
	}
	$("#mdyActiveShipInfoForm").dialog({
	      autoOpen: false,
	      modal: true
	});
 });
 
function setShipVal(p_uuid) {
	$("#e_active_uuid").val(p_uuid);
	$("#e_active_ship_status").val($("#ship_status_"+p_uuid).text());
}
</script>
</body>
</html>