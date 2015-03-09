<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户藏酒信息列表--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/single/member_cellar.css" />" />
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="title1">客户藏酒信息列表(<s:property value="member.uuid" />-<s:property value="member.member_name" />)</span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="memberCellar_list" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">会员编号:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_id" name="member.uuid" title="会员号" require="required" controlName="购货人" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">会员手机:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_mobile" name="member.mobile" title="手机" controlName="购货人" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">会员名称:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_name" name="member.member_name" title="姓名" controlName="购货人" />
							<span id="message"><s:property value="message" /></span>
							<br />
						</div>
					</div>
					<div class="label_hang">
	            <div class="label_ltit">所在仓库:</div>
	            <div class="label_rwben">
			       <span class="label_rwb">
	            	<s:select cssClass="selectKick" list="wares" name="memberCellar.ware_id" listKey="uuid"  listValue="ware_name" headerKey="" headerValue="--请选择--" />
	            	</span>
	            </div>
	        </div>
	        <div class="label_hang">
	            <div class="label_ltit">藏酒:</div>
	            <div class="label_rwben">
			       <span class="label_rwb">
	            	<s:select cssClass="selectKick" list="goodss" name="memberCellar.goods_id" listKey="uuid" listValue="goods_name" headerKey="" headerValue="--请选择--" />
	            	</span>
	            </div>
	        </div>
	        <div class="label_hang">
					<div class="label_ltit">位置号(%):</div>
					<div class="label_rwben label_rwb">
						<s:textfield name="memberCellar.cellar_position" title="位置号" />
					</div>
			</div>
			<div class="label_hang label_button tac noprint">
		            <s:submit cssClass="input-blue" id="search_form_submit_button" name="memberCellar_list" value="确定" action="memberCellar_list" />
					<input type="button" name="page_print" value="打印本页" onclick="window.print();" />
		        </div>
	</div>
	</s:form>
<!-- 有会员信息才能显示内容 -->
<s:if test="member.uuid!=null && member.uuid!=''">
	<s:form name="form1" theme="simple">
	<div id="cellar_list_exists" class="cellar_list clear">
		<s:set name="pre_position_prefix" value="" />
		<s:iterator value="memberCellars" status="sta">
			<s:if test="#pre_position_prefix!=goods_cellar_prefix">
				<s:if test="#sta.index>1"></ul></s:if>
				<div class="cellar_title">
				<span class="cellar_goods_name">商品名称:</span>
				<span class="cellar_goods_name_value" data="<s:property value="goods_id" />"><s:property value="goods_name" /></span> | 
				<span class="cellar_goods_ware">所在仓库:</span>
				<span class="cellar_goods_ware_value" data="<s:property value="ware_id" />"><s:property value="ware_name" /></span>
				</div>
				<ul>
			</s:if>
			<li id="cellarli_<s:property value="uuid" />" uuid="<s:property value="uuid" />" ware="<s:property value="ware_id" />" position="<s:property value="cellar_position" />" fullflag="<s:if test="stock>=num">true</s:if><s:else>false</s:else>" camera="<s:property value="camera" />">
				<span class="cellar_no"><s:property value="cellar_position" /></span>
				<span class="cellar_stock"><s:property value="stock" />/<s:property value="num" /></span>
			</li>
			<s:set name="pre_position_prefix" value="goods_cellar_prefix" />
		</s:iterator>
	</div>
	</s:form>
</s:if>
</div>
</div>
<div id="MemberCellar_MDY" title="藏酒信息" style="display: none;">
<s:form name="form_mdy" action="memberCellar_save" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
<table class="ilisttable" width="100%">
<tr>
<td class='firstRow'><span style="color:red;">*</span> 藏酒位置号:</td>
<td class='secRow'>
	<s:textfield name="memberCellar.cellar_position" title="藏酒位置号" require="required" dataLength="0,85" controlName="藏酒位置号" />
	<span id="cellar_position_check"></span>
	<div id="cellar_position_check_message" class="message_error" style="display: none;"></div>
</td>
</tr>
<tr>
<td class='firstRow'>实时摄像头链接:</td>
<td class='firstRow' style="text-align:center;"><span id="current_camera"></span></td>
</tr>
<tr>
<td class='secRow' colspan="2">
	<s:textfield name="memberCellar.camera" title="实时摄像头链接" dataLength="0,85" controlName="实时摄像头链接" cssStyle="width:95%;" />
	<br /><span class="message_prompt">http://...</span>
</td>
</tr>
<tr>
    <td colspan="20" class="buttonarea" align="center">
    	<s:hidden name="memberCellar.uuid" />
    	<s:hidden name="memberCellar.ware_id" />
    	<input id="MemberCellar_MDY_sflag" type="hidden" name="sflag" value="unchange" />
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_MEMBERCELLAR_MDY')">
		<s:submit id="memberCellarSave" name="memberCellarSave" value="保存信息" action="memberCellar_save" />
		</s:if>
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_MEMBERCELLAR_DEL')">
		<s:submit id="memberCellarDelete" name="memberCellarDelete" value="藏酒退货" action="memberCellar_del" />
		</s:if>
	</td>
