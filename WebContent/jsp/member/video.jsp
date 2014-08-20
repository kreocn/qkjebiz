<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>取酒视频 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/html/html_c.js" />"></script>
<style type="text/css">
.video_area {
padding: 30px;
}
.video_info {
width: 780px;margin: 10px auto;padding: 10px;border: #ccc dashed 1px;background-color: #EEE;letter-spacing: 1px;
}
.info_title {
font-weight: bold;border-bottom: #ccc dashed 1px;font-size: 14px;
}
.info_imp {
font-weight: bold;
}
.video_player {
text-align: center;
}
</style>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=cellar" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">取酒视频</div>
		<div class="right_search video_area">
		<c:if test="${empty cellarOrder}">参数错误!</c:if>
		<c:if test="${!(empty cellarOrder)}">
		<div class="video_player">
			<c:if test="${empty cellarOrder.order_video}">没有视频信息</c:if>
			<c:if test="${!(empty cellarOrder.order_video)}">
			<embed src="${cellarOrder.order_video}" allowFullScreen="true" quality="high" 
				width="780" height="490" align="middle" allowScriptAccess="always" type="application/x-shockwave-flash"></embed>
			</c:if>
		</div>
		<c:if test="${!(empty cellarOrder.order_video_pass)}">
		<div class="video_info info_imp">
			视频观看密码: ${cellarOrder.order_video_pass}
		</div>
		</c:if>
		<div class="video_info">
			<p class="info_title">取酒信息</p>
			<p>取酒时间: ${it:formatDate(cellarOrder.add_time,"yyyy-MM-dd HH:mm:ss")}</p>
			<p>取酒数量: ${cellarOrder.order_num}</p>
			<p>配送信息: ${cellarOrder.con_province} ${cellarOrder.con_city} ${cellarOrder.con_area} ${cellarOrder.con_street} (${cellarOrder.con_name} ${cellarOrder.con_mobile})</p>
			<p>快递信息: <c:if test="${cellarOrder.express_type==0}">快递</c:if><c:if test="${cellarOrder.express_type==1}">上门自提</c:if>	 - ${cellarOrder.express_no}</p>
		</div>
		</c:if>
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>