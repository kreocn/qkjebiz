<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<div id="top">
	<div class="top_content">
	<c:if test="${it:getMemberLogin()==true}">
		您好, ${it:getMemberID()} , 欢迎您回来!
		<b>|</b>
		<a href="/member/center">会员中心</a>
		<b>|</b>
		<a href="/html/help">帮助中心</a>
		<b>|</b>
		<a href="/member/member_login_out">退出</a>
	</c:if>
	<c:if test="${it:getMemberLogin()==false}">
		<a href="/member/login">会员登录</a>
		<b>|</b>
		<a href="/html/help">帮助中心</a>
	</c:if>
	</div>
</div>
<div id="top_menu">
	<div class="menu_list">
		<div class="icon_img logo2 inlineblock"><a href="/member/center" class="inlineblock"></a></div>
		<ul class="inlineblock">
			<li><a href="/" class="inlineblock">网站首页</a></li>
			<li><a href="/member/order" class="inlineblock">我的订单</a></li>
			<li><a href="/member/cellar" class="inlineblock">我的藏酒</a></li>
			<li><a href="/member/address" class="inlineblock">收货地址</a></li>
		</ul>
		<div class="menu_right">服务热线：4009-969-969</div>
		<div class="clear"></div>
	</div>
	<div class="menu_line"></div>
</div>