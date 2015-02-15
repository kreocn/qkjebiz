<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
body {background-color: #363636;}
.print_prepare {width: 0;height: 0;position: absolute;left: -9999px;top: -9999px;}
</style>
</head>
<body>
<div class="main lg_main">
	<div class="lg_title">商务系统登录</div>
	<div class="lg_input">
		<s:form id="mainForm" cssClass="validForm" name="mainForm" action="check_login" namespace="/manager" method="post" theme="simple">
        <div class="label_singlecol">
            <div class="label_singletitle">用户名:</div>
            <div class="label_singlecon"><s:textfield title="用户名" name="user.title" cssClass="validate[required]" nullable="false" /></div>
        </div>
        <div class="label_singlecol">
            <div class="label_singletitle">密&nbsp;&nbsp;&nbsp;&nbsp;码:</div>
            <div class="label_singlecon"><s:password title="密码" name="user.passwords" cssClass="validate[required]" nullable="false" /></div>
        </div>
        <div class="label_singlecol label_s2">
        	<s:submit value="登 录" />
        	<span class="label_seq"></span>
        	<s:reset value="重 置" />
        </div>
        </s:form>
	</div>
</div>
<!-- 提前加载图片 -->
<div>
<div class="print_prepare"><img src="<s:url value="/images/print/pageheader02.png" />" alt="" /></div>
<div class="print_prepare"><img src="<s:url value="/images/print/pageheader02.png" />" alt="" /></div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>