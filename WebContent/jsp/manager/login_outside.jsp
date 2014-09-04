<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<script type="text/javascript">
//<!--
window.onload = function() {
	setTimeout("checkAutoLogin()",3000);
}
function checkAutoLogin() {
	if(form1.title.value=="") {
		document.getElementById("login_message").innerHTML = "<font color='red'>登录失败,请关闭窗口重新选择系统进入</font>";
	}
}
function reloadImage() {
	form1.pic.src = form1.pic.src;
}
//-->
</script>
<body>
<div style="text-align: center;padding-top: 200px;">
	<img src="images/loading/ajax-loader.gif" alt=""><br />
	<span id="login_message">正在登陆,请稍后...</span><br />
</div>
<div style=" text-align:center; margin-top:80px;display: none;">
  <div style="width:490px; margin:auto; text-align:right; padding-right: 300px;"><img src="<s:url value="/images/Logo2.jpg" />" /></div>  
  <div align="right" style="width:490px; margin:auto; line-height:180%;">
<s:form name="form1" action="check_login" namespace="/manager" onsubmit="return checkFormx(form1)" method="post" theme="simple">
<table class="ilisttable" id="table1" width="50%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <tr>
	    <td class="firstRow">用户名:</td>
	    <td class="secRow"><s:textfield title="用户名" name="title" cssClass="input1" nullable="false" /></td>
	  </tr>
	  <tr>
	    <td class="firstRow">密&nbsp;&nbsp;&nbsp;码:</td>
	    <td class="secRow"><s:password title="密码" name="passwords" cssClass="input1" nullable="false" /></td>
	  </tr>
	  <%if("true".equals(org.iweb.sys.IWebConfig.getConfigMap().get("isCheckLoginRand"))){ %>
	  <tr>
	    <td class="firstRow">验证码:</td>
	    <td class="secRow">
	    	<s:textfield name="rand" cssStyle="width: 45%;" maxlength="4" />
			<img name="pic" class="imglink" onclick="reloadImage();" src="<s:url value="/jsp/common/image.jsp" />" />
		</td>
	  </tr>
	  <% } %>
	  <tr>
		<td colspan="2" class="buttonarea">		
		<s:submit value="登录" /> <s:reset value="重置" /></td>
	  </tr>
</table>
</s:form>
<div style="text-align: center;"><span id="message"><s:property value="message" /></span></div>
  </div>
</div>
</body>
</html>