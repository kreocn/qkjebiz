<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>我的藏酒 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript">
var history_cache = new Object();
var ajax_url_action = '<c:url value="/common_ajax/json_ajax" />';
function history_toggle(obj) {
var $a = $(obj);
var cellar_position = $a.attr("data");

if(CommonUtil.isVisible($("#"+cellar_position+"_history"))) {
	$("#"+cellar_position+"_history").hide();
	$a.text("查看取酒历史");
} else {
	$("#"+cellar_position+"_history").show();
	$a.text("隐藏历史记录");
	if(history_cache[cellar_position] && history_cache[cellar_position].length>0) {
		//$("#"+cellar_position+"_history").html();
	} else {
		$("#"+cellar_position+"_history_ctr").html("<td  colspan='5'><span class='loading16x16'></span></td>");
		var rhtml = "";
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url_action;
		ajax.config._success = function(data, textStatus) {
			if(data.length==0) {
				rhtml = "<td  colspan='5'>暂时没有任何取酒历史</td>";
			} else {
				var status_str = "";
				$.each(data, function(i, n){
					//alert( "Item #" + i);
					switch (n.status) {
					case 0:status_str="已作废";	break;
					case 10:status_str="新订单";break;
					case 20:status_str="已灌装";break;
					case 30:status_str="已发货";
					} 
					rhtml += '<tr>';
					rhtml += '<td class="ac">'+CommonUtil.formatJSONDate(n.add_time)+'</td>';
					rhtml += '<td class="ac">'+n.order_num+n.cellar_unit+'</td>';
					rhtml += '<td>'+n.con_name+" "+n.con_mobile+'</td>';
					rhtml += '<td class="ac">'+status_str+'</td>';
					rhtml += '<td class="ac"><a target="_blank" href="/member/cellarOrderLoad?memberCellar.uuid='+$a.attr("uuid")+'&cellarOrder.uuid='+n.uuid+'">订单详情</a> <a target="_blank" href="/member/video?cellarOrder.uuid='+n.uuid+'">取酒视频</a></td>';
					rhtml += '</tr>';
				});
			}
			$("#"+cellar_position+"_history_ctr").empty().html(rhtml);
			history_cache[cellar_position]=rhtml;
		};
		ajax.addParameter("work", "Member");
		ajax.addParameter("parameters", "ajax_name=GETCELLARORDER&cellar_position=" + encodeURI(cellar_position));
		ajax.sendAjax2();
	}
}
}
</script>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=cellar" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">我的藏酒</div>
		<div class="right_search">
			<form id="form_serach" name="form_serach" action="<c:url value="/member/cellar" />">
			<p>
				快速查询:
				<a href="javascript:;" onclick="CommonUtil.quickSearch('memberCellarfullflag','');">全部</a>
				<a href="javascript:;" onclick="CommonUtil.quickSearch('memberCellarfullflag','no');">已取过酒</a>
				<a href="javascript:;" onclick="CommonUtil.quickSearch('memberCellarfullflag','yes');">没取过酒</a>
				<input type="hidden" id="memberCellarfullflag" name="memberCellar.fullflag" value="${memberCellar.fullflag}" />
			</p>
			<p>
				<label for="TYD_cellar">藏酒种类:</label>
				<s:select id="TYD_cellar" name="memberCellar.goods_id" list="goods"
					listKey="uuid" listValue="goods_name"
					headerKey="" headerValue="全部" />
				<input type="submit" value="搜 索" class="search_input1" />
			</p>
			</form>
		</div>
	</div>
	<div class="right_result">
	<table id="content_b" class="order_table">
		<tbody class="order_body">
<c:forEach var="item" items="${memberCellars}" varStatus="sta">
		<tr class="sep-row"><td></td></tr>
		<tr class="od_head">
			<td colspan="8">
				<span class="order_id">
					藏酒编号/位置号:
					<span class="order_no">${item.cellar_position}</span>
					<!-- 
					封藏时间:
					<span class="order_no">2014-04-01</span>
					 -->
				</span>
			</td>
		</tr>
		<tr class="od_content">
			<td class="gd_img">
				<img src="${item.small_img}" alt="" />
			</td>
			<td class="gd_name">
				<a href="#">${item.goods_name}</a>
			</td>
			<td class="gd_perprice">${item.stock}${item.goods_spec_unit}</td>
			<td class="gd_num"></td>
			<td class="gd_operate"><c:if test="${!empty item.camera}">
				<p><a href="${item.camera}" target="_blank">查看实时摄像</a></p></c:if>
			</td>
			<td class="od_totprice">
				<p>${item.ware_name}</p>
				<p class="text_note">保管截至: ${it:formatDate(item.storage_date,"yyyy-MM-dd")}</p>
			</td>
			<td class="od_status">
				<p><a href="/member/cellarOrderLoad?memberCellar.uuid=${item.uuid}">我要取酒</a></p>
			</td>
			<td class="od_operate">
				<c:if test="${item.stock<item.num}">
				<p><a href="javascript:;" onclick="history_toggle(this);" data="${item.cellar_position}" uuid="${item.uuid}">查看取酒历史</a></p>
				</c:if>
				<!-- 
				<p><a href="#">发布售酒信息</a></p>
				<p><a href="#">我要退货</a></p>
				 -->
			</td>
		</tr>
		<c:if test="${item.stock<item.num}">
		<tr id="${item.cellar_position}_history" class="cellar_history">
			<td colspan="8" style="padding: 5px;">
				<table id="${item.cellar_position}_history_c" class="cellar_history_table">
					<thead>
					<tr>
						<td class="addtime ac">取酒时间</td>
						<td class="num ac">取酒数量</td>
						<td>收货人</td>
						<td class="status ac">状态</td>
						<td class="op ac"></td>
					</tr>
					</thead>
					<tbody id="${item.cellar_position}_history_ctr"></tbody>
				</table>
			</td>
		</tr>
		</c:if>
</c:forEach>
		<tr class="sep-row"><td></td></tr>
		</tbody>
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
</body>
</html>