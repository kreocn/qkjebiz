<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>联系我们 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.lightness/jquery-ui.min.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/page.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript">
$(function(){
	$( "#tabs" ).tabs().addClass( "ui-tabs-vertical ui-helper-clearfix" );
	$( "#tabs li" ).removeClass( "ui-corner-top" ).addClass( "ui-corner-left" );
});
</script>
<style type="text/css">
.ui-tabs {
background-color: transparent !important;
}

.ui-tabs .ui-tabs-nav li {
margin-bottom: 0.2em !important;
}
</style>
</head>
<body>
<c:import url="/jsp/fore/top.jsp" />
<div id="content">
	<div class="sep15"></div>
	<div class="mpanel contact_main">
		<div id="tabs">
		<ul>
		    <li><a href="#tabs-1">联系方式</a></li>
		    <li><a href="#tabs-2">地图位置</a></li>
		</ul>
		<div id="tabs-1" class="contact_text">
			<ul>
				<li><span class="con_title">公司名称:</span><span class="con_val">北京互助天佑德青稞酒销售有限公司</span></li>
				<li><span class="con_title">公司地址:</span><span class="con_val">北京市朝阳区京顺东街6号院8号楼</span></li>
				<li><span class="con_title">邮编:</span><span class="con_val">100015</span></li>
				<li><span class="con_title">热线:</span><span class="con_val">010-84306099</span></li>
				<li><span class="con_title">传真:</span><span class="con_val">010-84306009</span></li>
				<li><span class="con_title">投诉建议:</span><span class="con_val">010-84306009</span></li>
				<li><span class="con_title">电子邮件:</span><span class="con_val">service@51qkj.com</span></li>
			</ul>
		</div>
		<div id="tabs-2" class="contact_text">
			<div class="contact_map">
				<img src="../../images/fore/map_01.jpg" alt="" />
			</div>
		</div>
		</div>
		<div class="contact_phone">
			<span class="contact_phone_text">全国统一服务热线</span>
			<span class="contact_phone_no">4009-969-969</span>
		</div>
	</div>
	<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>