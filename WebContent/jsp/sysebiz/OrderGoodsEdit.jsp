<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_lite.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/ckeditor/ckeditor.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/ckfinder/ckfinder.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == orderGoods && 'add' == viewFlag">增加</s:if><s:elseif test="null != orderGoods && 'mdy' == viewFlag">修改</s:elseif>订单</span>
		<span class="extra1">
			<a href="<s:url action="orderGoods_list" namespace="/sysebiz" />" >订单列表</a>
		</span>	
	</div>
<s:form name="form1" action="orderGoods_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != orderGoods">
		  
		</s:if>
		  <tr>
<td class='firstRow'>0:</td>
<td class='secRow'><s:select name="orderGoods.goods_id" title="0" headerKey="" headerValue="--请选择--" list="#{0:'余额支付',1:'网上银行支付',2:'货到付款'}" /></td>
</tr>
<tr>
<td class='firstRow'>单价:</td>
<td class='secRow'><s:textfield name="orderGoods.per_price" title="单价" dataLength="0,5" dataType="number" controlName="单价" /></td>
</tr>
<tr>
<td class='firstRow'>订单数量:</td>
<td class='secRow'><s:textfield name="orderGoods.order_num" title="订单数量" dataLength="0,3" dataType="integer" controlName="订单数量" /></td>
</tr>
<tr>
<td class='firstRow'>实际价格:</td>
<td class='secRow'><s:textfield name="orderGoods.total_price" title="实际价格" dataLength="0,5" dataType="number" controlName="实际价格" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	<s:hidden name="orderGoods.uuid" title="0" />
<s:hidden name="orderGoods.order_id" title="0" />

		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == orderGoods && 'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="orderGoods_add" />
				</s:if>
				<s:elseif test="null != orderGoods && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="orderGoods_save" />
					<s:submit id="delete" name="delete" value="删除" action="orderGoods_del" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="orderGoods_list" namespace="/sysebiz" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>