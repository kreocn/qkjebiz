<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${it:i18n("APP_NAME")}</title>
<link href="<c:url value="/css/v0.1/jquery.mobile-1.4.3.min.css" />" rel="stylesheet">
<link href="<c:url value="/css/v0.1/jqm-demos.css" />" rel="stylesheet">
<link href="<c:url value="/css/v0.1/nav.css" />" type="text/css" rel="stylesheet">
<link href="<c:url value="/css/v0.1/style.css" />" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery-1.9.0.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery.mobile-1.4.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/index.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/tab.js" />"></script>
</head>
<body>
<div data-role="page"  class="jqm-demos">
  <div class="ht_top" data-role="header">
        <div class="ht_lTit">互助青稞酒商务管理中心</div>
        <ul class="ht_rczuo">
            <li><a href="" title="首页"><img src="<c:url value="/images/top/ht_tb1.gif" />" /></a></li>
            <li><a href="" title="帮助信息"><img src="<c:url value="/images/top/ht_tb3.gif" />" /></a></li>
            <li><a href="" title="退出系统"><img src="<c:url value="/images/top/ht_tb6.gif" />" /></a></li>
        </ul>
        <div style="clear:both;"></div>
    </div>
  
  
  <div data-role="content">
    	<a href="#" class="jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left">Menu</a>
	    <div data-role="panel" class="jqm-navmenu-panel" data-position="left" data-display="overlay" data-theme="a">
			<div data-role="collapsible">
		      <h1><a>点击我 - 我可以折叠！</a></h1>
		      <ul data-role="listview">
				  <li><a href="#">Adam</a></li>
				  <li><a href="#">Angela</a></li>
				  <li><a href="#">Bill</a></li>
				  <li><a href="#">Calvin</a></li>
				</ul>
	
		    </div>
		    <div data-role="collapsible">
		      <h1>点击我 - 我可以折叠！2</h1>
		      <ul data-role="listview">
				  <li><a href="#">Adam</a></li>
				  <li><a href="#">Angela</a></li>
				  <li><a href="#">Bill</a></li>
				  <li><a href="#">Calvin</a></li>
				</ul>
		    </div>
	    </div>
  </div>
  <div data-role="footer"></div>
</div>

</body>
</html>