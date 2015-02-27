<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>入库列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true"/>
</head>

<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_ADD')">
			<span class="opb lb op-area">
			<a href="<s:url namespace="/inStock" action="inStock_load"><s:param name="viewFlag">add</s:param></s:url>" >添加入库单</a>
			</span>
		</s:if>
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="inStock_list"  method="get" namespace="/inStock" theme="simple">
		<div class="label_con">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name="inStock.uuid" title="编号" /></div>
       		</div>
        	<div class="label_hang">
            <div class="label_ltit">单据号:</div>
            <div class="label_rwben"><s:textfield name="inStock.ordernum" title="单据号" /></div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">入库时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="datepicker iI iI-f" type="text" name="inStock.date_start" title="从" value="${it:formatDate(inStock.date_start,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="datepicker iI iI-t" type="text" name="inStock.date_end" title="到" value="${it:formatDate(inStock.date_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">入库仓库:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="inStock.store_id" title="入库仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">单据性质:</div>
            <div class="label_rwben label_rwb">
            	<select id="membermanagerid" cssClass="selectKick" name="inStock.reason" title="状态">
					<option value="-1">---请选择---</option>
					<option value="0">正常入库</option>
					<option value="1">正常退货</option>
					<option value="2" >损坏退货</option>
					<option value="3" >其它</option>
				</select>
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">状态:</div>
            <div class="label_rwben label_rwb">
            	<select id="membermanagerid" cssClass="selectKick" name="inStock.send" title="状态">
					<option value="-1">---请选择---</option>
					<option value="0">正常订单</option>
					<option value="1">取消订单</option>
				</select>
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
	
	<!-- 列表 -->
	<div class="tab_warp">
 		<table>
 		<tr id="coltr">
		<th class="td1">编号</th>
		<th class="td3">经办人</th>
		<th class="td3">保管员</th>
		<th class="td2">单据号</th>
		<th class="td1">单据性质/状态</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="inStocks" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw"><s:property value="uuid" /></td>
	  			<td class="td3 nw"><s:property value="operator_name" /></td>
				<td class="td3 nw"><s:property value="take_name" /></td>
			    <td class="td2 nw"><s:property value="ordernum" /></td>
			    <td class="td1 nw">
			    <s:if test="%{reason==0}">正常入库</s:if>
				<s:if test="%{reason==1}">正常退货</s:if>
				<s:if test="%{reason==2 }">损坏退货</s:if>
				<s:if test="%{reason==3 }">其它</s:if>(<s:if test="confirm==null">未确认</s:if><s:if test="confirm!=null">已确认</s:if>)
				(<s:if test="send==0">正常订单</s:if><s:if test="send==1">已取消订单</s:if>)
			    </td>
				<td class="td4 op-area">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_MDY') && @com.qkj.ware.action.warepower@checkPermit(store_id,'add')">
					<a class="input-blue" href="<s:url namespace="/inStock" action="inStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="inStock.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:if>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_DEL') && @com.qkj.ware.action.warepower@checkPermit(store_id,'add') && confirm==null">
			    	<a class="input-red" href="<s:url namespace="/inStock" action="inStock_del"><s:param name="inStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>	 
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_PUTSEAL') && confirm==1 && @com.qkj.ware.action.warepower@checkPermit(store_id,'add')">
			    	<a class="input-gray" href="<s:url namespace="/inStock" action="inStock_view"><s:param name="viewFlag">view</s:param><s:param name="inStock.uuid" value="uuid"></s:param></s:url>">查看/打印</a>
			    	</s:if>	  
		    	</td>
		    	<td class="td0 op-area"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
	  		</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div id="listpage" class="pagination"></div>
	<div class="hidden_area">
	<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
	</div>
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