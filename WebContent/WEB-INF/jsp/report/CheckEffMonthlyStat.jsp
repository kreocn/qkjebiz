<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动/至事由统计报表</title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
<div class="tab_warp main" >
	<div class="dq_step">
		<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;活动/至事由统计报表
	</div>
	<s:form id="serachForm" name="serachForm" action="checkeffmonthly"  method="get" namespace="/rpt" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
		            <div class="label_ltit">报表时间:</div>
		            <div class="label_rwben2">
		            	<span class="label_rwb nw">
						<input  class="datepicker iI iI-f" type="text" name="sem.pass_time_start" title="从" value="${it:formatDate(active.pass_time_start,'yyyy-MM-dd')}" />
						</span>
						<span class="label_rwb nw">
						<input  class="datepicker iI iI-t" type="text" name="sem.pass_time_end" title="到" value="${it:formatDate(active.pass_time_end,'yyyy-MM-dd')}" />
		            	</span>
		            </div>
		        </div>
        
				<div class="label_hang">
				       <div class="label_ltit">查询依据:</div>
				       <div class="label_rwbenx">
				       <s:select  name="sem.checkState" cssClass="selectKick" list="#{0:'总监审核通过',1:'活动通过'}"  headerKey="" headerValue="--请选择--" />
				       </div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">类别:</div>
				       <div class="label_rwbenx">
				       <s:select  name="sem.type" cssClass="selectKick" list="#{0:'活动申请',1:'活动结案',2:'至事由'}"  headerKey="" headerValue="--请选择--" />
				       </div>
				</div>
				
				<div class="label_hang">
		            <div class="label_ltit">部门:</div>
		            <div class="label_rwben2">
		            	<span class="label_rwb">
						<s:textfield title="部门名称" id="userdept_nameid" name="sem.dept_cname" readonly="true" />
						<s:hidden title="部门代码" id="userdept_codeid" name="sem.dept_code" readonly="true" />
						</span>
						<span class="lb nw">
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
						</span>
		            </div>
		        </div>
				
				<div class="label_hang tac">
		        	&nbsp;&nbsp;<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
					<label for="search_mcondition"></label>更多条件
		            <s:submit value="搜索" /> <s:reset value="重置" />
		            <span id="message"><s:property value="message" /></span>
		        </div>
			</div>
		</div>
	</s:form>
	
	<div class="tab_warp">
		<table>
			<tr id="coltr">
				<th class="td1">部门代码</th>
				<th class="td1">部门名称</th>
				<th class="td1">数量(个)</th>
				<th class="td3">类型</th>
				<th class="td0">查看</th>
						
			</tr>
			<s:iterator value="applys" status="sta">
			<tr id="showtr${uuid}">
				
				<td class="td1 nw">${apply_dept}</td>
				<td class="td1 nw">${dept_cname}</td>
				<td class="td1 nw">${cout}</td>
				<td class="td3 nw">${type}</td>
				<td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
			</tr>
			</s:iterator>
	    </table>
	</div>
	
	
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>