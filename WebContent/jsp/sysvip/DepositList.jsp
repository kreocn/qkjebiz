<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员预付款列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">会员预付款列表</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="deposit_list"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow3'>付款日期:</td>
			<td class='secRow3'>
				<input type="text" id="deposit_pay_date" name="deposit.pay_date" value="${it:formatDate(deposit.pay_date,'yyyy-MM-dd')}" />
				<script type="text/javascript">$("#deposit_pay_date").datepicker();</script>
			</td>
			<td class='firstRow3'>财务确认:</td>
			<td class='secRow3'><s:select name="deposit.fd_chek" title="财务确认" headerKey="" headerValue="--请选择--" list="#{0:'未确认',1:'已确认'}" /></td>
			<td class='firstRow3'>付款方式:</td>
			<td class='secRow3'><s:select name="deposit.type" title="付款方式" headerKey="" headerValue="--请选择--" list="#{0:'现金',1:'POS',2:'支票',3:'转账',4:'其他'}" /></td>
			</tr><tr>
			<td class='firstRow3'>客户编号:</td>
			<td class='secRow3'><s:textfield name="deposit.member_id" title="客户ID" dataLength="0,10" controlName="客户ID" /></td>
			<td class='firstRow3'>客户名称(%):</td>
			<td class='secRow3' colspan="3"><s:textfield name="deposit.member_id" title="客户ID" dataLength="0,10" controlName="客户ID" /></td>
			
			</tr>
			<tr>
			<td colspan="6" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>付款日期</th>
		<th>付款方式</th>
		<th>付款金额</th>
		<th>客户</th>
		<th>提交人</th>
		<th>提交时间</th>
		<th>财务确认</th>
		<th>操作</th>
	  </tr>
<s:iterator value="deposits" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td align="center"><s:date name="pay_date" format="yyyy-MM-dd" /></td>
		<td align="center"><s:if test="0==type">现金</s:if><s:if test="1==type">POS</s:if><s:if test="2==type">支票</s:if><s:if test="3==type">转账</s:if><s:if test="4==type">其他</s:if></td>
		<td align="center"><s:property value="amount" /></td>
		<td align="center">
			(<s:property value="member_id" />)<s:property value="member_name" />
		</td>
		<td align="center"><s:property value="add_user_name" /></td>
		<td align="center"><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td align="center">
			<s:if test="0==fd_check"><span class="noarea"></span></s:if>
			<s:if test="1==fd_check"><span class="yesarea"></span></s:if>
		</td>
		<td align="center">
			<c:if test="${it:checkPermit('VIP_SYSVIP_DEPOSIT',null)==true}">
	    	[<a href="<s:url namespace="/sysvip" action="deposit_load"><s:param name="viewFlag">mdy</s:param><s:param name="deposit.uuid" value="uuid"></s:param></s:url>">修改&查看</a>]
	    	</c:if>
	    	<c:if test="${it:checkPermit('VIP_SYSVIP_DEPOSIT_DEL',null)==true}">
	    	[<a href="<s:url namespace="/sysvip" action="deposit_del"><s:param name="deposit.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</c:if>	   
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage();
		spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
		</script>
		</td>	    
	  </tr>
	  <tr>
	    <td colspan="20" class="buttonarea">
	    <span id="message"><s:property value="message" /></span>
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>