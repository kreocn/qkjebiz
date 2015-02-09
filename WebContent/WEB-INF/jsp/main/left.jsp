<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<style type="text/css">
.jqm-demos .jqm-list .ui-icon-carat-u {background-color:  #EEE !important;}
.jqm-demos .jqm-list .ui-listview {background-color:  #FBFBFB !important;}
</style>
<div data-role='page' class='jqm-demos' data-quicklinks='true'>
	<a href='#' class='jqm-navmenu-link ui-btn ui-btn-icon-notext ui-corner-all ui-icon-bars ui-nodisc-icon ui-alt-icon ui-btn-left'>Menu</a>
	<div data-role='panel' class='jqm-navmenu-panel' data-position='left' data-display='overlay' data-theme='a'>
		<ul id='menuinit' class='jqm-list ui-alt-icon ui-nodisc-icon'></ul>
	</div>
</div>
<script type="text/javascript" src="<c:url value="/js/HttpCookie.min.js" />"></script>
 <script type="text/javascript">
var menuArray = new Array();
var rootArray = new Array();
var menuIndex = 0;
var rootIndex = 0;
//<s:iterator value="menus">
menuArray[menuIndex++] = eval("(" + '{uuid:"${uuid}",id:"${privilege_id}",p_id:"${parent_privilege}",name:"${privilege_name}",link:"${menu_url}",target:"${menu_target}",title:"${menu_title}",module:"${module}"}' + ")"); //</s:iterator>
var _m = $("#menuinit");
var _m_str = '';
//_m_str += '<li data-filtertext="demos homepage" data-icon="home"><a href="#">首页</a></li>';
//开始循环
for (var i = 0; i < menuArray.length; i++) {
	//var rootFlag = true;
	//找出一级菜单
	if(menuArray[i].p_id=='0') {
		_m_str+='<li id="M'+menuArray[i]['uuid']+'" data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="prvg-module prvg-module-'+menuArray[i]['module']+' ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed"><h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="javascript:;" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">'+menuArray[i]['name']+'</a></h3>';
		//找出二级菜单 remove ui-collapsible-content-collapsed
		_m_str+='<div class="ui-collapsible-content ui-body-inherit ui-collapsible-content-collapsed" aria-hidden="true">';
		_m_str += "<ul>";
		for (var j = 0; j < menuArray.length; j++) {
			if(menuArray[i]['id']==menuArray[j]['p_id']) {
				_m_str+='<li><a href="#" onClick="mLink(\''+menuArray[j]['link']+'\')" data-ajax="false">'+menuArray[j]['name']+'</a></li>';
			}
		}
		_m_str+="</ul>";
		_m_str+='</div>';
		_m_str+="</li>";
	}
}
_m.append(_m_str);
var mCo = new HttpCookie("mco");
mCo.setExpires(7200);
mCo.save();
$(".prvg-module").mouseup(function(){
	var tid = $(this).attr("id");
	if($(this).hasClass("ui-collapsible-collapsed")){//true 是关闭 -> 打开状态
		if (!mCo.isExisted() || (mCo.isExisted() && (mCo.values.get("i")==null || mCo.values.get("i").indexOf(tid)==-1))) {
			mCo.values.add("i", tid);
		} 
	} else {//false 是打开 -> 关闭状态
		if(mCo.isExisted()) {
			var tids = mCo.values.getValues("i");
			//alert(tids.length);
			for ( var i = 0, n = tids.length; i < n; i++) {
				if(tid == tids[i]) {
					tids.splice(i,1);
					break;
				}
			}
		}
	}
	mCo.save();
});
//一级菜单show/hide事件 flag=ture->展开 false->收缩
var MenuCollapsed = function(id,flag) {
	if(flag) {
		$("#"+id).removeClass('ui-collapsible-collapsed');
		$("#"+id+" .ui-collapsible-heading").removeClass('ui-collapsible-heading-collapsed');
		$("#"+id+" .ui-collapsible-heading-toggle").removeClass('ui-icon-carat-d').addClass('ui-icon-carat-u');
		$("#"+id+" .ui-collapsible-content").removeClass('ui-collapsible-content-collapsed');
	} else {
		$("#"+id).addClass('ui-collapsible-collapsed');
		$("#"+id+" .ui-collapsible-heading").addClass('ui-collapsible-heading-collapsed');
		$("#"+id+" .ui-collapsible-heading-toggle").removeClass('ui-icon-carat-u').addClass('ui-icon-carat-d');
		$("#"+id+" .ui-collapsible-content").addClass('ui-collapsible-content-collapsed');
	}
};

if(mCo.isExisted()) {
	//var tidxs = mCo.values.getValues("i");
	for(var i = 0,tidxs = mCo.values.getValues("i"), n = tidxs.length; i < n; i++)	{
		if(tidxs[i]!='')
			MenuCollapsed(tidxs[i],true);
	}
}

function enumCookieValues(coo) {
	var keys = coo.values.allKeys();
	for ( var i = 0, j = keys.length; i < j; i++) {
		alert("key=" + keys[i] + "; value=" + coo.values.get(keys[i]));
	}
}

function JsonToString(o){
	var arr = [];
	var fmt = function(s){
		if (typeof s == 'object' && s != null) return JsonToStr(s);
		return /^(string|number)$/.test(typeof s) ? "'" + s + "'" : s;
	};
	for ( var i in o)
		arr.push("'" + i + "':" + fmt(o[i]));
	return '{' + arr.join(',') + '}';
}

function mLink(url){
	if("javascript"==url.substr(0,10)) {
		return false;
	}	else {
		//alert('<c:url value="/" />' + url);
		location.href = '<c:url value="/" />' + url;
	}
}
</script>