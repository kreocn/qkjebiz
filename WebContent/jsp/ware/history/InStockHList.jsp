<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>入库历史列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">入库历史列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCKH_ADD')">
			<a href="<s:url namespace="/ware" action="inStockH_load"><s:param name="viewFlag">add</s:param></s:url>" >添加入库历史</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="inStockH_list"  method="get" namespace="/ware" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>主键ID:</td>
<td class='secRow'><s:property value="inStockH.uuid" /><s:hidden name="inStockH.uuid" title="主键ID" /></td>
<td class='firstRow'>订单编号:</td>
<td class='secRow'><s:date name="inStockH.date" format="yyyy-MM-dd HH:mm:ss" /><s:hidden name="inStockH.date" title="订单编号" /></td>
</tr><tr>
<td class='firstRow'>订单商品号:</td>
<td class='secRow'><s:textfield name="inStockH.store_id" title="订单商品号" dataLength="0,10" dataType="integer" controlName="订单商品号" /></td>
<td class='firstRow'>经办人:</td>
<td class='secRow'><s:textfield name="inStockH.operator_id" title="经办人" dataLength="0,16" controlName="经办人" /></td>
</tr><tr>
<td class='firstRow'>保管员:</td>
<td class='secRow'><s:textfield name="inStockH.take_id" title="保管员" dataLength="0,16" controlName="保管员" /></td>
<td class='firstRow'>总价:</td>
<td class='secRow'><s:textfield name="inStockH.total_price" title="总价" dataLength="0,10" dataType="number" controlName="总价" /></td>
</tr><tr>
<td class='firstRow'>添加人IP:</td>
<td class='secRow'><s:textfield name="inStockH.add_user" title="添加人IP" dataLength="0,16" controlName="添加人IP" /></td>
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
<th>经办人</th>
<th>保管员</th>
<th>入库原因</th>
<th>总价</th>
<th>添加人IP</th>
<th>添加时间</th>
<th>修改人</th>

		<th>操作</th>
	  </tr>
<s:iterator value="inStockHs" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
<td><s:property value="operator_id" /></td>
<td><s:property value="take_id" /></td>
<td><s:property value="note" /></td>
<td><s:property value="total_price" /></td>
<td><s:property value="add_user" /></td>
<td><s:date name="add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
<td><s:property value="lm_user" /></td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCKH')">
	    	[<a href="<s:url namespace="/ware" action="inStockH_load"><s:param name="viewFlag">mdy</s:param><s:param name="inStockH.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCKH_DEL')">
	    	[<a href="<s:url namespace="/ware" action="inStockH_del"><s:param name="inStockH.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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