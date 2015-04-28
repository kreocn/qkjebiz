<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>会员登录 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/login.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#TYD_login_submit").hover(function() {
		$(this).css("background-position", "0 -34px");
	}, function() {
		$(this).css("background-position", "0 0");
	});
});
</script>
</head>
<body>
<div id="content">
<div id="login_head">
	<span class="logo2 icon_img inlineblock"><a href="<c:url value="/" />" class="inlineblock"></a></span>
	<span class="logotext icon_img inlineblock"></span>
</div>
<div class="login_area">
	<div class="login_f">
		<div class="login_i">
			<img src="<c:url value="/images/emp/login_img.jpg" />" alt="" />
			<div class="login_iover icon_img"></div>
		</div>
		<div class="login_s">
			<div class="login_s_f">
				<form action="<c:url value="/member/check_login" />">
				<div class="field">
				<label for="TYD_username">帐号/手机号:</label>
				<input type="text" name="member.uuid" id="TYD_username" class="login_text login_user icon_img" />
				</div>
				<div class="field">
				<label for="TYD_passwords">登录密码:</label>
				<input type="password" name="member.passwords" id="TYD_passwords" class="login_text login_pwd icon_img" />
				</div>
				<div class="field sep_login"></div>
				<div class="field">
				<input id="TYD_login_submit" type="submit" name="submit" class="login_submit icon_img" value="" />
				<div class="f_pass"><a href="javascript:;">忘记密码</a></div>
				</div>
				<div id="message" class="field field_submit f4">${message}</div>
				</form>
			</div>
		</div>
	</div>
</div>
</div>
<!-- footer start -->
<c:import url="/jsp/m_c/login_footer.jsp" />
<!-- footer end -->
</body>
</html>