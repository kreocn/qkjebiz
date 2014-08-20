<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == memberHandover && 'add' == viewFlag">增加</s:if><s:elseif test="null != memberHandover && 'mdy' == viewFlag">修改</s:elseif>会员</span>
		<span class="extra1">
			<a href="<s:url action="memberHandover_list" namespace="/sysvip" />" >会员列表</a>
		</span>	
	</div>
<s:form name="form1" action="memberHandover_add" namespace="/sysvip" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != memberHandover">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 申请时间:</td>
<td class='secRow'><s:date name="memberHandover.applicant_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 状态:</td>
<td class='secRow'><s:property value="memberHandover.status" /></td>
</tr>
<tr>
<td class='firstRow'>接收/拒收时间:</td>
<td class='secRow'><s:date name="memberHandover.accept_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>最后修改人:</td>
<td class='secRow'><s:property value="memberHandover.lm_user" /></td>
</tr>
<tr>
<td class='firstRow'>最后修改时间:</td>
<td class='secRow'><s:date name="memberHandover.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
<td class='secRow'><s:textfield name="memberHandover.uuid" title="主键ID" require="required" dataLength="0,10" dataType="integer" controlName="主键ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 客户ID:</td>
<td class='secRow'><s:textfield name="memberHandover.member_id" title="客户ID" require="required" dataLength="0,85" controlName="客户ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 申请人ID:</td>
<td class='secRow'><s:textfield name="memberHandover.applicant" title="申请人ID" require="required" dataLength="0,85" controlName="申请人ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 目标部门:</td>
<td class='secRow'><s:textfield name="memberHandover.target_dept" title="目标部门" require="required" dataLength="0,85" controlName="目标部门" /></td>
</tr>
<tr>
<td class='firstRow'>目标人:</td>
<td class='secRow'><s:textfield name="memberHandover.target_manager" title="目标人" dataLength="0,85" controlName="目标人" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == memberHandover && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_ADD')">
					<s:submit id="add" name="add" value="确定" action="memberHandover_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != memberHandover && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_MDY')">
					<s:submit id="save" name="save" value="保存" action="memberHandover_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSVIP_MEMBERHANDOVER_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="memberHandover_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="memberHandover_list" namespace="/sysvip" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>