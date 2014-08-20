<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>${news.title} -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/html/html_c.js" />"></script>
</head>
<body>
<c:import url="/jsp/fore/top.jsp" />
<div id="content" class="content_m">
<div id="left_menu">
	<div class="lmenu_list">
		<!-- ${param.refid==item.uuid?'class="active"':''} -->
		<a href="/html/help" class="header">帮助中心</a>
		<c:forEach var="item" items="${newsx}" varStatus="sta">
			<a href="/html/help?refid=${item.uuid}" ${refid==item.uuid?'class="active"':''}>${item.title}<b></b></a>
		</c:forEach>
	</div>
</div>
<div id="right_content">
	<div class="right_top">
		<div class="right_title">${news.title}</div>
		<div class="right_search">
			${news.content}
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>