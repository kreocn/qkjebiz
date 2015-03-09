<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库提货单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
 	<div class="dq_step">
		<a href='/manager/default'>首页</a> > 订单确认列表
	</div>
	<s:form id="serachForm" name="serachForm" action="lading_checkList"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con"><div class="label_main">
 		<div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name='lading.uuid' /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">客户ID:</div>
            <div class="label_rwben"><s:textfield name='lading.member_id' /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">客户名称:</div>
            <div class="label_rwben"><s:textfield name='lading.member_name' /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">状态:</div>
            <div class="label_rwben">
            	<span class="label_rwb nw"><s:select name="lading.status" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'新单',5:'已退回',10:'待确认',20:'已确认',30:'已发货'}" /></span>
            </div>
        </div>
        <div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        </div>
 	</div></div>
 	</s:form>
 	<div class="tab_warp">
		<table>
			<tr id="coltr">
			    <th class="td3">编号</th>
			    <th class="td1">提交时间</th>
			    <th class="td3">提交部门</th>
			    <th class="td2">客户名称</th>
				<th class="td1">提交人</th>
				<th class="td1">状态</th>
				<th class="td4">操作</th>
				<th class="td0">查看</th>
			</tr>
			<s:iterator value="ladings" status="sta">
			<tr id="showtr${uuid}">
			    <td class="td3">${uuid}</td>
			    <td class="td1 nw">${it:formatDate(apply_time,'yyyy-MM-dd')}</td>
			    <td class="td3 nw">${apply_dept_name}</td>
			    <td class="td2 longnote">${member_name}</td>
				<td class="td1 nw">${applicant_name}</td>
				<td class="td1 nw">
					<s:if test='0==status'>新单</s:if>
	    			<s:if test='5==status'><span title="${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}" class="cr">已退回(${check_user_name})</span></s:if>
					<s:if test='10==status'><span title="${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}" class="cy">待确认(${check_user_name})</span></s:if>
					<s:if test='20==status'><span title="${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}" class="cg">已确认(${check_user_name})</span></s:if>
					<s:if test='30==status'><span  title="${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}" class="cg">已发货</span></s:if>
				</td>
				<td class="td4 op-area">
					<a class="input-blue" href="<s:url namespace="/qkjmanage" action="lading_Checkload"><s:param name="viewFlag">mdy</s:param><s:param name="lading.uuid" value="uuid"></s:param></s:url>">修改</a>
				</td>
				<td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
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