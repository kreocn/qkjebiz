<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>天佑德藏酒 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/index.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/include/jQuery/stylesheets/nivo-slider.css" />" />
<link rel="stylesheet" type="text/css" href="<c:url value="/include/jQuery/stylesheets/nivo-slider-default.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.nivo.slider.pack.js" />"></script>
<script type="text/javascript">
$(function(){
	$('#index-ad-show').nivoSlider({ pauseTime : 8000 });
});
</script>
</head>
<body>
<c:import url="/jsp/fore/top.jsp" />
<div id="content">
	<div class="sep25"></div>
	<div class="index_nav slider-wrapper theme-default">
		<div id="index-ad-show">
			<a href="/html/cellar"><img src="http://qkjchina.com/ckframe/userfiles/images/cangjiu/slider/slider_01.jpg" /></a>
			<a href="/html/cellar"><img src="http://qkjchina.com/ckframe/userfiles/images/cangjiu/slider/slider_02.jpg" /></a>
			<a href="/html/help?refid=1397282986266001"><img src="http://qkjchina.com/ckframe/userfiles/images/cangjiu/slider/slider_03.jpg" /></a>
		</div>
	</div>
	<div class="sep15"></div>
	<div class="justify_both">
		<a href="/html/cellar" class="index_link inlineblock">
			<span class="index_link_title">藏酒介绍</span>
			<span class="index_link_text">作为传统储藏文化的一个细分领域，洞藏本身就是一种文化...</span>
		</a>
		<a href="/jsp/fore/ware.jsp" class="index_link inlineblock">
			<span class="index_link_title">岩窖洞藏</span>
			<span class="index_link_text">与常规贮存方式相比，在相同的时间内，洞藏能使酒质发生更大飞跃...</span>
		</a>
		<a href="html/help?refid=1397283033193001" class="index_link inlineblock">
			<span class="index_link_title">精致品质</span>
			<span class="index_link_text">强化品质意识，品质是企业的生命，品质决定企业的命运...</span>
		</a>
		<a href="/html/help?refid=1397282986266001" class="index_link inlineblock">
			<span class="index_link_title">管家服务</span>
			<span class="index_link_text">对客户提供全过程跟进式的服务。针对不同客人的不同需求进行定制式管理...</span>
		</a>
		<span class="justify_fix"></span>
	</div>
	<div class="sep25 clear"></div>
	<div class="sep25"></div>
	<div class="index_service">
		<span class="index_bk" unselectable="on" onselectstart="return false;">Service</span>
		<span class="index_text">签约购买天佑德藏酒的专属会员，在购买后即刻享有全天24小时的贴心服务。藏酒管家恭候您的来电：4009-969-969</span>
	</div>
	<div class="sep25"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>