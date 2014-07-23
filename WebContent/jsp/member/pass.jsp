<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>会员中心 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/html/html_c.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/form_validator.js" />"></script>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=pass" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">我的信息</div>
		<div class="right_form">
			<form id="form_mdy" name="form_mdy" action="<c:url value="/member/mdyPassword" />" onsubmit="return validator(this);">
			<p>
				<label for="TYD_old_passwords" class="inlineblock"><span class="rt" >*</span> 原 密 码:</label>
				<input type="password" id="TYD_old_passwords" name="old_passwords" require="required" dataType="password" controlName="原密码" class="input_text input2" />
				<span class="rt" ><s:fielderror fieldName="old_passwords_error" /></span>
			</p>
			<p>
				<label for="TYD_new_passwords" class="inlineblock"><span class="rt" >*</span> 新 密 码:</label>
				<input type="password" id="TYD_new_passwords" name="new_passwords" require="required" dataType="password" controlName="新密码" class="input_text input2" />
				<span class="rt" ><s:fielderror fieldName="new_passwords_error" /></span>
			</p>
			<p>
				<label for="TYD_new_passwords2" class="inlineblock"><span class="rt" >*</span> 再输一次:</label>
				<input type="password" id="TYD_new_passwords2" name="new_passwords2" require="required" dataType="password" controlName="密码确认" confirm="new_passwords" class="input_text input2" />
				<span class="rt" ><s:fielderror fieldName="new_passwords2_error" /></span>
			</p>
			<p>
				<label class="inlineblock"></label>
				<input type="submit" value="保 存" class="search_input1" />
				<span class="text_note">${message}</span>
			</p>
			</form>
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>