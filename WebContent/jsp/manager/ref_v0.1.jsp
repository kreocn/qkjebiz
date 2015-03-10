<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<link rel="stylesheet" href="<c:url value="/css/v0.1/style.css" />" />
<link rel="stylesheet" href="<c:url value="/css/v0.1/validationEngine.jquery.css" />" />
<link rel="stylesheet" href="<c:url value="/css/animate.css" />" />
<link rel="stylesheet" href="<c:url value="/include/jQuery/stylesheets/jquery.xhupload.css" />" />
<link rel="stylesheet" href="<c:url value="/css/v0.1/demo.css" />" />
<script type="text/javascript">var app_path = '<c:url value="/" />', ajax_url = "/common_ajax/json_ajax";</script>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery-1.9.0.min.js" />"></script>
<!--  <script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>  
 <script type="text/javascript" src="<c:url value="/js/v0.1/jquery-2.1.1.min.js" />"></script> -->
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery-migrate-1.2.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery.validationEngine.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery.validationEngine-zh_CN.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/spin.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/common.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/demo.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/loading.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.1/jquery.iplugin.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/show_page2.0.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/xheditor/xheditor-1.2.1.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/xheditor/xheditor_lang/zh-cn.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/func/create_editor.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.xhupload.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/HttpCookie.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/v0.2/Cookie_Imp.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/form_validator.js" />"></script>
<!--[if lt IE 9]>
<script type="text/javascript">
window.onload=function(){
    document.getElementsByTagName("body")[0].innerHTML='<div class="dl_msg">您的浏览器版本太低啦~系统已不支持IE6/IE7/IE8了！请下载高版本浏览器~~<br>建议安装&nbsp;&nbsp;<a href="http://chrome.360.cn/">360极速浏览器(强烈推荐)</a>&nbsp;&nbsp;<a href="http://windows.microsoft.com/zh-cn/internet-explorer/download-ie">高版本IE(至少IE9)</a><div>';
}
</script>
<![endif]-->