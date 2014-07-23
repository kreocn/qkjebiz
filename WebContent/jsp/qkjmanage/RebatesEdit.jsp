<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>返利申请单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	/*<s:if test="null == rebates && 'add' == viewFlag">*/
	SimpleLoadMember(ajax_url_action,function(event, ui) {
		loadLadings(ui.item.order_user_id);
	});
	
	// 此段代码可以方式回车提交
	jQuery(function($){
	    $("form").keypress(function(e){
	        if(e.keyCode == 13) {
	            e.preventDefault();
	        }
	    });  
	});
	/*</s:if><s:else>*/
	CommonUtil.pickrow('rebatesLadingsTable');
	CommonUtil.pickrow('rebatesProductsTable');	
	/*</s:else>*/
	
	$("#addProductForm").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	
	if($("#addProduct").length>0) {
		$("#addProduct").click(function() {
			openAddForm();
		});
	}
});

function loadLadings(member_id) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		var viewHref = '<s:url namespace="qkjmanage" action="lading_view"><s:param name="viewFlag">view</s:param></s:url>' + '&lading.uuid=';
		var ladingsHtml = "";
		$.each(data, function(i, n){
			ladingsHtml += '<li><input id="ladingsNeedsRebates'+n.uuid+'" name="ladingsNeedsRebates" class="inputcheckbox" type="checkbox" value="'+n.uuid+'" />';
			ladingsHtml += '<label for="ladingsNeedsRebates'+n.uuid+'">('+CommonUtil.formatJSONDate(n.apply_time,2)+')<a href="'+viewHref + n.uuid +'" target="_blank">'+n.uuid+'</a></label></li>\n';
		});
		$("#ladings").empty().append(ladingsHtml);
		bindLis();
	};
	ajax.addParameter("privilege_id","QKJ_QKJMANAGE_AJAXLOADLADINGS_NEEDSREBATES");
	ajax.addParameter("parameters","member_id="+member_id);
	ajax.sendAjax();
}

function bindLis() {
	$("#ladings li").unbind().bind({mouseenter : function() {
			$(this).addClass("active");
		}, mouseleave : function() {
			$(this).removeClass("active");
		}
	});
	
	$("#ladings :checkbox").unbind().bind({
		click:function(){
			if($(this).is(":checked")) {
				$(this).parent("li").css("background-color", "#DFDFDF");
			} else {
				$(this).parent("li").css("background-color", "");
			}
		}
	});
}

function openAddForm() {
	$("#addProductForm").dialog("open");
}

function closeAddForm() {
	$("#addProductForm").dialog("close");
}
</script>
<style type="text/css">
.showladings {
list-style: none;padding: 5px;margin: 0px;
}

.showladings li {
display: inline-block;zoom:1;*display: inline;
}
.showladings li {
line-height: 20px;padding: 3px; margin: 3px;
}
.showladings .inputcheckbox {
vertical-align:middle;
}
.showladings label {
vertical-align:middle;
}

.showladings li.active {
background-color: #DFDFDF;
}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == rebates && 'add' == viewFlag">增加</s:if><s:elseif test="null != rebates && 'mdy' == viewFlag">修改</s:elseif>返利申请单</span>
		<span class="extra1">
			<a href="<s:url action="rebates_list" namespace="/qkjmanage" />" >返利申请单列表</a>
		</span>	
	</div>
