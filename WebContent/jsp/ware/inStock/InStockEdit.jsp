<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>入库管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == inStock && 'add' == viewFlag">增加</s:if><s:elseif test="null != inStock && 'mdy' == viewFlag">修改</s:elseif>入库</span>
		<span class="extra1">
			<a href="<s:url action="inStock_list" namespace="/inStock" />" >入库列表</a>
		</span>	
	</div>
<s:form name="form1" action="inStock_add" namespace="/inStock" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != inStock">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
			<td class='secRow'><s:property value="inStock.uuid" /><s:hidden name="inStock.uuid" title="主键ID" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 入库时间:</td>
			<td class='secRow'><s:date name="inStock.date" format="yyyy-MM-dd" /><s:hidden name="inStock.date" title="入库时间" /></td>
		</tr>
		</s:if>
		<s:else>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 入库时间:</td>
			<td class='secRow'>
			<s:textfield id="indate" name="inStock.date" title="入库时间"  controlName="入库时间"/>
			<script type="text/javascript">$("#indate").datepicker();</script>
			</td>
		</tr>
		</s:else>
		  
<tr>
<td class='firstRow'><span style="color:red;">*</span>经手人:</td>
<td class='secRow'><s:textfield name="inStock.operator_id" title="经手人" require="required"  controlName="经手人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 保管员:</td>
<td class='secRow'><s:textfield name="inStock.take_id" title="旧值" require="required" controlName="保管员" /></td>
</tr>
<tr>
	<td class='firstRow'><span style="color:red;">*</span> 状态:</td>
	<td class='secRow'>
			<select name="inStock.reason" title="状态">
					<option value="0"
					<s:if test="%{inStock.reason==0}">
					 selected="selected"
					</s:if>
					>正常入库</option>
					<option value="1"
					 <s:if test="%{inStock.reason==1}">
					 selected="selected"
					</s:if>
					>好货退</option>
					<option value="2" 
					<s:if test="%{inStock.reason==2 }">
					selected="selected"
					</s:if>
					>坏货退</option>
			</select>
	</td>
</tr>
<tr>
	<td class='firstRow'><span style="color:red;">*</span> 入库仓库:</td>
	<td class='secRow'>
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
	<td class='secRow'>
	<s:textarea name="inStock.note" title="入库原因" cssStyle="width:80%;" rows="4" require="required" controlName="入库原因"></s:textarea>
</tr>

<s:if test="null != inStock">
<tr>
<td class='firstRow'>入库明细:
	<%-- <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INSTOCK_INSTOCK_ADD') && inStock.status==0"> --%>
	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INSTOCK_INSTOCK_ADD')">
	<br />
	<input id="addItem" type="button" value="添加明细" />
	</s:if>
</td>
<td class='secRow' colspan="3">
<table class="ilisttable" id="table_item" width="100%">
  <tr>
    <th>主键编号</th>
	<th>产品名称</th>
	<th>单价</th>
	<th>订单数量</th>
	<th>实际价格</th>
	<th>操作</th>
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
	<td align="center">
   	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INDETAIL_INDETAIL_DEL')">
   	[<a href="<s:url namespace="/inStock" action="inDetail_del"><s:param name="inDetail.uuid" value="uuid" /><s:param name="inDetail.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
   	</s:if>	   
    </td>
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
</s:if>
		<tr>
		<td colspan="20" class="buttonarea">
				<s:if test="null == inStock && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INSTOCK_INSTOCK_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="inStock_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != inStock && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INSTOCK_INSTOCK_MDY') && null==inStock.confirm">
					<s:submit id="save" name="save" value="保存" action="inStock_save" />
					<s:submit value="确认" action="inStock_sure" onclick="return isOp('是否确认?\n确认后将不能更改!');"></s:submit>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INSTOCK_INSTOCK_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="inStock_del" onclick="return isDel();" />
					</s:if>
					<script type="text/javascript">
					$(function(){
						$("#formEdit :input").change(function(){
							if($("#saveinStockStatus0").length>0)
								$("#saveinStockStatus0").attr("disabled","disabled");
							if($("#saveinStockStatus1").length>0)
								$("#saveinStockStatus1").attr("disabled","disabled");
							$("#message").text("请先保存后才能进行其他相关操作");
						});
					});
					</script>
					</s:if>
					
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="inStock_list" namespace="/inStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
			</td>
		    
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>

<div id="addItemForm" title="添加明细">
<s:form id="form_addItem" name="form_addItem" action="inDetail_add" namespace="/inDetail" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 产品:</td>
			<td class='secRow'>
			<select name="inDetail.product_id" title="产品">
				<option>--请选择--</option>
				<s:iterator value="products" status="sta">
				<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />' value='<s:property value="uuid" />'><s:property value="title" /></option>
				</s:iterator>
			</select>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>单价:</td>
			<td class='secRow'>
				<s:textfield name="inDetail.price" title="单价" dataType="number" controlName="单价" require="required" />
				<span id="per_price_select_area"><select id="per_price_select"></select></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>数量:</td>
			<td class='secRow'>
				<s:textfield name="inDetail.num" title="数量" dataType="integer" controlName="数量" require="required" />
				<span id="ladingItemnumCase"></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>合计:</td>
			<td class='secRow'><s:textfield name="inDetail.total" title="合计" dataType="number" controlName="合计" require="required" /></td>
			</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
				<s:hidden name="inDetail.lading_id" title="提货单ID" value="%{inStock.uuid}" />
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INSTOCK_INSTOCK_ADD')">
				<s:submit id="add" name="add" value="确定" action="inDetail_add" />
				</s:if>
				<input type="button" value="关闭" onclick="closeAddForm();" />
			</td>
	    </tr>
	</table>	
</s:form>
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