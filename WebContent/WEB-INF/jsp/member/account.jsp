<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>账户中心 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/html/html_c.js" />"></script>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=account" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">账户中心</div>
		<div class="right_search">
			<p class="cols3">
				<label class="inlineblock">账户余额:</label>
				￥${memberCapital.money}
				<label class="inlineblock sec">消费积分:</label>
				${memberCapital.score}
				<label class="inlineblock sec">返利积分:</label>
				${memberCapital.re_score}
			</p>
		</div>
	</div>
	<div class="right_top" style="margin-top: 10px;">
		<div class="right_title">账户变更记录(最新30条)</div>
		<div class="right_search">
			<c:forEach var="item" items="${memberCapitalActns}" varStatus="sta">
				<p>${it:formatDate(item.lm_time,"yyyy-MM-dd HH:mm:ss")} ${item.note}</p>
			</c:forEach>
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>