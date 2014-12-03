<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>我的订单 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.lightness/jquery-ui.min.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/html/html_c.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/HttpCookie.min.js" />"></script>
<script type="text/javascript">
var coo = new HttpCookie("pp");
$(function(){
	//setSearchStatus(flag)
	if(coo.isExisted()&&coo.values.getValues("m_od")=="c") $(".more_condition").hide();
	else $(".more_condition").show();
	$("#more_condition_action").bind("click",function(){
		$(".more_condition").toggle();
		setSearchStatus(CommonUtil.isVisible($(".more_condition")));
	});
	 
	$("#s_add_time").datepicker();
	$("#e_add_time").datepicker();
});

function setSearchStatus(flag) {
	if(flag)
		coo.values.set("m_od", "o");
	else 
		coo.values.set("m_od", "c");
	coo.save();
}

</script>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=order" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">我的活动</div>
	</div>
	
	<div class="right_result">
	<table id="content_b" class="order_table">
		<!-- Order Start -->
		<tbody class="order_body">
		<s:iterator value="custActives" status="sta">
		<tr>
			<td colspan="8">
					<span class="order_id">
						<font color="red">*</font>&nbsp;编号:
						<span class="order_no">${uuid}</span>
					</span>
					<span class="add_time">
					活动时间:
					${it:formatDate(plan_start,"yyyy-MM-dd")} -- ${it:formatDate(plan_end,"yyyy-MM-dd")}
					</span>
					<span class="theme">
						申请人: ${apply_user_name}
					</span>
					<span class="theme">
						状态: 
						<s:if test="status==-1"><font class="message_error">已作废</font></s:if>
						<s:if test="status==0">新申请</s:if>
						<s:if test="status==1"><font class="message_warning">申请审批中</font></s:if>
						<s:if test="status==2"><font class="message_pass" title="${it:formatDate(pass_time,'yyyy-MM-dd HH:mm:ss')}">申请通过</font></s:if>
						<s:if test="status==3">开始结案</s:if>
						<s:if test="status==4"><font class="message_warning">结案审批中</font></s:if>
						<s:if test="status==5"><font class="message_pass" title="${it:formatDate(close_pass_time,'yyyy-MM-dd HH:mm:ss')}">结案通过</font></s:if>
						<s:if test="status==5">
						<span class="op-area">
						<s:if test="ship_status==0"><a class="ship_info input-nostyle"  data="${uuid}">未发货</a></s:if>
						<s:if test="ship_status==10"><a class="ship_info input-nostyle"  data="${uuid}"><span class="message_pass">已发货</span></a></s:if>
						</span>
						<span class="ship_hidden_info" style="display:none;">
							<span id="ship_no_${uuid}">${ship_no}</span>
							<span id="ship_type_${uuid}">${ship_type}</span>
							<span id="ship_date_${uuid}">${it:formatDate(ship_date,"yyyy-MM-dd")}</span>
							<span id="ship_phone_${uuid}">${ship_phone}</span>
							<span id="ship_status_${uuid}">${ship_status}</span>
							<span id="active_remark_${uuid}">${remark}</span>
						</span>
						</s:if>
					</span>
			</td>
		</tr>
		<tr>
			<td colspan="8">
					<span class="order_id">
						主题:
						<span class="order_no">${theme}</span>
					</span>
					
			</td>
		</tr>
		<tr>
			<td colspan="8">
					<span class="order_id">
						地址:
						<span class="order_no">${address}</span>
					</span>
					
			</td>
		</tr>
		</s:iterator>
		</tbody>
		<tr class="sep-row"><td></td></tr>
		<!-- Order End -->
		<tfoot>
		<tr style="padding: 100px 0;">
			<td colspan="2" style="border-right: none;"></td>
			<td colspan="6" class="page_area"  style="border-left: none;">
			<script type="text/javascript">
			var spage = new ShowPage();
			spage.show2(${recCount},${pageSize},2);
			</script>
			</td>
		</tr>
		</tfoot>
	</table>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=1&amp;uuid=6b878acc-4a07-41f6-962a-4aeb59bc0a08&amp;pophcol=1&amp;lang=zh"></script>
<script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script>
<script type="text/javascript" charset="utf-8">
bShare.addEntry({
    title: "天佑德藏酒",
    url: "http://qkjchina.com",
    summary: "我买了天佑德藏酒,很好喝,大家也来一起尝尝."
    //,pic: "指定分享的图片的链接，目前支持新浪微博，QQ空间，搜狐微博，网易微博，人人网， 嘀咕，腾讯微博和做啥。"
});
</script>
</body>
</html>