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
	$("#mdyActiveShipInfoForm").dialog({
	      autoOpen: false,
	      height: 320,
	      width: 700,
	      modal: true
	});
	
	$("#mdyActiveShipInfo_Button").click(function(){
		$("#mdyActiveShipInfoForm").dialog("open");
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
		<span class="title1">活动结案单(${active.uid})</span>
		<span class="extra1 printarea">
			<a href="<s:url action="active_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>" >活动列表</a>
		</span>	
	</div>
<s:form name="form_mdyCloseActive" action="mdyCloseActive" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != active">
		  <tr>
			<td class='firstRow3'><span style="color:red;">*</span> 申请编号:</td>
			<td class='secRow3'>${active.uid}<s:hidden name="active.uid" /><s:hidden name="active.uuid" title="" /></td>
			<td class='firstRow3'><span style="color:red;">*</span> 申请部门:</td>
			<td class='secRow3'><s:property value="active.apply_dept_name" /></td>
			<td class='firstRow3'><span style="color:red;">*</span> 申请人:</td>
			<td class='secRow3'><s:property value="active.apply_user_name" /></td>
			</tr>
			<tr>
			<td class='firstRow3'>结案单状态:</td>
			<td class='secRow3'>
				<s:if test="active.status==2"><span class="span_label"><font class="message_prompt">未开始结案</font></span></s:if>
				<s:if test="active.status==3"><span class="span_label">开始结案</span></s:if>
				<s:if test="active.status==4"><span class="span_label"><font class="message_warning">结案审批中</font></span></s:if>
				<s:if test="active.status==5">
					<span class="span_label"><font class="message_pass">结案通过</font></span>
					<span class="nowrap" title="${it:formatDate(active.close_pass_time,'yyyy-MM-dd HH:mm:ss')}">${it:formatDate(active.close_pass_time,'yyyy-MM-dd')}</span>
				</s:if>
			</td>
			<td class='firstRow3'><span style="color:red;">*</span> 销售部审核:</td>
			<td class='secRow3'>	
				<s:if test="active.close_sd_status>0">
					<s:if test="active.close_sd_status==0"><span class="span_label">新单</span></s:if>
					<s:if test="active.close_sd_status==5"><span class="span_label"><font class="message_error">审核退回</font>(${active.close_sd_user_name})</span></s:if>
					<s:if test="active.close_sd_status==10"><span class="span_label"><font class="message_warning">待审核</font></span></s:if>
					<s:if test="active.close_sd_status==30"><span class="span_label"><font class="message_pass">大区经理已审</font>(${active.close_sd_user_name})</span></s:if>
					<s:if test="active.close_sd_status==40">
						<s:if test="active.close_sd_user_sign==null">
						<span class="span_label"><font class="message_pass">运营总监已审</font>(${active.close_sd_user_name})</span>
						</s:if>
						<s:else>
						<span class="user_sign">
							<img alt="" src="${active.close_sd_user_sign}" /><br />
						</span>
						</s:else>
					</s:if>
					<s:if test="active.close_sd_status==50"><span class="span_label"><font class="message_pass">业务副总已审</font>(${active.close_sd_user_name})</span></s:if>
					<s:if test="active.close_sd_status==60"><span class="span_label"><font class="message_pass">总经理已审</font>(${active.close_sd_user_name})</span></s:if>
					<span class="nowrap" title="${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')}">${it:formatDate(active.close_sd_time,'yyyy-MM-dd')}</span>
				</s:if>
			</td>
			<td class='firstRow3'><span style="color:red;">*</span> 销管部审核:</td>
			<td class='secRow3'>
				<s:if test="active.close_smd_status>0">
					<s:if test="active.close_smd_status==0"><span class="span_label">未签收</span></s:if>
					<s:if test="active.close_smd_status==5"><span class="span_label"><font class="message_error">审核退回</font>(${active.close_smd_user_name})</span></s:if>
					<s:if test="active.close_smd_status==10"><span class="span_label"><font class="message_warning">已签收</font></span></s:if>
					<s:if test="active.close_smd_status==30">
						<s:if test="active.close_smd_user_sign==null">
						<span class="span_label"><font class="message_pass">销管经理已审</font>(${active.close_smd_user_name})</span>
						</s:if>
						<s:else>
						<span class="user_sign">
						<img alt="" src="${active.close_smd_user_sign}" />
						</span>
						</s:else>
					</s:if>
					<s:if test="active.close_smd_status==40"><span class="span_label"><font class="message_pass">销管部经理已审</font>(${active.close_smd_user_name})</span></s:if>
					<s:if test="active.close_smd_status==50"><span class="span_label"><font class="message_pass">销管副总已审</font>(${active.close_smd_user_name})</span></s:if>
				</s:if>
				<span class="nowrap" title="${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')}">${it:formatDate(active.close_smd_time,'yyyy-MM-dd')}</span>
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
				<th>数量(瓶)</th>
				<th>合计</th>
				</tr>
				<s:iterator value="activeProductsClose" status="sta">
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
<s:if test="activePosmsClose.size != 0">
			<div class="active_p_title active_p_title_second">公司销售物料(除酒品之外的其他费用,全部算物料)</div>
			<div class="active_p_list">
				<table class="ilisttable listtable_show" width="100%">
				<tr>
				<th>名目</th>
				<th>名目说明</th>
				<th>金额</th>
				</tr>
				<s:iterator value="activePosmsClose" status="sta">
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
				</tr>
				<s:iterator value="activeMemcostsClose" status="sta">
				<tr>
				<td class="nowrap"><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
				<td class="nowrap">${title}</td>
				<td>${note}</td>
				<td class="nowrap" align="center">￥${total_price}</td>
				<td class="nowrap" align="center">￥${with_score}</td>
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
		<s:if test="active.status==3">
		<tr><td class='firstRowx' colspan="6" style="text-align: center;">活动概况</td></tr>
		<tr>
		<td class='secRow3' colspan="6">${active.close_note}</td>
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
				<td class='firstRowx' colspan="8" style="text-align: center;">
					发货信息
					<s:if test="active.ship_status==0"><span class="message_error">【未发货】</span></s:if>
					<s:if test="active.ship_status==10"><span class="message_pass">【已发货】</span></s:if>
				</td>
			</tr>
			<tr>
			<td class='firstRowx'>发货时间:</td>
			<td class='secRowx'>${it:formatDate(active.ship_date,'yyyy-MM-dd')}</td>
			<td class='firstRowx'>运单号:</td>
			<td class='secRowx'>${active.ship_no}</td>
			<td class='firstRowx'>物流名称:</td>
			<td class='secRowx'>${active.ship_type}</td>
			<td class='firstRowx'>物流电话:</td>
			<td class='secRowx'>${active.ship_phone}</td>
			</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr><td colspan="6" height="5"></td></tr>
		<tr>
			<td colspan="6">
			<div class="money_div">
			<table class="ilisttable" width="100%">
			<tr><td class='firstRowx oneditor' colspan="6" style="text-align: center;">备注</td></tr>
			<tr>
			<td id="active_remark" class='secRow3' colspan="6">${active.remark }</td>
			</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr class="printarea">
		<td class='firstRow3'>相关操作:</td>
		<td class='secRow3' colspan="5">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYSHIPINFO') && active.status==5">
			<input id="mdyActiveShipInfo_Button" type="button" value="填写发货信息" />
			</s:if>
			<input type="button" value="返回" onclick="linkurl('<s:url action="active_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" />
			<input type="button" onclick="window.print();" value="打印本页"/>
		</td>
		</tr>
	</table>	
</s:form>
	</div>
</div>
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

<div id="mdyActiveShipInfoForm" title="修改发货信息">
<s:form name="form_mdyActiveShipInfoForm" action="mdyActiveShipInfo" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 发货状态:</td>
		<td class='secRow'><s:select name="active.ship_status" list="#{0:'未发货',10:'已发货' }" /></td>
		</tr>
		<tr>
		<td class='firstRow'>出库日期:</td>
		<td class='secRow'>
			<input id="form_active_ship_date" type="text" name="active.ship_date" title="出库日期" value="${it:formatDate(active.ship_date,'yyyy-MM-dd')}" dataType="date" controlName="出库日期" />
			<script type="text/javascript">$("#form_active_ship_date").datepicker();</script>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>运单号:</td>
		<td class='secRow'><s:textfield name="active.ship_no" title="运单号码" dataLength="0,48" controlName="运单号码" /></td>
		</tr>
		<tr>
		<td class='firstRow'>物流类型/名称:</td>
		<td class='secRow'><s:textfield name="active.ship_type" title="物流类型/名称" dataLength="0,32" controlName="物流电话" /></td>
		</tr>
		<tr>
		<td class='firstRow'>物流电话:</td>
		<td class='secRow'><s:textfield name="active.ship_phone" title="物流电话" dataLength="0,48" controlName="物流电话" /></td>
		</tr>
		<tr>
		<td class='firstRow'>备注:</td>
		<td class='secRow'><s:textarea name="active.remark" title="备注" dataLength="0,65535" cols="3" rows="4" controlName="备注"  cssStyle="width:80%;" /></td>
		</tr>
	<tr>
	    <td colspan="20" class="buttonarea">
	    	<s:hidden name="active.uuid" value="%{active.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYSHIPINFO')">
			<s:submit id="mdyActiveShipInfo" name="mdyActiveShipInfo" value="确定" action="mdyActiveShipInfo" />
			</s:if>
		</td>
    </tr>
</table>	
</s:form>
</div>
</body>
</html>