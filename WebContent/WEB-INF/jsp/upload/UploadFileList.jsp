<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">文件列表</div>	
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	<colGroup width="12"></colGroup>
	  <tr>
	    <th>&nbsp;</th>
	    <th>文件分类</th>
		<th>文件名称</th>
		<th>文件类型</th>
		<th>文件大小</th>
		<th>上传时间</th>
	  </tr>
<s:iterator value="files" status="sta">
<s:url id="fileurl" namespace="/upload" action="download">
	<s:param name="file.uuid" value="uuid" />
</s:url>
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" onclick="pickrow(this);">
	    <td><input name="uuid" type="checkbox" value="<s:property value="uuid" />" onclick="this.checked=!this.checked;" /></td>
	    <td><s:a href="%{fileurl}"><s:property value="class_name" /></s:a></td>
	    <td><s:property value="title" /></td>
		<td><s:property value="file_type" /></td>
		<td><s:property value="file_size" /></td>
	    <td><s:date name="lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="6" class="buttonarea">
<script type="text/javascript">
var spage = new ShowPage();
spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
</script>
		</td>	    
	  </tr>
	  <tr>
	    <td colspan="6" class="buttonarea">
	    <span id="message"><s:property value="message" /></span>
		<input type="button" value="全选" onclick="checkAllInTable('table1');" />
		<input type="button" value="反选" onclick="oppositeAllInTable('table1');" />
		<input type="button" value="新增" onclick="location.href='<s:url action="file_load" namespace="/upload"><s:param name="viewFlag">add</s:param></s:url>';" />
		<input type="button" value="修改" onclick="return forward('<s:url action="file_load" namespace="/upload"><s:param name="viewFlag">mdy</s:param></s:url>','uuid','file.uuid',false);" />
		<input type="button" value="删除" onclick="return isDel() && forward('<s:url action="file_del" namespace="/upload" />','uuid','file.uuid',false);" />
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>