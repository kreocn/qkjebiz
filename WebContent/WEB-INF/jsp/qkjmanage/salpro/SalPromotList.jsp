<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>促销活动列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.show_dialog {
}
.ui-tooltip {
max-width: 650px !important;
}
</style>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
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
            <div class="label_rwben"><s:textfield name="salPromot.uuid" /></div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">主题:</div>
            <div class="label_rwben"><s:textfield name="salPromot.sal_title" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">活动状态:</div>
            <div class="label_rwben label_rwb"><s:select id="status" name="salPromot.status" cssClass="selectKick" headerKey="" headerValue="-活动状态-" list="#{0:'新申请',1:'申请审批中',2:'申请通过'}" /></div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">审核状态:</div>
            <div class="label_rwben label_rwb"><s:select id="status" name="salPromot.smd_status" cssClass="selectKick" headerKey="" headerValue="-活动状态-" list="#{0:'待审核',5:'已退回',20:'经理/大区已审',30:'运营总监已审',40:'业务副总已审',50:'销管副总已审',60:'总经理已审'}" /></div>
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
	<th class="td3">返利系数</th>
	<th class="td4">操作</th>
	<th class="td0">查看</th>
</tr>
<s:iterator value="salPromots" status="sta">
	  <tr id="showtr${uuid}">
	    <td class="td1 nw"><s:property value="uuid" /></td>
	    <td class="td1 nw">
	    	${sal_title }
	    </td>
		<td class="td3 longnote"><s:date name="startime" format="yyyy-MM-dd" /></td>
		<td class="td3 longnote"><s:date name="endtime" format="yyyy-MM-dd" /></td>
		<td class="td2 nw"><s:property value="sal_scop" /></td>
		<td class="td2 nw">
		<s:if test="status==0">新申请</s:if>
		<s:if test="status==1">审核中</s:if>
		<s:if test="status==2">审核通过</s:if>
		</td>
		<td class="td2 nw">
			<s:if test="smd_status==0">待审核</s:if>
			<s:if test="smd_status==5"><span class="message_error">已退回</span></s:if>
			<s:if test="smd_status==20"><span class="message_pass">经理/大区已审</span></s:if>
			<s:if test="smd_status==30"><span class="message_pass">运营总监已审</span></s:if>
			<s:if test="smd_status==40"><span class="message_pass">业务副总已审</span></s:if>
			<s:if test="smd_status==50"><span class="message_pass">销管副总已审</span></s:if>
			<s:if test="smd_status==60"><span class="message_pass">总经理已审</span></s:if>
		</td>
		<td class="td3 nw">${rebate }</td>
		<td  class="td4 op-area">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_MDY')">
	    	<a class="input-blue" href="<s:url namespace="/salpro" action="salPromot_load"><s:param name="viewFlag">mdy</s:param><s:param name="salPromot.uuid" value="uuid"></s:param></s:url>">修改</a>
	    	</s:if>
	    	<!-- <s:if test="status>=0">
	    	<a class="input-gray" href="<s:url namespace="/salpro" action="salPromot_load"><s:param name="viewFlag">view</s:param><s:param name="salPromot.uuid" value="uuid"></s:param></s:url>">打印</a>
	    	</s:if> -->
	    	<s:if test="status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_DEL')">
	    	<a class="input-red" href="<s:url namespace="/salpro" action="salPromot_del"><s:param name="salPromot.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	    	</s:if>	   
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