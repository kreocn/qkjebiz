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
	if($("#active_note").length>0) {
		infoeditor01 = new widget_textarea();
		infoeditor01.init("active_note");
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
	
	
	SimpleLoadMember(ajax_url_action,$.noop);
	$("#addMemberForm").dialog({
	      autoOpen: false,
	      height: 300,
	      width: 600,
	      modal: true
	});
	$("#addMember").click(function(){
		$("#addMemberForm").dialog("open");
	});
	
	$("#viewMember").dialog({
	      autoOpen: false,
	      height: 180,
	      width: 400,
	      modal: true
	});
});

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
.money_div {padding: 4px; color: #333; border-radius: 4px; border: 1px solid #aaa;margin: 4px;}
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
.ui-autocomplete {z-index: 200;}
#active_remark,#active_remark textarea {
font-size: 14px;
}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">活动申请单(${active.uid})</span>
		<span class="extra1 printarea">
			<a href="<s:url action="active_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>" >活动列表</a>
		</span>	
	</div>
<s:form name="form1" action="active_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != active">
		  <tr>
			<td class='firstRow3'>申请编号:</td>
			<td class='secRow3'>${active.uid}<s:hidden name="active.uid" /><s:hidden name="active.uuid" title="" /></td>
			<td class='firstRow3'>申请部门:</td>
			<td class='secRow3'><s:property value="active.apply_dept_name" /></td>
			<td class='firstRow3'>申请人:</td>
			<td class='secRow3'><s:property value="active.apply_user_name" /></td>
			</tr>
			<tr>
			<td class='firstRow3'>申请单状态:</td>
			<td class='secRow3'>
				<s:if test="active.status==0"><span class="span_label">新申请</span></s:if>
				<s:if test="active.status==1"><span class="span_label"><font class="message_warning">申请审批中</font></span></s:if>
				<s:if test="active.status>=2">
					<span class="span_label"><font class="message_pass" title="">申请通过-可以执行</font></span>
					<span class="nowrap" title="${it:formatDate(active.pass_time,'yyyy-MM-dd HH:mm:ss')}">${it:formatDate(active.pass_time,'yyyy-MM-dd')}</span>
				</s:if>
				<!-- 
				<s:if test="active.status==3">开始结案</s:if>
				<s:if test="active.status==4"><font class="message_warning">结案审批中</font></s:if>
				<s:if test="active.status==5"><font class="message_pass">结案通过</font></s:if>
				 -->
			</td>
			<td class='firstRow3'>销售部审核:</td>
			<td class='secRow3'>
					<s:if test="active.sd_status==0"><span class="span_label">新单</span></s:if>
					<s:if test="active.sd_status==5"><span class="span_label"><font class="message_error">审核退回</font>(${active.sd_user_name})</span></s:if>
					<s:if test="active.sd_status==10"><span class="span_label"><font class="message_warning">待审核</font></span></s:if>
					<s:if test="active.sd_status==30"><span class="span_label"><font class="message_pass">大区经理已审</font>(${active.sd_user_name})</span></s:if>
					<s:if test="active.sd_status==40">
						<s:if test="active.sd_user_sign==null">
						<span class="span_label"><font class="message_pass">运营总监已审</font>(${active.sd_user_name})</span>
						</s:if>
						<s:else>
						<span class="user_sign">
							<img alt="" src="${active.sd_user_sign}" />
						</span>
						</s:else>
					</s:if>
					<s:if test="active.sd_status==50"><span class="span_label"><font class="message_pass">业务副总已审</font>(${active.sd_user_name})</span></s:if>
					<s:if test="active.sd_status==60"><span class="span_label"><font class="message_pass">总经理已审</font>(${active.sd_user_name})</span></s:if>
					<span class="nowrap" title="${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')}">${it:formatDate(active.sd_time,'yyyy-MM-dd')}</span>
				</td>
				<td class='firstRow3'>销管部审核:</td>
				<td class='secRow3'>
					<s:if test="active.smd_status==0"><span class="span_label">未签收</span></s:if>
					<s:if test="active.smd_status==5"><span class="span_label"><font class="message_error">审核退回</font>(${active.smd_user_name})</span></s:if>
					<s:if test="active.smd_status==10"><span class="span_label"><font class="message_warning">已签收</font></span></s:if>
					<s:if test="active.smd_status==30">
						<s:if test="active.smd_user_sign==null">
						<span class="span_label"><font class="message_pass">销管经理已审</font>(${active.smd_user_name})</span>
						</s:if>
						<s:else>
						<span class="user_sign">
						<img alt="" src="${active.smd_user_sign}" />
						</span>
						</s:else>
					</s:if>
					<s:if test="active.smd_status==40"><span class="span_label"><font class="message_pass">销管部经理已审</font>(${active.smd_user_name})</span></s:if>
					<s:if test="active.smd_status==50"><span class="span_label"><font class="message_pass">销管副总已审</font>(${active.smd_user_name})</span></s:if>
					<span class="nowrap" title="${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')}">${it:formatDate(active.smd_time,'yyyy-MM-dd')}</span>
				</td>
			</tr>
			
			<tr class="sign_tr">
			<td class='firstRow3'>财务部:</td>
			<td class='secRow3' valign="top" colspan="5">(签字/日期)</td>
			</tr>
			<tr class="sign_tr">
			<td class='firstRow3'>业务副总经理:</td>
			<td class='secRow3' valign="top" colspan="5">(签字/日期)</td>
			</tr>
			<tr class="sign_tr">
			<td class='firstRow3'>销售管理副总经理:</td>
			<td class='secRow3' valign="top" colspan="5">(签字/日期)</td>
			</tr>
			<tr class="sign_tr">
			<td class='firstRow3'>总经理:</td>
			<td class='secRow3'valign="top" colspan="5">(签字/日期)</td>
			</tr>
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
		<td class='secRow3'>${it:formatDate(active.plan_end,'yyyy-MM-dd')}</td>
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
				<td class='firstRowx' colspan="3" style="text-align: center;">
					公司预计费用
					<s:if test="active.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD')">
					<input type="button" id="addProduct" value="添加酒品" />
					</s:if>
					<s:if test="active.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_ADD')">
					<input type="button" id="addPosm" value="销售物料" />
					</s:if>
				</td>
				<td class='firstRowx' colspan="3" style="text-align: center;">
					参与客户&预计费用
					<s:if test="active.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOST_ADD')">
					<input type="button" id="addMember" value="添加参与客户" />
					</s:if>
				</td>
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
				<th>数量(瓶)</th>
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
		</td></tr>
		</table>
		<!-- <div style="page-break-after: always;">&nbsp; </div>  -->
		<table class="ilisttable" width="100%">
		<s:if test="'add'==viewFlag || active.status==0">
		<tr><td class='firstRowx' colspan="6" style="text-align: center;">方案说明</td></tr>
		<tr>
		<td class='secRow3' colspan="6">
			<s:textarea id="active_note" name="active.note" title="方案说明" dataLength="0,65535" controlName="方案说明" />
		</td>
		</tr>
		<tr><td colspan="6" height="5"></td></tr>
		</s:if>
		<s:else>
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
		</s:else>
		
		<tr>
			<td colspan="6">
			<div class="money_div">
			<table class="ilisttable" width="100%">
			<tr><td class='firstRowx' colspan="6" style="text-align: center;">备注</td></tr>
			<tr>
			<td id="active_remark" class='secRow3 oneditor' colspan="6">${active.remark }</td>
			</tr>
			</table>
			</div>
			</td>
		</tr>
		
		<tr class="printarea">
		<td class='firstRow3'>相关操作:</td>
		<td class='secRow3' colspan="5">
			<input type="button" value="返回" onclick="linkurl('<s:url action="active_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" />
			<input type="button" onclick="window.print();" value="打印本页"/>
			<span id="message"><s:property value="message" /></span>
		</td>
		</tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>