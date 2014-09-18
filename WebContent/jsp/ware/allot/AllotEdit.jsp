<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调库管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == allot && 'add' == viewFlag">增加</s:if><s:elseif test="null != allot && 'mdy' == viewFlag">修改</s:elseif>调库</span>
		<span class="extra1">
			<a href="<s:url action="allot_list" namespace="/allot" />" >调库列表</a>
		</span>	
	</div>
<s:form id="form1" name="form1" action="allot_add" namespace="/allot" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<tr>
			  <td class='firstRow'><span style="color:red;">*</span> 单据号:</td>
			  <td class='secRow' colspan="3">
					<s:textfield name="allot.ordernum" title="单据号"  rows="4" require="required" controlName="单据号"></s:textfield>
			  </td>
		</tr>
		<s:if test="null != allot">
		  <tr>
		<td class='firstRow'><span style="color:red;">*</span> 主键自增:</td>
		<td class='secRow' colspan="3"><s:property value="allot.uuid" /><s:hidden name="allot.uuid" title="主键自增" /></td>
		</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 状态:</td>
<td class='secRow' colspan="3">
		<s:if test="%{allot.state==0}"><font color="red">（未发货）</font></s:if>
	    <s:if test="%{allot.state==1}"><font color="red">（已发货）</font></s:if>
	    <s:if test="%{allot.state==2}"><font color="red">（取消发货）</font></s:if>
	    <s:if test="%{allot.state==3}"><font color="red">（已收货）</font></s:if>
</td>
</tr>
<tr>
		<td class='firstRow'><span style="color:red;">*</span> 调库日期:</td>
		<td class='secRow' colspan="3">
		<s:date name="allot.date" format="yyyy-MM-dd" /><s:hidden name="allot.date" title="入库时间" />
		</td>
</tr>
		</s:if>
		<s:else>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 调库日期:</td>
		<td class='secRow' colspan="3">
		<s:textfield id="indate" name="allot.date" title="调库时间" controlName="调库时间" />
		<script type="text/javascript">$("#indate").datepicker();</script>
		</td>
		</tr>
		</s:else>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 调出仓库:</td>
<td class='secRow' colspan="3">
	<select id="allot.sourceid" name="allot.sourceid" title="调出仓库" >
					
					<s:iterator value="warepowers" status="sta" var="x">
					<option value="<s:property value="uuid" />" 
					<s:if test="#x.uuid==allot.sourceid">
					selected="selected"
					</s:if>
					/><s:property value="ware_name" />
					</s:iterator>
			</select>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 调入仓库:</td>
<td class='secRow' colspan="3">
	<select id="allot.goldid" name="allot.goldid" title="调入仓库" >
					
					<s:iterator value="wares" status="sta" var="x">
					<option value="<s:property value="uuid" />" 
					<s:if test="#x.uuid==allot.goldid">
					selected="selected"
					</s:if>
					/><s:property value="ware_name" />
					</s:iterator>
	</select>
</tr>

<tr>
<td class='firstRow' >其它说明:</td>
<td class='secRow' colspan="3">
<s:textarea name="allot.note" title="其它说明" cssStyle="width:80%;" rows="4"></s:textarea>
</td>
</tr>


<s:if test="null != allot">
<tr>
<td class='firstRow'>调库明细:
	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_ADD') && allot.state==0 && @com.qkj.ware.action.warepower@checkPermit(sourceId,'edit')">
	<br />
	<input id="addItem" type="button" value="添加明细" />
	</s:if>
</td>
<td class='secRow' colspan="3">
<table class="ilisttable" id="table_item" width="100%">
  <tr>
    <th>主键</th>
	<th>产品名称</th>
	<th>调库数量</th>
	<s:if test="%{allot.state==0||allot.state==2}">
	<th>操作</th>
	</s:if>
  </tr>
