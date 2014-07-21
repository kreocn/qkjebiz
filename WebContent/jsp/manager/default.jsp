<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@ page import="org.iweb.sys.ContextHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title><s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<style type="text/css">
.main_info {
margin: auto; width: 850px; padding-top: 10px;
}
.update_info {
border: #999 solid 1px;margin-bottom: 10px;
}
.update_title {
margin: 1px;background-color: #999;line-height: 35px;height: 35px;font-size: 14px;font-weight: bold;cursor: pointer;
}
.update_info dl {
margin: 10px 5px;border-bottom: #999 dashed 1px;border-top: #999 dashed 1px;padding: 0;
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
.sysnote {
border: #999 solid 1px;margin-bottom: 10px;padding: 10px;
}
.sysnote .note_title {
font-size: 18px;text-align: center;font-weight: bold;padding: 10px;border-bottom: #999 dashed 1px; margin-bottom: 10px;
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
</style>
<script type="text/javascript">
	function load(){
   	 location.href="<s:url value="/sche/schedule_list" />"; 

	}
</script>
</head>
<body>
	<div class="main_info">
		<div class="sysnote">
			<div class="note_title">系统公告</div>
			<div class="note_content">
				常见问题:
				<ul>
				<li><font style="color: #FF0000;">推荐使用 360极速浏览器 浏览器</font>(<a href="http://chrome.360.cn/" target="_blank">点此下载</a>),或者拥有Chrome内核(极速模式)的浏览器</li>
				<li>用户登录后,请第一时间<font style="color: #FF0000;">修改密码</font>,以免账号不安全</li>
				<li>
					会员/客户添加时,请务必<font style="color: #FF0000;">选填<b>"客户经理"</b></font>,如果忘记填写,
					会使该客户直接登记在您所在的办事处中,而非您个人的"会员列表"下,<font style="color: #FF0000;">您将无法看到该客户</font>
					(只有办事处经理以上级别,拥有管理权限者才能看到),
					此时,若再次添加该客户,将会因为<font style="color: #FF0000;">手机号重复导致添加失败</font>(出现错误信息);
				</li>
				<li>当出现上述情况时,请马上联系您的办事处经理(或大区经理)进行分配,
				分配操作:  [会员管理]->[会员分配]->[把选中的会员分配给***]功能,把会员分配给您;</li>
				<li>活动申请单/结案单添加时,请注意添加格式,所有的<font style="color: #FF0000;">费用明细,<b>不是</b>填写在[方案说明]里面! </font>而是在您填完"活动内容",点击[下一步&填写费用明细]后添加的,具体请参考"系统操作指南" 第五条;</li>
				<li><font style="color: #FF0000;">"业务系统操作指南"</font>(2014-05-23更新) <a href="http://pan.baidu.com/s/1i3l4zVv" target="_blank">点此查看</a> ,提取密码为: c1cz</li>
				<li>潜在客户管理,如果要查看下属部门的所有客户,请在列表页面,选中[包含子部门]进行查询,否则只能看到当前指定部门下的客户</li>
				</ul>
			</div>
		</div>
		<s:iterator value="sches" status="sch">
			<div class="update_info">
					<div class="update_title">${sdate } ${title }</div>
					<div class="update_content">
					<dl><dt>${content }</dt></dl>
					</div>
			</div>
		</s:iterator>
		<div class="update_info">
			<div class="update_title">2014-07-03 系统临时更新</div>
			<div class="update_content">
			<dl>
				<dt>一.网站活动规则更改</dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>二.系统BUG修复</dt>
				<dd></dd>
			</dl>
			</div>
		</div>
		
		
	</div>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript">
var toggleCon = function(o) {
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