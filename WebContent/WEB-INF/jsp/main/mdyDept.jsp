<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<div class="main">
	<div style="height:10px;"></div>
	<s:form id="addMemberFormTag" name="form_addMemberForm" cssClass="validFormDialog" action="user_saveDept" namespace="/sys" method="post" theme="simple">
		<s:iterator value="userMDepts" status="sta">
					<div class="label_hang clear">
							<input type="radio"  name="user.dept_code" value="<s:property value="dept_code" />"  class="reg_radio" <s:if test="%{deptFlag==1}"> checked="checked" </s:if>>
							<span style="font-size:14px;">${dept_cname }</span>
					</div>
			</s:iterator>
					<div><font color="red">${message }</font></div>
					<div class="label_hang label_button tac input-a">
							<s:submit id="save" name="save" value="保存" action="user_saveDept" cssClass="input-blue"/>
					</div>
	</s:form>

</div>
</body>
</html>