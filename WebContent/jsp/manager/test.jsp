<%@page import="java.util.ArrayList"%>
<%@page import="org.iweb.rpt.domain.ListObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>TEST ONLY -- <s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-timepicker-addon.js" />"></script>
<style type="text/css">
</style>
<script type="text/javascript">
$(function(){
	$('#mydate').datetimepicker({
		stepMinute: 15,
		altField: "#mydate2"
	});
});
</script>
</head>
<body>
<div style="height: 20px;"></div>
<div>
日期:<input name="testdate" id="mydate" />
<input name="testdate2" id="mydate2" />
</div>
<div style="height: 50px;"></div>
</body>
</html>