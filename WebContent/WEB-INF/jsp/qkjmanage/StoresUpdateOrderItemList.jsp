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
						<th class="td1">商品编号</th>
						<th class="td3">商品名称</th>
						<th class="td3">商品类型</th>
						<th class="td3">单价</th>
						<th class="td3">数量</th>
						<th class="td1">总价</th>
						<th class="td2">条形码</th>
						<th class="td4">规格</th>
						 <c:if test="${it:checkPermit('QKJ_QKJMANAGE_STORES_FIND_ORDER_DEL',null)==true}"> 
						
						<th class="td4">操作</th>
						</c:if>
					</tr>
					<s:iterator value="storesorderitem" status="sta">
						<tr id="tr${id}">
						    <td class="td1" >${id}</td>
							<td class="td2" >${title}</td>
							<td class="td3">${brand_name}</td>
							<td class="td3">${product_price}</td>
							<td class="td4"  >		<c:if test=""> </c:if>
							<c:choose>  
    <c:when test="${it:checkPermit('QKJ_QKJMANAGE_STORES_FIND_ORDER_DEL',null)==true}"><input id="hiddennum" name="${order_num}" type="hidden" value="${id}"/><input id="spinner${id}" value="${order_num}"/></c:when>  
    <c:when test="${it:checkPermit('QKJ_QKJMANAGE_STORES_FIND_ORDER_DEL',null)==false}">${order_num}</c:when>  
                           </c:choose> 
							</td>
							<td class="td5">${order_total_price}</td>
							<td class="td6">${bar_code}</td>
							<td class="td7">${spec}</td>
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_STORES_FIND_ORDER_DEL',null)==true}"> 
							<td class="td4 op-area"><a  class="input-blue"  onclick="deleteorder(${id},${sotresorder.id},${order_total_price},${product_price})">保存</a></td>
							</c:if>
							<%-- href="/qkjmanage/stores_order_item_delete.action?id=${id}&storesid=${sotresorder.id}&price=${product_price}"
						 --%>
						 </tr>
					</s:iterator>
				</table>
				</fieldset>
			</div>
		</div>
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
	function deleteorder(id,storesorder_id,totalPrice,price){
		 var num=$( "#spinner"+id ).spinner( "value" );
		$("#tr"+id).find(".input-blue").attr("href","/qkjmanage/stores_order_item_delete.action?id="+id+"&storesid="+storesorder_id+"&totalPirce="+totalPrice+"&num="+num+"&price="+price+"");
		$("#tr"+id).find(".input-blue").click(); 
	}
	</script>
</body>
</html>