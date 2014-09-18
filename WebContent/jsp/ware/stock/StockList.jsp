<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<<<<<<< HEAD
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
=======
>>>>>>> feb9453d51ca1c99062b5b6bd220313572c120f5
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>库存物品列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">库存物品列表</span>
		<span class="extra1">
			<!--<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_STOCK_ADD')">
			<a href="<s:url namespace="/stock" action="stock_load"><s:param name="viewFlag">add</s:param></s:url>" >添加库存物品</a>
			</s:if>-->
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="stock_list"  namespace="/stock"  method="post" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
				<td class='firstRow'>商品名称:</td>
				<td class='secRow'>
				<s:select name="stock.product_id" title="状态" headerKey="" headerValue="--请选择--" list="products" listKey="uuid" listValue="title" />
<<<<<<< HEAD
				</td>
				
				<td class='firstRow'>所在仓库:</td>
				<td class='secRow'>
				<s:select name="stock.store_id" title="状态" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
				</td>
			</tr>
			<tr>
				<td class='firstRow'>(统计查询)商品名称:</td>
				<td class='secRow'>
				<s:select name="stock.groupQ" title="状态" headerKey="0" headerValue="--请选择--" list="products" listKey="uuid" listValue="title" />
=======

				</td>
			</tr>
			<tr>
				<td class='firstRow'>所在仓库:</td>
				<td class='secRow'>
				<s:select name="stock.store_id" title="状态" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
>>>>>>> feb9453d51ca1c99062b5b6bd220313572c120f5
				</td>
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
	    <th>主键ID</th>
	    <th>商品名称</th>
	    <th>所在仓库</th>
		<th>库存数量</th>
	  </tr>
<s:iterator value="stocks" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
		<td><s:property value="product_name" /></td>
		<td><s:property value="store_name" /></td>
<<<<<<< HEAD
		<td>
		<s:property value="quantity" />&nbsp;瓶
		(<s:property value="%{(quantity/(case_spec*1.0)).toString().substring(0,3)}" />件)
		</td>
=======
		<td><s:property value="quantity" />&nbsp;瓶</td>
>>>>>>> feb9453d51ca1c99062b5b6bd220313572c120f5
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
	    <s:actionerror/>
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