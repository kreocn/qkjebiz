<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>出库管理--<s:text name="APP_NAME" /></title>
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

<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
</head>
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
			  <td class='firstRow'>单据号:</td>
			  <td class='secRow' colspan="3">
					<s:textfield name="outStock.ordernum" title="单据号"  rows="4"></s:textfield>
			  </td>
			<s:hidden name="outStock.uuid"></s:hidden>
			<s:hidden name="outStock.send"></s:hidden>
			<s:hidden name="outDetail.lading_id"  title="出库单号" />
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
				<s:if test='5==outStock.send'>已取消订单</s:if>
				<s:if test='6==outStock.send'><span class="message_error">未返利</span></s:if><s:if test='1==lading.rebates_flag'><span class="message_pass">返利中</span></s:if><s:if test='2==lading.rebates_flag'>已返利</s:if>
			</td>
		</tr>
		
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 单据性质:</td>
			<td class='secRow'>
			<s:hidden name="outStock.reason" value="%{outStock.reason}"></s:hidden>
					<s:if test="%{outStock.reason==0}">销售出库
					</s:if>
					 <s:if test="%{outStock.reason==1}">招待用酒
					</s:if>
					
					<s:if test="%{outStock.reason==3 }">报损
					</s:if>
					<s:if test="%{outStock.reason==4 }">赠酒
					</s:if>
					<s:if test="%{outStock.reason==5 }">其它
					</s:if>
			</td>
			<td class='firstRow'><span style="color:red;">*</span> 出库仓库:</td>
			<td class='secRow' colspan="3">
					<select name="outStock.store_id" title="出库仓库" >
							
							<s:iterator value="wares" status="sta" var="x">
							<option value="<s:property value="uuid" />" 
							<s:if test="#x.uuid==outStock.store_id">
							selected="selected"
							</s:if>
							/><s:property value="ware_name" />
							</s:iterator>
					</select>
			</td>
		</tr>
		</s:if>
		
		<s:else>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 单据性质:</td>
			<td class='secRow'>
					<select name="outStock.reason" title="状态">
							<option value="0"
							<s:if test="%{outStock.reason==0}">
							 selected="selected"
							</s:if>
							>销售出库</option>
							<option value="1"
							 <s:if test="%{outStock.reason==1}">
							 selected="selected"
							</s:if>
							>招待用酒</option>
							
							<option value="3" 
							<s:if test="%{outStock.reason==3 }">
							selected="selected"
							</s:if>
							>报损</option>
							<option value="4" 
							<s:if test="%{outStock.reason==4 }">
							selected="selected"
							</s:if>
							>赠酒</option>
							<option value="5" 
							<s:if test="%{outStock.reason==5 }">
							selected="selected"
							</s:if>
							>其它</option>
					</select>
			</td>
			<td class='firstRow'><span style="color:red;">*</span> 出库仓库:</td>
			<td class='secRow' colspan="3">
					<select name="outStock.store_id" title="出库仓库" >
							
							<s:iterator value="wares" status="sta" var="x">
							<option value="<s:property value="uuid" />" 
							<s:if test="#x.uuid==outStock.store_id">
							selected="selected"
							</s:if>
							/><s:property value="ware_name" />
							</s:iterator>
					</select>
			</td>
		</tr>
		
		</s:else>
		
		
		

<tr>
	<td class='firstRow'>其它说明:<br />
	<s:submit value="修改说明" action="outStock_note"></s:submit>
	<td class='secRow' colspan="6">
	<s:textarea name="outStock.note" title="其它说明" cssStyle="width:80%;" rows="4"></s:textarea>
</tr>

<s:if test="%{outStock.reason==3}"><!-- 报损出库，不审核，自动入库到报损库 -->
	<tr>
		<td class='firstRow'><span style="color:red;">*</span> 报损原因:</td>
		<td class='secRow' colspan="3">
		<s:textarea id="bsreason" name="outStock.bsreason" title="内容" cssStyle="width:80%;" rows="4" require="required" controlName="报损原因"></s:textarea>
	</tr>
