<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	SimpleLoadMember(ajax_url_action,function(event, ui) {
		//$("#search_form_submit_button").click();
	});
 });
</script>
<style type="text/css">
.ui-menu .ui-menu-item a{font-size:14px;}
</style>
</head>
<body>
 <div class="main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/sysebiz" action="order_list"><s:param name="viewFlag">relist</s:param></s:url>">订单列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="travel_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<fieldset class="clear">
					<legend>订单基本信息</legend>
					<s:if test="null != order">
						<div class="label_hang">
					       <div class="label_ltit">订单号:</div>
					       <div class="label_rwben">${order.uuid}<s:hidden name="order.uuid"  title="订单号"/></div>
						</div>
						<div class="label_hang">
					       <div class="label_ltit">订单状态:</div>
					       <div class="label_rwbenx">
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
								<s:if test="1==order.pay_status"><span class="message_pass">已付款</span> (确认时间:<s:date name="order.pay_time" format="yyyy-MM-dd HH:mm:ss" />)</s:if>
								<s:hidden name="order.pay_status" />		
								<s:if test="0==order.invoice_status">未开票</s:if>
								<s:if test="1==order.invoice_status">已开票</s:if>
								<s:hidden name="order.invoice_status" />
					       </div>
						</div>
					</s:if>
					<div class="label_hang">
					       <div class="label_ltit">会员号:</div>
					       <div class="label_rwben"><s:textfield name="order.user_id" id="order_user_id" title="会员号" /></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">会员手机:</div>
					       <div class="label_rwben"><s:textfield name="order.user_mobile" id="order_user_mobile" title="会员手机" cssClass="validate[custom[integer]]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">会员姓名:</div>
					       <div class="label_rwben"><s:textfield name="order.user_name" id="order_user_name" title="会员姓名"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">支付方式:</div>
					       <div class="label_rwben">
					       		<s:select name="order.pay_type" list="#{0:'余额支付',1:'网上银行支付',2:'货到付款',3:'银行打款',4:'当面收取',5:'积分付款'}" />
					       </div>
					</div>
					<s:if test="null != order">
							<div class="label_hang">
							       <div class="label_ltit">下单时间:</div>
							       <div class="label_rwbenx">${it:formatDate(order.add_time,'yyyy-MM-dd  HH:mm:ss')}</div>
							</div>
							<div class="label_hang">
							       <div class="label_ltit">订单来源:</div>
							       <div class="label_rwbenx">
							       		<s:if test="0==order.order_source">本站</s:if>
										<s:if test="1==order.order_source">代客下单 (下单人:<s:property value="order.add_user_name" />)</s:if>
										<s:if test="2==order.order_source">淘宝 (淘宝帐号:<s:property value="order.add_user" />)</s:if>
							       </div>
							</div>
					</s:if>
				</fieldset>
 			</div>
 		</div>
	</s:form> 	
</div>
</body>
</html>