<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库提货单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
<div class="main" >
 	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="lading_load"><s:param name="viewFlag">add</s:param></s:url>">添加订单</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="apply_list"  method="get" namespace="/qkjmanage" theme="simple">
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
            <div class="label_rwben2">
            	<span class="label_rwb nw"><s:select name="lading.status" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'新单',1:'待审核',2:'结案'}" /></span>
				<span class="label_rwb nw"><s:select name="lading.out_flag" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'未出货',1:'已出货'}" /></span>
            </div>
        </div>
 	</div></div>
 	</s:form>
 	<div class="tab_warp">
		<table>
			<tr id="coltr">
			    <th>编号</th>
			    <th class="td2">客户名称</th>
			    <th class="td1">提交时间</th>
				<th class="td3">提交部门</th>
				<th class="td1">提交人</th>
				<th class="td4">财务状态</th>
				<th class="td4">发货状态</th>
				<th class="td4">操作</th>
				<th class="td0">查看</th>
			</tr>
			<s:iterator value="ladings" status="sta">
			<tr id="showtr${uuid}">
			    <td>${uuid}</td>
			    <td class="td1 longnote">${member_name}</td>
			    <td class="td2 nw">${it:formatDate(apply_time,'yyyy-MM-dd')}</td>
			    <td class="td1 nw"></td>
				<td class="td3 nw">${applicant_name}</td>
				<td class="td1 nw">
						<s:if test="2>fd_check"><span class="noarea"></span></s:if>
						<s:elseif test="2==fd_check"><span class="yesarea" title="<s:date name="fd_check_time" format="yyyy-MM-dd HH:mm:ss" />"></span></s:elseif>
				</td>
				<td class="td1 nw">
						<s:if test="2>fd_check"><span class="noarea"></span></s:if>
						<s:elseif test="2==fd_check"><span class="yesarea" title="<s:date name="fd_check_time" format="yyyy-MM-dd HH:mm:ss" />"></span></s:elseif>
				</td>
				<td class="td4 op-area">
					<a class="input-blue" href="<s:url namespace="/qkjmanage" action="lading_load"><s:param name="viewFlag">mdy</s:param><s:param name="lading.uuid" value="uuid"></s:param></s:url>">修改</a>
				</td>
				<td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
			</tr>
			</s:iterator>
	    </table>
	</div>
</div>
</body>
</html>