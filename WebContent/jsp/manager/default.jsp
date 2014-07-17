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
		<div class="update_info active_info">
			<div class="update_title">2014-07-17 系统例行更新</div>
			<div class="update_content">
			<dl>
				<dt>一.至事由-增加发货管理功能</dt>
				<dd>1.在审核通过之后,可以添加发货信息,包括是否已发货,物流单号电话等信息,方便管理</dd>
				<dd>2.在发货信息处,显示审核意见,方便查看</dd>
			</dl>
			<dl>
				<dt>二.至事由增加审阅功能</dt>
				<dd>1.拥有审阅权限的人,对至事由有审阅的功能.</dd>
				<dd>2.审阅不影响实际流程,只是作为审核人的参考.</dd>
			</dl>
			<dl>
				<dt>二.活动管理增加审阅功能</dt>
				<dd>1.拥有审阅权限的人,对至事由有审阅的功能.</dd>
				<dd>2.审阅不影响实际流程,只是作为审核人的参考.</dd>
			</dl>
			</div>
		</div>
		<div class="update_info">
			<div class="update_title">2014-07-11 系统例行更新</div>
			<div class="update_content">
			<dl>
				<dt>一.活动-增加发货管理功能</dt>
				<dd>在活动结案之后,可以添加发货信息,包括是否已发货,物流单号电话等信息,方便管理</dd>
			</dl>
			<dl>
				<dt>二.通用-编辑框精简</dt>
				<dd>鉴于编辑框按钮繁多,但是又不常用的情况,特地把编辑框无用的功能都取出了,使页面更加简洁</dd>
			</dl>
			</div>
		</div>
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
		
		<div class="update_info">
			<div class="update_title">2014-06-30 系统例行更新</div>
			<div class="update_content">
			<dl>
				<dt>一.至事由说明改成编辑框模式,可以插入表格和图片了</dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>二.系统BUG修复</dt>
				<dd></dd>
			</dl>
			</div>
		</div>
		<div class="update_info">
			<div class="update_title">2014-06-27 系统例行更新</div>
			<div class="update_content">
			<dl>
				<dt>一.网站活动功能完善</dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>二.系统BUG修复</dt>
				<dd></dd>
			</dl>
			</div>
		</div>
		<div class="update_info">
			<div class="update_title">2014-06-20 系统临时更新</div>
			<div class="update_content">
			<dl>
				<dt>一.至事由增加会审功能</dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>二.活动编号规则更改,变回原来的单S模式,将不会生成SS**这种类型的编号了,原来的申请不会受到影响</dt>
				<dd></dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info">
			<div class="update_title">2014-06-10 系统例行更新</div>
			<div class="update_content">
			<dl>
				<dt>一.北京公司资产管理模块启用</dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>二.活动管理页面微调,备注字体加大到14号</dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>二.修正一些系统BUG</dt>
				<dd></dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info">
			<div class="update_title">2014-06-04 系统临时更新</div>
			<div class="update_content">
			<dl>
				<dt>一.修正了活动管理排版异常的错误</dt>
				<dd></dd>
			</dl>
			<dl>
				<dt>二.至事由功能正式上线</dt>
				<dd></dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info">
			<div class="update_title">2014-05-28 系统更新</div>
			<div class="update_content">
			<dl>
				<dt>一.添加会员功能更加便捷</dt>
				<dd>添加会员时,客户归属/客户经理将默认为当前登录人</dd>
			</dl>
			<dl>
				<dt>二.修改BUG</dt>
				<dd>修改在活动管理中,申请通过时间/结案通过时间查询无效的问题</dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info active_info">
			<div class="update_title">2014-05-27 系统更新</div>
			<div class="update_content">
			<dl>
				<dt>一.至事由系统准备上线</dt>
				<dd>至事由申请审批系统已经开发完成,随时可以上线</dd>
			</dl>
			<dl>
				<dt>二.保持在线时间调整为120分钟</dt>
				<dd>系统登录后,如果无任何操作,120分钟之后将会被系统踢下线</dd>
				<dd>注意:[按按钮]和[刷新页面]才能称之为操作,如果只是在页面内打字撰写,不算操作范畴,所以特别提醒大家,要养成及时保存的好习惯.</dd>
				<dd>PS:现在属于系统熟悉期.为了系统安全,以后这个时间可能会缩短,请关注页面更新公告</dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info active_info">
			<div class="update_title">2014-05-23 系统例行更新</div>
			<div class="update_content">
			<dl>
				<dt>一.活动管理 打印流程调整</dt>
				<dd>调整为,只要运营总监审核通过,就能打印申请单和结案单</dd>
			</dl>
			<dl>
				<dt>二.省外潜在客户-报表更新</dt>
				<dd>更加适合实际情况,为考核提供相应的准确数据</dd>
			</dl>
			<dl>
				<dt>三.活动管理,查询条件更新</dt>
				<dd>添加了(包含子部门)选项,更加适合查询</dd>
			</dl>
			<dl>
				<dt>四.潜在客户管理</dt>
				<dd>在列表页,增加潜在[回访次数]列,使一目了然可以知道客户还需要回访</dd>
			</dl>
			<dl>
				<dt>五.业务系统操作指南 新版更新</dt>
				<dd>业务系统操作指南 新版更新</dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info">
			<div class="update_title">2014-05-22 系统临时更新</div>
			<div class="update_content">
			<dl>
				<dt>一.活动管理 打印页面调整</dt>
				<dd>活动管理打印页面整体效果调整 <br />只有在[申请通过]状态下,才能打印申请单,只有在[结案通过]状态下,才能打印结案单</dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info active_info">
			<div class="update_title">2014-05-19 系统更新</div>
			<div class="update_content">
			<dl>
				<dt>	一.活动管理流程调整</dt>
				<dd>1.大区经理->销管经理->运营总监 将实现严格审核流程,即大区经理未审核时,销管经理将不能审核;同理,销管经理未审核时,运营总监将不能审核
				<br />具体流程看下面流程图:
				<br /><img width="780" src="http://qkjchina.com/ckframe/userfiles/images/WebImages/qkjmanager/update_20140519_01.jpg" alt="" />
				</dd>
			</dl>
			<dl>
				<dt>二.在线保持时间调整</dt>
				<dd>在线保持时间调整为60分钟,登录系统后,<font style="color: #FF0000;">在没有任何操作</font>的情况下,60分钟后将自动下线,需要重新登录</dd>
			</dl>
			<dl>
				<dt>三.系统BUG修复</dt>
				<dd>修复了系统BUG,完善系统操作</dd>
			</dl>
			</div>
		</div>
		
		<div class="update_info">
			<div class="update_title">2014-05-12 系统更新</div>
			<div class="update_content">
			<dl>
				<dt>	一.活动管理将实现新的流程</dt>
				<dd>
				1.活动申请单/结案单都需要<font style="color: #FF0000;">大区经理审核</font>
				<br />2.活动申请单/结案单最后都需要<font style="color: #FF0000;">运营总监</font>做<font style="color: #FF0000;">最后确认</font>才能通过
				<br />具体流程看下面流程图:
				<br /><img width="780" src="http://qkjchina.com/ckframe/userfiles/images/WebImages/qkjmanager/update_20140511_01.jpg" alt="" />
				</dd>
			</dl>
			<dl>
				<dt>二.部门结构树,增加省外-东区和省外-西区的结构</dt>
				<dd>更加切合实际情况</dd>
			</dl>
			<dl>
				<dt>三.打印活动时,<font style="color: #FF0000;">增加领导的签字框</font>(只有打印时才有效果)</dt>
				<dd>更加切合实际情况</dd>
			</dl>
			<dl>
				<dt>四.活动管理状态,采用颜色标记</dt>
				<dd>更加清晰明了</dd>
			</dl>
			<dl>
				<dt>五.会员管理,添加会员,填写所属部门/人员时,当选中部门只有一个人员时,会自动选中</dt>
				<dd>使得错误发生率减少</dd>
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