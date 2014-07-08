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
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript">
var md;
var ___change_pwd_html_value;	//由于赋值了form,导致form_name重复而不能使用框架的checkFormx,所以要建立变量保存HTML
window.onload = function() {
	___change_pwd_html_value = $('#changePWDdiv').html();	
	$('#changePWDdiv').empty();	//清空原div数据,避免form_name重复	
}
function changePWD() {	
	md = new modelDiv();
	md.setTitle_HTML("");
	md.setBottom_HTML("");
	md.createModelDivByContent(580,260,___change_pwd_html_value);	
}
function closemDiv() {
	md.dropModelDiv();
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
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">用户信息</div>
<s:form name="form1" action="iuser_save" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
<s:hidden name="user.uuid" />
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		  <tr>
		    <td class="firstRow">用户名:</td>
		    <td class="secRow" colspan="3"><s:property value="user.title" /><s:hidden name="user.title" /></td>			
		  </tr>
		  <tr>
		    <td class="firstRow">姓名:</td>
		    <td class="secRow"><s:textfield id="user.user_name" name="user.user_name" title="姓名" require="required" controlName="姓名" /></td>
			<td class="firstRow">性别:</td>
			<td class="secRow"><s:radio name="user.sex" list="#{0:'保密',1:'男',2:'女'}" /></td>
		  </tr>
		  <tr>
		    <td class="firstRow">电话:</td>
		    <td class="secRow"><s:textfield title="电话" name="user.phone" controlName="电话" dataType="phone" /></td>
			<td class="firstRow">移动电话:</td>
			<td class="secRow"><s:textfield title="移动电话" name="user.mobile" controlName="移动电话" dataType="mobile" /></td>
		  </tr>
		  <tr>
		    <td class="firstRow">电子邮件:</td>
		    <td class="secRow"><s:textfield title="电子邮件" name="user.email" controlName="电子邮件" dataType="email" /></td>
			<td class="firstRow">汇报对象:</td>
			<td class="secRow"><s:property value="user.senior_name" /></td>
		  </tr>
		  <tr>
		    <td class="firstRow">职务:</td>
		    <td class="secRow"><s:property value="user.position" /></td>
			<td class="firstRow">职务说明:</td>
			<td class="secRow"><s:property value="user.position_note" /></td>
		  </tr>
		  <tr>
		    <td class="firstRow">部门:</td>
		    <td class="secRow" colspan="3"><s:property value="user.dept_cname" /></td>			
		  </tr>
		  <tr>
		    <td class="firstRow">用户拥有角色:</td>
		    <td class="secRow" colspan="3">
			<s:iterator value="roles" status="sta">	  
	    		<li><s:property value="role_name" /></li>
			</s:iterator>
		    </td>			
		  </tr>
		  <tr>
		    <td class="firstRow">其他描述:</td>
		    <td class="secRow" colspan="3">			
			<s:textarea title="其他描述" name="user.descriptions" cssStyle="width: 400px" />
			</td>			
		  </tr>
		  <tr>
		    <td class="firstRow">文件系统绑定目录:</td>
		    <td class="secRow" colspan="3"><s:property value="user.filesystem_root" /></td>			
		  </tr>
		  <tr>
			<td class="firstRow">帐户状态:</td>
			<td class="secRow" colspan="3">
			<s:if test="1 == user.status">正常</s:if>
			<s:elseif test="2 == user.status">冻结</s:elseif>
			<s:else>初始</s:else>
			</td>
		  </tr>
		  <tr>
		    <td class="firstRow">修改人:</td>
		    <td class="secRow"><s:property value="user.lm_user" />
						<s:hidden name="lm_user" value="%{user.lm_user}" /></td>
		    <td class="firstRow">修改时间:</td>
		    <td class="secRow"><s:date name="user.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>
		<tr>
		    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
				<s:submit id="save" name="save" value="保存" />
				<input type="button" value="修改密码" onclick="changePWD();" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
<div id="changePWDdiv" style="display: none;">
<s:form name="form2" action="iuser_change" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
<div class="itablemdy">
<div class="itabletitle">修改密码</div>
<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
  <tr>
    <td class="firstRow">用户名:</td>
    <td class="secRow"><s:property value="user.title" />
			<s:hidden name="user.title" />
			<s:hidden name="user.uuid" />
			<s:hidden name="viewFlag" value="mdy" /></td>	
  </tr>
  <tr>
    <td class="firstRow">原密码:</td>
    <td class="secRow"><s:password title="原密码" name="old_passwords" require="required" dataType="password" controlName="原密码" /></td>
  </tr>
  <tr>
    <td class="firstRow">新密码:</td>
    <td class="secRow"><s:password title="新密码" name="new_passwords" require="required" dataType="password" controlName="新密码" /></td>
  </tr>
  <tr>
    <td class="firstRow">再输一次:</td>
    <td class="secRow"><s:password title="再输一次的密码" name="new_passwords2" controlName="密码确认" confirm="new_passwords" /></td>
  </tr>
  <tr>
	<td colspan="2" class="buttonarea">
		<s:submit value="确定" />
		<input type="button" value="返回" onclick="closemDiv();" />
	</td>	    
  </tr>
</table>
</div>
</s:form>
</div>
</body>
</html>