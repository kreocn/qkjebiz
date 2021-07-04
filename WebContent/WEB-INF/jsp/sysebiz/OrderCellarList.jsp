<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单藏酒配货--${it:i18n("APP_NAME")}</title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<link rel="stylesheet" href="<c:url value="/css/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<c:url value="/css/main.css" />" />
<link rel="stylesheet" href="<c:url value="/css/single/cellar.css" />" />
<link rel="stylesheet" href="<c:url value="/css/animate.css" />" />
<script type="text/javascript" src="<c:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.jPages.min.js" />"></script>
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/common_ajax2.0.js" />"></script>

<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step noprint">
		<span class="opb lb op-area">
		<c:url var="back2order" value="/sysebiz/order_load">
				<c:param name="order.uuid">${memberCellar.order_id}</c:param>
				<c:param name="viewFlag">mdy</c:param>
			</c:url>
		<a href="${back2order}" >返回订单信息</a>
		<a href="javascript:;" onclick="window.print();">打印</a>
		</span>
	</div>
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">
			订单藏酒配货	[会员号:${memberCellar.member_id} 订单号:${memberCellar.order_id}]
		</span>
	</div>	
	<div class="ilistsearch">
		<div id="message"></div>
	</div>
<form id="add_form" name="add_form" action="<c:url value="/sysebiz/orderCellar_add" />">
<div id="cellar_list_exists">
<c:forEach var="item" items="${orderGoodss}" varStatus="sta">
	<div id='cellar_${item.uuid}' class='cellar_list'>
		<div class="cellar_title">
			<span class="cellar_goods_area">区域:</span>
			<span class="cellar_area_name">${item.uuid}</span> | 
			<span class="cellar_goods_name">商品名称:</span>
			<span class="cellar_goods_name_value">${item.goods_name}</span> | 
			<span class="cellar_goods_ware">所在仓库:</span>
			<span class="cellar_goods_ware_value">${item.ware_name}</span> | 
			<span class="cellar_goods_num">订单数量:</span>
			<span class="cellar_goods_num_value">${item.order_num}</span> | 
			<span class="cellar_goods_storage">保管日期截至:</span>
			<span class="cellar_goods_storage_value">${it:formatDate(item.storage_date,"yyyy-MM-dd")}</span> | 
			<span class="cellar_goods_pnum">已配货:</span>
			<span class="cellar_goods_pnum_value">0</span> |
			<span class="cellar_goods_operate"><a href="javascript:;" onclick="openAddDialog(${item.uuid},${item.goods_id},'${it:formatDate(item.storage_date,'yyyy-MM-dd')}');">点此添加藏酒</a></span>
		</div>
		<ul id="cellar_list_${item.uuid}"></ul>
	</div>
</c:forEach>
</div>
<ul id="mc" style="display: none;">
<c:forEach var="item" items="${memberCellars}" varStatus="sta">
<li belong="${item.order_goods_id}" uuid="${item.uuid}"><span class="cellar_no">${item.cellar_position}</span></li>
</c:forEach>
</ul>
</form>
	</div>
</div>
</div>
</div>
<div>
</div>
<div id="AddCellars" title="添加藏酒">
<form id="AddCellarsForm" action="<c:url value="/sysebiz/orderCellar_add" />">
<div id="AddCellarsList"></div>
<div id="AddCellarsSubmit" class="dialog_button">
	<input type="submit" value="提交" />
	<input type="hidden" name="memberCellar.member_id" value="${memberCellar.member_id}" />
	<input type="hidden" name="memberCellar.order_id" value="${memberCellar.order_id}" />
	<input type="hidden" name="memberCellar.goods_id" id="add_goods_id" />
	<input type="hidden" name="memberCellar.order_goods_id" id="add_order_goods_id" />
	<input type="hidden" name="memberCellar.storage_date" id="add_storage_date" />
</div>
<div class="message_prompt add_prompt">
	<div class="message_prompt">配货说明:</div>
	<ul>
		<li>当[选择的藏酒]大于[实际需求配货数量]时,将只会配货前面N个藏酒(N=实际需求配货数量)</li>
		<li>当有两个人同时选择了相同的藏酒,那么先提交者优先</li>
	</ul>
</div>
</form>
</div>

