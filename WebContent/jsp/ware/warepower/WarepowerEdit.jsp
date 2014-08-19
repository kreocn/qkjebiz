<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库管理权限管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>仓库管理权限</span>
		<span class="extra1">
			<a href="<s:url action="warepower_list" namespace="/warepower" />" >仓库管理权限列表</a>
		</span>	
	</div>
<s:form name="form1" action="warepower_add" namespace="/warepower" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		 <tr>
			<td class='firstRow'><span style="color:red;">*</span> 主键:</td>
			<td class='secRow'><s:property value="warepower.uuid" /><s:hidden name="warepower.uuid" title="主键" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 仓库id:</td>
			<td class='secRow'><s:property value="warepower.ware_id" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 管理员:</td>
			<td class='secRow'> </td>
		</tr>

		</s:if>
		<s:else>
		<tr>
		    <th>仓库类型</th>
		    <th>仓库名称</th>
			<th>仓库地址</th>
			<th>操作</th>
	  	</tr>
	  	<s:iterator value="wares" status="sta">
		  <tr>
		    <td>
		    
		    <s:if test="0==ware_class">普通库</s:if>
	    	<s:elseif test="1==ware_class">藏酒库</s:elseif>
		    </td>
			<td><s:property value="ware_name" /></td>
			<td><s:property value="address" /></td>
			<td>
			<s:hidden name="warepowers[%{#sta.index}].ware_id" value="%{uuid}" />
			<s:submit id="ss" name="ss" value="填加管理员" action="warepower_add" /></td>
		  </tr>
		</s:iterator>
		</s:else>
		  

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WAREPOWER_WAREPOWER_ADD')">
					<s:submit id="add" name="add" value="确定" action="warepower_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WAREPOWER_WAREPOWER_MDY')">
					<s:submit id="save" name="save" value="保存" action="warepower_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WAREPOWER_WAREPOWER_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="warepower_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="warepower_relist" namespace="/warepower" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>