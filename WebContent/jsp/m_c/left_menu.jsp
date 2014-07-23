<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<div id="left_menu">
	<div class="lmenu_list">
		<a href="<s:url value="/member/center" />" class="header">会员中心</a>
		<a href="<s:url value="/member/order" />" ${param.at=='order'?'class="active"':''}>我的订单<b></b></a>
		<a href="<s:url value="/member/cellar" />" ${param.at=='cellar'?'class="active"':''}>我的藏酒<b></b></a>
	</div>
	<div style="height: 10px;"></div>
	<div class="lmenu_list">
		<a href="javascript:;" class="header">会员信息</a>
		<a href="<s:url value="/member/address" />" ${param.at=='address'?'class="active"':''}>收货地址<b></b></a>
		<a href="<s:url value="/member/info" />" ${param.at=='info'?'class="active"':''}>我的信息<b></b></a>
		<a href="<s:url value="/member/account" />" ${param.at=='account'?'class="active"':''}>账户中心<b></b></a>
		<a href="<s:url value="/member/pass" />" ${param.at=='pass'?'class="active"':''}>修改密码<b></b></a>
	</div>
	<div style="height: 10px;"></div>
	<div class="lmenu_list">
		<a href="javascript:;" class="header">交流中心</a>
		<a href="<s:url value="/member/message" />" ${param.at=='message'?'class="active"':''}>我的留言<b></b></a>
	</div>
	<div style="height: 10px;"></div>
	<div class="lmenu_list">
		<a href="javascript:;" class="header">即将开放</a>
		<a href="<s:url value="/member/tieba" />" ${param.at=='tieba'?'class="active"':''}>酒友交流<b></b></a>
		<a href="<s:url value="/member/dingdan" />" ${param.at=='dingdan'?'class="active"':''}>业务订单<b></b></a>
	</div>
</div>