</tr>
<tr>
    <td colspan="20" class="buttonarea dialog_button">
    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_CELLARORDER_ADD')">
		<!--<span id="cellar_orderadd" class="ui_button_100x24_dark">代客取酒下单</span>-->
		<input id="cellar_orderadd" type="button" style="background: #363636;line-height: 22px;color: #FFF" value="代客取酒下单">
	</s:if>
    </td>
</tr>
</table>
</s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	SimpleLoadMember(ajax_url_action,function(event, ui) {
		//$("#search_form_submit_button").click();
	});
	
	$("#search_form :input").change(function(){
		//$("#search_form_submit_button").click();
	});
	
	$(".cellar_list li").bind({ click : function() {
		var $this = $(this);
		$("#MemberCellar_MDY :input[name='memberCellar.uuid']").val($this.attr("uuid"));
		$("#MemberCellar_MDY :input[name='memberCellar.cellar_position']").val($this.attr("position"));
		$("#MemberCellar_MDY").data("c_position",$this.attr("position"));//记录原position,主要用来在提交时,检查position是否更改
		var c_camera = $this.attr("camera");
		if(c_camera && c_camera.length>0) {
			$("#MemberCellar_MDY :input[name='memberCellar.camera']").val(c_camera);
			$("#MemberCellar_MDY #current_camera").html('<a href="'+c_camera+'" target="_blank">查看实时摄像头</a>');
		} else {
			$("#MemberCellar_MDY :input[name='memberCellar.camera']").val('');
			$("#MemberCellar_MDY #current_camera").empty();
		}
		//设置仓库信息
		$("#MemberCellar_MDY :input[name='memberCellar.ware_id']").val($this.attr("ware"));
		//delete
		if($this.attr("fullflag")=="true") {
			$("#MemberCellar_MDY #memberCellarDelete").unbind().bind("click",function(){
				return CommonUtil.isOp("真的要退回藏酒?\n退回操作不能取消,退回后,此藏酒将可以重新被配货!");
			});
		} else {
			$("#MemberCellar_MDY #memberCellarDelete").unbind().bind("click",function(){
				alert("取过酒的藏酒不能退回!");
				return false;
			});
		}
		$("#MemberCellar_MDY #cellar_orderadd").unbind().bind("click",function(){
			location.href='<s:url namespace="/sysebiz" action="cellarOrder_load"><s:param name="viewFlag">add</s:param></s:url>' + '&memberCellarID=' + $this.attr("uuid");
		});
		
		//重置Dialog的一些属性
		resetDialog();
		$("#MemberCellar_MDY").dialog("open");
	},mouseenter : function() {
		$(this).addClass("active");
	}, mouseleave : function() {
		$(this).removeClass("active");
	}});
	
	$("#MemberCellar_MDY").dialog({
	      autoOpen: false,
	      width: 400,
	      height: 200,
	      modal: true
	});
	
	$("#MemberCellar_MDY :input[name='memberCellar.cellar_position']").bind("keyup",function(){
		if (checkPositionChanges()) {
			//更改之后,先禁用保存按钮
			$("#cellar_position_check").removeClass().addClass("loadingarea");
			$("#memberCellarSave").attr("disabled","disabled");
			checkCellarPosition($("#MemberCellar_MDY :input[name='memberCellar.ware_id']").val(),
					$("#MemberCellar_MDY :input[name='memberCellar.cellar_position']").val());
		}
	});
	
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	// 此段代码可以方式回车提交
	jQuery(function($){
	    $("form").keypress(function(e){
	        if(e.keyCode == 13) {
	            e.preventDefault();
	        }
	    });  
	});
});

//检查藏酒位置号有没有改变
function checkPositionChanges() {
	//alert($("#MemberCellar_MDY :input[name='memberCellar.cellar_position']").val());
	//alert($("#MemberCellar_MDY").data("c_position"));
	if($("#MemberCellar_MDY :input[name='memberCellar.cellar_position']").val()!=$("#MemberCellar_MDY").data("c_position")) {
		$("#MemberCellar_MDY_sflag").val("change");
		return true;
	} else {
		$("#MemberCellar_MDY_sflag").val("unchange");
		return false;
	}
}

function checkCellarPosition(ware_id,cellar_position) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		var c = parseInt(data[0]);
		if(c==0) {
			$("#cellar_position_check").removeClass().addClass("yesarea");
			$("#memberCellarSave").removeAttr("disabled");
			$("#cellar_position_check_message").empty();
			$("#cellar_position_check_message").hide();
		} else {
			$("#cellar_position_check").removeClass().addClass("noarea");
			$("#cellar_position_check_message").text("位置号已经被占用!");
			$("#cellar_position_check_message").show();
		}
	};
	ajax.addParameter("privilege_id","QKJCJ_SYSEBIZ_MEMBERCELLAR_CHECKPOSITION");
	ajax.addParameter("parameters","ware_id="+ware_id+"&cellar_position="+cellar_position);
	ajax.sendAjax();
}

function resetDialog() {
	$("#cellar_position_check").removeClass();
	$("#memberCellarSave").removeAttr("disabled");
	$("#cellar_position_check_message").hide();
	$("#cellar_position_check_message").empty();
}
</script>
</html>