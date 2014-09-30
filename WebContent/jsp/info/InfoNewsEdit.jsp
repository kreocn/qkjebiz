<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
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
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery-ui-1.10.3.custom.min.css" />" />
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.xhupload.css" />" />
<body>
	<div id="main" style="width: 98%;">
		<div id="result">
			<div class="itablemdy">
				<div class="itabletitle">
					<s:if test="null == news && 'add' == viewFlag">增加</s:if>
					<s:elseif test="null != news && 'mdy' == viewFlag">修改</s:elseif>
					信息
				</div>
				<s:form name="form1" action="news_save" namespace="/info" onsubmit="return validator(this);" method="post" theme="simple">
					<div class="ifromoperate"></div>
					<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
						<tr>
							<td class="firstRow">信息类别:</td>
							<td colspan="3" class="secRow"><s:hidden id="news.class_id" title="信息类别" require="required" controlName="信息类别" name="news.class_id"
									value="%{news.class_id}" /> <s:textfield id="news.class_name" title="信息类别" require="required" controlName="信息类别" name="news.class_name"
									value="%{news.class_name}" readonly="true" /> <img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectClass();" /> <s:hidden
									name="news.uuid" /></td>
						</tr>
						<tr>
							<td class="firstRow">标题:</td>
							<td class="secRow" colspan="3"><s:textfield id="news_title" title="标题" require="required" controlName="标题" name="news.title" cssStyle="width:80%" /></td>
						</tr>
						<tr>
							<td class="firstRow">跳转链接:</td>
							<td class="secRow" colspan="3"><s:textfield title="跳转链接" name="news.redirect_url" cssStyle="width:80%" /></td>
						</tr>
						<tr>
							<td class="firstRow">是否为图片信息:</td>
							<td class="secRow" colspan="3"><s:radio title="是否为图片信息" onclick="showImgInput(this);" name="news.isimgnews" list="#{0:'否',1:'是'}"></s:radio>
							</td>
						</tr>
						<tr id="checkimgnews" <s:if test="null == news || null == news.isimgnews || 0 == news.isimgnews">style="display: none;"</s:if>>
							<td class="firstRow">小图链接:</td>
							<td class="secRow"><s:textfield id="newssmallimgid" title="小图链接" name="news.smallimg" /></td>
							<td class="firstRow">大图链接:</td>
							<td class="secRow"><s:textfield id="newsbigimgid" title="大图链接" name="news.bigimg" /></td>
						</tr>
						<tr>
							<td class="firstRow" style="border-right-color: menu;">信息内容:</td>
							<td class="firstRow" colspan="3"></td>
						</tr>
						<tr>
							<td class="secRow" colspan="4">
							<s:textarea id="newscontentedit1" title="信息内容" name="news.content" cssStyle="display:none;"  /> 
							</td>
						</tr>
						<tr>
							<td class="firstRow">关键字(多个用,隔开):</td>
							<td class="secRow" colspan="3"><s:textfield title="关键字" name="news.keywords" cssStyle="width:80%" /></td>
						</tr>
						<tr>
							<td class="firstRow">简短描述:</td>
							<td class="secRow" colspan="3">
								<s:textarea id="news_shortcontent" title="简短描述" name="news.shortcontent" cssStyle="width:80%" />
							</td>
						</tr>
						<tr>
							<td class="firstRow">其他信息:</td>
							<td class="secRow" colspan="3"><s:textfield id="news_new_source" title="其他信息" name="news.new_source" cssStyle="width:80%" /></td>
						</tr>
						<s:if test="null != news">
							<tr>
								<td class="firstRow">是否置顶:</td>
								<td class="secRow"><s:if test="0 == news.istop">否</s:if>
									<s:elseif test="1 == news.istop">是</s:elseif></td>
								<td class="firstRow">是否已审核:</td>
								<td class="secRow"><s:if test="0 == news.ischecked">否</s:if>
									<s:elseif test="1 == news.ischecked">是</s:elseif></td>
							</tr>
							<tr>
								<td class="firstRow">创建人:</td>
								<td class="secRow"><s:property value="news.add_user" /></td>
								<td class="firstRow">创建时间:</td>
								<td class="secRow"><s:date name="news.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
							<tr>
								<td class="firstRow">修改人:</td>
								<td class="secRow"><s:property value="news.lm_user" /></td>
								<td class="firstRow">修改时间:</td>
								<td class="secRow"><s:date name="news.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
							</tr>
						</s:if>
						<s:if test="null != news && 'mdy' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_SMDY')">
							<tr>
								<td class="firstRow" style="border-right-color: menu;">特殊操作:</td>
								<td class="secRow" colspan="3">
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
								</td>
							</tr>
							<tr>
								<td class="firstRow">信息置顶:</td>
								<td class="secRow"><s:url id="unTop" action="news_saveTop" namespace="/info">
										<s:param name="news.uuid" value="%{news.uuid}" />
										<s:param name="news.istop" value="0" />
									</s:url> <s:url id="toTop" action="news_saveTop" namespace="/info">
										<s:param name="news.uuid" value="%{news.uuid}" />
										<s:param name="news.istop" value="1" />
									</s:url> <s:url id="toAddLevel" action="news_saveAddLevel" namespace="/info">
										<s:param name="news.uuid" value="%{news.uuid}" />
									</s:url> <s:url id="toDownLevel" action="news_saveDownLevel" namespace="/info">
										<s:param name="news.uuid" value="%{news.uuid}" />
									</s:url> <s:if test="news.istop>=1">
										<span style="color: red;">已置顶(<s:property value="news.istop" />)
										</span>
				[<s:a href="%{unTop}">取消置顶</s:a>]
				[<s:a href="%{toAddLevel}">提升优先级</s:a>]
				[<s:a href="%{toDownLevel}">降低优先级</s:a>]
			</s:if> <s:else>				
				未置顶
				[<s:a href="%{toTop}">设置置顶</s:a>]
			</s:else></td>
								<td class="firstRow"></td>
								<td class="secRow"></td>
							</tr>
						</s:if>
						<tr>
							<td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span> <s:if
									test="null == news && 'add' == viewFlag  && @org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_ADD')">
									<s:submit id="saveadd" name="saveadd" value="暂存" action="news_saveadd" />
									<s:submit id="add" name="add" value="提交" action="news_add" />
									<input type="button" value="返回" onclick="linkurl('<s:url action="news_list" namespace="/info" />');" />
								</s:if> <s:elseif test="null != news && 'mdy' == viewFlag  && @org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDY')">
									<s:submit id="savetmp" name="savetmp" value="暂存" action="news_savetmp" />
									<s:submit id="save" name="save" value="保存并提交" action="news_save" />
									<s:url id="toRecycle" namespace="/info" action="news_saveDel">
										<s:param name="news.uuid" value="%{news.uuid}" />
										<s:param name="news.isdel" value="1" />
									</s:url>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDYDEL')">
										<input type="button" value="放入回收站" onclick="if(window.confirm('真的把记录放进回收站吗?'))location.href='<s:url value="%{toRecycle}" />';" />
									</s:if>
									<input type="button" value="返回" onclick="linkurl('<s:url action="news_list" namespace="/info" />');" />
								</s:elseif> <s:elseif test="null != news && 'view' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDYDEL')">
										<input type="button" value="还原"
											onclick="if(window.confirm('还原资源吗?'))location.href='<s:url namespace="/info" action="news_saveDel"><s:param name="news.isdel">0</s:param><s:param name="news.uuid" value="news.uuid" /></s:url>';" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_DEL')">
										<input type="button" value="删除"
											onclick="if(isDel())location.href='<s:url namespace="/info" action="news_del"><s:param name="news.uuid" value="news.uuid" /></s:url>';" />
									</s:if>
									<input type="button" value="返回" onclick="linkurl('<s:url action="news_listRecycle" namespace="/info" />');" />
								</s:elseif>
								</td>
						</tr>
					</table>
				</s:form>
			</div>
		</div>
	</div>
	<div id="selectInfoClass" style="display: none;">
		<div class="dtree2" style="overflow: scroll; height: 300px;">
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
		<div class="dtreebutton">
			<input type="button" value="确定" onclick="setCheckValue();" /> <input type="button" value="返回" onclick="closemDiv();" />
		</div>
	</div>
</body>
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_prototype.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/xheditor/xheditor-1.2.1.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/xheditor/xheditor_lang/zh-cn.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/create_editor.js" />"></script>
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