</s:if>
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

						
						
						
						
<s:if test="null != outStock">
<tr>
<td class='firstRow'>出库明细:
	<%-- <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_outStock_ADD') && outStock.status==0"> --%>
	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD') && 2==outStock.send && @com.qkj.ware.action.warepower@checkPermit(outStock.store_id,'del')">
	<br />
	<input id="addItem" type="button" value="添加明细" onclick="commain();"/>
	</s:if>
</td>
<td class='secRow' colspan="6">
<table class="ilisttable" id="table_item" width="100%">
  <tr>
    <th>编号</th>
	<th>产品名称</th>
	<th>单价</th>
	<th>订单数量</th>
	<th>实际价格</th>
	<s:if test="2==outStock.send">
	<th>操作</th>
	</s:if>
  </tr>
<s:iterator value="outDetails" status="sta">
  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
    <td align="center"><s:property value="uuid" /></td>
	<td><s:property value="product_name" /></td>
	<td align="right"><s:property value="price" /></td>
	<td align="center">
		<s:property value="num" />(<s:property value="%{(num/(case_spec*1.0)).toString().substring(0,3)}" />件)
	</td>
	<td align="right"><s:property value="totel" /></td>
	<td align="center">
   	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_DEL') && 2==outStock.send && @com.qkj.ware.action.warepower@checkPermit(outStock.store_id,'del')">
   	[<a href="<s:url namespace="/outStock" action="outDetail_del"><s:param name="outDetail.uuid" value="uuid" /><s:param name="outDetail.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
   	</s:if>	   
    </td>
  </tr>
</s:iterator>
	<tr>
	<td></td><td></td><td></td>
	<td align="right">总计:</td>
	<td align="right"><s:property value="outStock.total_price" /></td>
	<td></td>
	</tr>
	<s:if test="%{message!=null&&message==1}">
			<tr>
			<td align="center" colspan="6"><font color="red">库存不足！</font></td>
			</tr>
			</s:if>
</table>
</td>
</tr>
	<tr>
		<td class='firstRow'>添加人:</td>
		<td class='secRow'><s:property value="outStock.add_user_name" /></td>
		<td class='firstRow'>添加时间:</td>
		<td class='secRow' colspan="3"><s:date name="outStock.add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'>最后修改人:</td>
		<td class='secRow'><s:property value="outStock.lm_user_name" /></td>
		<td class='firstRow'>最后修改时间:</td>
		<td class='secRow' colspan="3"><s:date name="outStock.lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	<s:if test="%{outStock.manager_check!=null}">
	<tr>
		<td class='firstRow'>确认人/经手人:</td>
		<td class='secRow'><s:property value="outStock.manager_check_user_name" /></td>
		<td class='firstRow'>确认时间:</td>
		<td class='secRow'><s:date name="outStock.manager_check_time" format="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	</s:if>
</s:if>
		<tr>
		<td colspan="20" class="buttonarea">
				<s:if test="null == outStock && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="outStock_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != outStock && 'mdy' == viewFlag && outDetails!=null && @com.qkj.ware.action.warepower@checkPermit(outStock.store_id,'del')">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_MDY') && 2==outStock.send">
					<s:submit id="save" name="save" value="保存" action="outStock_save" />
					</s:if>
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_SURE') && 2==outStock.send">
					<s:submit value="经手人确认" action="outStock_sure" onclick="return isOp('是否确认?\n确认后将不能更改!');"></s:submit>
					</s:if>
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_DEL') && 2==outStock.send">
					<s:submit id="delete" name="delete" value="删除" action="outStock_del" onclick="return isDel();" />
					</s:if>
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_CENCLE') && 4==outStock.send && outStock.reason!=2">
					<s:submit id="cencle" name="cencle" value="取消订单" action="outStock_cencle" onclick="return isOp('确认取消?');" />
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

<div id="addItemForm" title="添加明细">
<s:form id="form_addItem" name="form_addItem" action="outDetail_add" namespace="/outDetail" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 产品:</td>
			<td class='secRow'>
			<s:hidden id="member_id" name="mid"></s:hidden>
			<s:hidden id="member_mebile" name="mmebile"></s:hidden>
			<s:hidden id="member_name" name="mname"></s:hidden>
			<s:hidden id="member_adress" name="madress"></s:hidden>
			<s:hidden id="member_price" name="mprice"></s:hidden>
			<select name="outDetail.product_id" title="产品">
				<option>--请选择--</option>
				<s:iterator value="stocks" status="sta">
				<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />' value='<s:property value="uuid" />'><s:property value="product_name" /></option>
				</s:iterator>
			</select>
			</td>
			</tr>
			<tr>
			<td class='firstRow'><span style="color:red;">*</span>单价:</td>
			<td class='secRow'>
				<s:textfield name="outDetail.price" title="单价" dataType="number" controlName="单价" require="required" />
				<span id="per_price_select_area"><select id="per_price_select"></select></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'><span style="color:red;">*</span>数量:</td>
			<td class='secRow'>
				<s:textfield name="outDetail.num" title="数量" dataType="integer" controlName="数量" require="required" />
				<span id="ladingItemnumCase"></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>合计:</td>
			<td class='secRow'>
			<s:textfield name="outDetail.totel" title="合计"/>
			</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
				<s:hidden name="outDetail.lading_id" title="提货单ID" value="%{outStock.uuid}" />
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
				<s:submit id="add" name="add" value="确定" action="outDetail_add" />
				</s:if>
				<input type="button" value="关闭" onclick="closeAddForm();" />
			</td>
	    </tr>
	</table>	
</s:form>
</div>
<script type="text/javascript">
function commain(){
	var id=$("#order_user_id").val();
	var mebile=$("#order_user_mobile").val();
	var name=$("#order_user_name").val();
	var address=$("#address").val();
	var price=$("#order_price").val();
	
	$("#member_id").val(id);
	$("#member_mebile").val(mebile);
	$("#member_name").val(name);
	$("#member_adress").val(address);
	$("#member_price").val(price);
	
}
var add_per_price_input = $("#form_addItem :input[name='outDetail.price']");
var add_num_input = $("#form_addItem :input[name='outDetail.num']");
var add_total_price_input = $("#form_addItem :input[name='outDetail.totel']");
var add_product_id = $("#form_addItem :input[name='outDetail.product_id']");

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
<script type="text/javascript">

var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_apply_dept = '${leave.leave_dept}';
var curr_apply_user = '${leave.leave_user}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	if(curr_apply_dept!='') {
		loadManagers(curr_apply_dept);
	}
	
	$("#AddLeaveForm").dialog({
	      autoOpen: false,
	      width: 300,
	      height: 100,
	      modal: true
	});
	
	$("#AddLeaveLink").click(function(){
		$("#AddLeaveForm").dialog("open");
	});
	
	showLeaveMold(${leave.leave_type});
	$("#searchLeaveType").change(function(){
		showLeaveMold($(this).val());
	});
	
	$(".leave_cause_show").tooltip({
		items: "[data]",
		content: function() {
			//alert($(this).attr("data"));
			return "<div class='show_dialog'>" + $("#leave_cause" + $(this).attr("data")).html() + "</div>";
	  }
	});
});
 
var sobj01;
var selectDept = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_nameid").val(val2);
		loadManagers(val1);
	};
	sobj01.create();
	sobj01.open();
};

function loadManagers(dept_code) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#membermanagerid").clearAllOption();
		$("#membermanagerid").addOption("--请选择--","");
		$.each(data, function(i, n){
			$("#membermanagerid").addOption(n.user_name,n.uuid);
		});
		if(curr_apply_user!='') {
			$("#membermanagerid").val(curr_apply_user);
		}
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}

function addLeave(p_type) {
	var add_url = '<s:url namespace="/adm" action="leave_load"><s:param name="viewFlag">add</s:param></s:url>';
	add_url = add_url + "&leave.leave_type="+p_type;
	//alert(add_url);
	location.href = add_url;
}

function showCause(s_id) {
	alert($("#"+s_id).text());
}


</script>
</html>