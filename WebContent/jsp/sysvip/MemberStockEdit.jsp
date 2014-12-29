<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员库存--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<body>
<div class="main">
<div class="dq_step">
	${path}
	<span class="opb lb op-area"><a href="<s:url action="memberStock_list" namespace="/sysvip"></s:url>">返回列表</a></span>
</div>
<s:form id="editForm" name="editForm" cssClass="validForm" namespace="/sysvip" method="post" theme="simple">
<div class="label_con">
	<s:if test="'mdy' == viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">会员号:</div>
		<div class="label_rwben">${memberStock.uuid}<s:hidden name="memberStock.uuid" title="会员号" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">登录密码:</div>
		<div class="label_rwben label_rwb"><s:password id="passwords" name="memberStock.passwords" cssClass="validate[required]" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">再次输入:</div>
		<div class="label_rwben label_rwb"><s:password id="passwords2" name="passwords2" cssClass="validate[required,equals[passwords]]" /></div>
	</div>
	</div>
	</s:if>
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">会员手机:</div>
		<div class="label_rwben2">
			<span class="label_rwb label_rwbx"><s:textfield name="memberStock.mobile" title="会员手机" cssClass="validate[required,custom[mobile]]" /></span>
			<span class="label_rwb nw"><s:radio name="memberStock.is_mobile_check" title="手机验证"  list="#{0:'未验证',1:'已验证'}" value="1" cssClass="regular-radio" /></span>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员名称:</div>
		<div class="label_rwben label_rwb"><s:textfield name="memberStock.memberStock_name" cssClass="validate[required,maxSize[85]]" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">联系人姓名:</div>
		<div class="label_rwben label_rwb"><span class="message_prompt">企业联系人</span><s:textfield name="memberStock.contact" title="联系人" cssClass="inputNote" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员分组:</div>
		<div class="label_rwben">
			<div class="label_rwb"><s:select name="memberStock.user_type" title="会员级别"  list="roles" listKey="uuid" listValue="role_name" /></div></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员EMAIL:</div>
		<div class="label_rwben2">
			<span class="label_rwb label_rwbx"><s:textfield name="memberStock.email" cssClass="validate[maxSize[85]]" /></span>
			<span class="label_rwb nw"><s:radio name="memberStock.is_email_check" title="EMAIL验证"  list="#{0:'未验证',1:'已验证'}" value="0" cssClass="regular-radio" /></span>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">登录别名:</div>
		<div class="label_rwben label_rwb"><s:textfield name="memberStock.title" cssClass="validate[maxSize[85]]" /></div>
	</div>
	<s:if test="'mdy'==viewFlag">
	<div class="label_hang">
		<div class="label_ltit">所属办事处:</div>
		<div class="label_rwben">${memberStock.dept_name}</div>
	</div>
	<div class="label_hang">
	<div class="label_ltit">所属人:</div>
	<div class="label_rwben">${memberStock.manager_name}</div>
	</div>
	</s:if>
	<s:if test="'add'==viewFlag">
	<div class="label_hang">
		<div class="label_ltit">所属办事处:</div>
		<div class="label_rwben nw">
			<div class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="memberStock.dept_name" readonly="true" /></div>
				<s:hidden id="userdept_codeid" name="memberStock.dept_code" />
			</div>
			<img class="imglink vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" />
	</div>
	<div class="label_hang">
	<div class="label_ltit">所属人:</div>
	<div class="label_rwben">
		<div class="label_rwb">
			<s:select id="membermanagerid" name="memberStock.manager" list="#{}"	headerKey="" headerValue="--请选择--" />
		</div>
	</div>
	</div>
	</s:if>
	</div>
	<s:if test="'mdy'==viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">注册来源:</div>
		<div class="label_rwben label_rwb">
			<s:if test="0==memberStock.reg_type">自行注册</s:if>
			<s:if test="1==memberStock.reg_type">管理员添加</s:if>
			<s:if test="2==memberStock.reg_type">批量导入</s:if>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">注册时间:</div>
		<div class="label_rwben" style="width:auto;"><s:date name="memberStock.reg_time" format="yyyy-MM-dd HH:mm:ss" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">最后登录时间:</div>
		<div class="label_rwben" style="width:auto;"><s:date name="memberStock.last_login_time" format="yyyy-MM-dd HH:mm:ss" /></div>
	</div>
	</div>
	</s:if>
	
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            	<s:if test="'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="member_add" />
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="member_save" cssClass="input-blue" />
					<s:submit id="delete" name="delete" value="删除" action="member_del" cssClass="input-red" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="member_list" namespace="/sysvip" />');"  class="input-gray" />
        	</div>
    	</div>
	</div>
</div>
</s:form>
</div>
</body>
</html>