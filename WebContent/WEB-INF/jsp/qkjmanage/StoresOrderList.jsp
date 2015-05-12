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
			<div class="dq_step">${path}</div>
			<s:form id="serachForm" name="serachForm" action="product_list" method="get" namespace="/qkjmanage" theme="simple">
				<div class="label_con">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">品名:</div>
							<div class="label_rwben">
								<s:textfield name="product.title" title="品名" dataLength="0,85" controlName="品名" />
							</div>
						</div>
						<div class="label_hang label_button tac">
							<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
							<label for="search_mcondition"></label>更多条件
							<s:submit value="搜索" />
							<s:reset value="重置" />
						</div>
					</div>
				</div>
			</s:form>
			<div class="tab_warp">
				<table>
					<tr id="coltr">
						<th class="td1">编号</th>
						<th class="td3">统一编码</th>
						<th class="td1">系列</th>
						<th class="td2">品名</th>
						<th class="td5">规格</th>
						<th >价格</th>
						<th class="td4">操作</th>
					</tr>
					<s:iterator value="products" status="sta">
						<tr id="showtr${uuid}">
							<td class="td1">${uuid}</td>
							<td class="td3">${prod_code}</td>
							<td class="td1">${brand_name}</td>
							<td class="td2">${title}</td>
							<td class="td5">${spec}</td>
							<td class="caname" style="widit: 100px">${market_price}</td>
							<td class="td4 op-area"><a class="input-blue" href="<s:url namespace="/qkjmanage" action="product_load"><s:param name="viewFlag">mdy</s:param><s:param name="product.uuid" value="uuid"></s:param></s:url>">确认修改</a></td>
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
                td.html(newtxt);  
                td.css("color","red");
        })
    })
});
        
</script>
</body>
</html>