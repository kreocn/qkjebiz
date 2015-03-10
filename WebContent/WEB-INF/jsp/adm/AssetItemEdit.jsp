<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产物品管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == assetItem && 'add' == viewFlag">增加</s:if><s:elseif test="null != assetItem && 'mdy' == viewFlag">修改</s:elseif>资产物品</span>
		<span class="extra1">
			<a href="<s:url action="assetItem_list" namespace="/adm" />" >资产物品列表</a>
		</span>	
	</div>
<s:form name="form1" action="assetItem_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != assetItem">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 编号:</td>
			<td class='secRow'><s:property value="assetItem.uuid" /><s:hidden name="assetItem.uuid" title="编号" /></td>
			</tr>
			<tr>
			<td class='firstRow'><span style="color:red;">*</span> 所属资产:</td>
			<td class='secRow'><s:property value="assetItem.asset_id" /><s:hidden name="assetItem.asset_id" title="所属资产" /></td>
			</tr>
		</s:if>
		  <tr>
			<td class='firstRow'>型号:</td>
			<td class='secRow'><s:textfield name="assetItem.model" title="型号" dataLength="0,96" controlName="型号" /></td>
			</tr>
			<tr>
			<td class='firstRow'>规格:</td>
			<td class='secRow'><s:textfield name="assetItem.spec" title="规格" dataLength="0,96" controlName="规格" /></td>
			</tr>
			<tr>
			<td class='firstRow'>单价:</td>
			<td class='secRow'><s:textfield name="assetItem.price" title="规格" dataLength="0,13" dataType="number" controlName="单价" /></td>
			</tr>
			<tr>
			<td class='firstRow'>所在位置:</td>
			<td class='secRow'><s:textfield name="assetItem.position" title="所在位置" dataLength="0,32" controlName="所在位置" /></td>
			</tr>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == assetItem && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_ADD')">
					<s:submit id="add" name="add" value="确定" action="assetItem_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != assetItem && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_MDY')">
					<s:submit id="save" name="save" value="保存" action="assetItem_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="assetItem_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="assets_load" namespace="/adm"><s:param name="viewFlag">mdy</s:param><s:param name="assets.uuid" value="%{assetItem.asset_id}" /></s:url>');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>