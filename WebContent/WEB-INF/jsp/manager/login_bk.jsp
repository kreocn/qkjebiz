<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>
<title><s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<script type="text/javascript">
<!--
function reloadImage() {
	form1.pic.src = form1.pic.src;
}
//-->
</script>
<style type="text/css">
.print_prepare01 {
background: url("<s:url value="/images/print/pageheader02.png" />") transparent no-repeat 0 0;display: none;
}
.print_prepare02 {
background: url("<s:url value="/images/print/pageheader02.png" />") transparent no-repeat 0 0;display: none;
}
</style>
</head>
<body>
<div style=" text-align:center; margin-top:80px;">
  <div style="margin:auto;text-align:center;"><img src="<s:url value="/images/logo.png" />" /></div>  
  <div align="center" style="width:490px; margin:auto; line-height:180%;padding-left: 100px;">
<s:form id="mainForm" action="check_login" namespace="/manager" onsubmit="return checkFormx(form1)" method="post" theme="simple">
<table class="ilisttable" id="table1" width="50%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <tr>
	    <td class="firstRow">用户名:</td>
	    <td class="secRow"><s:textfield title="用户名" name="user.title" cssClass="input1" nullable="false" /></td>
	  </tr>
	  <tr>
	    <td class="firstRow">密&nbsp;&nbsp;&nbsp;码:</td>
	    <td class="secRow"><s:password title="密码" name="user.passwords" cssClass="input1" nullable="false" /></td>
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
<!-- 提前加载图片 -->
<div>
<div class="print_prepare01"></div>
<div class="print_prepare02"></div>
</div>
</body>
</html>