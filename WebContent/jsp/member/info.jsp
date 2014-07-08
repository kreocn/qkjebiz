<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>我的信息 -- ${it:i18n("HTML_NAME")}</title>
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
<c:import url="/jsp/m_c/left_menu.jsp?at=info" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">我的信息</div>
		<div class="right_form">
			<form id="form_mdy" name="form_mdy" action="<c:url value="/member/saveMember" />" onsubmit="return validator(this);">
			<p><label class="inlineblock">会员号:</label>	${member.uuid}	</p>
			<p><label class="inlineblock">手机号:</label>	${member.mobile}</p>
			<p>
				<label for="TYD_memberName" class="inlineblock"><span class="rt" >*</span> 会员姓名:</label>
				<input id="TYD_memberName" name="member.member_name" class="input_text input2" require="required" controlName="会员姓名" value="${member.member_name}" />
			</p>
			<p>
				<label for="TYD_memberEmail" class="inlineblock">EMAIL:</label>
				<input id="TYD_memberEmail" name="member.email" class="input_text input2" value="${member.email}" />
			</p>
			<p>
				<label class="inlineblock">专属客户经理:</label>
				${member.manager_name}
				<span class="text_note">(联系手机:${member.manager_mobile})</span>
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