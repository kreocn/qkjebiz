<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${it:i18n("APP_NAME")}</title>
<link href="<c:url value="/css/v0.1/jquery.mobile-1.4.3.min.css" />" rel="stylesheet">
<link href="<c:url value="/css/v0.1/jqm-demos.css" />" rel="stylesheet">
<link href="<c:url value="/css/v0.1/nav.css" />" type="text/css" rel="stylesheet">
<link href="<c:url value="/css/v0.1/style.css" />" type="text/css" rel="stylesheet">
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery-1.9.0.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery.mobile-1.4.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/index.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/tab.js" />"></script>
</head>
<body>
<s:action name="top" namespace="/manage" executeResult="true" />
<s:action name="left" namespace="/manage" executeResult="true" />
</body>
<script type="text/javascript">
//var str = '{err:"xserr",msg:"this is msg"}';
//var j1 = eval("(" + str + ")");
//alert(j1.err + ":" + j1.msg);
</script>
</html>