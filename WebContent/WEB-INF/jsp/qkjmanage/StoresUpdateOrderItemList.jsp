<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
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
<title>门店订单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
 	<div class="dq_step">
		<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;<a href="/qkjmanage/stores_order_findOrder">查看订单</a>&nbsp;&gt;&nbsp;订单明细
		
	</div>		<div class="tab_warp main">
		<div class="label_con">
				<div class="label_main">
						<div class='label_hang'>
							<div class='label_ltit'>编号:</div>
							<div class='label_rwben'>${sotresorder.id}<s:hidden name="closeOrder.uuid" />
							</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>提交人:</div>
							<div class='label_rwben'>${sotresorder.user_name}</div>
						</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">时间:</div>
						<div class='label_rwben' style="width:200px">${sotresorder.add_time}</div>
						</div>
					</div>
						<div class="label_hang">
							<div class="label_ltit">总价:</div>
							<div class="label_rwb">
									<div class='label_rwben'>${sotresorder.total_price}</div>
							</div>
						</div>
					</div>
					<div class="label_main">
					</div>
					
			<div class="tab_warp">
				<fieldset>
					<legend>商品清单</legend>
				<table id="orderTable">
					<tr id="coltr">
							
						<th class="td1">商品名称</th>
					<th class="td2">规格</th>
						<th class="td3">单价</th>
						<th class="td4">数量</th>
						<th class="td5">总价</th>
					
						
						 <c:if test="${it:checkPermit('QKJ_STORES_FIND_ORDER_DEL',null)==true}"> 
						
						<th class="td6">操作</th>
						</c:if>
					</tr>
					<s:iterator value="storesorderitem" status="sta">
						<tr id="tr${id}">
						 
							<td class="td1" >${title}</td>
							<td class="td2">${spec}</td>
							<td class="td3">${product_price}</td>
							
							<td class="td4"  >		<s:if test="sotresorder.is_library==0&&sotresorder.is_liqueur_ticket==0">
							<c:choose>  
    <c:when test="${it:checkPermit('QKJ_STORES_FIND_ORDER_DEL',null)==true}"><input id="hiddennum" name="${order_num}" type="hidden" value="${id}"/><input id="spinner${id}" value="${order_num}"/></c:when>  
    <c:when test="${it:checkPermit('QKJ_STORES_FIND_ORDER_DEL',null)==false}">${order_num}</c:when>  
                           </c:choose> 
                            </s:if>
                            <s:if test="sotresorder.is_liqueur_ticket==1"> ${order_num}</s:if>
                            <s:if test="sotresorder.is_library==1">
                            ${order_num}
                            </s:if>
							</td>
							<td class="td5">${order_total_price}</td>
						
							
							<c:if test="${it:checkPermit('QKJ_STORES_FIND_ORDER_DEL',null)==true}"> 
							
							<td class="td6 op-area">   <s:if test="sotresorder.is_library==0&&sotresorder.is_liqueur_ticket==0"><a  class="input-blue"   onclick="del(${id},${sotresorder.id},${order_total_price},${product_price})">修改</a></s:if><s:if test="sotresorder.is_library==1">已出库</s:if><s:if test="sotresorder.is_liqueur_ticket==1">酒票订单</s:if></td>
							</c:if>
							<%-- href="/qkjmanage/stores_order_item_delete.action?id=${id}&storesid=${sotresorder.id}&price=${product_price}"
						 --%>
						 </tr>
					</s:iterator>
				</table>
				</fieldset>
			</div>
					<s:form id="serachForm" name="serachForm" action="update_story_order_itme" method="get" namespace="/qkjmanage" theme="simple">
			<div class="tab_warp">
				<fieldset>
					<legend>是否</legend>
			          			<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">是否需要开票</div>
							<div class="label_rwbenx">
							<input type="hidden" value="${sotresorder.id}" name="storyit.id">
						     <s:radio onclick="ticket(this);"  name="storyit.is_ticket" title="是否需要开票"  list="#{0:'否',1:'是'}" value="%{sotresorder.is_ticket}" cssClass="regular-radio" />
							</div>
						</div>
					</div>
					<div class="label_main" id="invoice"  style="display:none">
							<div class="label_hang" >
								<div class="label_ltit">发票抬头:</div>
								<div class="label_rwben label_rwb">
									<s:textfield id="invoice_title" name="storyit.invoice_title" value="%{sotresorder.invoice_title}" cssClass="label_hang_linput inputNote validate[maxSize[255]]"/>
								</div>
								</div>
						<div class="label_main" >
										<div class="label_hang" >
								<div class="label_ltit">发票金额:</div>
								<div class="label_rwben label_rwb">
									<s:textfield id="invoice_price" name="storyit.invoice_price" value="%{sotresorder.invoice_price}" />
								</div>
								</div>
										<div class="label_hang" >
								<div class="label_ltit">发票编号:</div>
								<div class="label_rwben label_rwb">
									<s:textfield id="invoice_id" name="storyit.invoice_id" value="%{sotresorder.invoice_id}" />
								</div>
						</div>
							</div>
							</div>
                      <div class="label_main" >
							<div class="label_ltit">付款方式:</div>
						<div class="label_rwben label_rwb">
						<s:select name="storyit.payment_type" title="付款方式" headerKey="" headerValue="--请选择--" value="%{sotresorder.payment_type}" list="#{0:'现金',1:'POS',2:'支票',3:'转账',4:'其他'}" />
						</div>
					</div>
						<div class="label_main">
							<div class="label_ltit">是否欠款</div>
							<div class="label_rwbenx">
						     <s:radio onclick="arrears(this);"  name="storyit.is_arrears" title="是否欠款" value="%{sotresorder.is_arrears}"  list="#{0:'否',1:'是'}" cssClass="regular-radio" />
							</div>
						</div>
					
						<div class="label_hang" id="arrears" style="display: none" >
						<div class="label_ltit">欠款金额:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="arrears_price" name="storyit.arrears_price" value="%{sotresorder.arrears_price}"/>
						</div>
					</div>
						<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">备注:</div>
						<div class="label_rwbenx">
							<s:textarea id="storyit_remark" name="storyit.remark" title="活动备注" cssClass="label_hang_linput inputNote validate[maxSize[65535]]" value="%{sotresorder.remark}"/>
						</div>
					</div>
				</div>
				<div class="label_hang">
					<s:submit type="reset" value="提交"  id="sumbit_order" cssClass="input-blue" />
					</div>
						</fieldset>
			</div>
			</s:form>
	</div>
		</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript">
	 $(function() {
		    $('#orderTable tr').each(function (){    
	    	    var id=$(this).children('td').find("input").val();
	    	     var spinner = $("#spinner"+id).spinner();
	 		     var a= $(this).children('td').find("#hiddennum").attr("name");
	 		    $("#spinner"+id).spinner({
	 		    	  max: a,
	 		    	  min: 0
	 		    	});
	 		    $("#spinner"+id).attr("readOnly",true);
	    	            });
	 });
	</script>
	<script type="text/javascript">
	function del(id,storesorder_id,totalPrice,price){
		       	 var num=$( "#spinner"+id ).spinner( "value" );
		 		$("#tr"+id).find(".input-blue").attr("href","/qkjmanage/stores_order_item_delete.action?id="+id+"&storesid="+storesorder_id+"&totalPirce="+totalPrice+"&num="+num+"&price="+price+"");
		 		$("#tr"+id).find(".input-blue").click(); 
	}
	
	var ticket = function(obj){
		
		if (getRadio("storyit.is_ticket") == 1) {
			
			document.getElementById("invoice").style.display = "";
			
			
		} else {
			document.getElementById("invoice").style.display = "none";
		}
	}
	var arrears = function(obj){
		if (getRadio("storyit.is_arrears") == 1) {
			document.getElementById("arrears").style.display = "";
		} else {
			document.getElementById("arrears").style.display = "none";
		}
	}
	$(function(){
		var is_ticket=${sotresorder.is_ticket};
		if(is_ticket==1){
			$("#invoice").css("display","")
		}
		var is_arrears=${sotresorder.is_arrears};
		if(is_arrears==1){
			$("#arrears").css("display","");
		}
	})
	</script>
</body>
</html>