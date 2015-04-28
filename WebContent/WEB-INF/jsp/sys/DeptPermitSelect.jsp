<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户权限列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript">
var objname = '<%=request.getParameter("objname")%>';
var parentobj;
$(function(){
	eval("parentobj = window.parent." + objname);
});

function setCheckValue() {
	var deptInfo = getCheckBox("cd");
	parentobj.selfAction(deptInfo[1],deptInfo[2]);
	closeDialog();
}

function setNullValue() {
	parentobj.selfAction(null,null);
	closeDialog();
}

function closeDialog() {
	parentobj.close();
}
</script>
<style type="text/css">
.dtree2 {
border: none !important;
}
</style>
<body bgcolor="#FEFEFE">
	<div class="dtree2" style="overflow: auto; height: 100%;">
		<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
		<script type="text/javascript">
			d = new dTree('d');
			d.config.check = 2;
			d.config.useIcons = false;
			d.config.isAddNoRootNode = true;
			d.icon = {
				root : '<s:url value="/include/dtree/" />' + 'img/globe.gif',
				folder : '<s:url value="/include/dtree/" />' + 'img/folder.gif',
				folderOpen : '<s:url value="/include/dtree/" />' + 'img/folderopen.gif',
				node : '<s:url value="/include/dtree/" />' + 'img/page.gif',
				empty : '<s:url value="/include/dtree/" />' + 'img/empty.gif',
				line : '<s:url value="/include/dtree/" />' + 'img/line.gif',
				join : '<s:url value="/include/dtree/" />' + 'img/join.gif',
				joinBottom : '<s:url value="/include/dtree/" />' + 'img/joinbottom.gif',
				plus : '<s:url value="/include/dtree/" />' + 'img/plus.gif',
				plusBottom : '<s:url value="/include/dtree/" />' + 'img/plusbottom.gif',
				minus : '<s:url value="/include/dtree/" />' + 'img/minus.gif',
				minusBottom : '<s:url value="/include/dtree/" />' + 'img/minusbottom.gif',
				nlPlus : '<s:url value="/include/dtree/" />' + 'img/nolines_plus.gif',
				nlMinus : '<s:url value="/include/dtree/" />' + 'img/nolines_minus.gif'
			};
			d.add('0', '-1', '部门列表');
			//<s:iterator value="depts">
			d.add('<s:property value="dept_code" />', '<s:property value="parent_dept" />',
					'<s:property value="dept_cname" />', "javascript:void(0);", '<s:property value="dept_cname" />');
			//</s:iterator>
			d.add();
			document.write(d);
		</script>
	</div>
	<div style="text-align: center;">
		<input type="button" value="确定" onclick="setCheckValue();" /> <input type="button" value="返回" onclick="closeDialog();" />
		<input type="button" value="清空" onclick="setNullValue();" />
	</div>
</body>
</html>
