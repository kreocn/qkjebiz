<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动申请单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var infoeditor01;
$(function(){
	if($("#active_close_note").length>0) {
		infoeditor01 = new widget_textarea();
		infoeditor01.init("active_close_note");
	}
	
	$("#active_plan_start").datepicker();
	$("#active_plan_end").datepicker();
	
	$("#addProductForm").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	
	$("#addProduct").click(function(){
		$("#addProductForm").dialog("open");
	});
	
	$("#addPosmForm").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addPosm").click(function(){
		$("#addPosmForm").dialog("open");
	});
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadMember(ui.item.order_user_id);});
	$("#addMemberForm").dialog({
	      autoOpen: false,
	      height: 300,
	      width: 600,
	      modal: true
	});
	$("#addMember").click(function(){
		$("#with_score_remain").empty();
		$("#addMemberForm").dialog("open");
	});
	
	$("#viewMember").dialog({
	      autoOpen: false,
	      height: 180,
	      width: 400,
	      modal: true
	});
});

function loadMember(member_id) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		var m = data[0];
		$("#activeMemcost_with_score").attr("dataBetween","0,"+m.with_score);
		$("#with_score_remain").text("此客户还有随量积分:" + m.with_score);
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJ_QKJMANAGER_AJAXLOAD_MEMBER&uuid=" + member_id);
	ajax.sendAjax();
}

function loadMemberInfo(member_id) {
	$("#view_member_uuid").text("正在加载...");
	$("#view_member_mobile").empty();
	$("#view_member_name").empty();
	$("#view_member_with_score").empty();
	
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		var m = data[0];
		$("#view_member_uuid").text(m.uuid);
		$("#view_member_mobile").text(m.mobile);
		$("#view_member_name").text(m.member_name);
		$("#view_member_with_score").text(m.with_score);
		$("#viewMember").dialog("open");
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJ_QKJMANAGER_AJAXLOAD_MEMBER&uuid=" + member_id);
	ajax.sendAjax();
}
</script>
<style type="text/css">
.active_icost {padding: 3px 5px;}
.active_icost_left {}
.active_icost_right {}
.active_p_title {
border-bottom: #666 dashed 1px;
text-indent: 2px;
font-weight: bold;
padding-bottom: 5px;
margin-bottom: 5px;
}

