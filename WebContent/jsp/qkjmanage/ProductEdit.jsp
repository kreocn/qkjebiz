<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == product && 'add' == viewFlag">增加</s:if><s:elseif test="null != product && 'mdy' == viewFlag">修改</s:elseif>产品</span>
		<span class="extra1">
			<a href="<s:url action="product_list" namespace="/qkjmanage" />" >产品列表</a>
		</span>	
	</div>
<s:form name="form1" action="product_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != product">
			<tr>
<td class='firstRow'>主键ID:</td>
<td class='secRow'><s:property value="product.uuid" /><s:hidden name="product.uuid" /></td>
		</tr>
		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 产品统一编码:</td>
<td class='secRow'><s:textfield name="product.prod_code" title="产品统一编码" require="required" dataLength="0,16" controlName="产品统一编码" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 产品系列:</td>
<td class='secRow'>
<s:select name="product.brand" title="产品系列" require="required"  controlName="产品统一编码" headerKey="" headerValue="--请选择--"
	list="#{'天佑德':'天佑德','八大作坊':'八大作坊','七彩互助':'七彩互助','互助头曲':'互助头曲','互助粮液':'互助粮液','永庆和':'永庆和','青稞酒':'青稞酒','世义德':'世义德','其他':'其他'}" />
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 品名:</td>
<td class='secRow'><s:textfield name="product.title" title="品名" require="required" dataLength="0,85" controlName="品名" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 规格:</td>
<td class='secRow'><s:textfield name="product.spec" title="规格(500ml)" require="required" dataLength="0,85" controlName="规格(500ml)" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 数量:</td>
<td class='secRow'><s:textfield name="product.case_spec" title="数量" require="required" dataType="integer" controlName="数量" />/件</td>
</tr>
<tr>
<td class='firstRow'>酒精度:</td>
<td class='secRow'><s:textfield name="product.alcohol" title="酒精度" dataType="number" controlName="酒精度" /></td>
</tr>
<tr>
<td class='firstRow'>香型:</td>
<td class='secRow'><s:textfield name="product.flavor" title="香型" dataLength="0,85" controlName="香型" /></td>
</tr>
<tr>
<td class='firstRow'>原材料:</td>
<td class='secRow'><s:textfield name="product.raw_materials" title="原材料" dataLength="0,85" controlName="原材料" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 档次:</td>
<td class='secRow'><s:select name="product.grade" title="档次" headerKey="" headerValue="--请选择--" list="#{1:'低端',2:'中端',3:'中高端',4:'高端'}" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 市场价:</td>
<td class='secRow'><s:textfield name="product.market_price" title="市场价" require="required" dataType="number" controlName="市场价" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 团购价:</td>
<td class='secRow'><s:textfield name="product.group_price" title="团购价" require="required" dataType="number" controlName="团购价" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 出厂价:</td>
<td class='secRow'><s:textfield name="product.dealer_price" title="出厂价" require="required" dataType="number" controlName="出厂价" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 返利标准(%):</td>
<td class='secRow'><s:textfield name="product.group_rebates" title="返利标准" require="required" dataType="number" controlName="返利标准" />%</td>
</tr>
<tr>
<td class='firstRow'>协议价1:</td>
<td class='secRow'><s:textfield name="product.agree_price_1" title="协议价1" dataType="number" controlName="协议价1" /></td>
</tr>
<tr>
<td class='firstRow'>协议价2:</td>
<td class='secRow'><s:textfield name="product.agree_price_2" title="协议价2" dataType="number" controlName="协议价2" /></td>
</tr>
<tr>
<td class='firstRow'>协议价3:</td>
<td class='secRow'><s:textfield name="product.agree_price_3" title="协议价3" dataType="number" controlName="协议价3" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == product && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
					<s:submit id="add" name="add" value="确定" action="product_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != product && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_MDY')">
					<s:submit id="save" name="save" value="保存" action="product_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="product_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="product_list" namespace="/qkjmanage" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>