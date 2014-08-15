<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>出库--<s:text name="APP_NAME" /></title>
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
</head>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == outStock && 'add' == viewFlag">增加</s:if><s:elseif test="null != outStock && 'mdy' == viewFlag">修改</s:elseif>出库</span>
		<span class="extra1">
			<a href="<s:url action="outStock_list" namespace="/outStock" />" >出库列表</a>
		</span>	
	</div>
<s:form name="form1" action="outStock_add" namespace="/outStock" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
	<!-- 主表显示 -->
		<s:if test="null != outStock">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 出库单号:</td>
			<td class='secRow' colspan="3"><s:property value="outStock.ordernum" />
			<s:hidden name="outStock.lading_id"  title="出库单号" />
			<s:hidden name="outStock.uuid"></s:hidden>
			</td>
		  </tr>
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 出库时间:</td>
			<td class='secRow'><s:date name="outStock.date" format="yyyy-MM-dd" /><s:hidden name="outStock.date" title="出库时间" /></td>
			<td class='firstRow'>状态:</td>
			<td class='secRow'>
				<s:if test='0==outStock.send'>借出未还</s:if>
				<s:if test='1==outStock.send'>借出已还</s:if>
				<s:if test='2==outStock.send'>新单</s:if>
				<s:if test='3==outStock.send'>待审核</s:if>
				<s:if test='4==outStock.send'>结案-<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
			</td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span>经手人:</td>
		<td class='secRow'>
		<s:property value="outStock.operator_id" />
		<td class='firstRow'><span style="color:red;">*</span> 保管员:</td>
		<td class='secRow' colspan="3">
		<s:property value="outStock.take_id" />
		</tr>


		<s:if test="%{outStock.reason==0}"><!-- 销售出库，填加会员信息，要审核 -->
		<tr>
				<td class='firstRow'><span style="color:red;">*</span> 客户信息:</td>
				<td class='secRow' colspan="6">
				会员号:
				<s:textfield id="order_user_id" name="outStock.member_id" title="会员号" require="required" dataLength="0,85" controlName="会员号" />
				手机:
				<s:textfield id="order_user_mobile" name="outStock.member_mebile"  title="手机" controlName="手机" />
				姓名:
				<s:textfield id="order_user_name" name="outStock.member_name" title="姓名" controlName="姓名" />
				</td>
				</tr>
				<tr>
				<td class='firstRow'>配送地点:</td>
				<td class='secRow' colspan="6">
				<s:textarea id="address" name="outStock.member_adress" title="配送地点" cssStyle="width:80%;" rows="2" require="required" controlName="配送地点"></s:textarea>
				<br />
				选择预设地址:<select id="selectAddress"></select>
				</td>
				</tr>
		</s:if>
		<s:elseif test="%{outStock.reason==3}"><!-- 报损出库，不审核，自动入库到报损库 -->
			<tr>
				<td class='firstRow'><span style="color:red;">*</span> 报损原因:</td>
				<td class='secRow' colspan="3">
				<s:textarea id="note" name="outStock.note" title="内容" cssStyle="width:80%;" rows="4" require="required" controlName="内容"></s:textarea>
			</tr>
		</s:elseif>
		<s:else><!-- 其它出库，不审核，但要 填写目的地，收货人，联系方式，基本费用-->
			<tr>
				<td class='firstRow'><span style="color:red;">*</span> 出库信息:</td>
				<td class='secRow' colspan="3">
				收货人:
				<s:textfield id="order_user_name" name="outStock.member_name" title="姓名" controlName="姓名" />
				联系方式 :
				<s:textfield id="order_user_mobile" name="outStock.member_mebile" title="手机" controlName="手机" />
				基本费用:
				<s:textfield id="order_price" name="outStock.member_price" title="基本费用" controlName="基本费用" />
				</td>
				</tr>
				<tr>
				<td class='firstRow'>配送地点:</td>
				<td class='secRow' colspan="3">
				<s:textarea id="address" name="outStock.member_adress" title="配送地点" cssStyle="width:80%;" rows="2" require="required" controlName="配送地点"></s:textarea>
				</td>
			</tr>
		
		</s:else>
		<tr>
		<td colspan="20" class="buttonarea">
				<s:if test="null == outStock && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_OUTSTOCK_OUTSTOCK_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="outStock_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != outStock && 'mdy' == viewFlag">
					<s:hidden name="outStock.reason"/>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_OUTSTOCK_OUTSTOCK_MDY')">
					<s:submit id="save" name="save" value="下一步" action="outStock_sale" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_OUTSTOCK_OUTSTOCK_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="outStock_del" onclick="return isDel();" />
					</s:if>
					</s:if>
					
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="outStock_list" namespace="/outStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
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
			$(":input[name='outStock.member_adress']").val(sh);
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