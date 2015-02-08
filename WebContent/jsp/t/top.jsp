<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>商务管理中心--<s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/css/v0.2/jquery.mobile-1.4.3.min.css" />" />
<link rel="stylesheet" href="<s:url value="/css/v0.2/jqm-demos.css" />" />
<link rel="stylesheet" href="<s:url value="/css/v0.2/nav.css" />" />
<link rel="stylesheet" href="<s:url value="/css/v0.2/style.css" />" />
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery-1.9.0.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery-migrate-1.2.1.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/v0.2/jquery.mobile-1.4.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/v0.2/index.js" />"></script>
</head>
<style type="text/css">
.ship_info {
cursor: pointer;
}
</style>
<body>
<!--left菜单-->
<div data-role="page" class="jqm-demos" data-quicklinks="true">
	<a href="#" class="jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left">Menu</a>
	<div data-role="panel" class="jqm-navmenu-panel" data-position="left" data-display="overlay" data-theme="a">
		<ul class="jqm-list ui-alt-icon ui-nodisc-icon">
            <li data-filtertext="demos homepage" data-icon="home"><a href="#">首页</a></li>            
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">业务管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="" data-ajax="false">提货申请单</a></li>
                        <li><a href="" data-ajax="false">返利申请单</a></li>
                        <li><a href="" data-ajax="false">活动管理</a></li>
                        <li><a href="" data-ajax="false">至事由管理</a></li>
                        <li><a href="" data-ajax="false">工业旅游管理</a></li>
                        <li><a href="" data-ajax="false">潜在客户管理</a></li>
                        <li><a href="" data-ajax="false">回访记录查询</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">行政管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">工时管理</a></li>
                        <li><a href="#" data-ajax="false">资产管理</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">新闻管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">新闻列表</a></li>
                        <li><a href="#" data-ajax="false">新闻初审</a></li>
                        <li><a href="#" data-ajax="false">信息终审</a></li>
                        <li><a href="#" data-ajax="false">新闻回收站</a></li>
                        <li><a href="#" data-ajax="false">新闻类别</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">会员管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">添加会员</a></li>
                        <li><a href="#" data-ajax="false">会员列表</a></li>
                        <li><a href="#" data-ajax="false">会员移交</a></li>
                        <li><a href="#" data-ajax="false">会员预付款</a></li>
                        <li><a href="#" data-ajax="false">积分消费记录(返利)</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">基本设置</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">我的资料</a></li>
                        <li><a href="#" data-ajax="false">服务器文件</a></li>
                    </ul>
				</div>
			</li>
		</ul>
	</div>
</div>
</body>
</html>