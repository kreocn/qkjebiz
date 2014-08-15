<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游客户名单管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>工业旅游客户名单</span>
		<span class="extra1">
			<a href="<s:url action="travelCustomer_list" namespace="/qkjmanage" />" >工业旅游客户名单列表</a>
		</span>	
	</div>
<s:form name="form1" action="travelCustomer_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键自增:</td>
<td class='secRow'><s:property value="travelCustomer.uuid" /><s:hidden name="travelCustomer.uuid" title="主键自增" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 旅游单ID:</td>
<td class='secRow'><s:textfield name="travelCustomer.travel_id" title="旅游单ID" require="required" dataLength="0,10" dataType="integer" controlName="旅游单ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 客户姓名:</td>
<td class='secRow'><s:textfield name="travelCustomer.cus_name" title="客户姓名" require="required" dataLength="0,32" controlName="客户姓名" /></td>
</tr>
<tr>
<td class='firstRow'>性别:</td>
<td class='secRow'><s:textfield name="travelCustomer.cus_sex" title="性别" dataLength="0,10" dataType="integer" controlName="性别" /></td>
</tr>
<tr>
<td class='firstRow'>单位名称:</td>
<td class='secRow'><s:textfield name="travelCustomer.cus_company" title="单位名称" dataLength="0,255" controlName="单位名称" /></td>
</tr>
<tr>
<td class='firstRow'>客户类别:</td>
<td class='secRow'><s:textfield name="travelCustomer.cus_type" title="客户类别" dataLength="0,10" dataType="integer" controlName="客户类别" /></td>
</tr>
<tr>
<td class='firstRow'>联系电话:</td>
<td class='secRow'><s:textfield name="travelCustomer.cus_phone" title="联系电话" dataLength="0,55" controlName="联系电话" /></td>
</tr>
<tr>
<td class='firstRow'>身份证号:</td>
<td class='secRow'><s:textfield name="travelCustomer.cus_idcard" title="身份证号" dataLength="0,32" controlName="身份证号" /></td>
</tr>
<tr>
<td class='firstRow'>备注:</td>
<td class='secRow'><s:textfield name="travelCustomer.note" title="备注" dataLength="0,255" controlName="备注" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD')">
					<s:submit id="add" name="add" value="确定" action="travelCustomer_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_MDY')">
					<s:submit id="save" name="save" value="保存" action="travelCustomer_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="travelCustomer_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="travelCustomer_relist" namespace="/qkjmanage" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>