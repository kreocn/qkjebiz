<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><s:text name="APP_NAME" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
<link rel="stylesheet" href="<s:url value="/css/v0.1/style.css" />" />
<link rel="stylesheet" href="<s:url value="/css/animate.css" />" />
<script type="text/javascript" src="<s:url value="/js/v0.1/jquery-1.9.0.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/v0.1/jquery-migrate-1.2.1.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/v0.1/common.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<link rel="stylesheet" href="<s:url value="/css/v0.2/layout-default-1.4.4.css" />" />
<script type="text/javascript" src="<s:url value="/js/v0.2/jquery.layout-1.4.4.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/singlejs/imain.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<!--[if lt IE 9]>
<script type="text/javascript" src="<s:url value="/js/v0.1/html5shiv.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/v0.1/PIE/PIE.js" />"></script>
<script type="text/javascript">
$(function() {
    if (window.PIE) {
        $("*").each(function() {
            PIE.attach(this);
        });
    }
});
</script>
<![endif]-->
<style type="text/css">
.ui-layout-south {overflow: hidden;}
.ui-layout-north {overflow: hidden;}
.layout_iframe{width: 100%;height:100%;overflow:auto;border: none;background: transparent;}
.ui-layout-pane-west {display: block !important;}
.ui-layout-center{overflow: auto;-webkit-overflow-scrolling: touch;overflow-y: scroll;}
.ui-layout-center .layout_iframe{width: 100%;height:100%;overflow:auto;border: none;background: transparent;}

@media screen and (max-width:960px) {
.ui-layout-pane-west {display: none !important;}
.ui-layout-pane-show{display: block !important;}
.ui-layout-pane-center{width: 100% !important; left:0 !important;}
}
</style>
</head>
<body>
<div class="ui-layout-center">
	<iframe id="mainFrame" name="mainFrame" src="about:blank" longdesc="default" class="layout_iframe" frameborder="0" scrolling="auto"></iframe>
</div>
<div class="ui-layout-south">
	<div id="bottom" class="bottom_style">
		当前登录信息:
			<s:property value="@org.iweb.sys.ContextHelper@getUserLoginDeptName()" />
			<s:property value="@org.iweb.sys.ContextHelper@getUserLoginName()" />
	</div>
	<!-- <iframe id="bottomFrame" name="bottomFrame" src="about:blank" longdesc="bottom" class="layout_iframe" frameborder="0" scrolling="no"></iframe> -->
</div>
<div  id="dtree3" class="ui-layout-west dtree3" style="overflow: auto;">
	<!-- <iframe id="leftFrame" name="leftFrame" src="about:blank" longdesc="menu" class="layout_iframe" frameborder="0" scrolling="auto"></iframe> -->
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
		function slink(url,target) {
			//alert(window.top.frames.length);
			//url = urlAddParam(url,'<s:property value="%{@org.iweb.sys.Parameters@left_menu_refresh}" />',getCurrentTimeMillis());
			window.frames[target].location=url;
		}
</script>
</div>
<div class="ui-layout-north">
	<div class="ht_top">
	<div class="ht_lTit">互助青稞酒商务管理中心</div>
	<ul class="ht_rczuo">
		<li><a title="首页" href="<s:url value="default" />" target="mainFrame"><img src="<s:url value="/images" />/top//ht_tb1.gif" /></a></li>
		<!-- <li><a title="切换账户" href="<s:url action="/login" />"  target="_top"><img src="<s:url value="/images" />/top/ht_tb2.gif" /></a></li> -->
		<li><a title="帮助信息" href="http://d.qkjchina.com/qkjzn/index.html?v=0.01"  target="mainFrame"><img src="<s:url value="/images" />/top/ht_tb3.gif" /></a></li>
		<!-- <li><a title="我的信息" href="<s:url value="/sys/iuser_load" />"  target="mainFrame"><img src="<s:url value="/images" />/top/ht_tb4.gif" /></a></li> -->
		<li><a title="刷新主页" href="javascript:;" onclick="window.frames['mainFrame'].location.reload();"><img src="<s:url value="/images" />/top/ht_tb5.gif" /></a></li>
		<li><a title="退出系统" href="<s:url action="login_out" namespace="/manager" />"  target="_top"><img src="<s:url value="/images" />/top/ht_tb6.gif" /></a></li>
	</ul>
	<div style="clear: both;"></div>
	</div>
	<!-- <iframe id="topFrame" name="topFrame" src="about:blank" longdesc="top" class="layout_iframe" frameborder="0" scrolling="no"></iframe> -->
</div>
<div class="ui-layout-east"></div>
<a class="ht_lMenu" id="lMenuToggle">Menu</a>
</body>
</html>