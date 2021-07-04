<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户单据--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/print.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<style type="text/css">
.apply_print .apply_print * {
	letter-spacing: 1px;
}

.apply_print {
	border-top: #000 solid 1px; padding-top: 8px;
}

.apply_t {
	font-size: 18px; margin: 8px 5px; /*font-weight: bold;*/
}

.apply_hr {
	margin: 15px 5px; height: 3px; background-color: #000;
}

.apply_h {
	padding-bottom: 50px;
}

.apply_n {
	font-size: 16px; margin: 8px 5px; text-indent: 28px; line-height: 30px;
}

.apply_n * {
	font-size: 16px;
}

.check_note {
	margin: 8px 5px; border: #666 solid 1px; clear: both;
}

.check_user {
	text-align: right; margin: 8px; border-top: #000 dashed 1px; padding: 10px 30px; font-size: 16px;
}

.check_user .uname {
	font-size: 24px; font-weight: bold;
}
</style>
<body>
	<div class="tab_right">
		<div class="main printarea">
			<div id="result">
				<div class="itablemdy">
					<div class="noprint tac">
						<input type="button" onclick="window.print();" value="打印本页" />
					</div>
					<div class="apply_print">
						<div class="apply_t apply_z">时间：${sotresorder.add_time}</div>
							<div style="float: right;">门店：${sotresorder.login_name }</div>
						<div class="apply_t apply_s">总价：${sotresorder.total_price}</div>
							<div class="apply_t apply_h">提交人：${sotresorder.user_name}</div>
						<div class="apply_hr"></div>
						<div class="check_note">
							<div class="apply_t">商品详情:</div>
							<div id="apply_check_note_text" class="apply_n"></div>
				
					<table  style="width:100%;mangin-right:30px">
					        <tr >
						<td class="td1">商品名称</td>
				     	<td class="td2">规格</td>
						<td class="td3">单价</td>
						<td class="td4">数量</td>
						<td class="td5">总价</td>
					</tr>
					<s:iterator value="storesorderitem" status="sta">
						<tr >
							<td class="td1" >${title}</td>
							<td class="td2">${spec}</td>
							<td class="td3">${product_price}</td>
							<td class="td4"  >${order_num}</td>
							<td class="td5">${order_total_price}</td>
						 </tr>
					</s:iterator>
				</table>
							
						</div>
					</div>
					<div id="apply_check_note" style="display: none;"><%-- ${apply.check_note} --%></div>
					<script type="text/javascript">
					</script>
					<div class="noprint tac">
						<input type="button" onclick="window.print();" value="打印本页" />
					</div>
</div>
</div>
</div>
</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>