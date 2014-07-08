<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>提货单明细管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == ladingItem && 'add' == viewFlag">增加</s:if><s:elseif test="null != ladingItem && 'mdy' == viewFlag">修改</s:elseif>提货单明细</span>
		<span class="extra1">
			<a href="<s:url action="ladingItem_list" namespace="/qkjmanage" />" >提货单明细列表</a>
		</span>	
	</div>
<s:form name="form1" action="ladingItem_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != ladingItem">
		  
		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 产品ID:</td>
<td class='secRow'><s:select name="ladingItem.product_id" title="产品ID" headerKey="" headerValue="--请选择--" list="#{0:'余额支付',1:'网上银行支付',2:'货到付款'}" /></td>
</tr>
<tr>
<td class='firstRow'>单价:</td>
<td class='secRow'><s:textfield name="ladingItem.per_price" title="单价" dataLength="0,15" dataType="number" controlName="单价" /></td>
</tr>
<tr>
<td class='firstRow'>订单数量:</td>
<td class='secRow'><s:textfield name="ladingItem.num" title="订单数量" dataLength="0,10" dataType="integer" controlName="订单数量" /></td>
</tr>
<tr>
<td class='firstRow'>实际价格:</td>
<td class='secRow'><s:textfield name="ladingItem.total_price" title="实际价格" dataLength="0,15" dataType="number" controlName="实际价格" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	<s:hidden name="ladingItem.uuid" title="主键ID" />
<s:hidden name="ladingItem.lading_id" title="提货单ID" />

		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == ladingItem && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_ADD')">
					<s:submit id="add" name="add" value="确定" action="ladingItem_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != ladingItem && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_MDY')">
					<s:submit id="save" name="save" value="保存" action="ladingItem_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="ladingItem_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="ladingItem_list" namespace="/qkjmanage" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>