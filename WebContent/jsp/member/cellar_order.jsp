<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>取酒订单 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/form_validator.js" />"></script>
<link rel="stylesheet" href="<c:url value="/include/jQuery/style.ui.lightness/jquery-ui.min.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#SelectAddress").dialog({
	      autoOpen: false,
	      width: 780,
	      height: 355,
	      modal: true
	});
	
	$("#SelectAddress").dialog({
	  open: function( event, ui ) {$("body").css("overflow","hidden");},
	  close: function( event, ui ) {$("body").css("overflow","auto");}
	});
});

function openSelectAddr() {
	$("#SelectAddress").dialog("open");
}

function closeSelectAddr() {
	$("#SelectAddress").dialog("close");
}

function selectAddr(addr_id) {
	var uuid,province,city,area,post,street,con_name,mobile;
	var ts;
	uuid = addr_id.substr(5);
	$.each($("#" + addr_id + " td"), function(i, n){
		//alert( "Item #" + i + " : " + n.innerText);
		if(i==0)con_name=n.innerText;
		if(i==1) {
			ts = n.innerText.split(" ");
			province = ts[0];city = ts[1];area= ts[2];
		}
		if(i==2) street = n.innerText;
		if(i==3) post = n.innerText;
		if(i==4) mobile = n.innerText;
	});
	//$("#TYD_addressUuid").val(uuid);
	sa.init(province,city,area);
	$("#TYD_addressPost").val(post);
	$("#TYD_addressStreet").val(street);
	$("#TYD_addressCon_name").val(con_name);
	$("#TYD_addressMobile").val(mobile);
	
	//$("#add").hide();
	//$("#save").show();
	
	if($("#SelectAddress").dialog("isOpen")) {
		closeSelectAddr();
	}
}
</script>
<style type="text/css">
.co_main {letter-spacing: 1px;}
.co_main .c_info {background-color: #F0F0F0;margin: 0 15px;}
.co_main .c_info_title {font-size: 14px;font-weight: bold;border-bottom: #CCC dashed 1px;line-height: 25px;}
.co_main .float_img {float: left;margin-right: 20px;margin-top: 0;}
.co_main label {display: inline-block;width: 80px;vertical-align: top;}
.co_main span.svalue {width: 150px;}
input.c_num {width: 30px !important;}
.ui-widget-content {background: #FFF !important;}
</style>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=cellar" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">取酒下单</div>
		<div class="right_search co_main">
			<div class="c_info">
				<p class="c_info_title">藏酒信息</p>
				<p class="float_img"><img src="${memberCellar.small_img}" /></p>
				<p>
					<label>藏酒位置号:</label>
					<span class="svalue inlineblock">${memberCellar.cellar_position}</span>
					
					<label>剩余库存:</label>
					<span class="svalue inlineblock">${memberCellar.stock}</span>
				</p>
				<p>
					<label>取酒仓库:</label>
					<span class="svalue inlineblock">${memberCellar.ware_name}</span>
				</p>
				<div class="clear"></div>
			</div>
			<div class="c_info">
			<form id="form_add" name="form_add" action="/member/cellarOrderAdd" onsubmit="return validator(this);" method="post">
				<p class="c_info_title">
					取酒信息
					<c:if test="${viewFlag=='view'}">
					(取酒单号:${cellarOrder.uuid})
					(当前状态:<c:if test="${0==cellarOrder.status}">已作废</c:if><c:if test="${10==cellarOrder.status}">新订单</c:if><c:if test="${20==cellarOrder.status}">已灌装</c:if><c:if test="${30==cellarOrder.status}">已发货</c:if>)
					</c:if>
				</p>
				<p>
					<label for="order_num_id"><span class="rt">*</span> 取酒数量:</label>
					<c:if test="${empty cellarOrder.order_num}">
					<select id="order_num_id" name="cellarOrder.order_num" ></select>L
					<span class="text_note">(剩余:${memberCellar.stock}L 取酒数量必须为整数,单位为L,1L=1000ml)</span>
					<script type="text/javascript">
					for(var i=4;i<=<s:property value="memberCellar.stock" />;i=i+4) {
						$("#order_num_id").addOption(i,i);
					}
					</script>
					</c:if>
					<c:if test="${not empty cellarOrder.order_num}">
						${cellarOrder.order_num} L
					</c:if>
				</p>
				<p>
					<label><span class="rt">*</span> 配送地址:</label>
					<s:select name="cellarOrder.con_province" id="co_p" title="省" list="#{}" require="required" controlName="省"></s:select>
					<s:select name="cellarOrder.con_city" id="co_c" title="市" list="#{}" require="required" controlName="市"></s:select>
					<s:select name="cellarOrder.con_area" id="co_a" title="县" list="#{}" require="required" controlName="县"></s:select>
					<c:if test="${empty viewFlag}"><a href="javascript:;" onclick="openSelectAddr();">其他预设地址</a></c:if>
				</p>
				<p>
				<label for="TYD_addressPost" class="inlineblock"><span class="rt" >*</span> 邮编:</label>
				<input id="TYD_addressPost" name="cellarOrder.con_post" class="input_text input2" require="required" controlName="邮编" value="${cellarOrder.con_post}" />
				</p>
				<p>
				<label for="TYD_addressStreet" class="inlineblock"><span class="rt" >*</span> 街道地址:</label>
				<textarea  id="TYD_addressStreet" name="cellarOrder.con_street" class="input_text input3" require="required" controlName="街道地址">${cellarOrder.con_street}</textarea>
				</p>
				<p>
				<label for="TYD_addressMobile" class="inlineblock"><span class="rt" >*</span> 联系手机:</label>
				<input id="TYD_addressMobile" name="cellarOrder.con_mobile" class="input_text input2" require="required" controlName="手机号" value="${cellarOrder.con_mobile}" />
				</p>
				<p>
				<label for="TYD_addressCon_name" class="inlineblock"><span class="rt" >*</span> 联系人:</label>
				<input id="TYD_addressCon_name" name="cellarOrder.con_name" class="input_text input2" require="required" controlName="联系人" value="${cellarOrder.con_name}" />
				</p>
				<p>
				<label for="TYD_OrderNote" class="inlineblock"><span class="rt" >&nbsp;</span> 备注:</label>
				<textarea  id="TYD_OrderNote" name="cellarOrder.con_note" class="input_text input3">${cellarOrder.con_note}</textarea>
				</p>
				<p>
				<label class="inlineblock"></label>
				<input type="hidden" name="cellarOrder.uuid" value="${cellarOrder.uuid}" />
				<input type="hidden" name="memberCellar.uuid" value="${memberCellar.uuid}" />
				<c:if test="${empty viewFlag}">
				<input type="submit" id="cellarOrderAdd" name="action:cellarOrderAdd" value="下 单" class="search_input1" />
				</c:if>
				<c:if test="${viewFlag=='view' && 10==cellarOrder.status}">
				<input type="submit" id="cellarOrderDel" name="action:cellarOrderDel" value="取消订单" class="search_input1" onclick="return $cu.isOp('确定取消订单!');" />
				</c:if>
				<span class="text_note">${message}</span>
				</p>
				<p>&nbsp;</p>
			</form>
			</div>
		</div>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
<div id="SelectAddress" title="选择配送地址">
	<table id="content_b" class="address_table">
		<thead>
		<tr>
			<td width="80">收货人</td>
			<td width="140">所在地区</td>
			<td>街道地址</td>
			<td width="60">邮编</td>
			<td width="100">手机</td>
			<td width="130" align="center"></td>
		</tr>
		</thead>
		<tbody>
<c:set var="d_addr">0</c:set>
<c:forEach var="item" items="${memberAddresses}" varStatus="sta">
		<tr id="addr_${item.uuid}">
			<td>${item.con_name}</td>
			<td>${item.province} ${item.city} ${item.area}</td>
			<td>${item.street}</td>
			<td>${item.post}</td>
			<td>${item.mobile}</td>
			<td align="center">
				<input type="button" value="确定选择"  onclick="selectAddr('addr_${item.uuid}');" />
			</td>
		</tr>
<c:if test="${item.defaultaddress==1}">
<c:set var="d_addr">${item.uuid}</c:set>
</c:if>
</c:forEach>
		</tbody>
	</table>
</div>
<script type="text/javascript">
var sa = new SArea($("#co_p") ,$("#co_c"),$("#co_a"));
sa.ajax_url = '/common_ajax/json_ajax';
/*<c:if test="${empty viewFlag}">*/
selectAddr('addr_${d_addr}');
/*</c:if>*/
/*<c:if test="${viewFlag=='view'}">*/
sa.init('${cellarOrder.con_province}','${cellarOrder.con_city}','${cellarOrder.con_area}');
/*</c:if>*/
</script>
</body>
</html>