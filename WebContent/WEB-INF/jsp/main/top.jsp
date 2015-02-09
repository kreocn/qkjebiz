<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var module_toggle = function(module_no) {
	if (typeof(module_no) == "undefined" || module_no<0) { 
		$(".prvg-module").show();
	} else {
		$(".prvg-module").hide();
		$(".prvg-module-"+module_no).show();
	}
};

$(function(){
	module_toggle(0);
});
</script>
<header>
	<div class="ht_top">
        <div class="ht_lTit">互助青稞酒商务管理中心</div>
        <ul class="ht_rczuo">
            <li><a href="" title="系统首页">系统首页</a></li>
			<li><a href="javascript:;" onclick="module_toggle()" title="全部功能">全部功能</a></li>
            <li><a href="javascript:;" onclick="module_toggle(0)" title="业务系统">业务系统</a></li>
            <li><a href="javascript:;" onclick="module_toggle(1)" title="信息系统">信息系统</a></li>
            <li><a href="javascript:;" onclick="module_toggle(2)" title="报表系统">报表系统</a></li>
            <li><a href="javascript:;" onclick="module_toggle(3)" title="基础数据">基础数据</a></li>
            <li><a href="javascript:;" onclick="module_toggle(4)" title="系统设置">系统设置</a></li>
            <li><a href="" title="帮助信息">帮助信息</a></li>
            <li><a href="" title="退出系统">退出系统</a></li>
        </ul>
        <div class="ht_rset">
        	<a href="javascript:void(0);" class="ht_clicka"><img src="<c:url value="/images/top/ht_tb7.png" />" width="45"></a>
            <ul class="ht_sjsub">
                <li><a href="" title="系统首页">系统首页</a></li>
                <li><a href="javascript:;" onclick="module_toggle()" title="全部功能">全部功能</a></li>
	            <li><a href="javascript:;" onclick="module_toggle(0)" title="业务系统">业务系统</a></li>
	            <li><a href="javascript:;" onclick="module_toggle(1)" title="信息系统">信息系统</a></li>
	            <li><a href="javascript:;" onclick="module_toggle(2)" title="报表系统">报表系统</a></li>
	            <li><a href="javascript:;" onclick="module_toggle(3)" title="基础数据">基础数据</a></li>
	            <li><a href="javascript:;" onclick="module_toggle(4)" title="系统设置">系统设置</a></li>
	            <li><a href="" title="帮助信息">帮助信息</a></li>
	            <li><a href="" title="退出系统">退出系统</a></li>
            </ul>
        </div>
    </div>
</header>