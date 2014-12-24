<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>促销活动列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.show_dialog {
}
.ui-tooltip {
max-width: 650px !important;
}
</style>
<body>
<div class="main" >
 	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/salpro" action="salPromot_load"><s:param name="viewFlag">add</s:param></s:url>">添加促销活动</a></span>
		</s:if>
	</div>
 	<s:form id="serachForm" name="serachForm" action="salPromot_list"  method="get" namespace="/salpro" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name="leave.uuid" /></div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">查询日期:</div>
            <div class="label_rwben"><input type="text" name="leave.serach_date" class="datepicker" value="${it:formatDate(leave.serach_date,'yyyy-MM-dd')}" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben nw">
            	<s:textfield title="部门名称" id="userdept_nameid" name="leave.leave_dept_name" readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="leave.leave_dept" readonly="true" />
            </div>
			<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="leave.leave_user" list="#{}" headerKey="" headerValue="--请选择--" />
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
    <th class="td1">主题</th>
	<th class="td3">开始时间</th>
	<th class="td3">结束时间</th>
	<th class="td2">范围</th>
	<th class="td2">单据状态</th>
	<th class="td2">审核状态</th>
	<th class="td4">操作</th>
	<th class="td0">查看</th>
</tr>
<s:iterator value="salPromots" status="sta">
	  <tr id="showtr${uuid}">
	    <td class="td1"><s:property value="uuid" /></td>
	    <td class="td1">
	    	${sal_title }
	    </td>
		<td class="td3 longnote"><s:date name="startime" format="yyyy-MM-dd" /></td>
		<td class="td3 longnote"><s:date name="endtime" format="yyyy-MM-dd" /></td>
		<td class="td2 nw"><s:property value="sal_scop" /></td>
		<td class="td2 nw">
		<s:if test="status==0">未审核</s:if>
		<s:if test="status==1">审核中</s:if>
		<s:if test="status==2">审核通过</s:if>
		</td>
		<td class="td2 nw">
			<s:if test="smd_status==0 && sd_status==0">待审核</s:if>
			<s:if test="smd_status==5"><span class="message_error">销管已退回</span></s:if>
			<s:if test="smd_status==20"><span class="message_pass">销管经理已审</span></s:if>
			<s:if test="sd_status==5"><span class="message_error">总监已退回</span></s:if>
			<s:if test="sd_status==30"><span class="message_pass">总监已审</span></s:if>
		</td>
		<td  class="td4 op-area">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_MDY')">
	    	<a class="input-blue" href="<s:url namespace="/salpro" action="salPromot_load"><s:param name="viewFlag">mdy</s:param><s:param name="salPromot.uuid" value="uuid"></s:param></s:url>">修改</a>
	    	</s:if>
	    	<s:if test="status>=0">
	    	<a class="input-gray" href="<s:url namespace="/salpro" action="salPromot_print"><s:param name="leave.uuid" value="uuid" /><s:param name="salPromot.leave_type" value="leave_type" /></s:url>">打印</a>
	    	</s:if>
	    	<s:if test="status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_DEL')">
	    	<a class="input-red" href="<s:url namespace="/salpro" action="salPromot_del"><s:param name="salPromot.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	    	</s:if>	   
	    </td>
	    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	  </tr>
</s:iterator>
</table>
</div>
<div class="pagination"><script type="text/javascript">var spage = new ShowPage(${currPage});	spage.show2(${recCount},${pageSize},2);</script></div>
</div>
</body>
</html>