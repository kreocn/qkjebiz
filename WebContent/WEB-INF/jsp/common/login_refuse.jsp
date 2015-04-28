<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登陆异常</title>
</head>
<script type="text/javascript">
function getTopWin() {
	var win = window;
	while(win.top!=win) {
		win = win.top;
	}
	return win;
}

function review() {
	var top_win = getTopWin();
	//top_win.mainFrame.location.reload();
	//top_win.mainFrame.history.back();
	top_win.mainFrame.location = '<s:url value="/default" />';
}
</script>
<body>
	<script type="text/javascript">
	alert('<s:property value="exception.message" escape="false" />');
	//window.history.back();
</script>
	<s:property value="exception.message" escape="false" />
	<br />
	<span style="font-size: 12px; font-weight: normal;">[<a href="javascript:review();">点击返回</a>]
	</span>
</body>
</html>