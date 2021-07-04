<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件管理器--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<script type="text/javascript">
	function $(obj_id) {
		return document.getElementById(obj_id);
	}
	window.onload = function() {
		if (window.Event)
			document.captureEvents(Event.MOUSEUP);
		document.oncontextmenu = nocontextmenu; // for IE5+ 
		document.onmousedown = norightclick; // for all others 
		
		window.open(
				'/JFileSystem/?user=<s:property value="user" />&date=<s:property value="date" />&validata=<s:property value="validata" />&root=<s:property value="root" />',
				'文件管理器',
				'height=600, width=660, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
		//alert('aa');

	};

	function nocontextmenu() {
		event.cancelBubble = true
		event.returnValue = false;
		return false;
	}

	function norightclick(e) {
		if (window.Event) {
			if (e.which == 2 || e.which == 3)
				return false;
		} else if (event.button == 2 || event.button == 3) {
			event.cancelBubble = true
			event.returnValue = false;
			return false;
		}
		return true;
	}
	
	function openx() {
		window.open(
				'/JFileSystem/?user=<s:property value="user" />&date=<s:property value="date" />&validata=<s:property value="validata" />&root=<s:property value="root" />',
				'文件管理器',
				'height=600, width=660, top=0, left=0, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, status=no');
	}
</script>
<style type="text/css">
.main {
	padding-top: 200px; width: 500px; margin: auto; font-size: 14px;
}

.main p {
	text-align: center;
}

.main a {
	color: blue; text-decoration: none; font-size: 14px;
}

.main a:hover {
	text-decoration: underline; color: red;
}
</style>
<body>
	<div class="main">
		<p>正在自动打开文件管理器</p>
		<p>
			如无反应,请<a href="javascript:void(0);" onclick="openx();">手动点击这里</a>打开
		</p>
	</div>
	<NOSCRIPT>
		<IFRAME SRC=*.html></IFRAME>
	</NOSCRIPT>
</body>
</html>