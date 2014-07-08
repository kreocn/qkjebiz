<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>青海互助青稞酒股份有限公司送酒活动</title>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<style type="text/css">
body,td,div {
font-family: "黑体";
font-size: 14px;
}
.leftCol {
width: 150px;
text-align: right;
padding: 5px;
}
.rightCol {
padding: 5px;
}

.rightCol input {
width: 300px;
}

.buttonarea {
text-align: center;
padding: 5px;
}
.buttonarea input.xbutton {
width: 100px;
height: 30px;
border: none;
}

.itable {
border-collapse: collapse;
border: #FFF solid 1px;
}
.itable td {
border: #FFF solid 1px;
}

#securityImg {
width: 16px;height: 16px;display: inline-block;overflow: hidden;
}

#errMsg {
background-color: #C0C0C0;
margin: 5px 10px 5px 3px;
line-height: 20px;
display: none;
}
</style>
</head>
<body>
<s:form name="form1" action="post_search" namespace="/qkjweb" onsubmit="return validator(this);" method="post" theme="simple">
<div style="width: 600px;margin: auto;">
<h1 align="center" style="margin-top: 100px;">礼品快递单号查询系统</h1>
<div align="center" class="rightCol">
股东证券/账户卡号:<s:textfield id="securityid" name="cusInfoh.security" title="股东证券账户卡号" require="required" controlName="股东证券账户卡号" />
</div>
<div align="center" class="buttonarea">
<s:hidden name="cusInfoh.linkid" value="v02" />
<s:submit id="add" name="add" cssClass="xbutton" value="查询单号" action="post_search" />
</div>

<div id="message" align="center">
<s:if test="'FAIL_NULL' == viewFlag"></s:if>
<s:elseif test="'FAIL' == viewFlag">请填写正确的[股东证券/账户卡号],请在卡号面前加0补足10位再试试?如有疑问,请致电我们!</s:elseif>
<s:elseif test="'OK' == viewFlag">
	<s:if test="null == cusInfoh.express_no">您的快递还没有发出,请耐心等待!</s:if>
	<s:else>您的快递号为:<s:property value="cusInfoh.express_no" />, 您可以登录 <a href="http://www.ems.com.cn/mailtracking/you_jian_cha_xun.html" target="_blank">EMS查询网站</a> 查询快递详情</s:else>
</s:elseif>
</div>
</div>
</s:form>
</body>
</html>