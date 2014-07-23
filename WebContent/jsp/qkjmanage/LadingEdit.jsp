<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库提货单管理--<s:text name="APP_NAME" /></title>
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
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == lading && 'add' == viewFlag">增加</s:if><s:elseif test="null != lading && 'mdy' == viewFlag">修改&审核</s:elseif>提货申请单</span>
		<span class="extra1">
			<a href="<s:url action="lading_list" namespace="/qkjmanage" />" >提货申请单列表</a>
		</span>	
	</div>
<s:form id="formEdit" name="form1" action="lading_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" >
		<span id="message"><s:property value="message" /></span>
	</div>
	<table class="ilisttable" width="100%">
		<s:if test="null != lading">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 申请编号:</td>
		<td class='secRow'>
			<s:property value="lading.uuid" />
			<s:hidden name="lading.uuid" />
		</td>
		<td class='firstRow'>状态:</td>
		<td class='secRow'>
			<s:if test='0==lading.status'>新单</s:if>
			<s:if test='1==lading.status'>待审核</s:if>
			<s:if test='2==lading.status'>结案-<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
			<s:if test='0==lading.out_flag'><span class="message_error">未出货</span></s:if><s:if test='1==lading.out_flag'>已出货</s:if>
			<s:if test='0==lading.rebates_flag'><span class="message_error">未返利</span></s:if><s:if test='1==lading.rebates_flag'><span class="message_pass">返利中</span></s:if><s:if test='2==lading.rebates_flag'>已返利</s:if>
		</td>
		</tr>
		</s:if>
		<s:if test="null!=lading && 1<=lading.status">
		<tr>
			<td class='firstRow'>确认表单:</td>
			<td class="tablearea" colspan="3">
			<table class="ilisttable" width="100%">
			<tr>
				<th style="width: 20%;">渠道/运营经理确认</th>
				<th style="width: 20%;">销售部经理确认</th>
				<th style="width: 20%;">市场部经理确认</th>
				<th style="width: 20%;">运营总监确认</th>
			</tr>
			<tr>
			<td class="confirm_td">
				<s:if test="0==lading.manager_check">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_MANAGERCHECK')">
				<a href='<s:url action="mdyLadingManagerCheck"><s:param name="lading.uuid" value="lading.uuid" /></s:url>' class="confirm_button confirm_ok" onclick="return isOp('是否通过审核?\n审核操作不能取消!');">通过</a>
				</s:if>
				<s:else><span class="confirmd confirmd_cancel">-</span></s:else>
				</s:if>
				<s:if test="1==lading.manager_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.manager_check_user_name" /> <s:date name="lading.manager_check_time" format="yyyy-MM-dd HH:mm:ss" />'>审核已通过</span>
				</s:if>
			</td>
			<td class="confirm_td">
				<s:if test="0==lading.sd_check">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_SDCHECK')">
				<a href='<s:url action="mdyLadingSDCheck"><s:param name="lading.uuid" value="lading.uuid" /></s:url>' class="confirm_button confirm_ok" onclick="return isOp('是否通过审核?\n审核操作不能取消!');">通过</a>
				</s:if>
				<s:else><span class="confirmd confirmd_cancel">-</span></s:else>
				</s:if>
				<s:if test="1==lading.sd_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.sd_check_user_name" /> <s:date name="lading.sd_check_time" format="yyyy-MM-dd HH:mm:ss" />'>审核已通过</span>
				</s:if>
			</td>
			<td class="confirm_td">
				<s:if test="0==lading.md_check">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_MDCHECK')">
				<a href='<s:url action="mdyLadingMDCheck"><s:param name="lading.uuid" value="lading.uuid" /></s:url>' class="confirm_button confirm_ok" onclick="return isOp('是否通过审核?\n审核操作不能取消!');">通过</a>
				</s:if>
				<s:else><span class="confirmd confirmd_cancel">-</span></s:else>
				</s:if>
				<s:if test="1==lading.md_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.md_check_user_name" /> <s:date name="lading.md_check_time" format="yyyy-MM-dd HH:mm:ss" />'>审核已通过</span>
				</s:if>
			</td>
			<td class="confirm_td">
				<s:if test="0==lading.coo_check">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_COOCHECK')">
				<a href='<s:url action="mdyLadingCOOCheck"><s:param name="lading.uuid" value="lading.uuid" /></s:url>' class="confirm_button confirm_ok" onclick="return isOp('是否通过审核?\n审核操作不能取消!');">通过</a>
				</s:if>
				<s:else><span class="confirmd confirmd_cancel">-</span></s:else>
				</s:if>
				<s:if test="1==lading.coo_check">
				<span class="confirmd confirmd_ok" title='<s:property value="lading.coo_check_user_name" /> <s:date name="lading.coo_check_time" format="yyyy-MM-dd HH:mm:ss" />'>审核已通过</span>
				</s:if>
			</td>
			</tr>
			<tr>
				<th colspan="6">
					财务到款情况
					<s:if test="lading.fd_check<2 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_MANAGER_LADINGPAY_ADD')">
					<input id="addLadingPayOpen" type="button" value="添加到款信息" />
					</s:if>
					<s:if test="lading.fd_check==2">
					<span class="message_pass">【到款已完成】</span>
					</s:if>
				</th>
			</tr>
			<tr>
				<td colspan="6">
					<s:if test="ladingPays==null || ladingPays.size == 0"><div class="message_warning" align="center">暂无到款信息</div></s:if>
					<s:else>
					<table class="ilisttable" id="fd_list_table" width="100%">
					  <tr>
					    <th>付款日期</th>
						<th>付款方式</th>
						<th>付款金额</th>
						<th>提交人</th>
						<th>提交时间</th>
						<th>财务确认</th>
						<th>操作</th>
					  </tr>
					<s:iterator value="ladingPays" status="sta">
					  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
					    <td align="center"><s:date name="pay_date" format="yyyy-MM-dd" /></td>
						<td align="center"><s:if test="0==type">现金</s:if><s:if test="1==type">POS</s:if><s:if test="2==type">支票</s:if><s:if test="3==type">转账</s:if><s:if test="4==type">预付款</s:if><s:if test="5==type">其他</s:if></td>
						<td align="center"><s:property value="money" /></td>
						<td align="center"><s:property value="add_user_name" /></td>
						<td align="center"><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
						<td align="center">
							<s:if test="0==fd_check"><span class="noarea" /></s:if>
							<s:if test="1==fd_check"><span class="yesarea" /></s:if>
						</td>
						<td align="center">
							<s:if test="0==fd_check && @org.iweb.sys.ContextHelper@checkPermit('QKJ_MANAGER_LADINGPAY_FDCHECK')">
					    	[<a href="<s:url namespace="/qkjmanage" action="ladingPay_fd_check"><s:param name="ladingPay.uuid" value="uuid"></s:param></s:url>" onclick="return isOp('确认款已到账吗?\n到帐后,此条到款信息将不能修改.');">确认到款</a>]
					    	</s:if>
					    	<s:if test="0==fd_check && @org.iweb.sys.ContextHelper@checkPermit('QKJ_MANAGER_LADINGPAY_DEL')">
					    	[<a href="<s:url namespace="/qkjmanage" action="ladingPay_del"><s:param name="ladingPay.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
					    	</s:if>	   
					    </td>
					  </tr>
					</s:iterator>
					</table>
					</s:else>
				</td>
			</tr>
			</table>
			</td>
		</tr>
		<tr>
		<td class='firstRow'>申请人/销售人:</td>
		<td class='secRow'>
			<s:property value="lading.applicant_name" />
		</td>
		<td class='firstRow'>申请时间:</td>
		<td class='secRow'><s:date name="lading.apply_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 客户信息:</td>
		<td class='secRow' colspan="3">
		会员号:
		<s:textfield id="order_user_id" name="lading.member_id" title="会员号" require="required" dataLength="0,85" controlName="会员号" />
		手机:
		<s:textfield id="order_user_mobile" name="lading.member_mobile" title="手机" controlName="手机" />
		姓名:
		<s:textfield id="order_user_name" name="lading.member_name" title="姓名" controlName="姓名" />
		</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 内容:</td>
		<td class='secRow' colspan="3">
		<s:textarea name="lading.content" title="内容" cssStyle="width:80%;" rows="4" require="required" controlName="内容"></s:textarea>
		</tr>
		<tr>
		<td class='firstRow'>配送地点:</td>
		<td class='secRow' colspan="3">
		<s:textarea name="lading.address" title="配送地点" cssStyle="width:80%;" rows="2" require="required" controlName="配送地点"></s:textarea>
		<br />
		选择预设地址:<select id="selectAddress"></select>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>其他说明:</td>
		<td class='secRow' colspan="3">
		<s:textarea name="lading.note" title="其他说明" cssStyle="width:80%;" rows="4"></s:textarea>
		</td>
		</tr>
		<s:if test="null != lading">
<!-- ------------------------------------------------------------- -->
<tr>
<td class='firstRow'>提货单明细:
	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_ADD') && lading.status==0">
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
<s:iterator value="ladingItems" status="sta">
  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
    <td align="center"><s:property value="uuid" /></td>
	<td><s:property value="product_name" /></td>
	<td align="right"><s:property value="per_price" /></td>
	<td align="center">
		<s:property value="num" />(<s:property value="num/(case_spec*1.0)" /> 件)
	</td>
	<td align="right"><s:property value="total_price" /></td>
	<td align="center">
   	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_DEL')  && lading.status==0">
   	[<a href="<s:url namespace="/qkjmanage" action="ladingItem_del"><s:param name="ladingItem.uuid" value="uuid" /><s:param name="ladingItem.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
   	</s:if>	   
    </td>
  </tr>
</s:iterator>
	<tr>
	<td></td><td></td><td></td>
	<td align="right">总计:</td>
	<td align="right"><s:property value="lading.total_price" /></td>
	<td></td>
	</tr>
</table>
</td>
</tr>
<!-- ------------------------------------------------------------- -->
		<tr>
		<td class='firstRow'>添加人:</td>
		<td class='secRow'><s:property value="lading.add_user_name" /></td>
		<td class='firstRow'>添加时间:</td>
		<td class='secRow'><s:date name="lading.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'>最后修改人:</td>
		<td class='secRow'><s:property value="lading.lm_user_name" /></td>
		<td class='firstRow'>最后修改时间:</td>
		<td class='secRow'><s:date name="lading.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		<tr>
		    <td colspan="20" class="buttonarea">
				<s:if test="null == lading && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="lading_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != lading && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_MDY')&&(lading.status==0||lading.status==1)">
					<s:submit id="save" name="save" value="保存" action="lading_save" />
					<script type="text/javascript">
					$(function(){
						$("#formEdit :input").change(function(){
							if($("#saveLadingStatus0").length>0)
								$("#saveLadingStatus0").attr("disabled","disabled");
							if($("#saveLadingStatus1").length>0)
								$("#saveLadingStatus1").attr("disabled","disabled");
							$("#message").text("请先保存后才能进行其他相关操作");
						});
					});
					</script>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_STATUS0')&&lading.status==0">
					<s:submit id="saveLadingStatus0" name="saveLadingStatus0" value="送审" action="saveLadingStatus0" onclick="return isOp('是否送审?\n送审后将不能更改!');" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_DEL')">
							<s:submit id="delete" name="delete" value="删除提货单(业务)" action="lading_del" onclick="return isDel();" />
						</s:if>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_STATUS1')&&lading.status==1">
					<s:submit id="saveLadingStatus1" name="saveLadingStatus1" value="结案&发货" action="saveLadingStatus1" onclick="return isOp('是否确定结案,送交仓库发货?\n结案后不能更改!');" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_MANAGERCHECK')&&lading.status==1">
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_DEL')">
							<s:submit id="delete" name="delete" value="删除提货单(主管)" action="lading_del" onclick="return isDel();" />
						</s:if>
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="lading_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
<div id="addItemForm" title="添加明细">
<s:form id="form_addItem" name="form_addItem" action="ladingItem_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 产品:</td>
			<td class='secRow'>
			<select name="ladingItem.product_id" title="产品" require="required" controlName="产品">
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
				<s:textfield name="ladingItem.per_price" title="单价" dataType="number" controlName="单价" require="required" />
				<span id="per_price_select_area"><select id="per_price_select"></select></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>数量:</td>
			<td class='secRow'>
				<s:textfield name="ladingItem.num" title="数量" dataType="integer" controlName="数量" require="required" />
				<span id="ladingItemnumCase"></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>合计:</td>
			<td class='secRow'><s:textfield name="ladingItem.total_price" title="合计" dataType="number" controlName="合计" require="required" /></td>
			</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
				<s:hidden name="ladingItem.lading_id" title="提货单ID" value="%{lading.uuid}" />
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_ADD')">
				<s:submit id="add" name="add" value="确定" action="ladingItem_add" />
				</s:if>
				<input type="button" value="关闭" onclick="closeAddForm();" />
			</td>
	    </tr>
	</table>	
</s:form>
</div>
<script type="text/javascript">
var add_per_price_input = $("#form_addItem :input[name='ladingItem.per_price']");
var add_num_input = $("#form_addItem :input[name='ladingItem.num']");
var add_total_price_input = $("#form_addItem :input[name='ladingItem.total_price']");
var add_product_id = $("#form_addItem :input[name='ladingItem.product_id']");

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
<div id="addLadingPay" title="添加到款信息">
<s:form name="form_addLadingPay" action="ladingPay_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 付款方式:</td>
		<td class='secRow'><s:select name="ladingPay.type" title="付款方式" headerKey="" headerValue="--请选择--" list="#{0:'现金',1:'POS',2:'支票',3:'转账',4:'预付款',5:'其他'}" require="required" controlName="付款方式" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 付款日期:</td>
		<td class='secRow'>
			<input type="text" id="ladingPay_pay_date" name="ladingPay.pay_date" value="${it:formatDate(ladingPay.pay_date,'yyyy-MM-dd')}"  require="required" controlName="付款日期" />
		</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 付款金额:</td>
		<td class='secRow'><s:textfield name="ladingPay.money" title="付款金额" dataLength="0,11" dataType="number"  require="required" controlName="付款金额" /></td>
		</tr>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	<s:hidden name="ladingPay.lading_id" value="%{lading.uuid}" />
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_MANAGER_LADINGPAY_ADD')">
				<s:submit id="add" name="add" value="确定" action="ladingPay_add" />
				</s:if>
			</td>
	    </tr>
	</table>	
</s:form>
</div>
<script type="text/javascript">$("#ladingPay_pay_date").datepicker();</script>
</body>
</html>