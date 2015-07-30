<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.tab_warp th {
	 background: #059c77;
     color: #fff; 
     font-size: 14px; 
     padding: 0 2px;
     height: 33px;
     white-space: nowrap; 
     word-break: break-all; 
     vertical-align: middle;
     width:110px;
}
</style>
<title>门店产品列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">	<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;添加酒票</div>
				<s:form id="serachForm" name="serachForm" action="insert_sotres_ticket" method="get" namespace="/qkjmanage" theme="simple">
			<div class="label_main">
				<div class="label_hang">
				<div class="label_ltit">酒票名称:</div>
				<div class="label_rwbenx">
					<s:textfield name="storesTicket.ticket_name"  />
				</div>
			</div>
			</div>
			<div class="label_main">
			<div class="label_hang">
				<div class="label_ltit">酒票商品:</div>
				<div class="label_rwbenx">
					<s:textfield id="auto_prod_name" name="prodname" cssClass="selectAll iI iI-s" />
					<input id="auto_prod_id" type="hidden" name="storesTicket.product_id" />
				</div>
			</div>
			</div>
				<div class="label_main">
			  <div class="label_hang">
            <div class="label_ltit">申请时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input type="text" class="datepicker iI iI-f" name="storesTicket.start_time" title="从" />
				</span>
				<span class="label_rwb nw">
				<input type="text" class="datepicker iI iI-t" name="storesTicket.end_time" title="到" />
            	</span>
            </div>
        </div>
        </div>
     	<s:submit type="reset" value="提交酒票"  cssClass="input-blue" />
              </s:form>
		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<c:url value="/js/func/select_products.js" />"></script>
	<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />">
</script>
	<script type="text/javascript">
	$(function(){
		SimpleLoadProducts(function(){}, "noparam=true");
	});
	$(function(){
		SimpleLoadMember(ajax_url, $.noop);
	});
</script>
</body>
</html>