<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产物品列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.con *{margin:0; padding:0; border:0; font-size:16px;}
.con{float:left; width:300px; padding:15px 10px 10px 10px; border:1px solid #000; margin:0 5px 5px 0;}
.bqtop{float:left; width:100%; text-align:center; position:relative;}
.bqlg{position:absolute; left:0; top:0;}
.bqtit{letter-spacing:3px;}
.bqlb{float:left; width:100%; margin-top:5px;}
.bqlb li{list-style:none;float:left; width:100%; margin-top:12px;}
.bqline{border-bottom:1px solid #000; width:215px; display:inline-block;}
@media print {
.printpage {
page-break-after:always;clear: both;
}
}
</style>
<body>
	<span class="opb lb op-area noprint"><input type="button" onclick="window.print();" value="打印本页"/>&nbsp;</span>
    <s:iterator value="assetItems" status="sta">
	    <div class="con">
		<div class="bqtop">
	    	<p class="bqlg"><img src="/images/tyd.gif" width="60" /></p>
	        <p class="bqtit">固定资产管理标签</p>
	    </div>
	    <ul class="bqlb">
	    	<li>资产名称：<span class="bqline">&nbsp;${ tname}</span></li>
	        <li>产品类型：<span class="bqline">A:${atype }&nbsp;&nbsp; B:${btype } &nbsp;&nbsp;　　C:${ctype } </span></li>
	        <li>所在位置：<span class="bqline">&nbsp;${adresss }</span></li>
	        <li>所&nbsp;有&nbsp;人：<span class="bqline">&nbsp;${allpeo }</span></li>
	        <li>编　　号：<span class="bqline">&nbsp;${nuuid }</span></li>
	    </ul>
		</div>
		<s:if test="(#sta.index+1)%8==0">
    	<div class="printpage"></div>
    	</s:if>
    </s:iterator>
	
	<!-- <div style="page-break-after:always;"></div> -->
</body>
</html>