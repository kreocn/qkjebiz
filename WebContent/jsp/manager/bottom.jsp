<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/admin_navigate.css" />" />
</head>
<body>
	<div id="bottom" class="bottom_style">
		当前登录信息:
			<!--<s:property value="org_name" />-->
			<s:property value="dept_name" />
			<s:property value="user_name" />
			[<a href="javascript:;" onclick="top.hidePane('west');">隐藏左边</a>]
			|
			[<a href="javascript:;" onclick="top.toggleWorkSpacePane();">主页面全屏/取消</a>]
			|
			[<a href="javascript:;" onclick="top.resetAllLayout();">重置页面布局</a>]
	</div>
	<div style="height: 200px;">&nbsp;</div>
	<div id="fmp_flash_div"></div>
	<script type="text/javascript" src="<s:url value="/js/fmp.js" />"></script>
	<script type="text/javascript">
	var pronu = {};
	FMP.cfg.movie = "<s:url value="/flash/fmp.swf" />?v=090105a";
	FMP.load();
	function play(seq){
		try{
			if(FMP.loaded){
				FMP.stop();
				FMP.setUrl(pronu[seq]);
				FMP.play();
			}else{
				FMP.onLoad=function(){
					FMP.setUrl(pronu[seq]);
					FMP.play();
				}
			}
		}catch(e){}				
	}
	pronu["msg1"]="<s:url value="/sound/msg.mp3" />";
	//play('msg1');
</script>
<!-- <a href="javascript:play('msg1');">###############</a> -->
</body>
</html>