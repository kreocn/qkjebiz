<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			${path}
			<span class="opb lb op-area"><a href="<s:url namespace="/sys" action="position_list"></s:url>" >职务管理列表</a></span>
		</div>
		<s:form id="formEdit" name="form1" cssClass="validForm" action="position_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
			<s:if test="null != position">
				<div class="label_hang">
			       <div class="label_ltit">用户ID:</div>
			       <div class="label_rwbenx">${position.uuid}<s:hidden name="position.uuid" /></div>
				</div>
			</s:if>
			<div class="label_hang clear">
		       <div class="label_ltit">职务名称:</div>
		       <div class="label_rwben"><s:textfield id="position.position_name" name="position.position_name" title="职务名称" cssClass="validate[required]" /></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">职务级别:</div>
		       <div class="label_rwben"><s:select title="职务级别" id="position.position_grade" name="position.position_grade" list="#{1:'总经理',2:'副总经理',3:'总监',4:'经理',5:'主管',6:'员工'}" cssClass="validate[required]"/></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">汇报对象:</div>
		       <div class="label_rwbenx"><s:select title="汇报对象" id="position.position_senior" name="position.position_senior" list="positions" listKey="uuid" listValue="position_name" headerKey="0" headerValue="无" cssClass="validate[required]"/></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">职务属性:</div>
		       <div class="label_rwben"><s:textfield id="position.position_attribute" name="position.position_attribute" title="职务属性" /></div>
			</div>
			<div class="label_hang clear">
		       <div class="label_ltit">职务描述:</div>
		       <div class="label_rwben"><s:textfield id="position.position_note" name="position.position_note" title="职务描述" cssClass="label_hang_linput"/></div>
			</div>
			<s:if test="null != position">
				<div class="label_hang clear">
			       <div class="label_ltit">修改人:</div>
			       <div class="label_rwben">${position.lm_user}<s:hidden name="position.lm_user" /></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">修改时间:</div>
			       <div class="label_rwbenx">${it:formatDate(position.lm_time,'yyyy-MM-dd HH:mm:ss')}</div>
				</div>
			</s:if>
			<div class="label_hang clear">
		       <div class="label_ltit">相关操作:</div>
		       <div class="label_rwbenx">
		       		<s:if test="null == position && 'add' == viewFlag">
						<s:submit id="add" name="add" value="增加" action="position_add" cssClass="input-blue"/>
					</s:if>
					<s:elseif test="null != position && 'mdy' == viewFlag">
						<s:submit id="save" name="save" value="保存" action="position_save" cssClass="input-blue"/>
						<s:submit id="delete" name="delete" value="删除" action="position_del" onclick="return isDel();" cssClass="input-red"/>
					</s:elseif>
					<input type="button" value="返回" onclick="linkurl('<s:url action="position_list" namespace="/sys" />');" class="input-gray"/>
					<span id="message"><s:property value="message" /></span>
		       </div>
			</div>
		</s:form>
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>