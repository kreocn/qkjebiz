<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == position && 'add' == viewFlag">增加</s:if><s:elseif test="null != position && 'mdy' == viewFlag">修改</s:elseif>用户</div>
<s:form name="form1" action="position_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != position">	
		  <tr>
		    <td class="firstRow">用户ID:</td>
		    <td colspan="3" class="secRow"><s:property value="position.uuid" />
			<s:hidden id="position.uuid" name="position.uuid" /></td>	
		  </tr>
		</s:if>
		  <tr>
		    <td class="firstRow">职务名称:</td>
		    <td class="secRow">
		    	<s:textfield id="position.position_name" name="position.position_name" title="职务名称" require="required" controlName="职务名称" />
		    	<span style="color:red;">*</span>
		    </td>
			<td class="firstRow">职务级别:</td>
			<td class="secRow">
				<s:select title="职务级别" 
					id="position.position_grade" 
					name="position.position_grade"
					list="#{1:'总经理',2:'副总经理',3:'总监',4:'经理',5:'主管',6:'员工'}"
					require="required" controlName="职务级别" />
				<span style="color:red;">*</span>
			</td>
		  </tr>
		  <tr>
		  	<td class="firstRow">汇报对象:</td>
			<td class="secRow">
				<s:select title="汇报对象" id="position.position_senior" name="position.position_senior"
					list="positions" listKey="uuid" listValue="position_name"
					headerKey="0" headerValue="无"
					require="required" controlName="汇报对象" />
				<span style="color:red;">*</span>
			</td>
		    <td class="firstRow">职务属性:</td>
		    <td class="secRow">
		    	<s:textfield id="position.position_attribute" name="position.position_attribute" title="职务属性" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">职务描述:</td>
		    <td class="secRow" colspan="3">
		    	<s:textfield id="position.position_note" name="position.position_note" title="职务描述" />
		    </td>
		  </tr>		  
		<s:if test="null != position">	
		  <tr>
		    <td class="firstRow">修改人:</td>
		    <td class="secRow"><s:property value="position.lm_user" />
						<s:hidden name="position.lm_user" /></td>
		    <td class="firstRow">修改时间:</td>
		    <td class="secRow"><s:date name="position.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>
		</s:if>
		<tr>
		    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
				<s:if test="null == position && 'add' == viewFlag">
					<s:submit id="add" name="add" value="增加" action="position_add" />
				</s:if>
				<s:elseif test="null != position && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="position_save" />
					<s:submit id="delete" name="delete" value="删除" action="position_del" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="position_list" namespace="/sys" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>