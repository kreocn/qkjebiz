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
		<div class="right_title">我的订单</div>
		<div class="right_search">
			<form name="form1" action="<c:url value="/member/order" />">
			<!-- <p>我的交易提醒: <a href="#">待评价</a></p> -->
			<p>
				<label for="TYD_orderGoods">商品名称:</label>
				<input id="TYD_orderGoods" name="memberOrderGoods.goods_name" class="input_text input2" value="${memberOrderGoods.goods_name}" />
				<input type="submit" value="搜 索" class="search_input1" />
				<a id="more_condition_action" href="javascript:;">更多筛选条件</a>
			</p>
			<p class="more_condition">
				<label>下单时间:</label>
				 从 <input type="text" id="s_add_time" name="memberOrderGoods.s_add_time" class="input_text input1" value='${it:formatDate(memberOrderGoods.s_add_time,"yyyy-MM-dd")}'  />				 
				 到 <input type="text" id="e_add_time" name="memberOrderGoods.e_add_time" class="input_text input1" value='${it:formatDate(memberOrderGoods.e_add_time,"yyyy-MM-dd")}'  />	
			</p>
			<p class="more_condition">
				<label for="TYD_orderStatus">交易状态:</label>
				<s:select id="TYD_orderStatus" cssClass="input_text" 
					name="memberOrderGoods.order_status" list="#{10:'待处理',20:'已受理',70:'交易成功'}"
					headerKey="" headerValue="全部" />
			</p>
			</form>
		</div>
	</div>
	
	<div class="right_result">
	<table id="content_b" class="order_table">
		<!-- Order Start -->
		<tbody class="order_body">
<c:set var="pre_order_id" value="" />
<c:forEach var="item" items="${memberOrderGoodss}" varStatus="sta">
<c:if test="${pre_order_id!=item.order_id}">
			<tr class="sep-row"><td></td></tr>
			<tr class="od_head">
				<td colspan="8">
					<span class="order_id">
						订单号:
						<span class="order_no">${item.order_id}</span>
					</span>
					<span class="add_time">
						下单时间: ${it:formatDate(item.add_time,"yyyy-MM-dd HH:mm:ss")}
					</span>
				</td>
			</tr>
			<tr class="od_content">
				<td class="gd_img">
					<img src="${item.goods_small_img}" alt="" />
				</td>
				<td class="gd_name">
					<p><a href="/html/cellar#cellar_info_${item.goods_id}" target="_blank">${item.goods_name}</a></p>
					<p class="text_note">
						保管费:￥${item.storage_fees}
						截至:${it:formatDate(item.storage_date,"yyyy-MM-dd")}
					</p>
				</td>
				<td class="gd_perprice">￥${item.per_price}</td>
				<td class="gd_num">${item.order_num}</td>
				<td class="gd_operate">
					<p><a href="/member/cellar?memberCellar.goods_id=${item.goods_id}">查看藏酒</a></p>
				</td>
				<td class="od_totprice" rowspan="${item.og_num}">
					<p>￥${item.order_total_price}</p>
				</td>
				<td class="od_status" rowspan="${item.og_num}">
					<p>
						<c:if test="${item.order_status==10}">新订单</c:if>
						<c:if test="${item.order_status==20}">已受理</c:if>
						<c:if test="${item.order_status>=70}">交易完成</c:if>
					</p>
					<p>
						<c:if test="${item.order_pay_status==0}">未付款</c:if>
						<c:if test="${item.order_pay_status==1}">已付款</c:if>
					</p>
				</td>
				<td class="od_operate" rowspan="${item.og_num}">
					<!-- 分享平台  -->
					<div class="bshare-custom"><div class="bsPromo bsPromo2"></div><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a><a title="更多平台" class="bshare-more bshare-more-icon more-style-addthis"></a></div>
					<!-- 分享平台 -->
				</td>
			</tr>
</c:if>
<c:if test="${pre_order_id==item.order_id}">
			<tr class="od_content">
				<td class="gd_img">
					<img src="<c:url value="/images/emp/cangjiu_p1.jpg" />" alt="" />
				</td>
				<td class="gd_name">
					<p><a href="/html/cellar#cellar_info_${item.goods_id}" target="_blank">${item.goods_name}</a></p>
					<p class="text_note">
						保管费:￥${item.storage_fees}
						截至:${it:formatDate(item.storage_date,"yyyy-MM-dd")}
					</p>
				</td>
				<td class="gd_perprice">￥${item.per_price}</td>
				<td class="gd_num">${item.order_num}</td>
				<td class="gd_operate">
					<a href="/member/cellar?memberCellar.goods_id=${item.goods_id}">查看藏酒</a>
				</td>
			</tr>
</c:if> 
<c:set var="pre_order_id" value="${item.order_id}" />
</c:forEach>
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