<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产列表--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"固定资产",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none",
		required:false
	});
 });
</script>
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
<div class="main noprint">
	<div class="dq_step">
		<span class="opb lb op-area noprint"><input type="button" onclick="window.print();" value="打印本页"/>&nbsp;</span>
	</div>
	<s:form id="serachForm" name="serachForm" action="assetItem_print"  method="get" namespace="/adm"  theme="simple">
		<div class="label_con">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield title="编号" name="assetItem.nuuid" />
            </div>
       		</div>
        	<div class="label_hang">
            <div class="label_ltit">最后修改时间:</div>
            <div class="label_rwben">
				<input  class="datepicker" type="text" name="assetItem.lm_time_item"  value="${it:formatDate(assetItem.lm_time_item,'yyyy-MM-dd')}" />
            </div>
        	</div>
       		
       		<div class="label_hang">
            <div class="label_ltit">所属公司:</div>
            <div class="label_rwben">
            <s:select name="assetItem.company" title="所属公司" headerKey="" headerValue="--请选择--" list="#{0:'北京互助天佑德青稞酒销售有限公司',1:'华实集团',2:'华奥地产',3:'青海互助青稞酒股份有限公司',4:'青海互助青稞酒销售有限公司',5:'北京互助天佑德青稞酒销售有限公司第二分公司'}" />
            </div>
       		</div>
       		<div class="label_hang">
            <div class="label_ltit">资产分类:</div>
            <div id="mmtype" class="label_rwbenx">
            	<select name="assetItem.typea" title="资产种类" class="prov" style="float:left; width:auto;" disabled="disabled"></select> 
            	<select name="assetItem.btype" title="资产类别" class="city" style="float:left; width:auto;"></select>
            	<select name="assetItem.ctype" title="子类别" class="dist" style="float:left; width:auto;" disabled="disabled"></select>
            </div>
       		</div>
       		
       		<div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        	</div>
        
		</div>
		</div>
	</s:form>
</div>
<s:iterator value="assetItems" status="sta">
	    <div class="con">
		<div class="bqtop">
	    	<p class="bqlg"><img src="/images/tyd.gif" width="60" /></p>
	        <p class="bqtit">固定资产管理标签</p>
	    </div>
	    <ul class="bqlb">
	    	<li>资产名称：<span class="bqline">&nbsp;${ tname}</span></li>
	        <li>产品类型：<span class="bqline"> B:${btype } &nbsp;&nbsp;　　C:${ctype } </span></li>
	        <li>所在位置：<span class="bqline">&nbsp;${adresss }</span></li>
	        <li>所&nbsp;有&nbsp;人：<span class="bqline">&nbsp;${allpeo }</span></li>
	        <li>编　　号：<span class="bqline">&nbsp;${nuuid }</span></li>
	    </ul>
		</div>
		<s:if test="(#sta.index+1)%8==0">
    	<div class="printpage"></div>
    	</s:if>
    </s:iterator>
</body>
</html>