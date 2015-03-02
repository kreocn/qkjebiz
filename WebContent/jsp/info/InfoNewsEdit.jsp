<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息内容--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<style type="text/css">
.label_ltit{width:120px;}
</style>
</head>
<body>
<div class="main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/info" action="news_list"><s:param name="viewFlag">add</s:param></s:url>" >信息列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="news_save" namespace="/info" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
			       <div class="label_ltit">信息类别:</div>
			       <div class="label_rwbenx">
			       		<s:hidden id="news.class_id" title="信息类别" require="required" name="news.class_id" value="%{news.class_id}" />
			       		<s:textfield id="news.class_name" title="信息类别" require="required" name="news.class_name"	value="%{news.class_name}" readonly="true" /><img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectClass();" />
			       		<s:hidden name="news.uuid" />
			       </div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">标题:</div>
			       <div class="label_rwbenx"><s:textfield name="news.title" title="标题" cssClass="label_hang_linput validate[required]"/></div>
			    </div>
			    <div class="label_hang clear">
			       <div class="label_ltit">跳转链接:</div>
			       <div class="label_rwbenx"><s:textfield name="news.redirect_url" title="跳转链接" cssClass="label_hang_linput"/></div>
			    </div>
			    <div class="label_hang clear">
			       <div class="label_ltit">是否为图片信息:</div>
			       <div class="label_rwbenx"><s:radio title="是否为图片信息" onclick="showImgInput(this);" name="news.isimgnews" list="#{0:'否',1:'是'}"></s:radio></div>
			    </div>
 			</div>
 		</div>
 	</s:form>
</div>
</body>
</html>