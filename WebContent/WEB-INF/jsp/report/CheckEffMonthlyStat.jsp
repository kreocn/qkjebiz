<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动/至事由统计报表</title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.tab_warp th,.tab_warp td{height:25px; padding:0 10px; font-size:12px;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step"><a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;活动/至事由统计报表</div>
	<s:form id="serachForm" name="serachForm" action="checkeffmonthly"  method="get" namespace="/rpt" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">报表时间:</div>
				       <div class="label_rwben"><s:select name="yearMonth" list="yearMonths" listKey="key" listValue="value" headerKey="" headerValue="--请选择--" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">统计机构:</div>
				       <div class="label_rwbenx"><s:select name="deptGroup" list="deptGroups" listKey="key" listValue="value" headerKey="" headerValue="合并统计" /></div>
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
 		<div class="label_main">
 			<div id="activePassesArea" class="label_hang" style="margin-right:10px;">
	 			<table  id="table_activePasses" border="1" bordercolor="#ffffff">
	 				<tr>
						<th colspan="3">活动申请数量</th>
					</tr>
					<tr>
						<th>部门代码</th>
						<th>部门名称</th>
						<th>数量(个)</th>
					</tr>
					<s:iterator value="activePasses" status="sta">
						<tr>
							<td>${apply_dept}</td>
						    <td>${dept_cname}</td>
							<td>${cout}</td>
						</tr>
					</s:iterator>
					<s:if test="%{totelActivePasses.size()>0}">
					<tr>
						<td><b>总计</b></td>
					</tr>
					</s:if>
					<s:iterator value="totelActivePasses" status="sta">
						  <tr>
						    <td>${apply_dept}</td>
						    <td>${dept_cname}</td>
							<td>${cout}</td>
						  </tr>
					</s:iterator>
	 			</table>
 			</div>
 			<div id="activeAvgTimeArea" class="label_hang">
 				<table  id="table_activeAvgTime" border="1" bordercolor="#ffffff">
	 				<tr>
						<th colspan="8">活动申请审核平均时间(天)</th>
					</tr>
					<tr>
						<th>总时间</th>
						<th>方案修改时间</th>
						<th>大区审核时间</th>
						<th>销管审核时间</th>
						<th>总监审核时间</th>
						<th>销管部经理审核时间</th>
						<th>销管副总审核时间</th>
						<th>申请通过时间</th>
					</tr>
					<s:iterator value="activeAvgTime" status="sta">
					<tr>
					    <td>${total}</td>
					    <td>${edit}</td>
						<td>${mct}</td>
						<td>${xct}</td>
					    <td>${zct}</td>
					    <td>${xgt}</td>
					    <td>${xgft}</td>
						<td>${pct}</td>
					</tr>
					</s:iterator>
				</table>
 			</div>
 		</div>
 		<div class="label_main">
 			<div id="activeClosePassesArea" class="label_hang" style="margin-right:10px;">
	 			<table  id="table_activeClosePasses" border="1" bordercolor="#ffffff">
	 				<tr>
						<th colspan="3">活动结案数量</th>
					</tr>
					<tr>
						<th>部门代码</th>
						<th>部门名称</th>
						<th>数量(个)</th>
					</tr>
					<s:iterator value="activeClosePasses" status="sta">
						<tr>
							<td>${apply_dept}</td>
						    <td>${dept_cname}</td>
							<td>${cout}</td>
						</tr>
					</s:iterator>
					<s:if test="%{totelActiveClosePasses.size()>0}">
					<tr>
						<td><b>总计</b></td>
					</tr>
					</s:if>
					<s:iterator value="totelActiveClosePasses" status="sta">
						  <tr>
						    <td>${apply_dept}</td>
						    <td>${dept_cname}</td>
							<td>${cout}</td>
						  </tr>
					</s:iterator>
	 			</table>
 			</div>
 			<div id="activeCloseAvgTimeArea" class="label_hang">
 				<table  id="table_activeCloseAvgTime" border="1" bordercolor="#ffffff">
	 				<tr>
						<th colspan="8">活动结案审核平均时间(天)</th>
					</tr>
					<tr>
						<th>总时间</th>
						<th>方案修改时间</th>
						<th>大区审核时间</th>
						<th>销管审核时间</th>
						<th>总监审核时间</th>
						<th>销管部经理审核时间</th>
						<th>销管副总审核时间</th>
						<th>申请通过时间</th>
					</tr>
					<s:iterator value="activeCloseAvgTime" status="sta">
					<tr>
					    <td>${total}</td>
					    <td>${edit}</td>
						<td>${mct}</td>
						<td>${xct}</td>
					    <td>${zct}</td>
					    <td>${xgt}</td>
					    <td>${xgft}</td>
						<td>${pct}</td>
					</tr>
					</s:iterator>
				</table>
 			</div>
 		</div>
 		<div class="label_main">
 			<div id="applyPassesArea" class="label_hang" style="margin-right:10px;">
	 			<table  id="table_applyPasses" border="1" bordercolor="#ffffff">
	 				<tr>
						<th colspan="3">至事由通过数量</th>
					</tr>
					<tr>
						<th>部门代码</th>
						<th>部门名称</th>
						<th>数量(个)</th>
					</tr>
					<s:iterator value="applyPasses" status="sta">
						<tr>
							<td>${apply_dept}</td>
						    <td>${dept_cname}</td>
							<td>${cout}</td>
						</tr>
					</s:iterator>
					<s:if test="%{totelApplyPasses.size()>0}">
					<tr>
						<td><b>总计</b></td>
					</tr>
					</s:if>
					<s:iterator value="totelApplyPasses" status="sta">
						  <tr>
						    <td>${apply_dept}</td>
						    <td>${dept_cname}</td>
							<td>${cout}</td>
						  </tr>
					</s:iterator>
	 			</table>
 			</div>
 			<div id="applyAvgTimeArea" class="label_hang">
 				<table  id="table_applyAvgTime" border="1" bordercolor="#ffffff">
	 				<tr>
						<th colspan="4">至事由审核平均时间(天)</th>
					</tr>
					<tr>
						<th>总时间</th>
						<th>方案修改时间</th>
						<th>大区审核时间</th>
						<th>总监审核时间</th>
					</tr>
					<s:iterator value="applyAvgTime" status="sta">
					<tr>
					    <td>${total}</td>
					    <td>${edit}</td>
						<td>${mct}</td>
					    <td>${zct}</td>
					</tr>
					</s:iterator>
				</table>
 			</div>
 		</div>
 	</div>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>