<div id="MdyCellar" title="藏酒信息" style="display: none;">
	<div class="dialog_button">
	<span id="cellar_del" class="ui_button_100x24_shallow">清除配货信息</span>
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
var ajax_current_url = '<c:url value="/common_ajax/json_ajax" />';
var w_height = $(window).height();
$(function(){
	$("#AddCellars").dialog({
	      autoOpen: false,
	      width: '95%',
	      height: w_height*0.95,
	      modal: true
	});
	
	$("#MdyCellar").dialog({
	      autoOpen: false,
	      width: 200,
	      height: 100,
	      modal: true
	});
	
	reserveCellar();
	
	$("#cellar_del").unbind().bind("click",function(){
		if(CommonUtil.isOp("确定要清除此藏酒的配货信息吗?")) {
			location.href='/sysebiz/orderCellar_del?memberCellar.order_id=${memberCellar.order_id}&memberCellar.member_id=${memberCellar.member_id}&memberCellar.uuid='+$(this).data("uuid");
		}
	});
});

function openAddDialog(order_goods_id,goods_id,storage_date) {
	$("#add_goods_id").val(goods_id);
	$("#add_order_goods_id").val(order_goods_id);
	$("#add_storage_date").val(storage_date);
	var con_id = "goods_dialog_"+goods_id;
	if($("#"+con_id).length==0) {
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_current_url;
		ajax.config._success = function(data, textStatus) {
			//c.uuid,c.member_id,c.num,c.stock,c.cellar_position,c.order_id,c.goods_id,c.`status`,c.order_goods_id
			var shtml = '<div id="'+con_id+'">';
			shtml += '<div id="'+con_id+'_page" class="jpage_pages"></div>';
			shtml += '<ul id="'+con_id+'_main" class="cellar_add_list cellar_list">';
			$.each(data, function(i, n){
				shtml += '<li '+(n.member_id==''?'':'class="disabled"')+'><input  id="'+n.cellar_position+'" type="checkbox" name="goods_add_id" value="'+n.cellar_position+'" '+(n.member_id==''?'':'disabled="disabled"')+' /><label for="'+n.cellar_position+'">'+n.cellar_position+'</label></li>';
			});
			shtml += '</ul></div>';
			$("#AddCellarsList").append(shtml);
			$("#"+con_id).siblings().hide();
			$("#AddCellars").dialog("open");
			createPageSplit(con_id+'_page',con_id+'_main');
			
			//disabled submit
			$("#"+con_id+" li").unbind().bind({
				click : function(){
					if(!$(this).hasClass("submit") && !$(this).hasClass("disabled")) {
						$(this).addClass("submit");
					}
				},mouseenter : function() {
					if(!$(this).hasClass("submit") && !$(this).hasClass("disabled")) {
						$(this).addClass("submit");
					}
				}, mouseleave : function() {
					//$(this).removeClass("submit");
					if(!$($(this).find("input")[0]).is(":checked")){
						$(this).removeClass("submit");
					}
				}
			});
		};
		ajax.addParameter("work", "AutoComplete");
		ajax.addParameter("parameters", "privilege_id=QKJCJ_SYSEBIZ_AJAXLOAD_MEMBERCELLAR&goods_id=" + encodeURI(goods_id));
		ajax.sendAjax2();
	} else {
		$("#"+con_id).siblings().hide();
		$("#"+con_id).show();
		$("#AddCellars").dialog("open");
	}
}

function createPageSplit(page_con_id,item_con_id) {
	$("#" + page_con_id).jPages({
        containerID:item_con_id,
        previous:"上一页",
        next:"下一页",
        perPage:50,
        animation:"pulse"
    });
}

function reserveCellar() {
	//初始位置
	var listObj = $("#mc");
	
	//分别放入相应的容器内
	$.each(listObj.find("li"),function(i,n){
		$("#cellar_list_" + $(this).attr("belong")).append($("<div></div>").append($(this).clone()).html());
	});
	
	//检查已配货数量	
	$.each($("div[id^='cellar_'][class='cellar_list']"),function(i,n){
		var uid = $(this).attr("id").substr(7);
		var length = listObj.find("[belong="+uid+"]").length;
		$("#cellar_"+uid+" .cellar_goods_pnum_value").text(length);
		
		// 配货数量还没到,则显示配货按钮
		if(!($("#cellar_"+uid+" .cellar_goods_num_value").text()==length)) {
			$("#cellar_"+uid+" .cellar_goods_operate").show();
		}
	});
	
	//添加点击时间
	$("div[id^='cellar_'][class='cellar_list'] li").unbind().bind({
		click : function(){
			/*<c:if test="${viewFlag!='view'}">*/
			$("#cellar_del").data("uuid",$(this).attr("uuid"));
			$("#MdyCellar").dialog("open");
			/*</c:if>*/
		},mouseenter : function() {
			$(this).addClass("active");
		}, mouseleave : function() {
			$(this).removeClass("active");
		}
	});
		
	listObj.empty();
}
</script>
</html>