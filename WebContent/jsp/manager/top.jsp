<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>顶部--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<script>
function onOver(id) {
	changeImg(id+"_1");
}
function onOut(id) {
	changeImg(id);
}
function changeImg(id) {
	var ev=(window.event)?window.event:e;
	var obj=(ev.target)?ev.target:ev.srcElement;
	var img="<s:url value="/images" />/selectwb"+id+".gif";
	obj.style.backgroundImage="url("+img+")";
}
</script>
<body>
<div id="head">
	<div id="banner">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td valign="middle" style="color: white;font-size: 14px;font-weight: bold;text-indent: 24px;">
				<s:text name="APP_NAME" />
				</td>
				<td align="right">
<table height="44" border="0" align="right" cellpadding="0" cellspacing="0" id="tt" style="margin-right:10px ">
	<tr>
		<td width="44" background="<s:url value="/images" />/selectwb0.gif" onmouseover="onOver(0);" onmouseout="onOut(0)" 
		onClick="parent.frames['mainFrame'].location='<s:url value="default" />';" 
		title="返回首页" style="cursor:hand ">&nbsp;</td>
		<td width="41" background="<s:url value="/images" />/selectwb1.gif" onmouseover="onOver(1);" onmouseout="onOut(1)"
		onClick="javascript:top.location='<s:url action="/login" />';" 
		title="用户登录" style="cursor:hand ">&nbsp;</td>
		<td width="39" background="<s:url value="/images" />/selectwb2.gif" onmouseover="onOver(2);" onmouseout="onOut(2)"
		onClick="parent.frames['mainFrame'].location.reload();" 
		title="帮助信息" style="cursor:hand ">&nbsp;</td>		
		<td width="41" background="<s:url value="/images" />/selectwb3.gif" onmouseover="onOver(3);" onmouseout="onOut(3)"
		onClick="parent.frames['mainFrame'].location='<s:url value="/sys/iuser_load" />';" 
		title="修改信息" style="cursor:hand ">&nbsp;</td>
		<td width="41" background="<s:url value="/images" />/selectwb4.gif" onmouseover="onOver(4);" onmouseout="onOut(4)"
		onClick="parent.frames['mainFrame'].location.reload();" 
		title="刷新主页" style="cursor:hand ">&nbsp;</td>
		<td width="37" background="<s:url value="/images" />/selectwb5.gif" onmouseover="onOver(5);" onmouseout="onOut(5)"
		onClick="javascript:top.location='<s:url action="login_out" namespace="/manager" />';" 
		title="退出系统" style="cursor:hand ">&nbsp;</td>
	</tr>
</table>
				</td>
			</tr>
		</table>
	</div>	
</div>
</body>
</html>