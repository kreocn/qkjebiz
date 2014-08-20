<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/singlejs/cellar_list.js" />"></script>
<link rel="stylesheet" href="<s:url value="/css/single/cellar.css" />" />
<style type="text/css">
.orderconsigneshow {line-height: 30px;}
.goods_num_show {display: inline-block;zoom:1;*display: inline;}
</style>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table_goods_list');
	
	/*<s:iterator value="memberCellars">*/
	addCellar('<s:property value="uuid" />','<s:property value="order_goods_id" />','<s:property value="cellar_position" />',
			'<s:property value="num" />','<s:property value="num" />','<s:property value="camera" />',
			'<s:property value="order_id" />','<s:property value="goods_id" />','<s:property value="goods_name" />',
			'<s:property value="order_num" />','<s:property value="ware_id" />','<s:property value="ware_name" />');
	/*</s:iterator>*/
	setPnumText();
});
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">订单信息(会员号:<s:property value="order.user_id" /> 订单号:<s:property value="order.uuid" />)</span>
	</div>
<s:form name="form1" action="order_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<tr><td class="titleRow" colspan="20">订单基本信息</td></tr>
		<s:if test="null != order">
		<tr>
		<td class='firstRow'>订单号:</td>
		<td class='secRow'><s:property value="order.uuid" /><s:hidden name="order.uuid" title="订单号" /></td>
		<td class='firstRow'>订单状态:</td>
		<td class='secRow'>
		<s:if test="0==order.status">作废订单</s:if>
		<s:if test="10==order.status">新订单</s:if>
		<s:if test="15==order.status">已退回</s:if>
		<s:if test="20==order.status">已受理</s:if>		
		<s:if test="30==order.status">已审核</s:if>
		<s:if test="40==order.status">已配货</s:if>
		<s:if test="50==order.status">已送达</s:if>
		<s:if test="60==order.status">交易不成功</s:if>
		<s:if test="70==order.status">交易成功</s:if>
		<s:if test="80==order.status"> 已评价</s:if>
		<s:hidden name="order.status" />
		
		<s:if test="0==order.pay_status">未付款</s:if>
		<s:if test="1==order.pay_status">已付款</s:if>
		<s:hidden name="order.pay_status" />
		
		<s:if test="0==order.invoice_status">未开票</s:if>
		<s:if test="1==order.invoice_status">已开票</s:if>
		<s:hidden name="order.invoice_status" />
		</td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'> 购货人信息:</td>
		<td class='secRow' colspan="3">
			<table class="ilisttable" width="100%">
			<tr>
			<td class="firstRow3">姓名:</td>
			<td class="secRow3"><s:property value="order.user_name" /></td>
			<td class="firstRow3">手机:</td>
			<td class="secRow3"><s:property value="order.user_mobile" /></td>
			<td class="firstRow3">会员号:</td>
			<td class="secRow3"><s:property value="order.user_id" /></td>
			</tr>
			</table>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>支付方式:</td>
		<td class='secRow'>
			<s:if test="0==order.pay_type">余额支付</s:if>
			<s:if test="1==order.pay_type">网上银行支付</s:if>
			<s:if test="2==order.pay_type">货到付款</s:if>
			<s:if test="3==order.pay_type">银行打款</s:if>		
			<s:if test="4==order.pay_type">当面收取</s:if>
			<s:if test="5==order.pay_type">积分付款</s:if>
		</td>
		<td class='firstRow'>支付时间:</td>
		<td class='secRow'><s:date name="order.pay_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'>下单时间:</td>
		<td class='secRow'><s:date name="order.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td class='firstRow'>订单来源:</td>
		<td class='secRow'>
			<s:if test="0==order.order_source">
				本站
			</s:if>
			<s:if test="1==order.order_source">
				代客下单 (下单人:<s:property value="order.add_user_name" />)
			</s:if>
			<s:if test="2==order.order_source">
				淘宝 (淘宝帐号:<s:property value="order.add_user_name" />)
			</s:if>
			
		</td>
		</tr>
		<tr><td class="titleRow" colspan="20">订单附加信息</td></tr>
		<tr>
		<td class='firstRow'>订单备注:</td>
		<td class='secRow' colspan="3">	<s:property value="order.note" /></td>
		</tr>
		
		<tr><td class="titleRow" colspan="20">收货人信息</td></tr>
		<tr>
			<td class='firstRow'>收货人姓名:</td>
			<td class='secRow'><s:property value="order.con_name" /></td>
			<td class='firstRow'>联系电话:</td>
			<td class='secRow'><s:property value="order.con_mobile" /></td>
		</tr>
		<tr>
			<td class='firstRow'>收货地区:</td>
			<td class='secRow'>
				<s:property value="order.con_province" />
				<s:property value="order.con_city" />
				<s:property value="order.con_area" />
			<td class='firstRow'>邮编:</td>
			<td class='secRow'><s:property value="order.con_post" /></td>
		</tr>
		<tr>
			<td class='firstRow'>街道地址:</td>
			<td class='secRow'><s:property value="order.con_street" /></td>
			<td class='firstRow'>收货人备注:</td>
			<td class='secRow'><s:property value="order.con_note" /></td>
		</tr>
		
		<tr>
		<td class="titleRow" colspan="20">商品信息</td>
		</tr>

		<tr>
			<td colspan="20" class="tablearea">
			<table class="ilisttable" id="table_goods_list" width="100%">
			  <tr>
			  	<th width="50">编号</th>
				<th>商品名称</th>
				<th>单价</th>
				<th>订单数量</th>
				<th>保管费</th>
				<th>保管截至日期</th>
				<th>小计</th>
			  </tr>
			<s:iterator value="orderGoodss" status="sta">
			  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
			  	<th><s:property value="uuid" /></th>
				<td><s:property value="goods_name" /></td>
				<td>￥<s:property value="per_price" /></td>
				<td><s:property value="order_num" /> <s:property value="goods_unit" /></td>
				<td>￥<s:property value="storage_fees" /></td>
				<td><s:date name="storage_date" format="yyyy-MM-dd" /></td>
				<td>￥<s:property value="total_price" /></td>
			  </tr>
			</s:iterator>
				<tr>
					<td colspan="5"></td>
					<td align="right">订单总价:</td>
					<td>￥<s:property value="order.total_price" /></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
		<td colspan="20">
<s:form id="add_form" name="form_add_form" theme="simple">
<div id="cellar_list_exists"></div>
</s:form>
		</td>
		</tr>
	</table>	
</s:form>
	</div>
</div>
</div>
<div class="printarea"><input type="button" onclick="window.print();" value="打印本页"/></div>
</body>
</html>