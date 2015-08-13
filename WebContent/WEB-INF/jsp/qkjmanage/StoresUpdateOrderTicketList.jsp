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
<title>门店产品列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">	<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;查看订单</div>
		
		
		<s:form id="serachForm" name="serachForm" action="stores_order_find_ticketOrder"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name='sotresorder.id' value=""/></div>
        </div>
        
           <div class="label_hang">
            <div class="label_ltit">订单状态:</div>
            <div class="label_rwben label_rwb"><s:select id="fdsta" name="sotresorder.is_library" cssClass="selectKick"
				 list="#{0:'未出库',1:'已出库'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
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
				<s:form id="serachForm" name="serachForm" action="sotres_the_library_ticket" method="get" namespace="/qkjmanage" theme="simple">
				<table>
					<tr id="coltr">
				<th class="td1">全选<input type="checkbox" id="cbselect"></th>
						<th class="td2">用户名称</th>
						<th class="td3">酒票编号</th>
							<th class="td4">订单状态</th>
						<th class="td5">订单总价</th>
						<th class="td6">添加时间</th>
						<th class="td7">操作</th>
					</tr>
					<s:iterator value="storesorderlist" status="sta">
						<tr>
							<td class="td1" >
								<input type="checkbox" name="cb" value="${id}" <s:if test="1==is_library">checked="checked"</s:if>>
							</td>
							<td class="td2" >${user_name}</td>
								<td class="td3">${liqueur_ticket_code}</td>
							<td class="td4" >	<s:if test="1==is_library">已出库</s:if>
							<s:if test="0==is_library">待出库</s:if></td>
							<td class="td5">${total_price}</td>
							<td class="td6">${add_time}</td>
							
							<td class="td7 op-area"><a class="input-gray"  href="/qkjmanage/stores_order_update_details_view.action?id=${id}" >打印</a><a  class="input-blue"  href="/qkjmanage/stores_order_update_details.action?id=${id}" >查看详情</a> 		<c:if test="${it:checkPermit('QKJ_STORES_FIND_ORDER_DEL',null)==true}">
							<s:if test="0==is_library"> <a  class="input-red" onclick="return isDel();" href="/qkjmanage/stores_order_delete.action?id=${id}"  >删除</a></s:if></c:if></td>
						</tr>
					</s:iterator>
				</table>
					<s:submit type="reset" value="批量出库"   cssClass="input-blue" />
					</s:form>
			</div>
			<div id="listpage" class="pagination"></div>
		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />">
</script>
	<script type="text/javascript">
	
	$("#cbselect").change(function() { 
		var num=0;
		var arrChk=$("input[name='cb']:checked");
		var arr=$("input[name='cb']");
		var count=arr.size();

	    $(arrChk).each(function(){
	       num++;
	    } ); 

	    if(num == count){
	    	 $("[name='cb']").removeAttr("checked");
	    }
	    else{
	    
	    	 $("[name='cb']").attr("checked",'true');
	    }
	})
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