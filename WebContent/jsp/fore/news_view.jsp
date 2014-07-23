<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>藏酒动态 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.lightness/jquery-ui.min.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/page.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/show_page.js" />"></script>
</head>
<body>
<c:import url="/jsp/fore/top.jsp" />
<div id="content">
	<div class="sep15"></div>
	<div class="mpanel news_view">
		<h1 class="news_title">${news.title}</h1>
		<div class="news_info">
			<span class="news_time">${it:formatDate(news.add_time,"yyyy-MM-dd HH:mm:ss")}</span>
			<span class="news_class">所属分类:${news.class_name}</span>
		</div>
		<div class="news_content">
			${news.content}
		</div>
	</div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>