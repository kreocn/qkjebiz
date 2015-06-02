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
        <ul class="ht_sjsub  subHide">
            <li><a href="<c:url value="/manager/default" />" title="系统首页">系统首页</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="所有功能" onclick="module_toggle(99)">所有功能</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="帮助信息" onclick="module_toggle(0)">业务系统</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="信息系统" onclick="module_toggle(1)">信息系统</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="报表系统" onclick="module_toggle(2)">报表系统</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="基础数据" onclick="module_toggle(3)">基础数据</a></li><li class="r_line">|</li>
            <li><a href="javascript:;" title="系统设置" onclick="module_toggle(4)">系统设置</a></li><li class="r_line">|</li>
            <li><a href="<c:url value="http://d.qkjchina.com/qkjzn/" />" title="帮助信息" target="_blank">帮助信息</a></li><li class="r_line">|</li>
            <li><a href="<s:url action="login_out" namespace="/manager" />" title="退出系统">退出系统</a></li>
        </ul>
    </div>
</div>
</header>
<!--left菜单-->
<div id="ht_left_menu" class="ht_left subHide"></div>
<footer><p class="botmsg">当前登录信息：${dept_name}&nbsp;&nbsp;${user_name}&nbsp;&nbsp;<a href="javascript:;" onclick="openUserDept();" style="color: #fff;">当前部门</a></p></footer>


<script type="text/javascript">
$(function(){
	createUserDept();
 });


var sobj02Dep;
var createUserDept = function() {
	//http://localhost:8888/qkjmanage/customer_load?viewFlag=mdy&customer.uuid=3
	var w_width = $(window).width();
	var w_height = $(window).height();
	sobj02Dep = new DialogIFrame({
		src:'',
		title:"修改当前部门",
		width:w_width*0.20,
		height:w_height*0.65
	});
	sobj02Dep.selfAction = function(val1,val2) {};
	sobj02Dep.create();
	//sobj02Dep.open();
	
};

var openUserDept = function() {
	var iframeId = sobj02Dep.getConid() + "iframe";
	$("#"+iframeId).attr("src","/sys/user_DeptList");
	sobj02Dep.open();
};


</script>
