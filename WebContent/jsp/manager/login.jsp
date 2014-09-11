<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<style type="text/css">
.print_prepare {
width: 0;height: 0;position: absolute;left: -9999px;top: -9999px;
}
body {
background-color: #363636;
}
.lg_main {
width:100%;max-width: 360px;background-color: #FFFFF0;height: 260px;margin: 50px auto;border-radius: 5px;
border:#000 solid 1px;
-moz-box-shadow:0px 0px 15px 5px #000;              
-webkit-box-shadow:0px 0px 15px 5px #000;           
box-shadow:0px 0px 15px 5px #000; position: relative;
-webkit-box-reflect: below 0 linear-gradient(to bottom,rgba(255,255,255,0),rgba(255,255,255,0.1));
}
.lg_title {
font-size: 20px;color: #FFFFF0;background: #363636;width: 240px;margin: auto;text-align: center;border-radius: 0 0 5px 5px;line-height: 30px;height: 30px;border:#000 solid 1px;border-top:none;
-moz-box-shadow:0px 0px 5px 0px #000;              
-webkit-box-shadow:0px 0px 5px 0px #000;           
box-shadow:0px 0px 5px 0px #000; 
}
</style>
</head>
<body>
<div class="lg_main">
	<div class="lg_title">商务系统登录</div>
	<div class="lg_input">
		<div class=""></div>
	</div>
</div>
<!-- 提前加载图片 -->
<div>
<div class="print_prepare"><img src="<s:url value="/images/print/pageheader02.png" />" alt="" /></div>
<div class="print_prepare"><img src="<s:url value="/images/print/pageheader02.png" />" alt="" /></div>
</div>
</body>
</html>