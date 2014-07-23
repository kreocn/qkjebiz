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
	$("#order_add_time").datepicker();
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">订单列表</span>
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_ADD')">
		<span class="extra1">
			<a href="<s:url namespace="/sysebiz" action="order_load"><s:param name="viewFlag">add</s:param></s:url>" >添加订单</a>
		</span>
		</s:if>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="order_list"  method="get" namespace="/sysebiz" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>订单号:</td>
<td class='secRow'><s:textfield name="order.uuid" title="订单号" /></td>
<td class='firstRow'>会员号:</td>
<td class='secRow'><s:textfield name="order.user_id" title="购货人"  /></td>
</tr><tr>
<td class='firstRow'>付款状态:</td>
<td class='secRow'>
<s:select name="order.pay_status" title="订单状态" headerKey="" headerValue="--请选择--" list="#{0:'未付款',1:'已付款'}" />
</td>
<td class='firstRow'>会员手机:</td>
<td class='secRow'><s:textfield name="order.user_mobile" title="收货人手机" /></td>
</tr><tr>
<td class='firstRow'>订单状态:</td>
<td class='secRow'><s:select name="order.status" title="订单状态" headerKey="" headerValue="--请选择--" list="#{10:'新订单',15:'已退回',20:'已受理',30:'已审核',40:'已配货',50:'已送达',60:'交易不成功',70:'交易成功',80:' 已评价'}" /></td>
<td class='firstRow'>下单时间:</td>
<td class='secRow'>
<s:textfield id="order_add_time" name="order.add_time" value="%{getText('global.date',{order.add_time})=='null'?'':getText('global.date',{order.add_time})}" title="下单时间" />
</td>
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
	<col width="125" />
	<col width="" />
	<col width="100" />
	<col width="80" />
	<col width="60" />
	<col width="150" />
	<col width="60" />
	<col width="110" />
	<col width="170" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>订单号</th>
		<th>购货人</th>
		<th>收货人手机</th>
		<th>订单总价</th>
		<th>支付方式</th>
		<th>下单时间</th>
		<th>订单来源</th>
		<th>订单状态</th>
		<th>操作</th>
	  </tr>
<s:iterator value="orders" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
		<td>(<s:property value="user_id" />)<s:property value="user_name" /></td>
		<td><s:property value="con_mobile" /></td>
		<td><s:property value="total_price" /></td>
		<td><s:if test="0==pay_type">余额支付</s:if><s:if test="1==pay_type">网上银行支付</s:if><s:if test="2==pay_type">货到付款</s:if><s:if test="3==pay_type">银行打款</s:if><s:if test="4==pay_type">当面收取</s:if><s:if test="5==pay_type">积分付款</s:if></td>
		<td><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td><s:if test="0==order_source">本站</s:if><s:if test="1==order_source">代客下单</s:if><s:if test="2==order_source">淘宝</s:if></td>
		<td>
		<s:if test="0==status">作废订单</s:if><s:if test="10==status">新订单</s:if><s:if test="15==status">已退回</s:if><s:if test="20==status">已受理</s:if><s:if test="30==status">已审核</s:if><s:if test="40==status">已配货</s:if><s:if test="50==status">已送达</s:if><s:if test="60==status">交易不成功</s:if><s:if test="70==status">交易成功</s:if><s:if test="80==status"> 已评价</s:if>
		<s:if test="0==pay_status">未付款</s:if><s:if test="1==pay_status">已付款</s:if>
		<s:if test="0==invoice_status">未开票</s:if><s:if test="1==invoice_status">已开票</s:if>
		</td>
		<td align="center">
    	[<a href="<s:url namespace="/sysebiz" action="order_load"><s:param name="viewFlag">mdy</s:param><s:param name="order.uuid" value="uuid"></s:param></s:url>">修改&审核</a>]
    	<s:if test="status>=40">
		[<a href="<s:url namespace="/sysebiz" action="order_view"><s:param name="order.uuid" value="uuid" /><s:param name="viewFlag">print</s:param></s:url>" target="_blank">订单打印</a>]
		</s:if>
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