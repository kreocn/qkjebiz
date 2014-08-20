<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆异常</title>
</head>
<body>
	<script type="text/javascript">
	var emessage = '<s:property value="exception.message" escape="false" />';
	var hmessage = '<s:property value="message" escape="false" />';
	var message = emessage==''?hmessage:emessage;	
	if(message!='')	{
		alert(message);
	}
	var win = window.top?window.top:window;
	win.location.href = '<s:url action="login" namespace="/manager" />';
</script>
</body>
</html>