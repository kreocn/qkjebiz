<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>收货地址 -- ${it:i18n("HTML_NAME")}</title>
<link rel="stylesheet" href="<c:url value="/css/h/css.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/menu.css" />" />
<link rel="stylesheet" href="<c:url value="/css/h/center.css" />" />
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/html/html_c.js" />"></script>
<script type="text/javascript" src="<c:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/select_area.js" />"></script>
<script type="text/javascript" src="<c:url value="/js/form_validator.js" />"></script>
<script type="text/javascript">
var sa;
$(function(){
	sa = new SArea($("#address_province") ,$("#address_city"),$("#address_area"));
	sa.ajax_url = '<c:url value="/common_ajax/json_ajax" />';
	sa.init();
});

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
	$("#TYD_addressUuid").val(uuid);
	sa.init(province,city,area);
	$("#TYD_addressPost").val(post);
	$("#TYD_addressStreet").val(street);
	$("#TYD_addressCon_name").val(con_name);
	$("#TYD_addressMobile").val(mobile);
	
	$("#add").hide();
	$("#save").show();
}
</script>
</head>
<body>
<c:import url="/jsp/member/top.jsp" />
<div id="content" class="content_m">
<c:import url="/jsp/m_c/left_menu.jsp?at=address" />
<div id="right_content">
	<div class="right_top">
		<div class="right_title">收货地址</div>
		<div class="right_form">
			<form id="form_mdy" name="form_mdy" action="<c:url value="/member/saveMember" />" onsubmit="return validator(this);" method="post">
			<p>
				<label class="inlineblock"><span class="rt" >*</span> 所在地区:</label>
				<s:select id="address_province" cssClass="input_text" name="memberAddress.province" title="省" list="#{}" require="required" controlName="省"></s:select>
				<s:select id="address_city" cssClass="input_text" name="memberAddress.city" title="市" list="#{}" require="required" controlName="市"></s:select>
				<s:select id="address_area" cssClass="input_text" name="memberAddress.area" title="县" list="#{}" require="required" controlName="县"></s:select>
			</p>
			<p>
				<label for="TYD_addressPost" class="inlineblock"><span class="rt" >*</span> 邮编:</label>
				<input id="TYD_addressPost" name="memberAddress.post" class="input_text input2" require="required" controlName="邮编" value="${memberAddress.post}" />
			</p>
			<p>
				<label for="TYD_addressStreet" class="inlineblock"><span class="rt" >*</span> 街道地址:</label>
				<textarea  id="TYD_addressStreet" name="memberAddress.street" class="input_text input3" require="required" controlName="街道地址">${memberAddress.street}</textarea>
			</p>
			<p>
				<label for="TYD_addressCon_name" class="inlineblock"><span class="rt" >*</span> 收货人姓名:</label>
				<input id="TYD_addressCon_name" name="memberAddress.con_name" class="input_text input2" require="required" controlName="收货人姓名" value="${memberAddress.con_name}" />
			</p>
			<p>
				<label for="TYD_addressMobile" class="inlineblock"><span class="rt" >*</span> 手机号:</label>
				<input id="TYD_addressMobile" name="memberAddress.mobile" class="input_text input2" require="required" controlName="手机号" value="${memberAddress.mobile}" />
			</p>
			<!-- 
			<p>
				<label class="inlineblock">设为默认地址：</label>
				<input type="checkbox" class="input_text" name="defaultAddress" id="J_SetDefault" />
				<label for="J_SetDefault">设置为默认收货地址</label>
			</p>
			 -->
			<p>
				<label class="inlineblock"></label>
				<input type="hidden" id="TYD_addressUuid" name="memberAddress.uuid" value="${memberAddress.uuid}"  />
				<input type="submit" id="add" name="action:addAddress" value="新 增" class="search_input1" />
				<input type="submit" id="save" name="action:saveAddress" value="保 存" class="search_input1" style="display: none;" />
				<span class="text_note">${message}</span>
			</p>
			</form>
		</div>
	</div>
	
	<div style="height: 10px;"></div>
	
	<div class="right_result">
		<table id="content_b" class="address_table">
			<thead>
			<tr>
				<td width="80">收货人</td>
				<td width="140">所在地区</td>
				<td>街道地址</td>
				<td width="60">邮编</td>
				<td width="100">手机</td>
				<td width="130" align="center">操作</td>
			</tr>
			</thead>
			<tbody>
<c:forEach var="item" items="${memberAddresses}" varStatus="sta">
			<tr id="addr_${item.uuid}">
				<td>${item.con_name}</td>
				<td>${item.province} ${item.city} ${item.area}</td>
				<td>${item.street}</td>
				<td>${item.post}</td>
				<td>${item.mobile}</td>
				<td>
					<c:if test="${item.defaultaddress==1}">
						默认地址
					</c:if>
					<c:if test="${not (item.defaultaddress==1)}">
						<c:url var="cda_url" value="/member/changeDefaultAddress">
							<c:param name="memberAddressUuid" value="${item.uuid}" />
						</c:url>
						<a href="${cda_url}">设为默认</a>
					</c:if>
					&nbsp;&nbsp;&nbsp;
					<a href="javascript:;" onclick="selectAddr('addr_${item.uuid}');">修改</a> |
					<a href="javascript:;">删除</a>
				</td>
			</tr>
</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<div class="clear"></div>
</div>
<c:import url="/jsp/fore/footer.jsp" />
</body>
</html>