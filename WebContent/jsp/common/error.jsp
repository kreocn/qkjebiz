<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>程序执行出错</title>
</head>
<style type="text/css">
.errorMain {
	margin-top: 10px; margin-left: 5%; margin-right: 5%; font-size: 12px; font-family: Verdana, Arial, Helvetica, sans-serif;
}

.errorTop {
	font-size: 14px; font-weight: bold;text-align: center;margin-top: 20px;
}

.errorContent {
	border: #336699 solid 1px; margin: 5px 0px;
}

.errorTitle {
	font-weight: bold; text-indent: 14px; background-color: #336699; color: #FFFFFF;line-height: 30px;height: 30px;
}

.errorInfo {
	text-indent: 24px; margin: 3px 0px; line-height: 200%;
}
</style>
<body>
	<div class="errorMain">
		<div class="errorTop">
			<img src="<s:url value="/images/error05.jpg" />" />
		</div>
		
		<div class="errorContent" style="display: none;">
			<div id="d_errorTitle" class="errorTitle">错误信息</div>
			<div id="d_errorInfo" class="errorInfo">
				<p><s:property value="message" escape="false" /></p>
				<p><s:fielderror /></p>
				<p><s:actionerror /></p>
				<p><s:property value="exception.message"/></p>
				<p><s:property value="exceptionStack" /></p>
			</div>
		</div>
	</div>
</body>
</html>