.active_p_title_second {
margin-top: 6px;
}
.active_p_list ul {
padding: 0;margin: 0 0 0 5px;list-style: none;
}
.active_p_list li {
line-height: 25px;height: 25px;clear: both;
}
.active_p_list li:hover {
color: #AA0000;
}
.active_p_list span {
display: block;float: left;
}
.active_p_list .p_n {width: 150px;}
.active_p_list .p_p {width: 80px;text-align: center;}
.active_p_list .p_m {width: 80px;text-align: center;}
.active_p_list .p_t {width: 100px;text-align: center;}
.active_p_list .p_x {width: 180px;text-align: left;}
.active_p_list .p_a {float: right;}
.active_p_list .p_x2 {width: 200px;text-align: left;}
.ui-autocomplete {z-index: 200;}
.money_div {padding: 4px; color: #333; border-radius: 4px; border: 1px solid #aaa;margin: 4px;}
.p_tm {text-indent: 70%;}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">活动结案单</span>
		<span class="extra1 printarea">
			<a href="<s:url action="active_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>" >返回活动列表</a>
		</span>	
	</div>
<s:form name="form_mdyCloseActive" action="mdyCloseActive" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != active">
		  <tr>
			<td class='firstRow3'><span style="color:red;">*</span> 申请编号:</td>
			<td class='secRow3'><s:property value="active.uuid" /><s:hidden name="active.uuid" title="申请编号" /></td>
			<td class='firstRow3'><span style="color:red;">*</span> 申请部门:</td>
			<td class='secRow3'><s:property value="active.apply_dept_name" /></td>
			<td class='firstRow3'><span style="color:red;">*</span> 申请人:</td>
			<td class='secRow3'><s:property value="active.apply_user_name" /></td>
			</tr>
			<tr>
			<td class='firstRow3'><span style="color:red;">*</span> 状态:</td>
			<td class='secRow3' colspan="5">
				<span class="span_label">
					申请单状态:
					<s:if test="active.status==2"><font class="message_prompt">未开始结案</font></s:if>
					<s:if test="active.status==3">开始结案</s:if>
					<s:if test="active.status==4"><font class="message_warning">结案审批中</font></s:if>
					<s:if test="active.status==5"><font class="message_pass">结案通过</font></s:if>
				</span>
				
				<s:if test="active.close_sd_status>0">
				<span class="span_label" title="${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')}">
					销售部审核状态:
					<s:if test="active.close_sd_status==0">新单</s:if>
					<s:if test="active.close_sd_status==5"><font class="message_error">审核退回</font>(${active.close_sd_user_name})</s:if>
					<s:if test="active.close_sd_status==10"><font class="message_warning">待审核</font></s:if>
					<s:if test="active.close_sd_status==30"><font class="message_pass">大区经理已审</font>(${active.close_sd_user_name})</s:if>
					<s:if test="active.close_sd_status==40"><font class="message_pass">运营总监已审</font>(${active.close_sd_user_name})</s:if>
					<s:if test="active.close_sd_status==50"><font class="message_pass">业务副总已审</font>(${active.close_sd_user_name})</s:if>
					<s:if test="active.close_sd_status==60"><font class="message_pass">总经理已审</font>(${active.close_sd_user_name})</s:if>
				</span>
				</s:if>
				
				<s:if test="active.close_smd_status>0">
				<span class="span_label" title="${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')}">
					销管部审核状态:
					<s:if test="active.close_smd_status==0">未签收</s:if>
					<s:if test="active.close_smd_status==5"><font class="message_error">审核退回</font>(${active.close_smd_user_name})</s:if>
					<s:if test="active.close_smd_status==10"><font class="message_warning">已签收</font></s:if>
					<s:if test="active.close_smd_status==30"><font class="message_pass">销管经理已审</font>(${active.close_smd_user_name})</s:if>
					<s:if test="active.close_smd_status==40"><font class="message_pass">销管部经理已审</font>(${active.close_smd_user_name})</s:if>
					<s:if test="active.close_smd_status==50"><font class="message_pass">销管副总已审</font>(${active.close_smd_user_name})</s:if>
				</span>
				</s:if>
				<s:hidden name="active.status" /><s:hidden name="active.close_sd_status" /><s:hidden name="active.close_smd_status" />
				<span id="message"><s:property value="message" /></span>
			</td>
			</tr>
			
			<tbody class="printshow">
			<tr class="sign_tr">
			<td class='firstRow3'>销售管理副总经理:</td>
			<td class='secRow3 message_prompt' valign="top" colspan="5">(签字/日期)</td>
			</tr>
			<tr class="sign_tr">
			<td class='firstRow3'>财务部:</td>
			<td class='secRow3 message_prompt' valign="top" colspan="5">(签字/日期)</td>
			</tr>
			<tr class="sign_tr">
			<td class='firstRow3'>数据中心:</td>
			<td class='secRow3 message_prompt' valign="top" colspan="5">(签字/日期)</td>
			</tr>
			<tr class="sign_tr">
			<td class='firstRow3'>业务副总经理:</td>
			<td class='secRow3 message_prompt' valign="top" colspan="5">(签字/日期)</td>
			</tr>
			<tr class="sign_tr">
			<td class='firstRow3'>总经理:</td>
			<td class='secRow3 message_prompt'valign="top" colspan="5">(签字/日期)</td>
			</tr>
			</tbody>
		</s:if>
		<!-- --------------------------------------------------------------- -->
		<tr>
		<td class='firstRow3'><span style="color:red;">*</span> 主题:</td>
		<td class='secRow3' colspan="5">${active.theme}</td>
		</tr>
		<tr>
		<td class='firstRow3'><span style="color:red;">*</span> 目的:</td>
		<td class='secRow3' colspan="5">${active.purpose}</td>
		</tr>
		<tr>
		<td class='firstRow3'><span style="color:red;">*</span> 活动开始时间:</td>
		<td class='secRow3'>${it:formatDate(active.plan_start,'yyyy-MM-dd')}</td>
		<td class='firstRow3'><span style="color:red;">*</span> 活动结束时间:</td>
		<td class='secRow3'>${it:formatDate(active.plan_end,'yyyy-MM-dd')}	</td>
		<td class='firstRow3'><span style="color:red;">*</span> 活动地点:</td>
		<td class='secRow3'>${active.address}</td>
		</tr>
		<tr>
		<td class='firstRow3'><span style="color:red;">*</span> 执行人:</td>
		<td class='secRow3'>${active.person}</td>
		<td class='firstRow3'><span style="color:red;">*</span> 活动预期:</td>
		<td class='secRow3' colspan="3">${active.expect}</td>
		</tr>
		<tr><td colspan="6" height="5"></td></tr>
		<tr><td colspan="6">
		<div class="money_div">
		<table class="ilisttable" width="100%">
			<tr><td class='firstRow3' colspan="6" style="text-align: center;">预计活动费用</td></tr>
			<tr>
				<td class='firstRowx' colspan="3" style="text-align: center;">公司预计费用</td>
				<td class='firstRowx' colspan="3" style="text-align: center;">参与客户&预计费用</td>
			</tr>
			<tr>
			<td class='secRowx' colspan="3" valign="top">
			<div class="active_icost active_icost_left">
<s:if test="activeProducts.size != 0">
			<div class="active_p_title">公司提供酒品</div>
			<div class="active_p_list">
				<table class="ilisttable listtable_show" width="100%">
				<tr>
				<th>品名</th>
				<th>单价</th>
				<th>数量</th>
				<th>合计</th>
				</tr>
				<s:iterator value="activeProducts" status="sta">
				<tr>
				<td>${product_name}</td>
				<td align="center">￥${per_price}</td>
				<td align="center">${num}</td>
				<td align="center">￥${total_price}</td>
				</tr>
				</s:iterator>
				</table>
			</div>
</s:if>
<s:if test="activePosms.size != 0">
			<div class="active_p_title active_p_title_second">公司销售物料(除酒品之外的其他费用,全部算物料)</div>
			<div class="active_p_list">
				<table class="ilisttable listtable_show" width="100%">
				<tr>
				<th>名目</th>
				<th>名目说明</th>
				<th>金额</th>
				</tr>
				<s:iterator value="activePosms" status="sta">
				<tr>
				<td class="nowrap">${title}</td>
				<td>${note}</td>
				<td class="nowrap" align="center">￥${total_price}</td>
				</tr>
				</s:iterator>
				</table>
			</div>
</s:if>
			</div>
			</td>
			<td class='secRowx' colspan="3" valign="top">
				<div class="active_icost active_icost_right">
<s:if test="activeMemcosts.size != 0">
			<div class="active_p_title">参与活动客户</div>
			<div class="active_p_list">
				<table class="ilisttable listtable_show" width="100%">
				<tr>
				<th>客户</th>
				<th>名目</th>
				<th>名目说明</th>
				<th>金额</th>
				</tr>
				<s:iterator value="activeMemcosts" status="sta">
				<tr>
				<td class="nowrap"><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
				<td class="nowrap">${title}</td>
				<td>${note}</td>
				<td class="nowrap">￥${total_price}</td>
				</tr>
				</s:iterator>
				</table>
			</div>
</s:if>
				</div>
			</td>
			</tr>
			<tr>
			<td class='secRowx' colspan="3" valign="top">
				<div class="active_icost">
				<div class="active_p_title active_p_title_second">公司预计费用合计</div>
				<div class="active_p_list p_tm">￥${active.it_price}</div>
				</div>
			</td>
			<td class='secRowx' colspan="3" valign="top">
				<div class="active_icost">
				<div class="active_p_title active_p_title_second">客户预计费用合计</div>
				<div class="active_p_list p_tm">￥${active.mt_price}</div>
				</div>
			</td>
			</tr>
			<tr><td class='firstRowx' colspan="6" style="text-align: center;">
				<span class="message_pass">方案预计费用总计: ${active.it_price} + ${active.mt_price} = ￥${active.it_price+active.mt_price}</span>
			</td></tr>
		</table>
		</div>
		<s:if test="active.status>=3">
		<div class="money_div" style="border: #FF0000 solid 1px;">
		<table class="ilisttable" width="100%">
			<tr><td class='firstRow3' colspan="6" style="text-align: center;">实际活动费用</td></tr>
			<tr>
				<td class='firstRowx' colspan="3" style="text-align: center;" width="45%;">
					公司实际费用
					<s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD')">
					<input type="button" id="addProduct" value="添加酒品" />
					</s:if>
					<s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_ADD')">
					<input type="button" id="addPosm" value="销售物料" />
					</s:if>
				</td>
				<td class='firstRowx' colspan="3" style="text-align: center;" width="55%;">
					参与客户承担费用&随量积分
					<s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOST_ADD')">
					<input type="button" id="addMember" value="添加客户" />
					</s:if>
				</td>
			</tr>
			<tr>
			<td class='secRowx' colspan="3" valign="top">
			<div class="active_icost active_icost_left">
			
<s:if test="activeProductsClose.size != 0">
			<div class="active_p_title">公司提供酒品</div>
			<div class="active_p_list">
				<table class="ilisttable listtable_show" width="100%">
				<tr>
				<th>品名</th>
				<th>单价</th>
				<th>数量</th>
				<th>合计</th>
				<th>操作</th>
				</tr>
				<s:iterator value="activeProductsClose" status="sta">
				<tr>
				<td>${product_name}</td>
				<td align="center">￥${per_price}</td>
				<td align="center">${num}</td>
				<td align="center">￥${total_price}</td>
				<td class="nowrap" align="center">
				<s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL')">
					<a href="<s:url action="activeProductClose_del"><s:param name="activeProduct.uuid" value="%{uuid}" /><s:param name="activeProduct.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
				</s:if>
				</td>
				</tr>
				</s:iterator>
				</table>
			</div>
</s:if>
<s:if test="activePosmsClose.size != 0">
			<div class="active_p_title active_p_title_second">公司销售物料(除酒品之外的其他费用,全部算物料)</div>
			<div class="active_p_list">
				<table class="ilisttable listtable_show" width="100%">
				<tr>
				<th>名目</th>
				<th>名目说明</th>
				<th>金额</th>
				<th>操作</th>
				</tr>
				<s:iterator value="activePosmsClose" status="sta">
				<tr>
				<td class="nowrap">${title}</td>
				<td>${note}</td>
				<td class="nowrap" align="center">￥${total_price}</td>
				<td class="nowrap" align="center">
					<s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_DEL')">
						<a href="<s:url action="activePosmClose_del"><s:param name="activePosm.uuid" value="%{uuid}" /><s:param name="activePosm.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
					</s:if>
				</td>
				</tr>
				</s:iterator>
				</table>
			</div>
</s:if>
			</div>
			</td>
			<td class='secRowx' colspan="3" valign="top">
				<div class="active_icost active_icost_right">
				<s:set var="totle_with_score" value="0" />
<s:if test="activeMemcostsClose.size != 0">
			<div class="active_p_title">参与活动客户</div>
			<div class="active_p_list">
				<table class="ilisttable listtable_show" width="100%">
				<tr>
				<th>客户</th>
				<th>名目</th>
				<th>名目说明</th>
				<th>金额</th>
				<th>扣除随量积分</th>
				<th>操作</th>
				</tr>
				<s:iterator value="activeMemcostsClose" status="sta">
				<tr>
				<td class="nowrap"><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
				<td class="nowrap">${title}</td>
				<td>${note}</td>
				<td class="nowrap" align="center">￥${total_price}</td>
				<td class="nowrap" align="center">￥${with_score}</td>
				<td class="nowrap" align="center">
					<s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOST_DEL')">
						<a href="<s:url action="activeMemcostClose_del"><s:param name="activeMemcost.uuid" value="%{uuid}" /><s:param name="activeMemcost.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
					</s:if>
				</td>
				</tr>
				</s:iterator>
				</table>
			</div>
</s:if>
				</div>
			</td>
			</tr>
			<tr>
			<td class='secRowx' colspan="3" valign="top">
				<div class="active_icost">
				<div class="active_p_title active_p_title_second">公司实际费用合计</div>
				<div class="active_p_list p_tm">￥${active.close_it_price}</div>
				</div>
			</td>
			<td class='secRowx' colspan="3" valign="top">
				<div class="active_icost">
				<div class="active_p_title active_p_title_second">客户实际费用合计</div>
				<div class="active_p_list p_tm">￥${active.close_mt_price}</div>
				</div>
			</td>
			</tr>
			<tr><td class='firstRowx' colspan="6" style="text-align: center;">
				<span class="message_error">
					方案实际费用总计: ${active.close_it_price} + ${active.close_mt_price} = ￥${active.close_it_price+active.close_mt_price}
					&nbsp;&nbsp;&nbsp;
					需扣除随量积分总数:	<s:property value="#totle_with_score" />
				</span>
			</td></tr>
		</table>
		</div>
	</s:if>
		</td></tr>
		<tr><td colspan="6" height="5"></td></tr>
		
		<tr><td colspan="6">
			<div class="money_div">
			<table class="ilisttable" width="100%">
			<tr><td class='firstRowx' colspan="6" style="text-align: center;">方案说明</td></tr>
			<tr>
			<td class='secRow3' colspan="6">
				${active.note}
			</td>
			</tr>
			</table>
			</div>
		</td></tr>
		
		<s:if test="active.status==3">
		<tr><td class='firstRowx' colspan="6" style="text-align: center;">活动概况</td></tr>
		<tr>
		<td class='secRow3' colspan="6">
			<s:textarea id="active_close_note" name="active.close_note" title="活动概况" dataLength="0,65535" controlName="活动概况" />
		</td>
		</tr>
		<tr><td colspan="6" height="5"></td></tr>
		</s:if>
		<s:elseif test="active.status>3">
		<tr><td colspan="6">
			<div class="money_div">
			<table class="ilisttable" width="100%">
			<tr><td class='firstRowx' colspan="6" style="text-align: center;">活动概况</td></tr>
			<tr>
			<td class='secRow3' colspan="6">
				${active.close_note}
			</td>
			</tr>
			</table>
			</div>
		</td></tr>
		</s:elseif>
		<tr><td colspan="6" height="5"></td></tr>
		
		<tr>
			<td colspan="6">
			<div class="money_div">
			<table class="ilisttable" width="100%">
			<tr>
			<td class='firstRowx' colspan="6" style="text-align: center;">备注</td>
			<td class='secRow3' colspan="5">
				<s:textarea id="active_remark" name="active.remark" title="活动备注" dataLength="0,65535" controlName="活动备注" rows="4" cssStyle="width:80%;" />
				<br /><span class="message_prompt printarea">任何保存/报审/审核操作都会同时保存备注</span>
			</td>
			</tr>
			</table>
			</div>
			</td>
		</tr>
		
		<tr class="printarea">
		<td class='firstRow3'>相关操作:</td>
		<td class='secRow3' colspan="5">
			<s:if test="null != active">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS2') && active.status==2">
				<s:submit id="mdyStatus2" name="mdyStatus2" value="结案&填写实际费用明细" action="mdyStatus2" onclick="return isOp('确定执行此操作?');" />
			</s:if>
				
			<s:if test="active.status==3">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_MDY')">
				<s:submit id="mdyCloseActive" name="mdyCloseActive" value="保存活动概况" action="mdyCloseActive" />
				</s:if>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS3')">
				<s:submit id="mdyStatus3" name="mdyStatus3" value="结案报审" action="mdyStatus3" onclick="return isOp('确定执行此操作?');" />
				</s:if>
			</s:if>
			<s:if test="active.status==4&&active.close_sd_status>=40&&active.close_smd_status>=30 &&@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS4')">
			<s:submit id="mdyStatus4" name="mdyStatus4" value="结案通过" action="mdyStatus4" onclick="return isOp('确定执行此操作?');" />
			</s:if>
			</s:if>
			<input type="button" value="返回" onclick="linkurl('<s:url action="active_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" />
			<s:if test="40<=active.close_sd_status">
				<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="active_closeView"><s:param name="active.uuid" value="active.uuid"></s:param></s:url>');" value="转到打印页面"/>
			</s:if>
			<!-- <input type="button" onclick="window.print();" value="打印本页"/> -->
		</td>
		</tr>
		<s:if test="null != active && active.status>=4">
		<tr>
		<td class='firstRow3'>销售部审核操作:</td>
		<td class='secRow3' colspan="5">
			<span class="printarea">
			<s:if test="10==active.close_sd_status && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10')">
			<s:submit id="mdyCloseActiveSDStatus10" name="mdyCloseActiveSDStatus10" value="大区经理-审核通过" action="mdyCloseActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
			<s:submit id="mdyCloseActiveSDStatus5" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
			</s:if>
			<s:if test="30==active.close_sd_status && 30==active.close_smd_status && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS30')">
			<s:submit id="mdyCloseActiveSDStatus30" name="mdyCloseActiveSDStatus30" value="运营总监-审核通过" action="mdyCloseActiveSDStatus30" onclick="return isOp('确定执行此操作?');" />
			<s:submit id="mdyCloseActiveSDStatus5" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
			</s:if>
			<s:if test="40==active.close_sd_status && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS40')">
			<s:submit id="mdyCloseActiveSDStatus40" name="mdyCloseActiveSDStatus40" value="业务副总-审核通过" action="mdyCloseActiveSDStatus40" onclick="return isOp('确定执行此操作?');" />
			<s:submit id="mdyCloseActiveSDStatus5" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
			</s:if>
			<s:if test="50==active.close_sd_status && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10')">
			<s:submit id="mdyCloseActiveSDStatus50" name="mdyCloseActiveSDStatus50" value="总经理-审核通过" action="mdyCloseActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />
			<s:submit id="mdyCloseActiveSDStatus5" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
			</s:if>
			</span>
			<s:if test="active.close_sd_status>0">
			<span class="span_label">
				销售部审核状态:
				<s:if test="active.close_sd_status==0">新单</s:if>
				<s:if test="active.close_sd_status==5"><font class="message_error">审核退回</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
				<s:if test="active.close_sd_status==10"><font class="message_warning">待审核</font></s:if>
				<s:if test="active.close_sd_status==30"><font class="message_pass">大区经理已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
				<s:if test="active.close_sd_status==40"><font class="message_pass">运营总监已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
				<s:if test="active.close_sd_status==50"><font class="message_pass">业务副总已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
				<s:if test="active.close_sd_status==60"><font class="message_pass">总经理已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
			</span>
			</s:if>
		</td>
		</tr>
		<tr>
		<td class='firstRow3'>销售管理部审核操作:</td>
		<td class='secRow3' colspan="5">
			<span class="printarea">
			<s:if test="10==active.close_smd_status && 30==active.close_sd_status && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS10')">
			<s:submit id="mdyCloseActiveSMDStatus10" name="mdyCloseActiveSMDStatus10" value="销管经理-审核通过" action="mdyCloseActiveSMDStatus10" onclick="return isOp('确定执行此操作?');" />
			<s:submit id="mdyCloseActiveSMDStatus5" name="mdyCloseActiveSMDStatus5" value="审核不通过" action="mdyCloseActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
			</s:if>
			<s:if test="30==active.close_smd_status && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS30')">
			<s:submit id="mdyCloseActiveSMDStatus30" name="mdyCloseActiveSMDStatus30" value="销管副总-审核通过" action="mdyCloseActiveSMDStatus30" onclick="return isOp('确定执行此操作?');" />
			<s:submit id="mdyCloseActiveSMDStatus5" name="mdyCloseActiveSMDStatus5" value="审核不通过" action="mdyCloseActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
			</s:if>
			</span>
			<s:if test="active.close_smd_status>0">
			<span class="span_label">
				销管部审核状态:
				<s:if test="active.close_smd_status==0">新单</s:if>
				<s:if test="active.close_smd_status==5"><font class="message_error">审核退回</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
				<s:if test="active.close_smd_status==10"><font class="message_warning">已签收</font></s:if>
				<s:if test="active.close_smd_status==30"><font class="message_pass">销管经理已审</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
				<s:if test="active.close_smd_status==40"><font class="message_pass">销管部经理已审</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
				<s:if test="active.close_smd_status==50"><font class="message_pass">销管副总已审</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
			</span>
			</s:if>
		</td>
		</tr>
		</s:if>
	</table>	
</s:form>
	</div>
</div>
</div>
<!-- 添加酒品 -->
<div id="addProductForm" title="添加酒品">
<s:form id="form_addProductForm" name="form_addProductForm" action="activeProductClose_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
<table class="ilisttable" width="100%">
	  <tr>
		<td class='firstRow'><span style="color:red;">*</span> 产品:</td>
		<td class='secRow'>
		<select name="activeProduct.product_id" title="产品" require="required" controlName="产品">
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
			<s:textfield name="activeProduct.per_price" title="单价" dataType="number" controlName="单价" require="required" />
			<span id="per_price_select_area"><select id="per_price_select"></select></span>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>数量:</td>
		<td class='secRow'>
			<s:textfield name="activeProduct.num" title="数量" dataType="integer" controlName="数量" require="required" />
			<span id="ladingItemnumCase"></span>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>合计:</td>
		<td class='secRow'><s:textfield name="activeProduct.total_price" title="合计" dataType="number" controlName="合计" require="required" />元</td>
		</tr>

	<tr>
	    <td colspan="20" class="buttonarea">
			<s:hidden name="activeProduct.active_id" value="%{active.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCTCLOSE_ADD')">
			<s:submit id="activeProduct_add" name="activeProduct_add" value="确定" action="activeProductClose_add" />
			</s:if>
		</td>
    </tr>
</table>
</s:form>
</div>
<script type="text/javascript">
var add_per_price_input = $("#form_addProductForm :input[name='activeProduct.per_price']");
var add_num_input = $("#form_addProductForm :input[name='activeProduct.num']");
var add_total_price_input = $("#form_addProductForm :input[name='activeProduct.total_price']");
var add_product_id = $("#form_addProductForm :input[name='activeProduct.product_id']");

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

<!-- 添加销售物料(公司) -->
<div id="addPosmForm" title="添加销售物料(公司)">
<s:form name="form_addPosmForm" action="activePosmClose_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
<table class="ilisttable" width="100%">
<tr>
<td class='firstRow'><span style="color:red;">*</span> 名目:</td>
<td class='secRow'><s:textfield name="activePosm.title" title="名目" require="required" dataLength="0,32" controlName="名目" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 名目说明:</td>
<td class='secRow'><s:textarea name="activePosm.note" title="说明" require="required"  dataLength="0,255" controlName="说明" cssStyle="width:80%;" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 金额:</td>
<td class='secRow'><s:textfield name="activePosm.total_price" title="金额" require="required" dataLength="0,11" dataType="number" controlName="金额" />元</td>
</tr>
<tr>
<td colspan="20" class="buttonarea">
	<s:hidden name="activePosm.active_id" value="%{active.uuid}" />
	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPOSMCLOSE_ADD')">
	<s:submit id="add" name="add" value="确定" action="activePosmClose_add" />
	</s:if>
</td>
</tr>
</table>
</s:form>
</div>

<div id="addMemberForm" title="添加参与客户">
<s:form name="form_addMemberForm" action="activeMemcostClose_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 会员编号:</td>
		<td class='secRow'><s:textfield id="order_user_id" name="activeMemcost.member_id" title="会员号" require="required" dataLength="0,85" controlName="会员号" /></td>
		</tr>
		<tr>
		<td class='firstRow'>会员手机:</td>
		<td class='secRow'><s:textfield id="order_user_mobile" name="activeMemcost.member_mobile" title="手机" controlName="手机" /></td>
		</tr>
		<tr>
		<td class='firstRow'>会员姓名:</td>
		<td class='secRow'><s:textfield id="order_user_name" name="activeMemcost.member_name" title="姓名" controlName="姓名" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 名目:</td>
		<td class='secRow'><s:textfield name="activeMemcost.title" title="名目" require="required" dataLength="0,32" controlName="名目" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 名目说明:</td>
		<td class='secRow'><s:textarea name="activeMemcost.note" title="说明" require="required" dataLength="0,255" controlName="说明" cssStyle="width:80%;" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 金额:</td>
		<td class='secRow'><s:textfield name="activeMemcost.total_price" title="金额" require="required" dataLength="0,11" dataType="number" controlName="金额" />元</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 扣除随量积分:</td>
		<td class='secRow'>
			<s:textfield id="activeMemcost_with_score" name="activeMemcost.with_score" title="随量积分" require="required" dataLength="0,11" dataType="number" dataBetween="0,0" controlName="随量积分" />
			<span id="with_score_remain"></span>
		</td>
		</tr>
	<tr>
	    <td colspan="20" class="buttonarea">
	    	<s:hidden name="activeMemcost.active_id" value="%{active.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOSTCLOSE_ADD')">
			<s:submit id="add" name="add" value="确定" action="activeMemcostClose_add" />
			</s:if>
		</td>
    </tr>
</table>	
</s:form>
</div>
<div id="viewMember" title="客户实时信息">
<table class="ilisttable" width="100%">
	<tr>
	<td class='firstRow'>会员编号:</td>
	<td class='secRow'><span id="view_member_uuid"></span></td>
	</tr>
	<tr>
	<td class='firstRow'>会员手机:</td>
	<td class='secRow'><span id="view_member_mobile"></span></td>
	</tr>
	<tr>
	<td class='firstRow'>会员姓名:</td>
	<td class='secRow'><span id="view_member_name"></span></td>
	</tr>
	<tr>
	<td class='firstRow'>可用随量积分:</td>
	<td class='secRow'><span id="view_member_with_score"></span></td>
	</tr>
</table>	
</div>
</body>
</html>