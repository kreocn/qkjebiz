<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>盘点列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true"/>
</head>
<style type='text/css'>
@media screen{.printhide{display:block}} 
@media print{.printhide{display:none}}
</style>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_ADD')">
			<span class="opb lb op-area printhide">
			<a id="addItem" onclick="commain();" >添加盘点</a>
			</span>
		</s:if>
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="check_list"  method="get" namespace="/check" theme="simple">
		<div class="label_con printhide">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">商品:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="check.product_id" title="商品" headerKey="" headerValue="--请选择--" list="products" listKey="uuid" listValue="title" />
            	</div>
       		</div>
        	<div class="label_hang">
            <div class="label_ltit">盘点仓库:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="check.store_id" title="仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">盘点日期:</div>
            <div class="label_rwben label_rwb">
            	<select id="membermanagerid" cssClass="selectKick" name="check.date" title="盘点日期" >
						<s:iterator value="checkDates" status="sta" var="x">
						<option value="<s:property value="date" />" /><s:date name="date" format="yyyy-MM-dd" />
						</s:iterator>
				</select>
            </div>
        	</div>
        	
        	<div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        	</div>
        
		</div>
		</div>
	</s:form>
	
	<!-- 列表 -->
	<div class="tab_warp">
 		<table>
 		<tr id="coltr">
		<th class="td1">编号</th>
		<th class="td2">盘点仓库</th>
	    <th class="td1">商品名称</th>
	    <th class="td2">盘点日期</th>
		<th class="td1">库存</th>
		<th class="td1">差异数量</th>
		<th class="td2">招待用酒</th>
		<th class="td2">赠酒</th>
		<th class="td3">报损</th>
		<th class="td3">借酒</th>
		<th class="td3">其它</th>
		<th class="td4"><div class="printhide">操作</div></th>
		
		<th class="td0">查看</th>
		 
	  	</tr>
	  	<s:iterator value="checks" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw"><s:property value="uuid" /></td>
	  			<td class="td2 nw"><s:property value="ware_name" /></td>
			    <td class="td1 nw"><s:property value="product_name" /></td>
			    <td class="td2 nw"><s:date name="date" format="yyyy-MM-dd" /></td>
				<td class="td1 nw"><s:property value="quantity" /></td>
				<td class="td1 nw"><s:property value="num" /></td>
				<td class="td2 nw"><s:property value="zdnum"></s:property></td>
				<td class="td2 nw"><s:property value="znum"></s:property></td>
				<td class="td3 nw"><s:property value="snum"></s:property></td>
				<td class="td3 nw"><s:property value="jnum"></s:property></td>
				<td class="td3 nw"><s:property value="qnum"></s:property></td>
				
				
				<td class="td4 op-area">
				<div class="printhide">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_MDY')">
			    	<a class="input-blue" href="<s:url namespace="/check" action="check_load"><s:param name="viewFlag">mdy</s:param><s:param name="check.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:if>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_DEL')">
			    	<a class="input-red" href="<s:url namespace="/check" action="check_del"><s:param name="check.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>	
			    </div>   
			    </td>
				<td class="td0 op-area"><div class="printhide"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></div></td>
				
	  		</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div class="pagination printhide">
		<input class="input-gray" type="button" onclick="window.print();" value="打印本页"/>
	</div>
 	<!--盘点仓库 -->
<div id="addItemForm" title="选择盘点仓库">
<s:form id="form_addItem" name="form_addItem" action="check_load" namespace="/check" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="input-a">
		  <tr>
		   	<td>
				<div id="addItemForm" class="label_con" title="请选择盘点仓库">																			
					<div class="label_hang">																		
			            <div class="label_ltit">盘点仓库:</div>																				
			            <div class="label_rwben label_rwb">													
			            	<s:select id="membermanagerid" cssClass="selectKick" name="check.store_id" title="仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />																
			            </div>																				
			        </div>																				
			        <div class="label_hang label_button tac">																				
			           <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_ADD')">																				
							<s:submit id="add" name="add" value="确定" class="input-blue"  />																
							</s:if>																
							<input type="button" value="关闭" onclick="closeAddForm();" class="input-gray" />																
			        </div>																				
				</div>
			</td>
		 	</tr>
		
	</table>	
	<s:hidden name="viewFlag" value="add" />
</s:form>
</div>

<div class="hidden_area">
	<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
	</div>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>

<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var c_mid = '<s:property value="outStock.member_id" />';
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id);});
	if(c_mid!='') {
		loadAddress(c_mid);
	}
	$("#addItemForm").dialog({
	      autoOpen: false,
	      height: 150,
	      width: 300,
	      modal: true
	});
	$("#addItem").click(function() {
		openAddForm();
	});
	// 此段代码可以方式回车提交
	jQuery(function($){
	    $("form").keypress(function(e){
	        if(e.keyCode == 13) {
	            e.preventDefault();
	        }
	    });  
	});
	
	CommonUtil.pickrow('fd_list_table');
});



function openAddForm() {
	$("#addItemForm").dialog("open");
}

function closeAddForm() {
	$("#addItemForm").dialog("close");
}

</script>
</html>