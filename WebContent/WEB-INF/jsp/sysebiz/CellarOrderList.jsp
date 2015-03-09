<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>取酒订单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
		${path}
		</div>
		<s:form id="serachForm" name="serachForm" action="cellarOrder_list"  method="get" namespace="/sysebiz" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">取酒订单号:</div>
				       <div class="label_rwben"><s:textfield name="cellarOrder.uuid" title="取酒订单号" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">收货人姓名:</div>
				       <div class="label_rwben"><s:textfield name="cellarOrder.con_name" title="收货人姓名" /></div>
				</div>
				<div class="label_hang">
	            <div class="label_ltit">取酒仓库:</div>
	            <div class="label_rwben">
			       <span class="label_rwb">
	            	<s:select cssClass="selectKick" name="cellarOrder.ware_id" list="wares" listKey="uuid" listValue="ware_name" headerKey="" headerValue="--请选择--" />
	            	</span>
		            </div>
		        </div>
				<div class="label_hang">
		            <div class="label_ltit">下单时间:</div>
		            <div class="label_rwben2">
						<span class="label_rwb nw">
						<input id="cellarOrder_add_time"  class="datepicker" type="text" name="cellarOrder.add_time"  value="${it:formatDate(order.add_time,'yyyy-MM-dd')}"/>
		            	</span>
		            </div>
		        </div>
		        <div class="label_hang">
				       <div class="label_ltit">取酒位置(%):</div>
				       <div class="label_rwben"><s:textfield name="cellarOrder.cellar_position" title="取酒位置" /></div>
				</div>
				<div class="label_hang">
		            <div class="label_ltit">订单状态::</div>
		            <div class="label_rwben label_rwb">
		            	<s:select cssClass="selectKick"  name="cellarOrder.status" title="订单状态" headerKey="" headerValue="--请选择--" list="#{10:'新订单',20:'已灌装',30:'已发货',40:'已收货',50:'已评价'}" />
		            </div>
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
			    <th class="td1">取酒订单号</th>
			    <th class="td1">取酒位置号</th>
				<th class="td2">取酒数量</th>
				<th class="td2">收货人姓名</th>
				<th class="td2">所送地区</th>
				<th class="td3">手机/联系电话</th>
				<th class="td3">状态</th>
				<th class="td3">来源</th>
				<th class="td4">操作</th>
				<th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="cellarOrders" status="sta">
				  <tr  id="showtr${uuid}">
				    <td class="td1 nw"><s:property value="uuid" /></td>
				    <td class="td1 nw"><s:property value="cellar_position" /></td>
					<td class="td2 nw"><s:property value="order_num" /> <s:property value="cellar_unit" /></td>
					<td class="td2 nw"><s:property value="con_name" /></td>
					<td class="td2 nw"><s:property value="con_province" /> <s:property value="con_city" /></td>
					<td class="td3 nw"><s:property value="con_mobile" /></td>
					<td class="td3 nw">
						<s:if test="0==status">作废订单</s:if>
						<s:if test="10==status">新订单</s:if>	
						<s:if test="20==status">已灌装</s:if>
						<s:if test="30==status">已发货</s:if>	
						<s:if test="40==status">已收货</s:if>
						<s:if test="50==status">已评价</s:if>
						<s:if test="(null==order_video||''==order_video)&&status>10">
						<span style="color:red;">无视频</span>
						</s:if>
					</td>
					<td class="td3 nw">
						<s:if test="0==order_source"><span class="message_pass">客户自助下单</span></s:if>
						<s:if test="1==order_source">代客下单</s:if>
					</td>
					<td class="td4 op-area">
				    	<a class="input-blue" href="<s:url namespace="/sysebiz" action="cellarOrder_load"><s:param name="viewFlag">mdy</s:param><s:param name="cellarOrder.uuid" value="uuid"></s:param></s:url>">修改&操作</a>
				    </td>
				    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
				  </tr>
			</s:iterator>
	        </table>
	 </div>
	 <div id="listpage" class="pagination"></div>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
 });
</script>
</body>
</html>