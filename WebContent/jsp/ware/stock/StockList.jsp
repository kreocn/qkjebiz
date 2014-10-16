<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>库存物品列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
<div class="main">
	<div class="dq_step">
	${path}
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="stock_list"  namespace="/stock"  method="get"  theme="simple">
		<div class="label_con">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">商品名称:</div>
            <div class="label_rwben label_rwb">
            	<div class="iselect">
            	<s:select id="membermanagerid" cssClass="selectKick" name="stock.product_id" title="状态" headerKey="" headerValue="--请选择--" list="products" listKey="uuid" listValue="title" />
            	</div>
            </div>
       		</div>
        	<div class="label_hang">
            <div class="label_ltit">所在仓库:</div>
            <div class="label_rwben label_rwb">
            	<div class="iselect">
            	<s:select id="membermanagerid" cssClass="selectKick" name="stock.store_id" title="状态" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
            	</div>
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">(统计查询)商品名称:</div>
            <div class="label_rwben label_rwb">
            	<div class="iselect">
            	<s:select id="membermanagerid" cssClass="selectKick" name="stock.groupQ" title="状态" headerKey="0" headerValue="--请选择--" list="inproducts" listKey="product_id" listValue="product_name" />
            	</div>
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
	    <th class="td1">商品名称</th>
	    <s:if test="t==null">
	    <th class="td2">所在仓库</th>
	    </s:if>
		<th class="td1">库存数量</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="stocks" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw"><s:property value="uuid" /></td>
				<td class="td1 nw"><s:property value="product_name" /></td>
				<s:if test="t==null">
				<td class="td2 nw"><s:property value="store_name" /></td>
				</s:if>
				<td class="td1 nw">
				<s:property value="%{quantity-freezeNum}" />&nbsp;瓶
				(<s:property value="%{((quantity-freezeNum)/(case_spec*1.0)).toString().substring(0,3)}" />件)
				</td>
				<td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
	  		</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div class="pagination">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
		</script>
	</div>
 	<div class="hidden_area">
	<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
	</div>
</div>
</body>
</html>