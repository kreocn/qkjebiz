<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>程序执行出错</title>
<script type="text/javascript" src="/js/v0.1/jquery-2.1.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$(".errorbtn").click(function(){
		$(".errorContent").toggle();
	});
})
</script>
<style type="text/css">
p{padding:0; margin:0;}
.errorMain {
	margin-top: 10px; width:90%; margin:0 auto; font-size: 12px; font-family:"微软雅黑",Verdana, Arial, Helvetica, sans-serif;
}
.errorTop {
	text-align: center;margin-top: 20px; background: #ddd8d4; border:1px solid #8c8887; padding:50px 0 20px 0;
}
.errormsg{
	font-size:26px; padding:25px 0 35px 0; color:#999;
}
.errorContent {
	border: #336699 solid 1px; margin: 10px 0px; display:none;
}
.errorTitle {
	font-weight: bold; text-indent: 14px; background-color: #336699; color: #FFFFFF;line-height: 30px;height: 30px; font-size:14px;
}
.errorInfo {
	text-indent: 24px; margin: 10px 0px; line-height: 200%;
}
.errorbtn{
	float:right; padding-right:20px;
}
.errorbtn a{
	display: block; font-size:14px; background:#d34015; width:110px; height:28px; line-height:28px; text-decoration: none; color:#fff;
}
</style>
</head>
<body>
	<div class="errorMain">
		<div class="errorTop">
			<p><img src="<s:url value="/images/error/error06.png" />" /></p>
			<p class="errormsg">很抱歉，您所访问的页面未能找到或者出现了未知错误...</p>
			<p class="errorbtn"><a href="javascript:;">查看错误信息</a></p>
			<div style="clear:both;"></div>
		</div>
		<div class="errorContent">
			<div id="d_errorTitle" class="errorTitle">错误信息</div>
			<div id="d_errorInfo" class="errorInfo">
				<p><s:property value="message" escape="false" /></p>
				<p><s:fielderror /></p>
				<p><s:actionerror /></p>
				<p><s:property value="exception.message" escape="false"/></p>
				<p><s:property value="exceptionStack" escape="false" /></p>
			</div>
		</div>
	</div>
</body>
</html>