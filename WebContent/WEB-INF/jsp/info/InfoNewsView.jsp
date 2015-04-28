<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@ page import="org.iweb.sys.ContextHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息内容--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/ckedit/ckeditor.js" />"></script>
<script type="text/javascript">
var md;
function selectClass() {	
	md = new modelDiv();
	md.setTitle_HTML("");
	md.setBottom_HTML("");
	md.createModelDivByContent(220,300,___select_infoclass_html_value);	
}
function closemDiv() {
	md.dropModelDiv();
}

function showImgInput(obj) {
	//alert(getRadio("news.isimgnews"));
	if(getRadio("news.isimgnews")==1) {	
		document.getElementById("checkimgnews").style.display = "";
	} else {
		document.getElementById("checkimgnews").style.display = "none";
	}
}

function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('#message').html(str);
}
</script>
<style type="text/css">
.info_view {
width: 1000px;margin: auto;
}
.base_info {
letter-spacing: 1px;
}
.info_title {
text-align: center;
}

.extra_info {
background-color: #F0F0F0;
padding: 5px;
}
</style>
<body>
	<div id="main" style="width: 98%;">
		<div id="result">
			<div class="itablemdy">
			<div class="itabletitle">
				信息预览
			</div>
			<div class="info_view">
				<div class="base_info">
					信息类别:<s:property value="news.class_name" /> | 
					是否是图片新闻:<s:if test="news.isimgnews==0">否</s:if><s:elseif test="news.isimgnews==1">是</s:elseif> |
					是否置顶:<s:if test="news.istop>=1">已置顶(<s:property value="news.istop" />)</s:if><s:else>未置顶</s:else>  |
					发布人:<s:property value="news.add_user_name" />(<s:date name="news.add_time" format="yyyy-MM-dd" />) | 
					最终修改人:<s:property value="news.lm_user_name" />
				</div>
				<h1 class="info_title"><s:property value="news.title" /></h1>
				<div class="extra_info">
					<s:if test="news.redirect_url!=null && news.redirect_url!=''">
					<p>点击标题直接跳转:<s:property value="news.redirect_url" /></p>
					</s:if>
					<p>
					<s:if test="news.smallimg!=null && news.smallimg!=''">小图:<img alt="" src='<s:property value="news.smallimg" />' width="95" height="95"></s:if>					
					<s:if test="news.bigimg!=null && news.bigimg!=''">大图:<img alt="" src='<s:property value="news.bigimg" />' width="750" height="380"></s:if>
					</p>
					<p><s:property value="news.shortcontent" /></p>
				</div>
				<div class="info_content">
					<s:property value="news.content" escape="false" />
				</div>
			</div>
			</div>
		</div>
	</div>
</body>
</html>