<s:iterator value="allotDetails" status="sta">
  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
    <td align="center"><s:property value="uuid" /></td>
	<td><s:property value="product_name" /></td>
	<td align="center">
		<s:property value="num" />(<s:property value="num/(case_spec*1.0)" /> 件)
	</td>
	<s:if test="%{allot.state==0||allot.state==2}">
	<td align="center">
   	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_DEL')">
   	[<a href="<s:url namespace="/allot" action="allotDetail_del"><s:param name="allotDetail.uuid" value="uuid" /><s:param name="allotDetail.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
   	</s:if>	   
    </td>
    </s:if>
  </tr>
</s:iterator>
</table>
</td>
</tr>
	<tr>
		<td class='firstRow'>添加人:</td>
		<td class='secRow'><s:property value="allot.add_user_name" /></td>
		<td class='firstRow'>添加时间:</td>
		<td class='secRow'><s:date name="allot.add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'>最后修改人:</td>
		<td class='secRow'><s:property value="allot.lm_user_name" /></td>
		<td class='firstRow'>最后修改时间:</td>
		<td class='secRow'><s:date name="allot.lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	
</s:if>


		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == allot && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="allot_add" onclick="return xt();"/>
					</s:if>
				</s:if>
				<s:elseif test="null != allot && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkPermit(sourceId,'edit')">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_MDY')">
					<s:if test="%{allot.state==0||allot.state==2}">
					<s:submit id="save" name="save" value="保存" action="allot_save" onclick="return xt();"/>
					<s:if test="%{allotDetails.size>0}">
					<s:submit id="freeze" name="freeze" value="发货" action="allot_freeze" onclick="return isOp('是否确认发货?\n发货后将不能更改!');"></s:submit>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_DEL') && (allot.state==0||allot.state==2)">
					<s:submit id="delete" name="delete" value="删除" action="allot_del" onclick="return isDel();" />
					</s:if>
					</s:if>
					</s:if>
					
					<s:if test="%{allot.state==1}">
					<s:submit id="freeze" name="freeze" value="取消发货" action="allot_cancel" onclick="return isOp('确认取消发货?');"></s:submit>
					</s:if>
					
					<s:if test="%{allot.state==1}">
					<s:submit id="freeze" name="freeze" value="确认收货" onclick="return isOp('确认收货?');" action="allot_delivery"></s:submit>
					</s:if>
					
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="allot_relist" namespace="/allot" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>

<div id="addItemForm" title="添加明细">
<s:form id="form_addItem" name="form_addItem" action="allotDetail_add" namespace="/allot" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 产品:</td>
			<td class='secRow'>
			<select name="allotDetail.stock_id" title="产品">
				<option>--请选择--</option>
				<s:iterator value="stocks" status="sta">
				<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />' value='<s:property value="uuid" />'><s:property value="product_name" /></option>
				</s:iterator>
			</select>
			</td>
			</tr>
			<tr>
			
			<td class='firstRow'>数量:</td>
			<td class='secRow'>
				<s:textfield name="allotDetail.num" title="数量" dataType="integer" controlName="数量" require="required" />
				<span id="ladingItemnumCase"></span>
			</td>
			</tr>
			
			
		<tr>
		    <td colspan="20" class="buttonarea">
				<s:hidden name="allotDetail.lading_id" title="调货单ID" value="%{allot.ordernum}" />
				<s:hidden name="allotDetail.goldId" title="调入仓库" value="%{allot.goldid}"></s:hidden>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_ADD')">
				<s:submit id="add" name="add" value="确定" action="allotDetail_add" />
				</s:if>
				<input type="button" value="关闭" onclick="closeAddForm();" />
			</td>
	    </tr>
	</table>	
</s:form>
</div>
<script type="text/javascript">
function xt(){
	var source=document.getElementById('allot.sourceid').value;
	var gold=document.getElementById('allot.goldid').value;
	if(source==gold){
		alert("调入仓库调出仓库不能一致！");
		return false;
	}
}
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var c_mid = '<s:property value="lading.member_id" />';
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
	
	$("#addLadingPay").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addLadingPayOpen").click(function() {
		$("#addLadingPay").dialog("open");
	});
	
	//lading_fd_date
	if($("#lading_fd_date").length>0) {
		$("#lading_fd_date").datepicker();
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
			$(":input[name='lading.address']").val(sh);
			selectid.setSelectedValue(i);
		}
		c_data[i] = sh;
		sh="";
	}
	selectid.unbind().bind("change",function(){
		$(":input[name='lading.address']").val(c_data[$(this).getSelectedValue()]);
	});
}

function openAddForm() {
	$("#addItemForm").dialog("open");
}

function closeAddForm() {
	$("#addItemForm").dialog("close");
}
</script>
<script type="text/javascript">
//当前日期
function wol() {
	var date = new Date();
	var dateString = date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
			+ date.getDate();
		document.getElementById("indate").value=dateString;
}

var add_per_price_input = $("#form_addItem :input[name='allotDetail.price']");
var add_num_input = $("#form_addItem :input[name='allotDetail.num']");
var add_total_price_input = $("#form_addItem :input[name='allotDetail.total']");
var add_product_id = $("#form_addItem :input[name='allotDetail.stock_id']");

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