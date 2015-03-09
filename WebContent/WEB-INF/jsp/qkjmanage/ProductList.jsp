<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_SELECT')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="proType_lista"></s:url>" >更新产品树</a></span>
		</s:if>
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="product_load"><s:param name="viewFlag">add</s:param></s:url>" >添加产品</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="product_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">品名:</div>
				       <div class="label_rwben"><s:textfield name="product.title" title="品名" dataLength="0,85" controlName="品名" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">档次:</div>
				       <div class="label_rwben">
				       			<s:select name="product.grade" title="档次" headerKey="" headerValue="--请选择--"  list="#{1:'低端',2:'中端',3:'中高端',4:'高端'}" />
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
	 		<table>
		 		<tr id="coltr">
				    <th class="td1">编号</th>
					<th class="td3">统一编码</th>
					<th class="td1">系列</th>
					<th class="td2">品名</th>
					<th class="td5">规格</th>
					<th class="td1">数量</th>
					<th class="td3">档次</th>
					<th class="td3">市场价</th>
					<th class="td3">团购价</th>
					<th class="td3">出厂价</th>
					<th class="td2">返利标准</th>
					<th class="td4">操作</th>
					<th class="td0">查看</th>
			  	</tr>
			  	<s:iterator value="products" status="sta">
			  		<tr id="showtr${uuid}">
					    <td class="td1">${uuid}</td>
						<td class="td3">${prod_code}</td>
						<td class="td1">${brand_name}</td>
						<td class="td2">${title}</td>
						<td class="td5">${spec}</td>
						<td class="td1">${case_spec}</td>
						<td class="td3"><s:if test='1==grade'>低端</s:if><s:if test='2==grade'>中端</s:if><s:if test='3==grade'>中高端</s:if><s:if test='4==grade'>高端</s:if></td>
						<td class="td3">${market_price}</td>
						<td class="td3">${group_price}</td>
						<td class="td3">${dealer_price}</td>
						<td class="td2">${group_rebates}%</td>
						<td class="td4 op-area">
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_LIST')">
					    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="product_load"><s:param name="viewFlag">mdy</s:param><s:param name="product.uuid" value="uuid"></s:param></s:url>">修改</a>
					    	</s:if>
					    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_DEL')">
					    	<a class="input-red" href="<s:url namespace="/qkjmanage" action="product_del"><s:param name="product.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
					    	</s:if>	 
						</td>
						<td class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
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