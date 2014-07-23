<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>岩窖洞藏 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.lightness/jquery-ui.min.css" />" />
<link rel="stylesheet" href="<c:url value="/include/jQuery/stylesheets/panorama_viewer.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/page.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.panorama_viewer.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
$(function(){
	$(".banner360").panorama_viewer({
		repeat: true,              //true 图像将一直可以滚动。默认值为false,图像只滚动到边缘。
		direction: "horizontal",    //让你定义的滚动方向。可接受的价值观是“水平”和“垂直”。默认值是水平
		animationTime: 700,         //这允许你设置时间当图像被拖。设置为0以使其瞬间。默认值是700。
		easing: "ease-out",
		// 宽度选项 "ease", "linear", "ease-in", "ease-out", "ease-in-out", and "cubic-bezier(...))". 默认值”。 "ease-out".
		overlay: true               // 真/假 这个隐藏的初始指令覆盖
	});

});

</script>
</head>
<body>
<c:import url="/jsp/fore/top.jsp" />
<div id="content">
	<div class="sep15"></div>
	<div class="banner360">
		<img src="<c:url value="/images/emp/demo_photo.jpg" />" />
	</div>
	<div class="mpanel">
		<div></div>
	</div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>