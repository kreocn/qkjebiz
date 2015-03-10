<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">add</s:param></s:url>" >添加工业旅游申请</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="travel_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">申请编号:</div>
				       <div class="label_rwben"><s:textfield name="travel.uuid"  title="申请编号" cssClass="validate[custom[number],maxSize[24]]" /></div>
				</div>
				<div class="label_hang">
		            <div class="label_ltit">申请部门:</div>
		            <div class="label_rwben2">
		            	<span class="label_rwb">
						<s:textfield title="部门名称" id="userdept_nameid" name="travel.apply_dept_name" readonly="true" />
						<s:hidden title="部门代码" id="userdept_codeid" name="travel.apply_dept" readonly="true" />
						</span>
						<span class="lb nw">
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
						<s:checkbox id="apply_is_sub_dept" name="active.is_sub_dept" cssClass="regular-checkbox" />
						<label for="apply_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
						</span>
		            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">申请人:</div>
		            <div class="label_rwben label_rwb">
		            	<s:select id="membermanagerid" cssClass="selectKick" name="travel.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
		            </div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">业务审核状态:</div>
				       <div class="label_rwben"><s:select name="travel.check_status" title="业务审核状态" headerKey="" headerValue="--请选择--" list="#{0:'新申请',5:'已退回',10:'待审核',20:'经理/大区已审',30:'总监已审',40:'业务副总已审'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">行政审核状态:</div>
				       <div class="label_rwben"><s:select name="travel.acheck_status" title="行政审核状态" headerKey="" headerValue="--请选择--" list="#{0:'新申请',5:'已退回',10:'待审核',20:'行政经理已审',30:'行政副总已审',40:'总经理已审'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">查询日期:</div>
				       <div class="label_rwben"><input id="travel_travel_date_search" class="datepicker validate[custom[date]]" type="text" name="travel.travel_date_search" title="查询日期" value="${it:formatDate(travel.travel_date_search,'yyyy-MM-dd')}" /></div>
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
	              <th  class="td1">申请编号</th>
	              <th  class="td2">申请部门</th>
	              <th  class="td1">申请人</th>
	              <th  class="td2">执行日期</th>
	              <th  class="td3">业务审核状态</th>
	              <th  class="td3">行政审核状态</th>
	              <th  class="td4">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="travels" status="sta">
	            	<tr id="showtr${uuid}">
	            		<td  class="td1">${uuid}</td>
	            		<td  class="td2">${apply_dept_name}</td>
	            		<td  class="td1">${apply_user_name}</td>
	            		<td  class="td2">${it:formatDate(travel_date,'yyyy-MM-dd')} -- ${it:formatDate(travel_date_end,'yyyy-MM-dd')}</td>
	            		<td  class="td3">
           						<s:if test="check_status==0">新申请</s:if>
								<s:if test="check_status==5"><span class="message_error" title="${check_user_name}">已退回</span></s:if>
								<s:if test="check_status==10"><span class="message_warning">待审核</span></s:if>
								<s:if test="check_status==20"><span class="message_pass"  title="${check_user_name}">经理/大区已审</span></s:if>
								<s:if test="check_status==30"><span class="message_pass"  title="${check_user_name}">总监已审</span></s:if>
								<s:if test="check_status==40"><span class="message_pass"  title="${check_user_name}">业务副总已审</span></s:if>
	            		</td>
	            		<td  class="td3">
								<s:if test="acheck_status==0">新申请</s:if>
								<s:if test="acheck_status==5"><span class="message_error" title="${acheck_user_name}">已退回</span></s:if>
								<s:if test="acheck_status==10"><span class="message_warning">待审核</span></s:if>
								<s:if test="acheck_status==20"><span class="message_pass"  title="${acheck_user_name}">行政经理已审</span></s:if>
								<s:if test="acheck_status==30"><span class="message_pass"  title="${acheck_user_name}">行政副总已审</span></s:if>
								<s:if test="acheck_status==40"><span class="message_pass"  title="${acheck_user_name}">总经理已审</span></s:if>
	            		</td>
	            		<td  class="td4 op-area nw">
	            				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL')">
				    	    	<a class="input-blue"  href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">mdy</s:param><s:param name="travel.uuid" value="uuid"></s:param></s:url>">修改</a>
				    	    	</s:if>
				                <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_DEL') && check_status>=30 && acheck_status>=10">
				                <a class="input-gray"  href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">print1</s:param><s:param name="travel.uuid" value="uuid" /></s:url>">打印1</a>
				                <a class="input-gray" href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">print2</s:param><s:param name="travel.uuid" value="uuid" /></s:url>">打印2</a>
				                <a class="input-gray" href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">print3</s:param><s:param name="travel.uuid" value="uuid" /></s:url>">打印客户表</a>
				                </s:if>
				                <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_DEL') && (check_status<=5 || acheck_status<=5)">
				      	    	<a class="input-red" href="<s:url namespace="/qkjmanage" action="travel_del"><s:param name="travel.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
				      	    	</s:if>
	            		</td>
	            		<td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
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
</body>
</html>