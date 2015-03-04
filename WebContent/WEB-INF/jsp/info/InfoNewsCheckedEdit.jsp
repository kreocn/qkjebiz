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
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div id="result">
			<div class="itablemdy">
				<div class="itabletitle">审核信息</div>
				<s:form name="form1" action="news_save" namespace="/info" onsubmit="return validator(this);" method="post" theme="simple">
					<div class="ifromoperate"></div>
					<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
						<tr>
							<td class="firstRow">信息类别:</td>
							<td colspan="3" class="secRow"><s:hidden name="news.class_id" />
								<s:hidden name="news.uuid" /> <s:property value="news.class_name" /></td>
						</tr>
						<tr>
							<td class="firstRow">标题:</td>
							<td class="secRow" colspan="3"><s:property value="news.title" /></td>
						</tr>
						<tr>
							<td class="firstRow">跳转链接:</td>
							<td class="secRow" colspan="3"><s:property value="news.redirect_url" /></td>
						</tr>
						<tr>
							<td class="firstRow">是否为图片信息:</td>
							<td class="secRow" colspan="3"><s:radio title="是否为图片信息" onclick="showImgInput(this);" name="news.isimgnews" list="#{0:'否',1:'是'}"></s:radio>
							</td>
						</tr>
						<tr id="checkimgnews" <s:if test="null == news || null == news.isimgnews || 0 == news.isimgnews">style="display: none;"</s:if>>
							<td class="firstRow">小图链接:</td>
							<td class="secRow"><s:property value="news.smallimg" /></td>
							<td class="firstRow">大图链接:</td>
							<td class="secRow"><s:property value="news.bigimg" /></td>
						</tr>
						<tr>
							<td class="firstRow" style="border-right-color: menu;">信息内容:</td>
							<td class="firstRow" colspan="3"></td>
						</tr>
						<tr>
							<td class="secRow" colspan="4"><s:property value="news.content" escape="false" /></td>
						</tr>
						<tr>
							<td class="firstRow">关键字(多个用,隔开):</td>
							<td class="secRow" colspan="3"><s:property value="news.keywords" /></td>
						</tr>
						<tr>
							<td class="firstRow">简短描述:</td>
							<td class="secRow" colspan="3"><s:property value="news.shortcontent" /></td>
						</tr>
						<tr>
							<td class="firstRow">信息来源:</td>
							<td class="secRow"><s:property value="news.new_source" /></td>
							<td class="firstRow">是否置顶:</td>
							<td class="secRow"><s:if test="0 == news.istop">否</s:if>
								<s:elseif test="1 == news.istop">是</s:elseif></td>
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
						<tr>
							<td class="firstRow" style="border-right-color: menu;">审核信息:<s:hidden name="news.ischecked" /></td>
							<td class="firstRow" style="border-right-color: menu;"></td>
							<td class="firstRow" style="border-right-color: menu;">当前状态: <s:if test="news.ischecked==0">
									<span style="color: red; font-weight: bold;">待初审</span>
								</s:if> <s:elseif test="news.ischecked==1">
									<span style="color: yellow;">初审退回</span>
								</s:elseif> <s:elseif test="news.ischecked==2">
									<span style="color: green;">初审通过</span>
								</s:elseif> <s:elseif test="news.ischecked==3">
									<span style="color: orange;">终审退回</span>
								</s:elseif> <s:elseif test="news.ischecked==4">
									<span style="color: gray;">终审通过</span>
								</s:elseif> <s:else>
									<span style="color: red; font-weight: bold;">状态异常,请通知管理员</span>
								</s:else>
							</td>
							<td class="firstRow"></td>
						</tr>
						<s:if test="news.ischecked==0 || news.ischecked==1">
							<tr>
								<td class="firstRow">初审意见:</td>
								<td class="secRow"><s:textarea title="信息内容" name="news.first_check_note" cssStyle="width: 80%;" /></td>
								<td class="firstRow">操作:</td>
								<td class="secRow"><s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FIRSTPASS')">
										<s:submit id="firstpass" name="firstpass" value="初审通过" action="news_saveFirstPass" />
									</s:if> <s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FIRSTFAIL')">
										<s:submit id="firstfail" name="firstfail" value="初审退回" action="news_saveFirstFail" />
									</s:if></td>
							</tr>
						</s:if>
						<s:if test="news.ischecked>1">
							<tr>
								<td class="firstRow">初审意见:</td>
								<td class="secRow" colspan="3"><s:property value="news.first_check_note" /></td>
							</tr>
						</s:if>
						<s:if test="news.ischecked>1 && news.ischecked<4">
							<tr>
								<td class="firstRow">终审意见:</td>
								<td class="secRow"><s:textarea title="终审意见" name="news.final_check_note" cssStyle="width: 80%;" /></td>
								<td class="firstRow">操作:</td>
								<td class="secRow"><s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FINALPASS')">
										<s:submit id="firstpass" name="firstpass" value="终审通过" action="news_saveFinalPass" />
									</s:if> <s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FINALFAIL')">
										<s:submit id="firstfail" name="firstfail" value="终审退回" action="news_saveFinalFail" />
									</s:if></td>
							</tr>
						</s:if>
						<s:if test="news.ischecked==4">
							<tr>
								<td class="firstRow">终审意见:</td>
								<td class="secRow" colspan="3"><s:property value="news.final_check_note" /></td>
							</tr>
						</s:if>
						<tr>
							<td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span> <s:if
									test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FIRSTPASS')">
									<input type="button" value="返回" onclick="linkurl('<s:url action="news_firstCheckedList" namespace="/info" />');" />
								</s:if> <s:elseif test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FINALPASS')">
									<input type="button" value="返回" onclick="linkurl('<s:url action="news_finalCheckedList" namespace="/info" />');" />
								</s:elseif></td>
						</tr>
					</table>
				</s:form>
			</div>
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
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/fckeditor/fckeditor.js" />"></script>
<script type="text/javascript">
var md;
var ___select_infoclass_html_value;

window.onload = function() {	
	___select_infoclass_html_value = $('#selectInfoClass').html();
	$('#selectInfoClass').empty();
	var oFCKeditor = new FCKeditor('news.content') ;
	oFCKeditor.BasePath	= '<s:url value="/include/fckeditor/" />';
	oFCKeditor.Height='300px';
	oFCKeditor.ReplaceTextarea();
}
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
</body>
</html>