<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网络营销--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />

</head>
<body>
<div class="main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url action="market_list" namespace="/qkjmanage" />" >返回列表</a>
		</span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="market_add" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_con">
	<s:if test="null != market">
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">编号:</div>
		         <div class="label_rwb"><s:property value="market.uuid" /> <s:hidden id="market.uuid" name="market.uuid" /></div>
	       	</div>
	 </div>
	</s:if>
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">公司名称:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="market.name" name="market.name" title="仓库名称"  cssClass="label_hang_linput validate[required,maxSize[100]]" /></div>
		         </div>
	       	</div>
	 </div>
	 <div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">所属区域:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="market.area" name="market.area" title="仓库名称" cssClass="label_hang_linput validate[required,maxSize[100]]" /></div>
		         </div>
	       	</div>
	 </div>
	 <div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">性质:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="market.lead" name="market.lead" title="仓库地点" cssClass="label_hang_linput validate[required,maxSize[255]]" /></div>
		         </div>
	       	</div>
	 </div>
	 <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">联系地址:</div>
            <div class="label_rwbenx">
            	<s:textarea name="market.address" cssStyle="width:50%;" rows="3" title="联系地址" cssClass="label_hang_linput validate[required,maxSize[128]]" />
            </div>
        </div>
      </div>
      <div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">联系人:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="market.people" name="market.people" title="联系人" cssClass="label_hang_linput validate[maxSize[100]]" /></div>
		         </div>
	       	</div>
	 </div>
	 <div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">联系电话:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="market.phone" name="market.phone" title="仓库地点" cssClass="label_hang_linput validate[required,maxSize[100]]" /></div>
		         </div>
	       	</div>
	 </div>
	 <div class="label_main">
	 <div class="label_hang">
		<div class="label_ltit">门头:</div>
		<div class="label_rwbenx">
	 		<s:textfield id="newssmallimgid" title="图片链接" name="market.img" />
	 	</div>
	 </div>
	 </div>
        <s:if test="null != market">
        	<div class="label_main">
			       <div class="label_hang">
				         <div class="label_ltit">所在位置:</div>
				         <div class="label_rwbenx">[${market.abs }，${market.yaxis }]</div>
			       	</div>
			 </div>
        	<div class="label_main">
        		<div class="label_hang">
		            <div class="label_ltit">修改人:</div>
		            <div class="label_rwben">
		           <s:property value="market.lm_user_name" /> <s:hidden name="market.lm_user" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">修改时间:</div>
		            <div class="label_rwben" style="width:auto;">
		            ${it:formatDate(market.lm_time,'yyyy-MM-dd hh:mm:ss')}
		            </div>
	       		</div>
        	</div>
	    </s:if>
	    <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            	
            	<s:if test="null == market && 'add' == viewFlag">
            	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_MARKET_ADD')">
				<s:submit id="add" name="add" value="下一步填写位置信息" action="market_add" cssClass="input-blue"/>
				</s:if>
				</s:if>
				<s:elseif test="null != market && 'mdy' == viewFlag">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_MARKET_MDY')">
				<s:submit id="save" name="save" value="保存" action="market_save" cssClass="input-blue"/>
				<s:submit id="saveab" name="saveab" value="修改位置" action="market_saveab" cssClass="input-blue"/>
				</s:if>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_MARKET_DEL')">
				<s:submit id="delete" name="delete" value="删除" action="market_del" onclick="return isDel();" cssClass="input-red"/>
				</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="market_list" namespace="/qkjmanage" />');" />
				
            </div>
		</div>
		</div>
	</div>
	</s:form>
</div>
</body>

<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/xheditor/xheditor-1.2.1.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.xhupload.js" />"></script>
<script type="text/javascript">
var md;
var ___select_infoclass_html_value;

var infoeditor01;
var wb_smallimg;
var wb_bigimg;
$(function(){
	createHtmlEditor("#newscontentedit1");
	$.fn.xhuploadinit();
	___select_infoclass_html_value = $('#selectInfoClass').html();
	$('#selectInfoClass').empty();
	$("#newssmallimgid").xhupload();
	$("#newsbigimgid").xhupload();
});

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
</html>