<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>盘点管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>盘点</span>
		<span class="extra1">
			<a href="<s:url action="check_list" namespace="/check" />" >盘点列表</a>
		</span>	
	</div>
<s:form name="form1" action="check_add" namespace="/check" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != check">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
		<td class='secRow'><s:property value="check.uuid" /><s:hidden name="check.uuid" title="主键ID" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 商品名称:</td>
		<td class='secRow'><s:property value="check.product_name" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 所在仓库:</td>
		<td class='secRow'><s:property value="check.ware_name" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 库存数量:</td>
		<td class='secRow'><s:property value="check.quantity" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 相差数量:</td>
		<td class='secRow'><s:textfield name="check.num"></s:textfield></td>
		</tr>
		</s:if>
		<s:else>
		<tr>
		    <th>商品名称</th>
		    <th>所在仓库</th>
			<th>库存</th>
			<th>变动数量</th>
	  	</tr>
	  	<s:iterator value="stocks" status="sta">
		  <tr>
		    <td>
		    	<s:property value="product_name" />
		    	<s:hidden name="pageStocks[%{#sta.index}].uuid" value="%{uuid}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].product_id" value="%{product_id}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].store_id" value="%{store_id}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].quantity" value="%{quantity}" />
		    </td>
			<td><s:property value="store_name" /></td>
			<td><s:property value="quantity" /></td>
			<td><s:textfield name="pageStocks[%{#sta.index}].cnum" value="0"></s:textfield></td>
		  </tr>
		</s:iterator>
		</s:else>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_ADD')">
					<s:submit id="add" name="add" value="确定" action="check_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_MDY')">
					<s:submit id="save" name="save" value="保存"  action="check_save"  />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="check_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="check_relist" namespace="/check" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
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
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addItem").click(function() {
		openAddForm();
	});
	
	$("#addoutStockPay").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addoutStockPayOpen").click(function() {
		$("#addoutStockPay").dialog("open");
	});
	
	//outStock_fd_date
	if($("#outStock_fd_date").length>0) {
		$("#outStock_fd_date").datepicker();
	}
	
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

function loadAddress(memberid) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		createAddreeeSelect(data);
	};
	ajax.addParameter("privilege_id", "QKJCJ_SYSEBIZ_AJAXLOAD_ADDRESS");
	ajax.addParameter("parameters", "member_id=" + memberid);
	ajax.sendAjax();
}

var c_data=new Array(); // 保存当前用户的所有联系人信息
function createAddreeeSelect(p_data) {
	var selectid = $("#selectAddress");
	selectid.clearAllOption();
	var sh = "";
	for ( var i = 0; i < p_data.length; i++) {
		selectid.addOption(i+"-"+ p_data[i].province,i);
		sh += p_data[i].province + " " + p_data[i].city + " " + p_data[i].area + " " + p_data[i].street + "  " 
			+ p_data[i].con_name + ' 收  邮编:' + p_data[i].post + ' 联系电话:' + p_data[i].mobile;
		if (p_data[i].defaultaddress == 1) {
			$(":input[name='outStock.address']").val(sh);
			selectid.setSelectedValue(i);
		}
		c_data[i] = sh;
		sh="";
	}
	selectid.unbind().bind("change",function(){
		$(":input[name='outStock.address']").val(c_data[$(this).getSelectedValue()]);
	});
}

function openAddForm() {
	$("#addItemForm").dialog("open");
}

function closeAddForm() {
	$("#addItemForm").dialog("close");
}

//当前日期
function wol() {
	var date = new Date();
	var dateString = date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
			+ date.getDate();
		document.getElementById("indate").value=dateString;
}
</script>
</html>