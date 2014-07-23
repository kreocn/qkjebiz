<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动客户管理管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == hCusInfo && 'add' == viewFlag">增加</s:if><s:elseif test="null != hCusInfo && 'mdy' == viewFlag">修改</s:elseif>活动客户</span>
		<span class="extra1">
			<a href="<s:url action="hCusInfo_list" namespace="/webmanager"><s:param name="viewFlag">relist</s:param></s:url>" >活动客户列表</a>
		</span>	
	</div>
<s:form name="form1" action="hCusInfo_save" namespace="/webmanager" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != hcusInfo">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 系统编号:</td>
			<td class='secRow'>
				<s:property value="hcusInfo.uuid" />
				<s:hidden name="hcusInfo.uuid" title="系统编号" />
				<s:hidden name="hcusInfo.linkid" title="投票ID" />
			</td>
			</tr>
			<tr>
			<td class='firstRow'>证券帐号:</td>
			<td class='secRow'><s:property value="hcusInfo.security" /></td>
			</tr>
		  <tr>
		<td class='firstRow'>姓名:</td>
		<td class='secRow'><s:textfield name="hcusInfo.fullname" title="姓名" dataLength="0,32" controlName="姓名" require="required"  /></td>
		</tr>
		<tr>
		<td class='firstRow'>联系手机:</td>
		<td class='secRow'><s:textfield name="hcusInfo.mobile" title="联系手机" dataLength="0,32" controlName="联系手机" require="required"  /></td>
		</tr>
		<tr>
			<td class='firstRow'>邮编:</td>
			<td class='secRow'><s:textfield name="hcusInfo.postno" title="邮编" dataLength="0,32" controlName="邮编" /></td>
		</tr>
		<tr>
		<td class='firstRow'>地址:</td>
		<td class='secRow'><s:textfield name="hcusInfo.address" title="地址" dataLength="0,255" controlName="地址" require="required"  cssStyle="width:80%;" /></td>
		</tr>
		<tr>
			<td class='firstRow'>是否已快递:</td>
			<td class='secRow'>
				<s:if test="hcusInfo.express_status==0">
					<span class="message_error">未快递</span>
				</s:if>
				<s:elseif test="hcusInfo.express_status==1">
					<span class="message_pass">已快递</span>
				</s:elseif>
			</td>
			</tr>
			<s:if test="hcusInfo.express_status==1">
			<tr>
			<td class='firstRow'>快递类型:</td>
			<td class='secRow'><s:property value="hcusInfo.express_type" /></td>
			</tr>
			<tr>
			<td class='firstRow'>快递单号:</td>
			<td class='secRow'><s:property value="hcusInfo.express_no" /></td>
			</tr>
			<tr>
			<td class='firstRow'>快递时间:</td>
			<td class='secRow'><s:date name="hcusInfo.express_date" format="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			</s:if>
		</s:if>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == hcusInfo && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('WEB_QKJWEB_HCUSINFO_ADD')">
					<s:submit id="add" name="add" value="确定" action="hCusInfo_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != hcusInfo && 'mdy' == viewFlag && hcusInfo.express_status==0">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('WEB_QKJWEB_HCUSINFO_MDY')">
					<s:submit id="save" name="save" value="保存" action="hCusInfo_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('WEB_QKJWEB_HCUSINFO_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="hCusInfo_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="hCusInfo_relist" namespace="/webmanager" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>