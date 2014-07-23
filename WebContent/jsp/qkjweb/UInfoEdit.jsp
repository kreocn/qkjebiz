<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>青海互助青稞酒股份有限公司送酒活动</title>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
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
.message {
border-top: #ddd dashed 1px; text-align: center;padding: 10px 0;margin: 10px 0;
}
.message h2 {
padding-top: 0;
}
</style>
</head>
<body>
<s:form name="form1" action="loaduMdy" namespace="/qkjweb" onsubmit="return validator(this);" method="post" theme="simple">
<div style="width: 600px;margin: auto;">
<h1 align="center" style="margin-top: 100px;">送酒活动-地址自助更改系统</h1>
<div align="center" class="rightCol">
证券账户卡号:<s:textfield id="securityid" name="cusInfoh.security" title="股东证券账户卡号" require="required" controlName="股东证券账户卡号" />
</div>
<div align="center" class="rightCol">
联系人手机号:<s:textfield name="cusInfoh.mobile" title="手机号" require="required" controlName="手机号" dataType="mobile" />
<!--<s:textfield id="infouuid" name="cusInfoh.uuid" title="系统查询编号" require="required" controlName="系统查询编号" />-->
</div>
<div align="center" class="buttonarea">
<s:hidden name="cusInfoh.linkid" value="v02" />
<s:submit id="loaduMdy" name="loaduMdy" cssClass="xbutton" value="更改配送地址" action="loaduMdy" />
</div>
<div id="info_message" class="message">
<s:if test="'NOPARA' == viewFlag">请输入联系人手机号和证券账户卡号,一一对应之后才能更改</s:if>
<s:if test="'NULL' == viewFlag">联系人手机号和证券账户卡号不对应.</s:if>
<s:if test="'EXPRESSED' == viewFlag">您的快递已经发出,请联系快递公司更改地址,请<a href="<s:url namespace="qkjweb" action="post_search"><s:param name="cusInfoh.security" value="cusInfoh.security" /></s:url>">点击这里</a>查询您的快递单号!
</s:if>
</div>
</div>
</s:form>
<s:if test="null!=cusInfoh && (null==viewFlag||''==viewFlag)">
<s:form name="form_mdy" action="usave" namespace="/qkjweb" onsubmit="return validator(this);" method="post" theme="simple">
<s:hidden name="cusInfoh.uuid" />
<s:hidden name="cusInfoh.security" />
<div style="width: 600px;margin: auto;">
<div id="mdy_form" class="message">
<h2 align="center">地址信息</h2>
<div align="center" class="rightCol">
姓　　名:<s:textfield name="cusInfoh.fullname" title="姓名" dataLength="0,32" controlName="姓名" require="required" />
</div>
<div align="center" class="rightCol">
联系手机:<s:textfield name="cusInfoh.mobile" title="联系手机" dataLength="0,32" controlName="联系手机" require="required" dataType="mobile"  />
</div>
<div align="center" class="rightCol">
邮　　编:<s:textfield name="cusInfoh.postno" title="邮编" dataLength="0,32" controlName="邮编" />
</div>
<div align="center" class="rightCol">
邮寄地址:<s:textfield name="cusInfoh.address" title="地址" dataLength="0,255" controlName="地址" require="required" />
</div>
<div align="center" class="buttonarea">
<s:hidden name="cusInfoh.linkid" value="v02" />
<s:submit id="usave" name="usave" cssClass="xbutton" value="确认更改" action="usave" onclick="return isOp('是否确定修改!');" />
</div>
</div>
</div>
</s:form>
</s:if>
</body>
</html>