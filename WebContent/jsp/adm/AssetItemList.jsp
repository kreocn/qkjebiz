<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产物品列表--<s:text name="APP_NAME" /></title>
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
	CommonUtil.pickrowAll('table1','uuidcheck');
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">资产物品列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_ADD')">
			<a href="<s:url namespace="/adm" action="assetItem_load"><s:param name="viewFlag">add</s:param></s:url>" >添加资产物品</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="assetItem_list"  method="get" namespace="/adm" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>编号:</td>
<td class='secRow'><s:property value="assetItem.uuid" /><s:hidden name="assetItem.uuid" title="编号" /></td>
<td class='firstRow'>所属资产:</td>
<td class='secRow'><s:property value="assetItem.asset_id" /><s:hidden name="assetItem.asset_id" title="所属资产" /></td>
</tr><tr>
<td class='firstRow'>型号:</td>
<td class='secRow'><s:textfield name="assetItem.model" title="型号" dataLength="0,96" controlName="型号" /></td>
<td class='firstRow'>规格:</td>
<td class='secRow'><s:textfield name="assetItem.spec" title="规格" dataLength="0,96" controlName="规格" /></td>
</tr><tr>
<td class='firstRow'>所属人:</td>
<td class='secRow'><s:textfield name="assetItem.own_user" title="所属人" dataLength="0,32" controlName="所属人" /></td>
<td class='firstRow'>执行时间:</td>
<td class='secRow'><s:date name="assetItem.op_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr><tr>
<td class='firstRow'>修改人:</td>
<td class='secRow'><s:property value="assetItem.lm_user" /></td>
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
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>编号</th>
		<th>型号</th>
		<th>规格</th>
		<th>所在位置</th>
		<th>是否已领用</th>
		<th>所属人</th>
		<th>领用时间</th>
		<th>执行人</th>
		<th>执行时间</th>
		<th>操作</th>
	  </tr>
<s:iterator value="assetItems" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
		<td><s:property value="model" /></td>
		<td><s:property value="spec" /></td>
		<td><s:property value="position" /></td>
		<td><s:if test="0==is_use">未领用</s:if><s:if test="1==is_use">已领用</s:if></td>
		<td><s:property value="own_user" /></td>
		<td><s:date name="use_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td><s:property value="op_user" /></td>
		<td><s:date name="op_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_MDY')">
	    	[<a href="<s:url namespace="/adm" action="assetItem_load"><s:param name="viewFlag">mdy</s:param><s:param name="assetItem.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_DEL')">
	    	[<a href="<s:url namespace="/adm" action="assetItem_del"><s:param name="assetItem.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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