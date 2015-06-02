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
			<div class="dq_step">	<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;门店自定义支付</div>
			<s:form id="serachForm" name="serachForm" action="stores_order_list" method="get" namespace="/qkjmanage" theme="simple">
				<div class="label_con">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">品名:</div>
							<div class="label_rwben">
								<s:textfield id="auto_prod_name" name="product.title" cssClass="selectAll iI iI-s" />
		                         	
							</div>
						</div>
						<div class="label_hang label_button tac">
							<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
							<label for="search_mcondition"></label>更多条件
							<s:submit value="搜索" />
						</div>
					</div>
				</div>
			</s:form>
			<div class="tab_warp">
				<table>
					<tr id="coltr">
						<th class="td1" style="display: none;">编号</th>
				
						<th class="td3" style="display: none;">条形码</th>
						<th class="td1">系列</th>
						<th class="td2">品名</th>
						<th class="td5">规格</th>
						<th>修改后价格<c:if test="${it:checkPermit('QKJ_QKJMANAGE_STORES_ORDER_UPDATE',null)==true}">(点击修改)	</c:if></th>
						<th >原价</th>
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_STORES_ORDER_UPDATE',null)==true}">
						<th class="td4">操作</th>
						</c:if>
					</tr>
					<s:iterator value="products" status="sta">
						<tr id="showtr${uuid}">
							<td class="td1" id="uuid" style="display: none;">${uuid}</td>
				
							<td class="td1" id="bar_code" style="display: none;">${bar_code}</td>
							<td class="td1">${brand_name}</td>
							<td class="td2">${title}</td>
							<td class="td5">${spec}</td>
							<td       <c:if test="${it:checkPermit('QKJ_QKJMANAGE_STORES_ORDER_UPDATE',null)==true}"> class="caname"  </c:if> style="widit: 100px"  id="price">${update_price}</td>
							<td >${market_price}</td>
					        <c:if test="${it:checkPermit('QKJ_QKJMANAGE_STORES_ORDER_UPDATE',null)==true}">
							<td class="td4 op-area"><a id="${uuid}" class="input-blue" uuid="${uuid}" onclick="javascript:addprice(this)">确认修改</a></td>
					        </c:if>
						</tr>
					</s:iterator>
				</table>
			</div>
			<div id="listpage" class="pagination"></div>
		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<c:url value="/js/func/select_products.js" />"></script>
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
$(function () {  
    //获取class为caname的元素   
    $(".caname").click(function () {  
        var td = $(this);  
        var txt = $.trim(td.text());  
        var input = $("<input type='text' style='width:100px' value='" + txt + "'/>");  
        td.html(input);  
        input.click(function () { return false; });  
        //获取焦点   
        input.trigger("focus");  
        //文本框失去焦点后提交内容，重新变为文本   
        input.blur(function () {  
            var newtxt = $(this).val();  
            //判断文本有没有修改
            if (newtxt != txt) {  
                td.css("color","red");
            }
            td.html(newtxt);  
        })
    })
});
function addprice(data){
	var productid =$("#"+data.id).parent().parent("#showtr"+data.id).find("#uuid").text();
	var price =$("#"+data.id).parent().parent("#showtr"+data.id).find("#price").text();
	var barcode =$("#"+data.id).parent().parent("#showtr"+data.id).find("#bar_code").text();
	var userid='${sessionScope.userlogininfosessionstr.uuid}';
	/*
	 var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
	 var ajax=new Common_Ajax();
	 ajax.config.action_url=ajax_url_action;
	 ajax.config._success=function(data,textStatus){
	 }
	 ajax.addParameter("privilege_id", "QKJ_QKJMANAGE_STORES_ORDER");
	 ajax.addParameter("parameters", "productid="+productid+",price="+price+",userid="+userid);
	 ajax.addParameter("dbnum","1");
	 ajax.addParameter("work", "update");
	 ajax.sendAjax();
	 */
	var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
	 var ajax=new Common_Ajax();
	 ajax.config.action_url=ajax_url_action;
	 ajax.config._success=function(data,textStatus){
		
	 }
	 //ajax.addParameter("privilege_id", "QKJ_QKJMANAGE_STORES_ORDER");
	// ajax.addParameter("parameters", "productid="+productid+",price="+price+",userid="+userid);
	 //ajax.addParameter("dbnum","1");
	 ajax.addParameter("work", "Stores");
	 ajax.addParameter("parameters", "productid="+productid+"&price="+price+"&userid="+userid+"&barcode="+barcode);
	 ajax.addParameter("dbnum","1");
	 ajax.sendAjax();
}
$(function(){
	SimpleLoadProducts(function(){},"noparam=true");
 });
</script>
</body>
</html>