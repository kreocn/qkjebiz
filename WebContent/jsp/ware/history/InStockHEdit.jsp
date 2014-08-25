<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>入库历史管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>入库历史</span>
		<span class="extra1">
			<a href="<s:url action="inStockH_list" namespace="/ware" />" >入库历史列表</a>
		</span>	
	</div>
<s:form name="form1" action="inStockH_add" namespace="/ware" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
<td class='secRow'><s:property value="inStockH.uuid" /><s:hidden name="inStockH.uuid" title="主键ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 订单编号:</td>
<td class='secRow'><s:date name="inStockH.date" format="yyyy-MM-dd HH:mm:ss" /><s:hidden name="inStockH.date" title="订单编号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 修改时间:</td>
<td class='secRow'><s:date name="inStockH.lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>状态:</td>
<td class='secRow'><s:property value="inStockH.reason" /></td>
</tr>
<tr>
<td class='firstRow'>审核人:</td>
<td class='secRow'><s:property value="inStockH.confirm" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 订单商品号:</td>
<td class='secRow'><s:textfield name="inStockH.store_id" title="订单商品号" require="required" dataLength="0,10" dataType="integer" controlName="订单商品号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 经办人:</td>
<td class='secRow'><s:textfield name="inStockH.operator_id" title="经办人" require="required" dataLength="0,16" controlName="经办人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 保管员:</td>
<td class='secRow'><s:textfield name="inStockH.take_id" title="保管员" require="required" dataLength="0,16" controlName="保管员" /></td>
</tr>
<tr>
<td class='firstRow'>入库原因:</td>
<td class='secRow'><s:textfield name="inStockH.note" title="入库原因" dataLength="0,200" controlName="入库原因" /></td>
</tr>
<tr>
<td class='firstRow'>总价:</td>
<td class='secRow'><s:textfield name="inStockH.total_price" title="总价" dataLength="0,10" dataType="number" controlName="总价" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加人IP:</td>
<td class='secRow'><s:textfield name="inStockH.add_user" title="添加人IP" require="required" dataLength="0,16" controlName="添加人IP" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加时间:</td>
<td class='secRow'><s:textfield name="inStockH.add_timer" title="添加时间" require="required" value="%{getText('global.date',{inStockH.add_timer})=='null'?'':getText('global.date',{inStockH.add_timer})}" dataType="date" controlName="添加时间" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 修改人:</td>
<td class='secRow'><s:textfield name="inStockH.lm_user" title="修改人" require="required" dataLength="0,16" controlName="修改人" /></td>
</tr>
<tr>
<td class='firstRow'>审核时间:</td>
<td class='secRow'><s:textfield name="inStockH.conname" title="审核时间" dataLength="0,20" controlName="审核时间" /></td>
</tr>
<tr>
<td class='firstRow'>审核意见:</td>
<td class='secRow'><s:textfield name="inStockH.contime" title="审核意见" value="%{getText('global.date',{inStockH.contime})=='null'?'':getText('global.date',{inStockH.contime})}" dataType="date" controlName="审核意见" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCKH_ADD')">
					<s:submit id="add" name="add" value="确定" action="inStockH_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCKH_MDY')">
					<s:submit id="save" name="save" value="保存" action="inStockH_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCKH_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="inStockH_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="inStockH_relist" namespace="/ware" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>