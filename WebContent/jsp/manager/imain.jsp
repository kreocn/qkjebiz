<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.layout1.3.0.css" />" />
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.layout1.3.0.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/singlejs/imain.js" />"></script>
<style type="text/css">
.ui-layout-south {overflow: hidden;}
.ui-layout-north {overflow: hidden;}
.ui-layout-center{overflow: auto;}
.layout_iframe{width: 100%;height:100%;overflow:auto;border: none;background: transparent;}
</style>
</head>
<body>
<div class="ui-layout-center" style="overflow: hidden;">
	<iframe id="mainFrame" name="mainFrame" src="about:blank" longdesc="default" class="layout_iframe" frameborder="0" scrolling="auto"></iframe>
</div>
<div class="ui-layout-south">
	<iframe id="bottomFrame" name="bottomFrame" src="about:blank" longdesc="bottom" class="layout_iframe" frameborder="0" scrolling="no"></iframe>
</div>
<div class="ui-layout-west" style="overflow: hidden;">
	<iframe id="leftFrame" name="leftFrame" src="about:blank" longdesc="menu" class="layout_iframe" frameborder="0" scrolling="auto"></iframe>
</div>
<div class="ui-layout-north">
	<iframe id="topFrame" name="topFrame" src="about:blank" longdesc="top" class="layout_iframe" frameborder="0" scrolling="no"></iframe>
</div>
<div class="ui-layout-east"></div>
</body>
</html>