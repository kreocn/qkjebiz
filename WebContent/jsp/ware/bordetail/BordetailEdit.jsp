<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>还库管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>还库</span>
		<span class="extra1">
			<a href="<s:url action="bordetail_list" namespace="/bordetail" />" >还库列表</a>
		</span>	
	</div>
<s:form name="form1" action="bordetail_add" namespace="/bordetail" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 编号:</td>
<td class='secRow'><s:property value="bordetail.uuid" /><s:hidden name="bordetail.uuid" title="编号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 商品:</td>
<td class='secRow'><s:property value="bordetail.product_id" /><s:hidden name="bordetail.product_id" title="商品" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 还库:</td>
<td class='secRow'><s:textfield name="bordetail.bstore_id" title="还库" require="required" dataLength="0,10" dataType="integer" controlName="还库" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 借库:</td>
<td class='secRow'><s:textfield name="bordetail.sstor_id" title="借库" require="required" dataLength="0,10" dataType="integer" controlName="借库" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 还数量:</td>
<td class='secRow'><s:textfield name="bordetail.bnum" title="还数量" require="required" dataLength="0,10" dataType="integer" controlName="还数量" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 时间:</td>
<td class='secRow'><s:textfield name="bordetail.bdate" title="时间" require="required" value="%{getText('global.date',{bordetail.bdate})=='null'?'':getText('global.date',{bordetail.bdate})}" dataType="date" controlName="时间" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 还货编号:</td>
<td class='secRow'><s:textfield name="bordetail.back_id" title="还货编号" require="required" dataLength="0,10" dataType="integer" controlName="还货编号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 借货编号:</td>
<td class='secRow'><s:textfield name="bordetail.land_id" title="借货编号" require="required" dataLength="0,10" dataType="integer" controlName="借货编号" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_BORDETAIL_BORDETAIL_ADD')">
					<s:submit id="add" name="add" value="确定" action="bordetail_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_BORDETAIL_BORDETAIL_MDY')">
					<s:submit id="save" name="save" value="保存" action="bordetail_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_BORDETAIL_BORDETAIL_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="bordetail_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="bordetail_relist" namespace="/bordetail" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>