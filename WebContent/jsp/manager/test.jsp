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
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<style type="text/css">
</style>
<script type="text/javascript">
$(function(){
	$("#mmtype").citySelect({
		url:{"citylist":[
		             	{"p":"固定资产","c":[
		         	                 	{"n":"办公家具","a":[{"s":"桌子"},{"s":"椅子"},{"s":"沙发"},{"s":"茶几"},{"s":"花架"},{"s":"运动器具"},{"s":"饰品"},{"s":"书柜"},{"s":"生活用具"}]},
		         	                 	{"n":"电器设备","a":[{"s":"电视"},{"s":"空调"},{"s":"灯具"},{"s":"生活用具"}]},
		                          		{"n":"电子设备","a":[{"s":"电脑"},{"s":"打印机"},{"s":"音频"},{"s":"电话"},{"s":"放映设备"},{"s":"网络设备"}]}
		         	                 	]},
		         	{"p":"非固定资产","c":[
		         	                  	{"n":"办公用品"},
		         	                  	{"n":"生活用品"}
		         	                  	]},
		         ]},
		prov:"",
		city:"",
		dist:"",
		nodata:"none"
	});
	
	$("#mmtypex").citySelect({
		url:"/js/jqueryPlugins/select3/city.min.js",
		prov:"",
		city:"",
		dist:"",
		nodata:"none"
	});
	
	$("#mmtypey").citySelect({
		url:"/js/jqueryPlugins/select3/mm.js",
		prov:"",
		city:"",
		dist:"",
		nodata:"none"
	});
	
	$("#mmtypez").citySelect({
		url:"/js/jqueryPlugins/select3/mm2.js",
		prov:"",
		city:"",
		dist:"",
		nodata:"none"
	});
});
</script>
</head>
<body>
<div style="height: 20px;"></div>
<div id="mmtype">
<select class="prov"></select> 
<select class="city" disabled="disabled"></select>
<select class="dist" disabled="disabled"></select>
</div>
<div style="height: 20px;"></div>
<div id="mmtypex">
<select class="prov"></select> 
<select class="city" disabled="disabled"></select>
<select class="dist" disabled="disabled"></select>
</div>
<div style="height: 20px;"></div>
<div id="mmtypey">
<select class="prov"></select> 
<select class="city" disabled="disabled"></select>
<select class="dist" disabled="disabled"></select>
</div>
<div style="height: 20px;"></div>
<div id="mmtypez">
<select class="prov"></select> 
<select class="city" disabled="disabled"></select>
<select class="dist" disabled="disabled"></select>
</div>
<div style="height: 50px;"></div>
</body>
</html>