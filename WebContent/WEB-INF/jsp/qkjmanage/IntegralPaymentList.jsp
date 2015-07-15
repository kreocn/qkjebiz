<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.tab_warp th {
	 background: #059c77;
     color: #fff; 
     font-size: 14px; 
     padding: 0 2px;
     height: 33px;
     white-space: nowrap; 
     word-break: break-all; 
     vertical-align: middle;
     width:110px;
}
</style>
<title>积分消费--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">	<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;积分消费</div>
			<s:form id="serachForm" name="serachForm" action="integralPayment_add" method="get" namespace="/qkjmanage" theme="simple">
				<div class="label_con">
					<div class="label_main">

						<div class="label_ltit">会员名称:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_name"/>
						<input type="hidden" name="integralPay.member_id" id="order_user_id" value=""  >
						</div>
					</div>
					</div>
						<div class="label_main">
						<div class="label_ltit">消费说明:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="payContent" name="integralPay.payContent"  cssClass="label_hang_linput validate[required,maxSize[255]]"/>
						</div>
					</div>
						<div class="label_main">
						<div class="label_ltit">消费详情:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="payDetails" name="integralPay.payDetails"  cssClass="label_hang_linput validate[required,maxSize[255]]"/>
						</div>
					</div>
					<div class="label_main">
						<div class="label_ltit">消费积分:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="integral" name="integralPay.integral"   onkeyup="update_price()"/>
						</div>
					</div>
					
						<input type="button" onclick="nonull()" style="margin-left:100px;margin-top:10px" value="确定" >
										<span id="message"><s:property value="message" /></span>
							</s:form>
				</div>
	
			<div class="tab_warp">
			</div>
		
		</div>

	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<c:url value="/js/func/select_products.js" />"></script>
	<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />">
</script>
<script type="text/javascript">

$(function(){
	SimpleLoadProducts(function(){},"noparam=true");
 });
$(function(){
	SimpleLoadMember(ajax_url, $.noop);
 });
 function nonull(){

	 if($("#order_user_name").val().trim()==""){
		 alert("会员名称不能为空")
	 }else if($("#payContent").val().trim()==""){
		 alert("消费说明不能为空")
	 }else if($("#payDetails").val().trim()==""){
		 alert("消费详情不能为空")
	 }else if($("#integral").val()==""||$("#integral").val().trim()=="0"){
		 alert("消费积分不能为空且不能为0")
	 }else{
		 $("#serachForm").submit();
	 }
 }
 function update_price(){
	 var integral=$("#integral").val();
     if(isNaN(integral))
     {
    	 var count=integral.length;
    	 if(count=="1"){
    		 $("#integral").val("");
    	 }else{
    	 var integral=$("#integral").val(parseInt(integral));
    	 }
     }
 }
</script>
</body>
</html>