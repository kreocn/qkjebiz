<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>会员中心 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/html/html_c.js" />"></script>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">会员中心首页</div>
		<div class="right_search">
			<div class="lay_info i_info">
				<div class="iinfo">
					<div class="ileft">
						<div class="ipic">
							<!-- <img src="<c:url value="/images/emp/login_img.jpg" />" alt="" /> -->
							<span class="nopic icon_img"></span>
						</div>
						<div class="ilevel">
							${member.user_type_name}
						</div>
					</div>
					<div class="iright">
						<p>
							<!-- <span class="iname">周骏宇,</span> -->
							<span class="iname">您好, ${member.member_name}</span>
							<span class="iname_text inlineblock block">欢迎您登录会员中心 </span>
						</p>
						<p><label>会员号:</label><span>${member.uuid}</span></p>
						<p><label>手　机:</label><span>${member.mobile}</span></p>
						<p><label>邮　箱:</label><span>${member.email}</span></p>
						<p><label>经理人:</label><span>${member.manager_name} (手机:${member.manager_mobile})</span></p>
					</div>
				</div>
				<div class="isep10"></div>
				<div class="push_info"></div>
			</div>
			<div class="rsep sep_dash"></div>
			<div class="lay_info">
				<div class="lay_info_title right_title">我的资产</div>
				<div class="i_info justify_both">
					<div class="i_info_a">
						<div class="lpic lpic_money icon_img"></div>
						<div class="decimal block">${memberCapital.money}</div>
						<div class="text block">我的资金账户</div>
					</div>
					<div class="i_info_a">
						<div class="lpic lpic_rescore icon_img"></div>
						<div class="block decimal">${memberCapital.re_score}</div>
						<div class="block text">我的返利积分</div>
					</div>
					<div class="i_info_a">
						<div class="lpic lpic_score icon_img"></div>
						<div class="block decimal">${memberCapital.score}</div>
						<div class="block text">我的消费积分</div>
					</div>
					<div class="i_info_a">
						<div class="lpic lpic_cellar icon_img">${cellarSum}</div>
						<div class="block decimal"><a href="<c:url value="/member/cellar" />">查看藏酒</a></div>
						<div class="block text">我的藏酒总储量</div>
					</div>
					<span class="justify_fix"></span>
				</div>
			</div>
			<!-- INSERT HERE -->
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>