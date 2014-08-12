<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>顶部--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/admin_navigate.css" />" />
<body>
  <div class="ht_top">
    <div class="ht_lTit">互助青稞酒商务管理中心</div>
    <ul class="ht_rczuo">
      <li><a title="首页" href="<s:url value="default" />" target="mainFrame"><img src="<s:url value="/images" />/top//ht_tb1.gif" /></a></li>
      <li><a title="切换账户" href="<s:url action="/login" />"  target="_top"><img src="<s:url value="/images" />/top/ht_tb2.gif" /></a></li>
      <li><a title="帮助信息" href="http://d.qkjchina.com/qkjzn/index.html?v=0.01"  target="mainFrame"><img src="<s:url value="/images" />/top/ht_tb3.gif" /></a></li>
      <li><a title="我的信息" href="<s:url value="/sys/iuser_load" />"  target="mainFrame"><img src="<s:url value="/images" />/top/ht_tb4.gif" /></a></li>
      <li><a title="刷新主页" href="javascript:;" onclick="parent.frames['mainFrame'].location.reload();"><img src="<s:url value="/images" />/top/ht_tb5.gif" /></a></li>
      <li><a title="退出系统" href="<s:url action="login_out" namespace="/manager" />"  target="_top"><img src="<s:url value="/images" />/top/ht_tb6.gif" /></a></li>
    </ul>
    <div style="clear: both;"></div>
  </div>
</body>
</html>