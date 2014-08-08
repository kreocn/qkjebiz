<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>库存物品管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == stock && 'add' == viewFlag">增加</s:if><s:elseif test="null != stock && 'mdy' == viewFlag">修改</s:elseif>库存物品</span>
		<span class="extra1">
			<a href="<s:url action="stock_list" namespace="/stock" />" >库存物品列表</a>
		</span>	
	</div>
<s:form name="form1" action="stock_add" namespace="/stock" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != stock">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
<td class='secRow'><s:property value="stock.uuid" /><s:hidden name="stock.uuid" title="主键ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 商品编号:</td>
<td class='secRow'><s:property value="stock.product_id" /><s:hidden name="stock.product_id" title="商品编号" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 仓库编号:</td>
<td class='secRow'><s:textfield name="stock.store_id" title="仓库编号" require="required" dataLength="0,10" dataType="integer" controlName="仓库编号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 库存数量:</td>
<td class='secRow'><s:textfield name="stock.quantity" title="库存数量" require="required" dataLength="0,10" dataType="integer" controlName="库存数量" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 入库单号:</td>
<td class='secRow'><s:textfield name="stock.lading_id" title="入库单号" require="required" dataLength="0,50" controlName="入库单号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 入库日期:</td>
<td class='secRow'><s:textfield name="stock.date" title="入库日期" require="required" value="%{getText('global.date',{stock.date})=='null'?'':getText('global.date',{stock.date})}" dataType="date" controlName="入库日期" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == stock && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_STOCK_STOCK_ADD')">
					<s:submit id="add" name="add" value="确定" action="stock_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != stock && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_STOCK_STOCK_MDY')">
					<s:submit id="save" name="save" value="保存" action="stock_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_STOCK_STOCK_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="stock_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="stock_relist" namespace="/stock" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>