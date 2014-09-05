<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!--left菜单-->
<div data-role="page" class="jqm-demos" data-quicklinks="true">
	<a href="#" class="jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left">Menu</a>
	<div data-role="panel" class="jqm-navmenu-panel" data-position="left" data-display="overlay" data-theme="a">
		<ul id="menuinit" class="jqm-list ui-alt-icon ui-nodisc-icon">
			<!-- 
            <li data-filtertext="demos homepage" data-icon="home"><a href="#">首页</a></li>          
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">业务管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="" data-ajax="false">提货申请单</a></li>
                        <li><a href="" data-ajax="false">返利申请单</a></li>
                        <li><a href="" data-ajax="false">活动管理</a></li>
                        <li><a href="" data-ajax="false">至事由管理</a></li>
                        <li><a href="" data-ajax="false">工业旅游管理</a></li>
                        <li><a href="" data-ajax="false">潜在客户管理</a></li>
                        <li><a href="" data-ajax="false">回访记录查询</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">行政管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">工时管理</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">新闻管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">新闻列表</a></li>
                        <li><a href="#" data-ajax="false">新闻初审</a></li>
                        <li><a href="#" data-ajax="false">信息终审</a></li>
                        <li><a href="#" data-ajax="false">新闻回收站</a></li>
                        <li><a href="#" data-ajax="false">新闻类别</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">会员管理</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">添加会员</a></li>
                        <li><a href="#" data-ajax="false">会员列表</a></li>
                        <li><a href="#" data-ajax="false">会员移交</a></li>
                        <li><a href="#" data-ajax="false">会员预付款</a></li>
                        <li><a href="#" data-ajax="false">积分消费记录(返利)</a></li>
                    </ul>
				</div>
			</li>
            <li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed">
				<h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="http://www.163.com/" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">基本设置</a></h3>
				<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">
                    <ul>
                        <li><a href="#" data-ajax="false">我的资料</a></li>
                        <li><a href="#" data-ajax="false">服务器文件</a></li>
                    </ul>
				</div>
			</li>
			-->
		</ul>
	</div>
</div>
 <script type="text/javascript">
var menuArray = new Array();
var menuIndex = 0;
//<s:iterator value="menus">
menuArray[menuIndex++] = eval("(" + '{id:"${privilege_id}",p_id:"${parent_privilege}",name:"${privilege_name}",link:"${menu_url}",target:"${menu_target}",title:"${menu_title}"}' + ")"); //</s:iterator>

var _m = $("#menuinit");
_m.append('<li data-filtertext="demos homepage" data-icon="home"><a href="#">首页</a></li>');
//开始循环
//第一次循环,找出顶级元素
for (var i = 0; i < menuArray.length; i++) {
	//var rootFlag = true;//是否是根菜单
	if(menuArray[i].p_id=='0') {
		menuArray[i]['rootFlag'] = true;
		menuArray[i]['hpFlag'] = false;
		_m.append('<li data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed"><h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="#" onClick="mLink(\''+menuArray[i]['link']+'\')" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">'+menuArray[i]['name']+'</a></h3></div></li>');
	}  else {
		menuArray[i]['rootFlag'] = false;
		var hpFlag = false; 
		for (var j = 0; j < menuArray.length; j++) {
			if (menuArray[i].p_id == menuArray[j].id) { //有父元素
				//alert(menuArray[i].id);
				hpFlag = true;
				break;
			}
		}
		menuArray[i]['hpFlag'] = hpFlag;	//是否有父级菜单
	}
}
for (var i = 0; i <= 10; i++) {
	//alert(JsonToString(menuArray[i]));
}
function JsonToString(o){
	var arr = [];
	var fmt = function(s){
		if (typeof s == 'object' && s != null) return JsonToStr(s);
		return /^(string|number)$/.test(typeof s) ? "'" + s + "'" : s;
	}
	for ( var i in o)
		arr.push("'" + i + "':" + fmt(o[i]));
	return '{' + arr.join(',') + '}';
}
function mLink(url){
	if("javascript"==url.substr(0,10)) {
		return false;
	}	else {
		alert("/" + url);
	}
}
	</script>