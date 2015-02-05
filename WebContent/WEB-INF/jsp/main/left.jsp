<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<style type="text/css">
.ui-icon-carat-u {border-color: red !important;}
</style>
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
<script type="text/javascript" src="<c:url value="/js/HttpCookie.min.js" />"></script>
 <script type="text/javascript">
var menuArray = new Array();
var rootArray = new Array();
var menuIndex = 0;
var rootIndex = 0;
//<s:iterator value="menus">
menuArray[menuIndex++] = eval("(" + '{uuid:"${uuid}",id:"${privilege_id}",p_id:"${parent_privilege}",name:"${privilege_name}",link:"${menu_url}",target:"${menu_target}",title:"${menu_title}"}' + ")"); //</s:iterator>
var _m = $("#menuinit");
var _m_str = '<li data-filtertext="demos homepage" data-icon="home"><a href="#">首页</a></li>';
//开始循环
for (var i = 0; i < menuArray.length; i++) {
	//var rootFlag = true;
	//找出一级菜单
	if(menuArray[i].p_id=='0') {
		_m_str+='<li id="M'+menuArray[i]['uuid']+'" data-role="collapsible" data-enhanced="true" data-collapsed-icon="carat-d" data-expanded-icon="carat-u" data-iconpos="right" data-inset="false" class="collapsible-status ui-collapsible ui-collapsible-themed-content ui-collapsible-collapsed"><h3 class="ui-collapsible-heading ui-collapsible-heading-collapsed"><a href="javascript:;" class="ui-collapsible-heading-toggle ui-btn ui-btn-icon-right ui-btn-inherit ui-icon-carat-d">'+menuArray[i]['name']+'</a></h3>';
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
$(".collapsible-status").mouseup(function(){
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
		alert("/" + url);
	}
}
</script>