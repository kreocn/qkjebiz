<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<div class="main">
	<div style="height:10px;"></div>
	<s:form id="addMemberFormTag" name="form_addMemberForm" cssClass="validFormDialog" action="user_saveDept" namespace="/sys" method="post" theme="simple">
		<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">所在部门:</div>
						<div class="label_rwben label_rwb">
							<s:iterator value="userMDepts" status="sta">
							${dept_cname }
							<s:if test="%{deptFlag==1}">
							<input name="user.dept_code" type="checkbox" value="<s:property value="dept_code" />"  checked="checked"/>
							</s:if>
							<s:else>
							<input name="user.dept_code" type="checkbox" value="<s:property value="dept_code" />" />
							</s:else>
							</s:iterator>
						</div>
					</div>
					<div class="label_hang label_button tac">
							<s:submit id="save" name="save" value="保存" action="user_saveDept" cssClass="input-blue"/>
					</div>
			</div>
	</s:form>

</div>

</body>
</html>