<s:form id="formEdit" name="form1" action="rebates_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != rebates">
		<tr>
		<td class='firstRow'>申请编号:</td>
		<td class='secRow'><s:property value="rebates.uuid" /><s:hidden name="rebates.uuid" /></td>
		<td class='firstRow'><span style="color:red;">*</span> 状态:</td>
		<td class='secRow'>
		<s:if test='0==rebates.status'>新单</s:if>
		<s:if test='10==rebates.status'>待审核</s:if>
		<s:if test='20==rebates.status'>主管已审</s:if>
		<s:if test='30==rebates.status'>经理已审</s:if>
		<s:if test='40==rebates.status'>财务已审</s:if>
		<s:if test='50==rebates.status'>总监已审</s:if>
		<s:if test='60==rebates.status'>总经理已审</s:if>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>申请人:</td>
		<td class='secRow'><s:property value="rebates.applicant_name" /></td>
		<td class='firstRow'>申请时间:</td>
		<td class='secRow'><s:date name="rebates.apply_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		  
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 会员:</td>
		<td class='secRow' colspan="3">
		<s:if test="null == rebates && 'add' == viewFlag">
		会员号:<s:textfield id="order_user_id" name="rebates.member_id" title="会员号" require="required" controlName="会员号" />
		手机:<s:textfield id="order_user_mobile" name="rebates.member_mobile" title="手机" controlName="手机" />
		姓名:<s:textfield id="order_user_name" name="rebates.member_name" title="姓名" controlName="姓名" />
		</s:if>
		<s:if test="null != rebates">
		会员号:<s:property value="rebates.member_id" /><s:hidden name="rebates.member_id" title="会员号" />
		手机:<s:property value="rebates.member_mobile" /><s:hidden name="rebates.member_mobile" title="手机" />
		姓名:<s:property value="rebates.member_name" /><s:hidden name="rebates.member_name" title="姓名" />
		</s:if>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>需返利出货单:</td>
		<td class='secRow' colspan="3">
			<ul id="ladings" class="showladings">
			<s:iterator value="rebatesLadings">
				<li class="active">(<s:date name="lading_time" format="yyyy-MM-dd" />)<a href='<s:url namespace="qkjmanage" action="lading_view"><s:param name="lading.uuid" value="lading_id" /><s:param name="viewFlag">view</s:param></s:url>' target="_blank"><s:property value="lading_id" /></a></li>
			</s:iterator>
			</ul>
			<table class="ilisttable" id="rebatesLadingsTable" width="100%">
			<tr>
			    <th>产品名称</th>
			    <th>出货单总数量</th>
				<th>出货单总金额</th>
				<th>返利系数%</th>
				<th>返利金额</th>
			</tr>
			<s:set name="total" value="0" />
			<s:set name="total_re" value="0" />
			<s:iterator value="ladingItems" status="sta">
			<tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
			<td><s:property value="product_name" /></td>
			<td align="center"><s:property value="num" /></td>
			<td align="center"><s:property value="total_price" /></td>
			<td align="center">
			<input name='re_scales[<s:property value="#sta.index" />]' value="<s:property value="re_scales[#sta.index]" />" style="width: 30px;" />%
			</td>
			<td align="center"><s:property value="total_price*re_scales[#sta.index]/100" /></td>
			</tr>
			<s:set name="total" value="#total+total_price" />
			<s:set name="total_re" value="#total_re+total_price*re_scales[#sta.index]/100" />
			</s:iterator>
			<tr>
				<td colspan="2" align="right">合计:</td>
				<td align="center"><s:property value="#total" /></td>
				<td align="right">合计返利:</td>
				<td align="center"><s:property value="#total_re" /></td>
			</tr>
			</table>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>返利类型:</td>
		<td class='secRow'><s:radio name="rebates.re_type" title="返利类型"  list="#{0:'随单返利',1:'季度返利',2:'年度返利',3:'活动返利',4:'其他'}" /></td>
		<td class='firstRow'>随量积分:</td>
		<td class='secRow'><s:textfield name="rebates.with_score" title="随量积分" dataLength="0,11" dataType="integer" controlName="随量积分" /></td>
		</tr>
		<tr>
		<td class='firstRow'>返现金数:</td>
		<td class='secRow'><s:textfield name="rebates.re_money" title="返现金数" dataLength="0,11" dataType="number" controlName="返现金数" /></td>
		<td class='firstRow'>返利积分:</td>
		<td class='secRow'><s:textfield name="rebates.re_score" title="返利积分" dataLength="0,10" dataType="integer" controlName="返利积分" /></td>
		
		</tr>
		<s:if test="null != rebates && 'mdy' == viewFlag">
		<tr>
		<td class='firstRow'>
		实体返利内容:
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATESPRODUCT_ADD')">
		<br/>
		<input id="addProduct" type="button" value="添加明细" />
		</s:if>
		</td>
		<td class='secRow' colspan="3">
<!-- ---------------------------------------------------------------------- -->
<table class="ilisttable" id="rebatesProductsTable" width="100%">
	  <tr>
	    <th>产品名称</th>
		<th>单价</th>
		<th>数量</th>
		<th>总价</th>
		<th>操作</th>
	  </tr>
<s:set name="total2" value="0" />
<s:iterator value="rebatesProducts" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td><s:property value="product_name" /></td>
		<td align="center"><s:property value="per_price" /></td>
		<td align="center"><s:property value="num" /></td>
		<td align="center"><s:property value="total_price" /></td>
		<td align="center">
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATESPRODUCT_DEL')">
	    	[<a href="<s:url namespace="/qkjmanage" action="rebatesProduct_del"><s:param name="rebatesProduct.uuid" value="uuid" /><s:param name="rebatesProduct.rebates_id" value="rebates_id" /></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>	   
	    </td>
	  </tr>
<s:set name="total2" value="#total2+total_price" />
</s:iterator>
	<tr>
		<td colspan="3" align="right">合计:</td>
		<td align="center"><s:property value="#total2" /></td>
		<td ></td>
	</tr>
	</table>
<!-- ---------------------------------------------------------------------- -->
		</td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'>返利说明:</td>
		<td class='secRow' colspan="3">
			<s:textarea name="rebates.note" cssStyle="width:80%;" />
			<br /><span class="message_prompt">当需要实体返利(需要出货时),请填写送货地址.</span>
		</td>
		</tr>
		
		<tr>
		<td class='firstRow'>可用操作:</td>
		<td class='secRow' colspan="3">
			<s:if test="null == rebates && 'add' == viewFlag">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_ADD')">
				<s:submit id="add" name="add" value="确定" action="rebates_add" />
				</s:if>
			</s:if>
			<s:elseif test="null != rebates && 'mdy' == viewFlag">
				<s:if test="0==rebates.status">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_MDY')">
					<s:submit id="save" name="save" value="保存信息" action="rebates_save" />
					<script type="text/javascript">
					$(function(){
						$("#formEdit :input").change(function(){
							$("#rebates_mdyRebatesStatus0").attr("disabled","disabled");
							$("#message").text("请先保存后才能送审");
						});
					});
					</script>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_DEL')">
					<s:submit id="delete" name="delete" value="删除申请单(业务)" action="rebates_del" onclick="return isDel();" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_STATUS0')">
					<s:submit id="rebates_mdyRebatesStatus0" name="rebates_mdyRebatesStatus0" value="送审" action="rebates_mdyRebatesStatus0" onclick="return isOp('是否送审?\n送审后将不能更改!');" />
					</s:if>
				</s:if>
				<s:if test="10==rebates.status">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_STATUS10')">
				<s:submit id="rebates_mdyRebatesStatus10" name="rebates_mdyRebatesStatus10" value="主管-审核通过" action="rebates_mdyRebatesStatus10" onclick="return isOp('是否审核通过?\n审核通过后将不能更改!');" />
				</s:if>
				</s:if>
				
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_STATUS10') && 10==rebates.status && rebates.status<=50">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_DEL')">
				<s:submit id="delete" name="delete" value="删除申请单(主管)" action="rebates_del" onclick="return isDel();" />
				</s:if>
				</s:if>
				
				<s:if test="20==rebates.status">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_STATUS20')">
				<s:submit id="rebates_mdyRebatesStatus20" name="rebates_mdyRebatesStatus20" value="经理-审核通过" action="rebates_mdyRebatesStatus20" onclick="return isOp('是否审核通过?\n审核通过后将不能更改!');" />
				</s:if>
				</s:if>
				<s:if test="30==rebates.status">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_STATUS30')">
				<s:submit id="rebates_mdyRebatesStatus30" name="rebates_mdyRebatesStatus30" value="财务-审核通过" action="rebates_mdyRebatesStatus30" onclick="return isOp('是否审核通过?\n审核通过后将不能更改!');" />
				</s:if>
				</s:if>
				<s:if test="40==rebates.status">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_STATUS40')">
				<s:submit id="rebates_mdyRebatesStatus40" name="rebates_mdyRebatesStatus40" value="运营总监-审核通过" action="rebates_mdyRebatesStatus40" onclick="return isOp('是否审核通过?\n审核通过后将不能更改!');" />
				</s:if>
				</s:if>
				<s:if test="50==rebates.status">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_STATUS50')">
				<s:submit id="rebates_mdyRebatesStatus50" name="rebates_mdyRebatesStatus50" value="总经理-审核通过" action="rebates_mdyRebatesStatus50" onclick="return isOp('是否审核通过?\n审核通过后将不能更改!');" />
				</s:if>
				</s:if>
				<s:if test="50<=rebates.status && rebates.fd_check==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_FDCHECK')">
				<s:submit id="rebates_mdyFDCheck" name="rebates_mdyFDCheck" value="财务最终确定" action="rebates_mdyFDCheck"  onclick="return isOp('是否最终确定?\n最终确定后,赠送的积分将直接到账?\n最终确定操作不能更改!');" />
				</s:if>
			</s:elseif>
			<input type="button" value="返回" onclick="linkurl('<s:url action="rebates_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" />
			<span id="message"><s:property value="message" /></span>
		</td>
		</tr>
	</table>	
</s:form>
	</div>
</div>
</div>

<div id="addProductForm" title="添加酒品" style="display: none;">
<s:form id="form_addProduct" name="form_addProduct" action="rebatesProduct_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 产品:</td>
			<td class='secRow'>
			<select name="rebatesProduct.product_id" title="产品" require="required" controlName="产品">
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
				<s:textfield name="rebatesProduct.per_price" title="单价" dataType="number" controlName="单价" require="required" />
				<span id="per_price_select_area"><select id="per_price_select"></select></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>数量:</td>
			<td class='secRow'>
				<s:textfield name="rebatesProduct.num" title="数量" dataType="integer" controlName="数量" require="required" />
				<span id="rebatesProductnumCase"></span>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>合计:</td>
			<td class='secRow'><s:textfield name="rebatesProduct.total_price" title="合计" dataType="number" controlName="合计" require="required" /></td>
			</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
				<s:hidden name="rebatesProduct.rebates_id" title="提货单ID" value="%{rebates.uuid}" />
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATESPRODUCT_ADD')">
				<s:submit id="add" name="add" value="确定" action="rebatesProduct_add" />
				</s:if>
				<input type="button" value="关闭" onclick="closeAddForm();" />
			</td>
	    </tr>
	</table>	
</s:form>
</div>
<script type="text/javascript">
var add_per_price_input = $("#form_addProduct :input[name='rebatesProduct.per_price']");
var add_num_input = $("#form_addProduct :input[name='rebatesProduct.num']");
var add_total_price_input = $("#form_addProduct :input[name='rebatesProduct.total_price']");
var add_product_id = $("#form_addProduct :input[name='rebatesProduct.product_id']");

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
		$("#rebatesProductnumCase").text((num_value/data_case)+'件');
	}
}
</script>
</body>
</html>