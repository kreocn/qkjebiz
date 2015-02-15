<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title><s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.main_info {
	margin: auto; width: 98%; padding-top: 10px;
}

.main_info a {
	font-size: 14px; 
}

.main_info a:hover {
text-decoration: underline;
}

.ht_tabcon p {
line-height: 25px;
}

.ht_tabtit2 {
padding:10px 0;
margin:10px 0;
border-bottom: #999 dashed 1px; 
}

.update_info {
	border: #999 solid 1px; margin-bottom: 10px;
}

.update_title {
	margin: 1px; background-color: #999; line-height: 35px; height: 35px; font-size: 14px; font-weight: bold; cursor: pointer;
}

.update_info dl {
	margin: 10px 5px; border-bottom: #999 dashed 1px; border-top: #999 dashed 1px; padding: 0;
}

.update_info dt,.update_info dd {
	font-size: 14px;
}

.update_info dd {
	margin-left: 14px;
}

.last_update {
	color: red;
}

.sysnote ul {
	margin-left: 30px;
}

.sysnote {
	border: #999 solid 1px; margin-bottom: 10px; padding: 10px;
}

.sysnote .note_title {
	font-size: 18px; text-align: center; font-weight: bold; padding: 10px; border-bottom: #999 dashed 1px; margin-bottom: 10px;
}

.sysnote .note_content {
	font-size: 14px;
}

.active_info .update_content {
	display: block;
}

.update_content {
	display: none;
}
.ht_right{
font-size:14px;
float: right;
}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
<div class="main_info">
	<div class="sysnote">
		<div class="note_title">系统公告</div>
		<p style="color: red;"><span id="pointx"></span><span id="pointy"></span></p>
		<div class="note_content">
			<p>新版系统上线，<font style="color: #FF0000;">活动、至事由、工时和会员管理</font>四个模块已经实现新版改版工作。</p>
			<p>&nbsp;</p>
			<p>新版特点如下:</p>
			<ul>
				<li>界面改造，对于不同的屏幕自动进行适应。</li>
				<li><font style="color: #FF0000;">适用于移动端</font>，如手机、PAD等设备，也能正常使用</li>
				<li>文本编辑框改造，更加简洁适用；特别是<font style="color: #FF0000;">文件上传功能</font>，不像以前那么繁琐了。</li>
			</ul>
			<p>&nbsp;</p>
			<p>特别注意:</p>
			<ul>
				<li>如用户使用的是IE，本系统将<font style="color: #FF0000;">不支持IE8及以下版本</font>，请升级浏览器版本，或者直接使用其他内核的浏览器(推荐使用360极速浏览器)</li>
				<li>手机端左侧菜单触摸滑动，仅支持Android和iOS，不支持WP</li>
				<li>其他未改造的系统模块，不支持滑动和自适应功能</li>
			</ul>
			<p>&nbsp;</p>
			<p>常见问题:</p>
			<ul>
				<li><font style="color: #FF0000;">推荐使用360极速浏览器 浏览器</font>(<a href="http://chrome.360.cn/" target="_blank">点此下载</a>),或者拥有Chrome内核(极速模式)的浏览器</li>
				<li>用户登录后,请第一时间<font style="color: #FF0000;">修改密码</font>,以免账号不安全</li>
				<li>会员/客户添加时,请务必<font style="color: #FF0000;">选填<b>"客户经理"</b></font>,如果忘记填写, 会使该客户直接登记在您所在的办事处中,而非您个人的"会员列表"下,<font style="color: #FF0000;">您将无法看到该客户</font> (只有办事处经理以上级别,拥有管理权限者才能看到), 此时,若再次添加该客户,将会因为<font style="color: #FF0000;">手机号重复导致添加失败</font>(出现错误信息);</li>
				<li>当出现上述情况时,请马上联系您的办事处经理(或大区经理)进行分配, 分配操作: [会员管理]-[会员分配]->[把选中的会员分配给***]功能,把会员分配给您;</li>
				<li>活动申请单/结案单添加时,请注意添加格式,所有的<font style="color: #FF0000;">费用明细,<b>不是</b>填写在[方案说明]里面!</font>而是在您填完"活动内容",点击[下一步&填写费用明细]后添加的,具体请参考"系统操作指南" 第五条;</li>
				<li>新上线 <a href="http://d.qkjchina.com/qkjzn/index.html?v=0.01">业务系统操作指南</a></li>
				<li>潜在客户管理,如果要查看下属部门的所有客户,请在列表页面,选中[包含子部门]进行查询,否则只能看到当前指定部门下的客户</li>
			</ul>
		</div>
	</div>
	<div class="ht_tablb">
	    <h3 class="ht_tabtit2">公司内部公告</h3>
	    <div class="ht_tabcon">
            <s:iterator value="sches" status="sch">
             
            <p>
            <a href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">view</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">
            [<s:if test="type==0"> 部门手册</s:if>
			<s:if test="type==1">公司制度</s:if>
			<s:if test="type==2">公司文件</s:if>
			<s:if test="type==3"> 更新公告 </s:if>]&nbsp;
			${title}&nbsp;(${sdate})</a></p>
			
            </s:iterator>
	    </div>
	    <!-- <div class="ht_right">
	    <a href='/sche/schedule_leftList?sche.type=0'>>>更多公告信息</a>
	    </div> -->
	</div>
	<div>
	</div>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var toggleCon = function(o){
	$(o).find(".update_content").toggle();
};

$(function(){
	$(".update_info").click(function(){
		toggleCon($(this));
	});
});
</script>
</body>
</html>