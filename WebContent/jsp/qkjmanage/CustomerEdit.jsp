<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户管理管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
 <div class="main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="customer_list"><s:param name="viewFlag">relist</s:param></s:url>">客户列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="customer_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<fieldset class="clear">
					<legend>基本信息</legend>
					<div class="label_hang">
					       <div class="label_ltit">所属部门:</div>
					       <div class="label_rwben"></div>
					</div>
				</fieldset>
			</div>
		</div>
	</s:form>
</div>
</body>
</html>