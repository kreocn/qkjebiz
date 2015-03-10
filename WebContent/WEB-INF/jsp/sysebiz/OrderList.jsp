<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 <div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/sysebiz" action="order_load"><s:param name="viewFlag">add</s:param></s:url>" >添加订单</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="order_list"  method="get" namespace="/sysebiz" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">订单号:</div>
				       <div class="label_rwben"><s:textfield name="order.uuid"  title="订单号"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">会员号:</div>
				       <div class="label_rwben"><s:textfield name="order.user_id"  title="购货人"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">付款状态:</div>
				       <div class="label_rwben"><s:select name="order.pay_status"  title="付款状态" headerKey="" headerValue="--请选择--" list="#{0:'未付款',1:'已付款'}"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">会员手机:</div>
				       <div class="label_rwben"><s:textfield name="order.user_mobile"  title="收货人手机"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">订单状态:</div>
				       <div class="label_rwben"><s:select name="order.status"  title="订单状态" headerKey="" headerValue="--请选择--" list="#{10:'新订单',15:'已退回',20:'已受理',30:'已审核',40:'已配货',50:'已送达',60:'交易不成功',70:'交易成功',80:' 已评价'}"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">下单时间:</div>
				       <div class="label_rwben"><input id="order_add_time" class="datepicker validate[custom[date]]" type="text" name="order.add_time" title="下单时间" value="${it:formatDate(order.add_time,'yyyy-MM-dd')}" /></div>
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
	 		<table id="table1">
	 			<tr id="coltr">
	              <th  class="td1">订单号</th>
	              <th  class="td1">购货人</th>
	              <th  class="td2">收货人手机</th>
	              <th  class="td2">订单总价</th>
	              <th  class="td3">支付方式</th>
	              <th  class="td2">下单时间</th>
	              <th  class="td3">订单来源</th>
	              <th  class="td3">订单状态</th>
	              <th  class="td4">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="orders" status="sta">
		            <tr>
		            	<td  class="td1">${uuid}</td>
		            	<td  class="td1">(${user_id})${user_name}</td>
		            	<td  class="td2">${con_mobile}</td>
		            	<td  class="td2">${total_price}</td>
		            	<td  class="td3">
		            		<s:if test="0==pay_type">余额支付</s:if>
		            		<s:if test="1==pay_type">网上银行支付</s:if>
		            		<s:if test="2==pay_type">货到付款</s:if>
		            		<s:if test="3==pay_type">银行打款</s:if>
		            		<s:if test="4==pay_type">当面收取</s:if>
		            		<s:if test="5==pay_type">积分付款</s:if>
		            	</td>
		            	<td  class="td2">${it:formatDate(add_time,'yyyy-MM-dd HH:mm:ss')}</td>
		            	<td  class="td3">
		            		<s:if test="0==order_source">本站</s:if>
		            		<s:if test="1==order_source">代客下单</s:if>
		            		<s:if test="2==order_source">淘宝</s:if>
		            	</td>
		            	<td  class="td3">
		            		<s:if test="0==status">作废订单</s:if>
		            		<s:if test="10==status">新订单</s:if>
		            		<s:if test="15==status">已退回</s:if>
		            		<s:if test="20==status">已受理</s:if>
		            		<s:if test="30==status">已审核</s:if>
		            		<s:if test="40==status">已配货</s:if>
		            		<s:if test="50==status">已送达</s:if>
		            		<s:if test="60==status">交易不成功</s:if>
		            		<s:if test="70==status">交易成功</s:if>
		            		<s:if test="80==status"> 已评价</s:if>
							<s:if test="0==pay_status">未付款</s:if>
							<s:if test="1==pay_status">已付款</s:if>
							<s:if test="0==invoice_status">未开票</s:if>
							<s:if test="1==invoice_status">已开票</s:if>
		            	</td>
		            	<td  class="td4 op-area">
		            		<a class="input-blue" href="<s:url namespace="/sysebiz" action="order_load"><s:param name="viewFlag">mdy</s:param><s:param name="order.uuid" value="uuid"></s:param></s:url>">修改&审核</a>
		            		<a href="<s:url namespace="/sysebiz" action="order_view"><s:param name="order.uuid" value="uuid" /><s:param name="viewFlag">print</s:param></s:url>">订单打印</a>
		            	</td>
		            	<td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
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