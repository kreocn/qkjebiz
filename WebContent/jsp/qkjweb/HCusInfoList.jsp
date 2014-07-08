<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动客户管理列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">活动客户列表(2014年股东送酒活动)</span>
		<!-- 
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('WEB_QKJWEB_HCUSINFO_ADD')">
			<a href="<s:url namespace="/webmanager" action="hCusInfo_load"><s:param name="viewFlag">add</s:param></s:url>" >添加活动客户</a>
			</s:if>
		</span>
		 -->
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="hCusInfo_list"  method="get" namespace="/webmanager" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>证券卡号:</td>
			<td class='secRow'>
				<s:textfield name="hcusInfo.security" />
				<s:hidden name="hcusInfo.linkid" title="投票ID" />
			</td>
			<td class='firstRow'>是否已快递:</td>
			<td class='secRow'>
				<s:select list="#{0:'未快递',1:'已快递' }" headerKey="" headerValue="--请选择--" name="hcusInfo.express_status" />
			</td>
			</tr><tr>
			<td class='firstRow'>姓名:</td>
			<td class='secRow'><s:textfield name="hcusInfo.fullname" title="姓名" dataLength="0,32" controlName="姓名" /></td>
			<td class='firstRow'>联系手机:</td>
			<td class='secRow'><s:textfield name="hcusInfo.mobile" title="联系手机" dataLength="0,32" controlName="联系手机" /></td>
			</tr>
			<tr>
			<td colspan="4" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	  <tr>
	    <th>系统编号</th>
	    <th>证券卡号</th>
		<th>姓名</th>
		<th>联系手机</th>
		<th>地址</th>
		<th>是否已快递</th>
		<th>快递单号</th>
		<th>操作</th>
	  </tr>
<s:iterator value="hcusInfos" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center" class="nowrap"><s:property value="uuid" /></td>
	    <td align="center" class="nowrap"><s:property value="security" /></td>
		<td align="center" class="nowrap"><s:property value="fullname" /></td>
		<td align="center" class="nowrap"><s:property value="mobile" /></td>
		<td align="center"><s:property value="address" /></td>
		<td align="center" class="nowrap">
			<s:if test="express_status==0">
				<span class="message_error">未快递</span>
			</s:if>
			<s:elseif test="express_status==1">
				<span class="message_pass">已快递</span>
			</s:elseif>
		</td>
		<td align="center" class="nowrap"><s:property value="express_no" /></td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('WEB_QKJWEB_HCUSINFO_MDY')">
	    	<span class="nowrap">[<a href="<s:url namespace="/webmanager" action="hCusInfo_load"><s:param name="viewFlag">mdy</s:param><s:param name="hcusInfo.uuid" value="uuid"></s:param></s:url>">修改信息</a>]</span>
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('WEB_QKJWEB_HCUSINFO_EXPRESS')">
	    	<span class="nowrap">[<a href="<s:url namespace="/webmanager" action="hCusInfo_loadExpress"><s:param name="hcusInfo.uuid" value="uuid"></s:param></s:url>">发快递</a>]</span>
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('WEB_QKJWEB_HCUSINFO_DEL')">
	    	<span class="nowrap">[<a href="<s:url namespace="/webmanager" action="hCusInfo_del"><s:param name="hcusInfo.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]</span>
	    	</s:if>
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
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