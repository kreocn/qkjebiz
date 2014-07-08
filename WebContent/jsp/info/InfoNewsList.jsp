<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
var md;
var ___select_infoclass_html_value;
window.onload = function() {
	___select_infoclass_html_value = $('#selectInfoClass').html();
	$('#selectInfoClass').empty();
	setStyle("table1");
};
function selectClass() {	
	md = new modelDiv();
	md.setTitle_HTML("");
	md.setBottom_HTML("");
	md.createModelDivByContent(220,300,___select_infoclass_html_value);	
}
function closemDiv() {
	md.dropModelDiv();
}
</script>
<body>
	<div id="main">
		<div id="result">
			<div class="itablemdy">
				<div class="itabletitle">信息列表</div>
				<div class="ilistsearch">
					<s:form name="form_serach" action="news_list" method="get" namespace="/info" theme="simple">
						<table class="ilisttable" id="serach_table" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
							<tr>
								<td class="firstRow">标题:</td>
								<td class="secRow"><s:textfield id="news.title" title="标题" name="news.title" /></td>
								<td class="firstRow">类别:</td>
								<td class="secRow"><s:hidden id="news.class_id" title="信息类别" name="news.class_id" /> <s:textfield id="news.class_name" title="信息类别"
										name="news.class_name" readonly="true" /> <img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectClass();" /></td>
							</tr>
							<tr>
								<td class="firstRow">状态:</td>
								<td class="secRow"><s:select id="news.ischecked" title="状态" name="news.ischecked" headerKey="" headerValue="-请选择-"
										list="#{-1:'未提交',0:'待初审',1:'初审退回',2:'初审通过',3:'终审退回',4:'终审通过'}" /></td>
								<td class="firstRow"></td>
								<td class="secRow"></td>
							</tr>
							<tr>
								<td colspan="4" class="buttonarea"><s:submit value="查询" /> <s:reset value="重置" /></td>
							</tr>
						</table>
					</s:form>
				</div>
				<s:form name="form1" theme="simple">
					<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
						<tr>
							<th width="12">&nbsp;</th>
							<th width="140">编号</th>
							<th width="120">类别</th>
							<th>标题</th>
							<th width="100" style="">发布人</th>
							<th width="160">发布时间</th>
							<th width="80">置顶</th>
							<th width="80">状态</th>
						</tr>
						<s:iterator value="newsx" status="sta">
							<tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" onclick="pickrow(this);">
								<td><input name="uuid" type="checkbox" value="<s:property value="uuid" />" onclick="this.checked=!this.checked;" /></td>
								<td align="center"><s:property value="uuid" /></td>
								<td align="center"><s:property value="class_name" /></td>
								<td>
								<a href="<s:url namespace="/info" action="news_view"><s:param name="viewFlag">view</s:param><s:param name="news.uuid" value="uuid" /></s:url>" target="_blank">
								<s:property value="title" />
								</a>
								</td>
								<td align="center"><s:property value="add_user_name" /></td>
								<td align="center"><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
								<td align="center"><s:if test="istop==0">未置顶</s:if> <s:elseif test="istop>0">
										<span style="color: red;">已置顶(<s:property value="istop" />)
										</span>
									</s:elseif></td>
								<td align="center"><s:if test="ischecked==0">
										<span style="color: red;">待初审</span>
									</s:if> <s:elseif test="ischecked==-1">未提交</s:elseif> <s:elseif test="ischecked==1">
										<span style="color: yellow;">初审退回</span>
									</s:elseif> <s:elseif test="ischecked==2">
										<span style="color: green;">初审通过</span>
									</s:elseif> <s:elseif test="ischecked==3">
										<span style="color: orange;">终审退回</span>
									</s:elseif> <s:elseif test="ischecked==4">
										<span style="color: gray;">终审通过</span>
									</s:elseif> <s:else>
										<span style="color: red; font-weight: bold;">状态异常,请通知管理员</span>
									</s:else></td>
							</tr>
						</s:iterator>
						<tr>
							<td colspan="20" class="buttonarea"><script type="text/javascript">
var spage = new ShowPage();
spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
</script></td>
						</tr>
			<tr>
				<td colspan="20" class="buttonarea"><span id="message"><s:property value="message" /></span> 
				<input type="button" value="全选" onclick="checkAllInTable('table1');" />
				<input type="button" value="反选" onclick="oppositeAllInTable('table1');" /> 
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_ADD')">
					<input type="button" value="新增" onclick="location.href='<s:url value="/info/news_load?viewFlag=add" />';" />
				</s:if>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDY')">
					<input type="button" value="修改" onclick="return forward('<s:url value="/info/news_load?viewFlag=mdy" />','uuid','news.uuid',false);" />
				</s:if>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_MDYDEL')">
					<input type="button" value="放入回收站" onclick="return window.confirm('真的把记录放进回收站吗?') && forward('<s:url value="/info/news_saveDel?news.isdel=1" />','uuid','news.uuid',false);" />
				</s:if>
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
</html>