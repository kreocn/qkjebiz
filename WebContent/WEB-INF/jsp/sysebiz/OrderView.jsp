<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/single/cellar.css" />" />
<link rel="stylesheet" href="<s:url value="/css/print.css" />" />
<script type="text/javascript" src="<s:url value="/js/singlejs/cellar_list.js" />"></script>
<style type="text/css">
body{font-size:12px;}
.printTab td{border:1px solid #000; padding:5px;}
.dy_title{padding:10px 0; font-size:14px; font-weight: bold;}
.firstRow{text-align: right; font-weight: bold;}
.printTab .titleRow{text-align:center; font-size:14px; padding:10px 0; background:#f1f1f1; font-weight: bold;}
.printTab .lb_jpin td,.lb_jpin th{border:none; border:1px solid #bbb;}
.noprint{text-align: center;}
</style>
</head>
<body>
 <s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="noprint"><input type="button" onclick="window.print();" value="打印本页"/></div>
 	<p class="dy_title">订单信息(会员号:${order.user_id}&nbsp;&nbsp;订单号:${order.uuid})</p>
 	<table width="100%" cellpadding="0" cellspacing="0" border="0" class="printTab">
 		<tr>
 			<td colspan="6" class='titleRow'>订单基本信息</td>
 		</tr>
 		<tr>
 			<td class='firstRow'>订单号:</td>
 			<td>${order.uuid}</td>
 			<td class='firstRow'>订单状态:</td>
 			<td>
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
 			<td class='firstRow'>订单来源:</td>
 			<td>
 				<s:if test="0==order.order_source">本站</s:if>
				<s:if test="1==order.order_source">代客下单 (下单人:${order.add_user_name})</s:if>
				<s:if test="2==order.order_source">淘宝 (淘宝帐号:${order.add_user_name})</s:if>
 			</td>
 		</tr>
 		<tr>
 			<td class='firstRow'>支付方式:</td>
 			<td>
 				<s:if test="0==order.pay_type">余额支付</s:if>
				<s:if test="1==order.pay_type">网上银行支付</s:if>
				<s:if test="2==order.pay_type">货到付款</s:if>
				<s:if test="3==order.pay_type">银行打款</s:if>		
				<s:if test="4==order.pay_type">当面收取</s:if>
				<s:if test="5==order.pay_type">积分付款</s:if>
 			</td>
 			<td class='firstRow'>支付时间:</td>
 			<td><s:date name="order.pay_time" format="yyyy-MM-dd HH:mm:ss" /></td>
 			<td class='firstRow'>下单时间:</td>
 			<td><s:date name="order.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
 		</tr>
 		<tr> 			
 			<td class='firstRow'>购货人信息:</td>
 			<td colspan="5">姓名：${order.user_name}&nbsp;&nbsp;手机：${order.user_mobile}&nbsp;&nbsp;会员号：${order.user_id}</td>
 		</tr> 		
 		<tr>
 			<td colspan="6" class='titleRow'>订单附加信息</td>
 		</tr>
 		<tr> 			
 			<td class='firstRow'>订单备注:</td>
 			<td colspan="5">${order.note}</td>
 		</tr> 	 		
 		<tr>
 			<td colspan="6" class='titleRow'>收货人信息</td>
 		</tr>
 		<tr>
 			<td class='firstRow'>收货人姓名:</td>
 			<td>${order.con_name}</td>
 			<td class='firstRow'>联系电话:</td>
 			<td>${order.con_mobile}</td>
 			<td class='firstRow'>收货地区:</td>
 			<td>${order.con_province}&nbsp;&nbsp;${order.con_city}&nbsp;&nbsp;${order.con_area}</td>
 		</tr>
 		<tr>
 			<td class='firstRow'>邮编:</td>
 			<td>${order.con_post}</td>
 			<td class='firstRow'>街道地址:</td>
 			<td>${order.con_street}</td>
 			<td class='firstRow'>收货人备注:</td>
 			<td>${order.con_note}</td>
 		</tr> 	 		
 		<tr>
 			<td colspan="6" class='titleRow'>商品信息</td>
 		</tr>
 		<tr>
 			<td colspan="6">
 				<table class="lb_jpin" width="100%">
					<tr>
						<th>编号</th>
						<th>商品名称</th>
						<th>单价</th>
						<th>订单数量</th>
						<th>保管费</th>
						<th>保管截至时间</th>
						<th>小计</th>
					</tr>
					<s:iterator value="orderGoodss" status="sta">
						<tr>
							<td>${uuid}</td>
							<td>${goods_name}</td>
							<td>￥${per_price}</td>
							<td>${order_num} ${goods_unit}</td>
							<td>${storage_fees}</td>
							<td><s:date name="storage_date" format="yyyy-MM-dd" /></td>
							<td>￥${total_price}</td>
						</tr>
					</s:iterator>
					<tr>
						<td colspan="6" style="text-align:right;">订单总价:</td>
						<td>￥${order.total_price}</td>
					</tr>
				 </table>
 			</td>
 		</tr>
 		<tr>
 			<td colspan="6">
 				<s:form id="add_form" name="form_add_form" theme="simple">
					<div id="cellar_list_exists"></div>
				</s:form>
 			</td>
 		</tr>
 	</table>
 	<div class="noprint"><input type="button" onclick="window.print();" value="打印本页"/></div>
 </div>
 </div>
 <s:action name="ref_foot" namespace="/manager" executeResult="true" />
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
</body>
</html>