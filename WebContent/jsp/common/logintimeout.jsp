<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆超时</title>
</head>
<body>
	<script type="text/javascript">
	var win = window.top?window.top:window;
	win.alert("登陆超时,请重新登录!");	
	win.location.href = '<s:url action="login" namespace="/manager" />';
</script>
</body>
</html>