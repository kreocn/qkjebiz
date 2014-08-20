<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript">
function slink(url,target) {
	//alert(window.top.frames.length);
	//url = urlAddParam(url,'<s:property value="%{@org.iweb.sys.Parameters@left_menu_refresh}" />',getCurrentTimeMillis());
	window.top.frames[target].location=url;
}
</script>
<body style="background-color: #F0F0F0">
<div id="dtree3" class="dtree3" style="width:100%; overflow: auto; height: 100%; position: absolute; left: 0; top: 0;">
<div class="ctrl"><a href="javascript: d.openAll();">全部展开</a>&nbsp;&nbsp;&nbsp;<a href="javascript: d.closeAll();">全部收缩</a>
</div>
<script type="text/javascript">
	d = new dTree('d');
	d.config.useLines = false;
	d.config.useIcons = false;
	d.config.isMenu = true;	
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
			nlPlus		: '<s:url value="/include/dtree/" />'+'img/nolines_plus3.png',
			nlMinus		: '<s:url value="/include/dtree/" />'+'img/nolines_minus3.png'
	};
	
	d.add(0,-1,'Menu');
	
	<s:iterator value="menus">	
	d.add('<s:property value="privilege_id" />','<s:property value="parent_privilege" />','<s:property value="privilege_name" />',"javascript:slink('<s:url value='/%{menu_url}' />','<s:property value='menu_target' />');",'<s:property value="menu_title" />');
	</s:iterator>
	//d.add('<s:property value="privilege_id" />','<s:property value="parent_privilege" />','<s:property value="privilege_name" />',"javascript:slink('<s:url value='/%{menu_url}' />','<s:property value='menu_target' />');",'<s:property value="menu_title" />');
	//d.add('1','0','系统管理X','javascript:void(0);');
	//d.add('2','1','权限管理',"javascript:slink('<s:url value='/%{menu_url}' />','mainFrame');",'权限管理');
	//d.add('3','1','角色管理','<s:url action="role_list" namespace="/sys" />','角色管理','mainFrame');
	//d.add('4','1','部门管理','<s:url action="dept_list" namespace="/sys" />','部门管理','mainFrame');
	//d.add('5','1','人员管理','<s:url action="user_list" namespace="/sys" />','人员管理','mainFrame');
	document.write(d);		
</script>
</div>
<div id="message"></div>
</body>
</html>