<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!--top顶部-->
<header>
<div class="ht_top">
	<a href="javascript:;" class="ht_lmenu"><img src="<c:url value="/images/icon/ht_icon.png" />" width="45" /></a>
	<div class="ht_lTit">互助青稞酒商务管理中心</div>
    <div class="ht_rset">
        <a href="javascript:void(0);" class="ht_clicka"><img src="<c:url value="/images/top/ht_tb7.png" />" width="45" /></a>
        <ul class="ht_sjsub">
            <li><a href="<c:url value="/manager/default" />" title="系统首页">系统首页</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="所有功能" onclick="module_toggle(99)">所有功能</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="帮助信息" onclick="module_toggle(0)">业务系统</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="信息系统" onclick="module_toggle(1)">信息系统</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="报表系统" onclick="module_toggle(2)">报表系统</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="基础数据" onclick="module_toggle(3)">基础数据</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="系统设置" onclick="module_toggle(4)">系统设置</a></li><li class="r_line">|</li>
            <li><a href="<c:url value="/manager/help" />" title="帮助信息">帮助信息</a></li><li class="r_line">|</li>
            <li><a href="<s:url action="login_out" namespace="/manager" />" title="退出系统">退出系统</a></li>
        </ul>
    </div>
</div>
</header>
<!--left菜单-->
<div id="ht_left_menu" class="ht_left"></div>
<footer><p class="botmsg">当前登录信息：${dept_name}&nbsp;&nbsp;${user_name}</p></footer>