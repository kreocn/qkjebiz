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
	<div class="dq_step">${path}</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="iuser_save" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<div class="label_hang">
	            	<div class="label_ltit">用户名:</div>
		            <div class="label_rwben">${user.title}<s:hidden name="user.title" /></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">姓名:</div>
		            <div class="label_rwben"><s:textfield  name="user.user_name" title="姓名" cssClass="validate[required]" /></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">性别:</div>
		            <div class="label_rwben"><s:select name="user.sex" list="#{0:'保密',1:'男',2:'女'}" /></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">电话:</div>
		            <div class="label_rwben"><s:textfield  name="user.phone" title="电话" cssClass="validate[custom[integer]]"/></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">移动电话:</div>
		            <div class="label_rwben"><s:textfield  name="user.mobile" title="移动电话" cssClass="validate[custom[integer]]"/></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">电子邮件:</div>
		            <div class="label_rwben"><s:textfield  name="user.email" title="电子邮件"/></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">汇报对象:</div>
		            <div class="label_rwben">${user.senior_name}</div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">职务:</div>
		            <div class="label_rwben">${user.position}</div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">职务说明:</div>
		            <div class="label_rwben"><s:property value="user.position_note" /></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">部门:</div>
		            <div class="label_rwben">${user.dept_cname}</div>
				</div>
				<div class="label_hline">
					<div class="label_hang">
		            	<div class="label_ltit">用户拥有角色:</div>
			            <div class="label_rwbenx juese">
			            	<s:iterator value="roles" status="sta">
			            		<li>${role_name}</li>
			            	</s:iterator>
			            </div>
					</div>
				</div>
				<div class="label_hline">
					<div class="label_hang">
		            	<div class="label_ltit">其他描述:</div>
			            <div class="label_rwbenx"><s:textarea title="其他描述" name="user.descriptions" cssClass="label_hang_linput" /></div>
					</div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">账号状态:</div>
		            <div class="label_rwben">
		            	<s:if test="1 == user.status">正常</s:if>
						<s:elseif test="2 == user.status">冻结</s:elseif>
						<s:else>初始</s:else>
		            </div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">修改人:</div>
		            <div class="label_rwben">${user.lm_user}<s:hidden name="lm_user" value="%{user.lm_user}" /></div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit">修改时间:</div>
		            <div class="label_rwbenx">${it:formatDate(user.lm_time,'yyyy-MM-dd hh:mm:ss')}</div>
				</div>
				<div class="label_hang">
	            	<div class="label_ltit" style="width:150px;">文件系统绑定目录:</div>
		            <div class="label_rwben">${user.filesystem_root}</div>
				</div>
				<div class="label_hline">
					<div class="label_hang">
		            	<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<s:submit id="save" name="save" value="保存" cssClass="input-blue"/>
							<input type="button" value="修改密码" onclick="changePWD();" />
							<span id="message"><s:property value="message" /></span>
						</div>
					</div>
				</div>
 			</div>
 		</div>
 	</s:form>
</div>
<div id="changePWDdiv" style="display: none;" title="修改密码">
	<s:form name="form2" cssClass="validForm" action="iuser_change" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
		<table class="ilisttable" width="100%" >
		  <tr>
		    <td width="25%" align="right">用户名:</td>
		    <td>${user.title}<s:hidden name="user.title" /><s:hidden name="user.uuid" /><s:hidden name="viewFlag" value="mdy" /></td>	
		  </tr>
		  <tr>
		    <td align="right">原密码:</td>
		    <td><s:password title="原密码" name="old_passwords" cssClass="validate[required]" /></td>
		  </tr>
		  <tr>
		    <td align="right">新密码:</td>
		    <td><s:password title="新密码" name="new_passwords" cssClass="validate[required]" /></td>
		  </tr>
		  <tr>
		    <td align="right">再输一次:</td>
		    <td><s:password title="再输一次的密码" name="new_passwords2" confirm="new_passwords" /></td>
		  </tr>
		  <tr>
		  	<td>&nbsp;</td>
			<td class="buttonarea"><s:submit value="确定" /></td>	    
		  </tr>
		</table>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
$(function(){
	$("#changePWDdiv").dialog({
	      autoOpen: false,
	      width: 420,
	      height: 220,
	      modal: true
	});
});
function changePWD() {	
	$("#changePWDdiv").dialog("open");
}
function checkPWD2(obj) {
	if (obj.passwords.value!=obj.passwords2.value) {
		alert("两次密码输入不一致,请重新检查!");
		obj.passwords.focus();
	} else {
		return true;
	}
	return false;
}
function checkPWD(obj) {
	if (obj.new_passwords.value!=obj.new_passwords2.value) {
		alert("两次密码输入不一致,请重新检查!");
		obj.new_passwords.focus();
	} else {
		return true;
	}
	return false;
}
function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('message').innerHTML = str;
}
</script>
</html>