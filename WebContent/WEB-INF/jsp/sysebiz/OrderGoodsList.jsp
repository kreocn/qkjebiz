<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">订单列表</span>
		<span class="extra1">
			<a href="<s:url namespace="/sysebiz" action="orderGoods_load"><s:param name="viewFlag">add</s:param></s:url>" >添加订单</a>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="orderGoods_list"  method="get" namespace="/sysebiz" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>0:</td>
<td class='secRow'><s:hidden name="orderGoods.uuid" title="0" /></td>
<td class='firstRow'>0:</td>
<td class='secRow'><s:hidden name="orderGoods.order_id" title="0" /></td>
</tr><tr>
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
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>0</th>
<th>0</th>
<th>单价</th>
<th>订单数量</th>
<th>实际价格</th>

		<th>操作</th>
	  </tr>
<s:iterator value="orderGoodss" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
<td><s:if test='0==goods_id'>余额支付</s:if><s:if test='1==goods_id'>网上银行支付</s:if><s:if test='2==goods_id'>货到付款</s:if></td>
<td><s:property value="per_price" /></td>
<td><s:property value="order_num" /></td>
<td><s:property value="total_price" /></td>

		<td align="center">
	    	[<a href="<s:url namespace="/sysebiz" action="orderGoods_load"><s:param name="viewFlag">mdy</s:param><s:param name="orderGoods.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	[<a href="<s:url namespace="/sysebiz" action="orderGoods_del"><s:param name="orderGoods.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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