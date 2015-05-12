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
		<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit"></div>
						<div class="label_rwben label_rwb">
							<s:if test="%{deptFlag==1}">
							<s:radio name="member.is_mobile_check" title="手机验证"  list="#{0:'未验证',1:'已验证'}" value="1" cssClass="regular-radio" />
							<span class="label_rwb nw"><input type=radio name=user.dept_code value="<s:property value="dept_code" />" checked="checked" class="regular-radio"></span>
							</s:if>
							<s:else>
							<span class="label_rwb nw"><input type=radio name=user.dept_code value="<s:property value="dept_code" />" class="regular-radio"></span>
							</s:else>
							${dept_cname }
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">会员手机:</div>
						<div class="label_rwben2">
							<span class="label_rwb label_rwbx"><s:textfield id="memMobile" name="member.mobile" title="会员手机" cssClass="validate[required,custom[mobile]]" /></span>
							<span class="label_rwb nw"><s:radio name="member.is_mobile_check" title="手机验证"  list="#{0:'未验证',1:'已验证'}" value="1" cssClass="regular-radio" /></span>
						</div>
					</div>
			</div>
			</s:iterator>
					<div><font color="red">${message }</font></div>
					<div class="label_hang label_button tac">
							<s:submit id="save" name="save" value="保存" action="user_saveDept" cssClass="input-blue"/>
					</div>
	</s:form>

</div>
</body>
</html>