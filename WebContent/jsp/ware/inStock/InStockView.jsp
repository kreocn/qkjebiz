<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>入库打印</title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var c_mid = '<s:property value="inStock.member_id" />';
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
	
	$("#addinStockPay").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addinStockPayOpen").click(function() {
		$("#addinStockPay").dialog("open");
	});
	
	//inStock_fd_date
	if($("#inStock_fd_date").length>0) {
		$("#inStock_fd_date").datepicker();
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
			$(":input[name='inStock.address']").val(sh);
			selectid.setSelectedValue(i);
		}
		c_data[i] = sh;
		sh="";
	}
	selectid.unbind().bind("change",function(){
		$(":input[name='inStock.address']").val(c_data[$(this).getSelectedValue()]);
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
<style type="text/css">
.confirm_td{text-align:center;padding:5px 0 0!important;}
.confirm_button{margin:auto;display:block;border:#333 solid 1px;border-radius:3px;font-size:28px;margin-bottom:5px;color:#333;}
a.confirm_button{width:100px;text-decoration:none;cursor:pointer;}
a.confirm_button:hover{background-color:#333;color:#FFF;}
.confirm_ok{line-height:50px;}
.confirm_cancel{line-height:35px;}
.confirmd{display:block;margin:auto;text-indent:-9999px;width:50px;height:50px;background:url(../images/icon/yesno_wb.png) transparent no-repeat;}
.confirmd_ok{background-position:-150px 0;}
.confirmd_cancel{background-position:-150px -150px;}
.fd_button{width:50px;height:50px;font-size:14px;border:#333 solid 1px;border-radius:5px;cursor:pointer;}
</style>

<body onload="wol();">
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
<<<<<<< HEAD
		<span class="title1"><s:if test="null == inStock && 'add' == viewFlag">增加</s:if><s:elseif test="null != inStock && 'mdy' == viewFlag">修改</s:elseif>入库单（No.<s:property value="inStock.ordernum" />）</span>
=======
		<span class="title1"><s:if test="null == inStock && 'add' == viewFlag">增加</s:if><s:elseif test="null != inStock && 'mdy' == viewFlag">修改</s:elseif>入库单（No.<s:property value="inStock.uuid" />）</span>
>>>>>>> ware
		
	</div>
<s:form name="form1" action="inStock_add" namespace="/inStock" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != inStock">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 单据号:</td>
			<td class='secRow' colspan="3"><s:property value="inStock.ordernum" /><s:hidden name="inStock.uuid" title="主键ID" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 入库时间:</td>
			<td class='secRow' colspan="3"><s:date name="inStock.date" format="yyyy-MM-dd" /><s:hidden name="inStock.date" title="入库时间" /></td>
		</tr>
		</s:if>
		<s:else>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 入库时间:</td>
			<td class='secRow' colspan="3">
			<s:textfield id="indate" name="inStock.date" title="入库时间"  controlName="入库时间"/>
			<script type="text/javascript">$("#indate").datepicker();</script>
			</td>
		</tr>
		</s:else>
		  
<tr>
<td class='firstRow'><span style="color:red;">*</span>经手人:</td>
<td class='secRow' colspan="3">
<s:property value="inStock.operator_name" />
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 保管员:</td>
<td class='secRow' colspan="3"><s:property value="inStock.take_name" /></td>
</tr>
<tr>
	<td class='firstRow'><span style="color:red;">*</span> 状态:</td>
	<td class='secRow' colspan="3">
		<s:if test="%{inStock.reason==0}">正常入库</s:if>
		<s:if test="%{inStock.reason==1}">正常退货</s:if>
		<s:if test="%{inStock.reason==2 }">损坏退货</s:if>
<<<<<<< HEAD
=======
		<s:if test="%{inStock.reason==3 }">其它</s:if>
>>>>>>> ware
	</td>
</tr>
<tr>
	<td class='firstRow'><span style="color:red;">*</span> 入库仓库:</td>
	<td class='secRow' colspan="3">
			<select name="inStock.store_id" title="入库仓库" >
					<s:iterator value="wares" status="sta" var="x">
					<option value="<s:property value="uuid" />" 
					<s:if test="#x.uuid==inStock.store_id">
					selected="selected"
					</s:if>
					/><s:property value="ware_name" />
					</s:iterator>
			</select>
	</td>
</tr>
<tr>
	<td class='firstRow'><span style="color:red;">*</span>入库原因:</td>
	<td class='secRow' colspan="3">
	<s:textarea name="inStock.note" title="入库原因" cssStyle="width:80%;" rows="4" require="required" controlName="入库原因"></s:textarea>
</tr>

<s:if test="null != inStock">
<tr>
<td class='firstRow'>入库明细:
</td>
<td class='secRow' colspan="3">
<table class="ilisttable" id="table_item" width="100%">
  <tr>
    <th>主键编号</th>
	<th>产品名称</th>
	<th>单价</th>
	<th>订单数量</th>
	<th>实际价格</th>
  </tr>
<s:iterator value="inDetails" status="sta">
  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
    <td align="center"><s:property value="uuid" /></td>
	<td><s:property value="product_name" /></td>
	<td align="right"><s:property value="price" /></td>
	<td align="center">
		<s:property value="num" />(<s:property value="num/(case_spec*1.0)" /> 件)
	</td>
	<td align="right"><s:property value="total" /></td>
	
  </tr>
</s:iterator>
	<tr>
	<td></td><td></td><td></td>
	<td align="right">总计:</td>
	<td align="right"><s:property value="inStock.total_price" /></td>
	<td></td>
	</tr>
</table>
</td>
</tr>
	<tr>
		<td class='firstRow'>添加人:</td>
		<td class='secRow'><s:property value="inStock.add_user_name" /></td>
		<td class='firstRow'>添加时间:</td>
		<td class='secRow'><s:date name="inStock.add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'>最后修改人:</td>
		<td class='secRow'><s:property value="inStock.lm_user_name" /></td>
		<td class='firstRow'>最后修改时间:</td>
		<td class='secRow'><s:date name="inStock.lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	
	<s:if test="%{inStock.conname!=null}">
	<tr>
		<td class='firstRow'>确认人:</td>
		<td class='secRow'><s:property value="inStock.conname_u" /></td>
		<td class='firstRow'>确认时间:</td>
		<td class='secRow'><s:date name="inStock.contime" format="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	</s:if>
</s:if>
		<tr>
		<td colspan="20" class="buttonarea">
		 <div class="printarea"><input type="button" onclick="window.print();" value="打印本页"/></div>		
		</td>
		    
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>

<script type="text/javascript">
var add_per_price_input = $("#form_addItem :input[name='inDetail.price']");
var add_num_input = $("#form_addItem :input[name='inDetail.num']");
var add_total_price_input = $("#form_addItem :input[name='inDetail.total']");
var add_product_id = $("#form_addItem :input[name='inDetail.product_id']");

$(function(){
	add_per_price_input.bind("keyup",function(){
		add_total_price_input.val($(this).val()*add_num_input.val());
		
	});
	add_num_input.bind("keyup",function(){
		add_total_price_input.val($(this).val()*add_per_price_input.val());
		setDataCase();
	});
	
	$("#per_price_select_area").hide();
	add_product_id.bind("change",function(){
		add_per_price_input.val("");
		$("#per_price_select").clearAllOption();
		if($(this).getSelectedAttr("data")==null || $(this).getSelectedAttr("data")=='') {
			$("#per_price_select_area").hide();
		} else {
			var ps = $(this).getSelectedAttr("data").split("#");
			if(ps.length>=3) {
				$("#per_price_select").addOption("自定义","");
				$("#per_price_select").addOption("市场价("+ps[0]+")",ps[0]);
				$("#per_price_select").addOption("团购价("+ps[1]+")",ps[1]);
				$("#per_price_select").addOption("出厂价("+ps[2]+")",ps[2]);
				if(ps[3]!='')$("#per_price_select").addOption("协议价1("+ps[3]+")",ps[3]);
				if(ps[4]!='')$("#per_price_select").addOption("协议价2("+ps[4]+")",ps[4]);
				if(ps[5]!='')$("#per_price_select").addOption("协议价3("+ps[5]+")",ps[5]);
				$("#per_price_select_area").fadeIn(1000);
			}
		}
	});
	
	$("#per_price_select").bind("change",function(){
		add_per_price_input.val($(this).val());
		add_total_price_input.val($(this).val()*add_num_input.val());
		setDataCase();
	});
});

function setDataCase() {
	var data_case = add_product_id.getSelectedAttr("data_case");
	var num_value = add_num_input.val();
	if(!(data_case==null || data_case=='' || num_value==null || num_value=='')) {
		$("#ladingItemnumCase").text((num_value/data_case)+'件');
	}
}
</script>
</body>
</html>