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
			<div class="dq_step">	<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;查看订单</div>
			<div class="tab_warp">
				<table>
					<tr id="coltr">
			
						<th class="td3">用户名称</th>
						<th class="td3">订单总价</th>
						<th class="td1">添加时间</th>
						
						<th class="td4">操作</th>
					</tr>
					<s:iterator value="storesorderlist" status="sta">
						<tr>
						
							<td class="td2" >${user_name}</td>
							<td class="td3">${total_price}</td>
							<td class="td4">${add_time}</td>
							
							<td class="td4 op-area"><a  class="input-blue"  href="/qkjmanage/stores_order_update_details.action?id=${id}" >查看详情</a> <a  class="input-red" href="/qkjmanage/stores_order_delete.action?id=${id}"  >删除</a></td>
						</tr>
					</s:iterator>
				</table>
			</div>
			<div id="listpage" class="pagination"></div>
		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />">
</script>
	<script type="text/javascript">
	$(function(){
		$("#mmtype").citySelect({
			url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
			prov:"${assets.typea}",
			city:"${assets.typeb}",
			dist:" ${assets.typec}",
			nodata:"none",
			required:false
		});
		printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
	 });
</script>
</body>
</html>