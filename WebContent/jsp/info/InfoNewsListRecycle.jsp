<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>回收站资源列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
</head>
<body>
<div class="main" >
	<div class="dq_step"><a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;回收站资源列表</div>
	<s:form id="serachForm" name="serachForm" action="news_listRecycle"  method="get" namespace="/info" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">标题:</div>
				       <div class="label_rwbenx"><s:textfield id="news.title" title="标题" name="news.title" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">类别:</div>
				       <div class="label_rwbenx">
				       		<s:hidden id="news.class_id" title="信息类别" name="news.class_id" />
				       		<s:textfield id="news.class_name" title="信息类别" name="news.class_name" readonly="true" /><img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectClass();" />
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
	<div class="tab_warp">
	 		<table id="table1">
	 			<tr id="coltr">
	              <th  class="td1">&nbsp;</th>
	              <th  class="td1">类别</th>
	              <th  class="td2" width="50%">标题</th>
	              <th  class="td3">发布人</th>
	              <th  class="td3">发布时间</th>
	              <th  class="td4">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="newsx" status="sta">
	            	<tr id="showtr${uuid}">
	            		  <td  class="td1"><input name="uuid" type="checkbox" value="${uuid}" /></td>
			              <td  class="td1">${class_name}</td>
			              <td  class="td2">${title}</td>
			              <td  class="td3">${add_user_name}</td>
			              <td  class="td3"><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
			              <td  class="td4">
			              		<s:url id="viewNews" namespace="/info" action="news_load">
									<s:param name="viewFlag">view</s:param>
								</s:url>
								<s:url id="toNormal" namespace="/info" action="news_saveUnDel">
									<s:param name="news.isdel" value="0" />
								</s:url>
								<input type="button" class="input-blue"  value="查看" onclick="return forward('<s:property value="%{viewNews}" />','uuid','news.uuid',false);" />
								<input type="button" class="input-green"  value="还原" onclick="return window.confirm('还原资源吗?') && forward('<s:property value="%{toNormal}" />','uuid','news.uuid',false);" />
								<input type="button" class="input-red"  value="删除" onclick="return isDel() && forward('<s:url namespace="/info" action="news_del" />','uuid','news.uuid',false);" />
			              </td>
			              <td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	            	</tr>
	            </s:iterator>
	       </table>
	       <div class="pagination">
			<script type="text/javascript">
				var spage = new ShowPage(${currPage});
				spage.show2(${recCount},${pageSize},2);
			</script>
			</div>
			<span id="message"><s:property value="message" /></span>
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
<script type="text/javascript">
var md;
var ___select_infoclass_html_value;
window.onload = function() {
	___select_infoclass_html_value = $('#selectInfoClass').html();
	$('#selectInfoClass').empty();
	setStyle("table1");
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
</script>
</body>
</html>