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
<title>门店财务对账列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
	<div class="tab_warp main" >
 	<div class="dq_step">
		<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;财务对账单
	</div>		
	
	
	
	<s:form id="serachForm" name="serachForm" action="stores_order_finance_details"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name='sotresorder.id' value=""/></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">订单时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input type="text" class="datepicker iI iI-f" name="sotresorder.time_begin" title="从" value="${it:formatDate(apply.apply_time_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input type="text" class="datepicker iI iI-t" name="sotresorder.time_end" title="到" value="${it:formatDate(apply.apply_time_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
     
        <div class="label_hang tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        </div>
	</div>
 	</div>
 	</s:form>
	
	
	
	
	
	
	
	<div class="tab_warp">
 		<table>
 		<tr id="coltr">
	    <th class="td1">编号</th>
		<th class="td2">提交人</th>
		<th class="td3">时间</th>
		<th class="td4">总价</th>
		<th class="td5">订单类型</th>
		<th class="td6">是否需要开票</th>
		<th class="td7">发票抬头</th>
		<th class="td8">发票金额</th>
		<th class="td9">发票编号</th>
		<th class="td10">付款方式</th>
		<th class="td11">是否欠款</th>
			<th class="td12">欠款金额</th>
		<th class="td13">备注</th>
	
		<th class="td14">查看</th>
	  	</tr>
	  		<s:iterator value="storesorderlist" status="sotresorder">
	  	<tr id="showtr${id}">
		    <td class="td1 nw">${id}</td>
			<td class="td2 nw">${user_name}</td>
			<td class="td3 nw">${add_time}</td>
			<td class="td4 nw" >${total_price}</td>
				<td class="td4 nw" >
				
				<s:if test="is_liqueur_ticket==1">酒票订单</s:if>
						<s:if test="!is_liqueur_ticket==1">门店订单</s:if>
					</td>
		
				<td class="td6 nw" >
				<s:if test="is_ticket==1">是</s:if>
						<s:if test="!is_ticket==1">否</s:if>
					</td>
			<td class="td7">
			${invoice_title}
			</td>
			<td class="td8">
					${invoice_price}
			</td>
			<td class="td9 op-area nw">
						${invoice_id}
		    </td>
		    	<td class="td10 op-area nw">
					<s:if test="payment_type==0">现金</s:if>
						<s:if test="payment_type==1">POS</s:if>
						<s:if test="payment_type==2">支票</s:if>
						<s:if test="payment_type==3">转账</s:if>
						<s:if test="payment_type==4">其他</s:if>
		    </td>
		    	<td class="td11 op-area nw">
				
					<s:if test="is_arrears==0">否</s:if>
							<s:if test="is_arrears==1">是</s:if>
		    </td>
		        	<td class="td12 op-area nw">
						${arrears_price}
		    </td>
		    	
		    	
		    	   	<td class="td13 op-area nw">
					${remark}
		    </td>
		    	
		    <td class="td14 op-area nw"><a onclick="myshowDetail('showtr${id}',${id});" href="javascript:;" class="input-nostyle">查看</a></td>
	  	</tr>
	  	
	  	
	  	
	  	</s:iterator>
 		</table>
 	</div>
	
	
				<%-- <s:iterator value="storesorderlist" status="sotresorder">
		<fieldset>
					<legend>订单</legend>
			<div class="tab_warp">
				<fieldset>
					<legend>基本信息</legend>
					<div class="label_main">
						<div class='label_hang'>
							<div class='label_ltit'>编号:</div>
							<div class='label_rwben'>${id}<input type="hidden" value="${id}" name="listid"></div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>提交人:</div>
							<div class='label_rwben'>${user_name}</div>
						</div>
					<div class="label_hang">
						<div class="label_hang">
							<div class="label_ltit">时间:</div>
						<div class='label_rwben' style="width:200px">${add_time}</div>
						</div>
					</div>
						<div class="label_hang">
							<div class="label_ltit">总价:</div>
							<div class="label_rwb">
									<div class='label_rwben'>${total_price}</div>
							</div>
						</div>
					</div>
			          			<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">是否需要开票：</div>
							<div class="label_rwbenx">
					
							<s:if test="is_ticket==1">是</s:if>
						<s:if test="!is_ticket==1">否</s:if>
							</div>
						</div>
					</div>
					<s:if test="is_ticket==1">
							<div class="label_hang" id="invoice" >
								<div class="label_ltit">发票抬头:</div>
								<div class="label_rwben label_rwb">
								${invoice_title}
								</div>
								<div class="label_ltit">发票金额:</div>
								<div class="label_rwben label_rwb">
									${invoice_price}
								</div>
								<div class="label_ltit">发票编号:</div>
								<div class="label_rwben label_rwb">
							${invoice_id}
								</div>
							</div>
							</s:if>
                      <div class="label_hang" >
							<div class="label_ltit">付款方式:</div>
						<div class="label_rwben label_rwb">
						<s:if test="payment_type==0">现金</s:if>
						<s:if test="payment_type==1">POS</s:if>
						<s:if test="payment_type==2">支票</s:if>
						<s:if test="payment_type==3">转账</s:if>
						<s:if test="payment_type==4">其他</s:if>
						</div>
					</div>
						<div class="label_hang">
							<div class="label_ltit">是否欠款</div>
							<div class="label_rwbenx">
							<s:if test="is_arrears==0">否</s:if>
							<s:if test="is_arrears==1">是</s:if>
							</div>
						</div>
					<s:if test="is_arrears==1">
						<div class="label_hang" id="arrears"  >
						<div class="label_ltit">欠款金额:</div>
						<div class="label_rwben label_rwb">
						${arrears_price}
						</div>
					</div>
					</s:if>
						<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">备注:</div>
						<div class="label_rwbenx">
						${remark}
						</div>
					</div>
				</div>
				<div class="label_hang">
					</div>
						</fieldset>
			</div>	<div class="tab_warp" id="div${id}"></div>
				</fieldset>
			</s:iterator> --%>
			<%-- 	<fieldset>
					<legend>商品清单</legend>
				<table id="orderTable">
				<tr id="coltr">
				<th class="td1">商品名称</th>
					<th class="td2">规格</th>
						<th class="td3">单价</th>
						<th class="td4">数量</th>
						<th class="td5">总价</th>
					</tr>
					<s:iterator value="storesorderitem" status="sta">
						<tr id="tr${id}">
							<td class="td1" >${title}</td>
							<td class="td2">${spec}</td>
							<td class="td3">${product_price}</td>
							<td class="td4"  >${order_num}	</td>
							<td class="td5">${order_total_price}</td>
							href="/qkjmanage/stores_order_item_delete.action?id=${id}&storesid=${sotresorder.id}&price=${product_price}"
						 </tr>
					</s:iterator>
				</table>
				</fieldset> --%>
			<div id="listpage" class="pagination"></div>
			</div>
				</div>	 
				
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript">
	$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
	});
	$(function my(){
		var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url_action;
		ajax.config._success = function(data, textStatus){
		};
	 });
	function getItems(id,a) {
		var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url_action;
		ajax.config._success = function(data, textStatus){
			show = new Array();
	
			for (var i = 0; i < data.length; i++) {
				var idd = data[i].idd;
				var title=data[i].title;
				var spec=data[i].spec;
				var product_price=data[i].product_price;
				var order_num=data[i].order_num;
				var order_total_price=data[i].order_total_price;
		        show.push('<tr name="order'+id+'">');
		        show.push('<td colspan="5"  class="td1">'+title+'</td>');
		        show.push('<td colspan="2" class="td3">'+product_price+'（单价）</td>');
		        show.push('<td colspan="2"  class="td4"  >'+order_num+'（数量）</td>');
		        show.push('<td colspan="2" class="td5">'+order_total_price+'（总价）</td>');  
		        show.push(' </tr>');
			}
			show.push('</table>')
				 show.push('</tr>');
			$("#"+a).after(show.join(""));
		};
		ajax.addParameter("parameters", "order_id="+id+"");
	    ajax.addParameter("work", "StoresFinance");
		ajax.sendAjax();
	}
	function myshowDetail (a,b){
		if ( $("[name=order"+b+"]").length > 0 ) {
			$("[name=order"+b+"]").remove();
			
			}else{
				 getItems(b,a);
			}
		
	  
	}
	</script>
</body>
</html>