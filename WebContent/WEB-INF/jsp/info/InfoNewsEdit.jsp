<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息内容--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<style type="text/css">
.label_ltit{width:130px;}
#ModelDiv{top:80px!important;}
#ModelDiv,#BgDiv{height:100%!important;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
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
			       		<s:hidden id="news.class_id" title="信息类别" cssClass="validate[required]" name="news.class_id" value="%{news.class_id}" />
			       		<s:textfield id="news.class_name" title="信息类别"  cssClass="validate[required]" name="news.class_name"	value="%{news.class_name}" readonly="true" /><img id="class_detail_open" class="detail vatop" src='<s:url value="/images/open2.gif" />' />
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
			    <div class="label_hang clear" id="checkimgnews" <s:if test="null == news || null == news.isimgnews || 0 == news.isimgnews">style="display: none;"</s:if>>
						<div class="label_ltit">小图链接:</div>
						<div class="label_rwbenx"><s:textfield id="newssmallimgid" title="小图链接" name="news.smallimg" /></div>
						<div class="label_ltit">大图链接:</div>
						<div class="label_rwbenx"><s:textfield id="newsbigimgid" title="大图链接" name="news.bigimg" /></div>
				</div>
				<div class="label_hang  clear">
					<div class="label_ltit">信息内容:</div>
				</div>
				<div class="note_area  clear">
					<s:textarea name="news.content" title="信息内容" cssClass="xheditorArea validate[maxSize[65535]]" id="newscontentedit1" />
					<div class="clear"></div>
				</div>
				<div class="label_hang  clear">
			       <div class="label_ltit">关键字(多个用,隔开):</div>
			       <div class="label_rwbenx"><s:textfield name="news.keywords" title="关键字" cssClass="label_hang_linput"/></div>
			    </div>
				<div class="label_hang  clear">
			       <div class="label_ltit">简短描述:</div>
			       <div class="label_rwbenx"><s:textarea id="news_shortcontent" name="news.shortcontent" title="简短描述" cssClass="label_hang_linput inputNote validate[maxSize[65535]]" /></div>
			    </div>
				<div class="label_hang  clear">
			       <div class="label_ltit">其他信息:</div>
			       <div class="label_rwbenx"><s:textfield name="news.new_source" title="其他信息" cssClass="label_hang_linput" id="news_new_source"/></div>
			    </div>
		    	<s:if test="null != news">
				<div class="label_hang  clear">
			       <div class="label_ltit">是否置顶:</div>
			       <div class="label_rwben"><s:if test="0 == news.istop">否</s:if> <s:elseif test="1 == news.istop">是</s:elseif></div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">是否已审核:</div>
			       <div class="label_rwben"><s:if test="0 == news.ischecked">否</s:if> <s:elseif test="1 == news.ischecked">是</s:elseif></div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">创建人:</div>
			       <div class="label_rwben">${news.add_user}</div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">创建时间:</div>
			       <div class="label_rwbenx">${it:formatDate(news.add_time,'yyyy-MM-dd hh:mm:ss')}</div>
			    </div>
			    </s:if>
			    <s:if test="null != news && 'mdy' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_SMDY')">
					<div class="label_hang clear">
				       <div class="label_ltit">特殊操作:</div>
				       <div class="label_rwbenx">
				       		<script type="text/javascript">
							//news_shortcontent news_new_source news_title
							var news_title = $("#news_title").val();
							var news_shortcontent = $("#news_shortcontent").val();
							var news_new_source = $("#news_new_source").val();
							if(!news_new_source.startWith("http"))news_new_source = '';
							var shareInfo = {url:'http://www.qkj.com.cn', title:news_title, summary:news_shortcontent,pic:news_new_source};
							</script>
							<span class="bsync-custom icon-long-orange"><a title="一键分享" class="bshare-bsync" onclick="javascript:bSync.share(event, 'bsharesync',shareInfo)"></a><span class="BSHARE_COUNT bshare-share-count">0</span></span>
							<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bsync.js#uuid=adbc3a1c-dee7-4d36-8baa-f7a2869c77ea"></script> 
							<!-- b7042f0d-1093-4b7f-94ea-d5d3be116301 -->
				       </div>
				    </div>
				    <div class="label_hang clear">
				       <div class="label_ltit">信息置顶:</div>
				       <div class="label_rwbenx">
				       		<s:url id="unTop" action="news_saveTop" namespace="/info">
								<s:param name="news.uuid" value="%{news.uuid}" />
								<s:param name="news.istop" value="0" />
							</s:url>
							<s:url id="toTop" action="news_saveTop" namespace="/info">
								<s:param name="news.uuid" value="%{news.uuid}" />
								<s:param name="news.istop" value="1" />
							</s:url>
							<s:url id="toAddLevel" action="news_saveAddLevel" namespace="/info">
								<s:param name="news.uuid" value="%{news.uuid}" />
							</s:url>
							<s:url id="toDownLevel" action="news_saveDownLevel" namespace="/info">
								<s:param name="news.uuid" value="%{news.uuid}" />
							</s:url>
							<s:if test="news.istop>=1">
								<span style="color: red;">已置顶(<s:property value="news.istop" />)</span>
								[<s:a href="%{unTop}">取消置顶</s:a>]
								[<s:a href="%{toAddLevel}">提升优先级</s:a>]
								[<s:a href="%{toDownLevel}">降低优先级</s:a>]
							</s:if>
							<s:else>未置顶[<s:a href="%{toTop}">设置置顶</s:a>]</s:else>
				       </div>
				    </div>
			    </s:if>
			    <div class="label_hang  clear">
			       <div class="label_ltit">相关操作:</div>
			       <div class="label_rwbenx op-area">
			       		<span id="message"><s:property value="message" /></span>
			       		<s:if test="null == news && 'add' == viewFlag  && @org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_ADD')">
							<s:submit id="saveadd" name="saveadd" value="暂存" action="news_saveadd" />
							<s:submit id="add" name="add" value="提交" action="news_add" cssClass="input-blue"/>
							<input type="button" value="返回" onclick="linkurl('<s:url action="news_list" namespace="/info" />');" class="input-gray"/>
						</s:if>
						<s:elseif test="null != news && 'mdy' == viewFlag  && @org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDY')">
							<s:submit id="savetmp" name="savetmp" value="暂存" action="news_savetmp" />
							<s:submit id="save" name="save" value="保存并提交" action="news_save"  cssClass="input-blue"/>
							<s:url id="toRecycle" namespace="/info" action="news_saveDel">
								<s:param name="news.uuid" value="%{news.uuid}" />
								<s:param name="news.isdel" value="1" />
							</s:url>
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDYDEL')">
								<input type="button" value="放入回收站"  class="input-red" onclick="if(window.confirm('真的把记录放进回收站吗?'))location.href='<s:url value="%{toRecycle}" />';" />
							</s:if>
							<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="news_list" namespace="/info" />');" />
						</s:elseif>
						<s:elseif test="null != news && 'view' == viewFlag">
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDYDEL')">
								<input type="button" class="input-green" value="还原" onclick="if(window.confirm('还原资源吗?'))location.href='<s:url namespace="/info" action="news_saveDel"><s:param name="news.isdel">0</s:param><s:param name="news.uuid" value="news.uuid" /></s:url>';" />
							</s:if>
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_DEL')">
								<input type="button" value="删除" class="input-red" onclick="if(isDel())location.href='<s:url namespace="/info" action="news_del"><s:param name="news.uuid" value="news.uuid" /></s:url>';" />
							</s:if>
							<input type="button" value="返回" onclick="linkurl('<s:url action="news_listRecycle" namespace="/info" />');" class="input-gray" />
						</s:elseif>
			       </div>
			    </div>
 			</div>
 		</div>
 	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<div id="selectInfoClass" style="display: none;">
	<div class="dtree2" style="overflow: scroll; height: 300px; border: none;">
		<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
		<script type="text/javascript">
	d = new dTree('d');
	d.config.check = 2;
	d.config.useIcons = false;
	//d.config.isAddNoRootNode = true;
	d.icon = {
			root		: '<s:url value="/include/dtree/" />'+'img/globe.gif',
			folder		: '<s:url value="/include/dtree/" />'+'img/folder.gif',
			folderOpen	: '<s:url value="/include/dtree/" />'+'img/folderopen.gif',
			node		: '<s:url value="/include/dtree/" />'+'img/page.gif',
			empty		: '<s:url value="/include/dtree/" />'+'img/empty.gif',
			line		: '<s:url value="/include/dtree/" />'+'img/line.gif',
			join		: '<s:url value="/include/dtree/" />'+'img/join.gif',
			joinBottom	: '<s:url value="/include/dtree/" />'+'img/joinbottom.gif',
			plus		: '<s:url value="/include/dtree/" />'+'img/plus.gif',
			plusBottom	: '<s:url value="/include/dtree/" />'+'img/plusbottom.gif',
			minus		: '<s:url value="/include/dtree/" />'+'img/minus.gif',
			minusBottom	: '<s:url value="/include/dtree/" />'+'img/minusbottom.gif',
			nlPlus		: '<s:url value="/include/dtree/" />'+'img/nolines_plus.gif',
			nlMinus		: '<s:url value="/include/dtree/" />'+'img/nolines_minus.gif'
	};		
	d.add('0','-1','信息类别列表');
	<s:iterator value="iclasses">
	d.add('<s:property value="uuid" />','<s:property value="parent_id" />','<s:property value="title" />',"javascript:getInfo('<s:property value="uuid" />')",'<s:property value="title" />');
	</s:iterator>
	d.add();
	document.write(d);
	function setCheckValue() {
		var deptInfo = getCheckBox("cd");
		if(null==deptInfo||""==deptInfo) {
			if(window.confirm("没有选择任何部门,是否确认?")) {
				closemDiv();
			}
		} else {
			//alert(document.getElementById('news.class_id'));
			//$('news.class_id').value = deptInfo[1];
			//document.getElementById('news.class_id').value = deptInfo[1];
			//$('news.class_name').value = deptInfo[2];
			//document.getElementById('news.class_name').value = deptInfo[2];
			//alert($('news.class_name'));
			
			$("#news\\.class_id").val(deptInfo[1]);
			$("#news\\.class_name").val(deptInfo[2]);
			closemDiv();
		}
	}
	</script>
	</div>
	<div class="dtreebutton" style="border: none;">
		<input type="button" value="确定" onclick="setCheckValue();" /> <input type="button" value="返回" onclick="closemDiv();" />
	</div>
</div>
<script type="text/javascript" src="<s:url value="/js/common_prototype.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript">
/*var md;
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
}*/

function closemDiv() {
	 $("#selectInfoClass").dialog("close");
}

$(function(){
$("#selectInfoClass").dialog({ autoOpen : false,
		modal : true });

$("#class_detail_open").click(function(){
	 $("#selectInfoClass").dialog("open");
});
});

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
</body>
</html>