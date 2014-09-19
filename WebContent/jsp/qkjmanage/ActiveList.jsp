<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动申请单列表--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref" namespace="/manager" executeResult="true" />
<style type="text/css">
.ship_info {
cursor: pointer;
}
</style>
<body>
<div class="main" >
 	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="active_load"><s:param name="viewFlag">add</s:param></s:url>">添加申请单</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="active_list"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
 		<div class="label_hang">
            <div class="label_ltit">数字编号:</div>
            <div class="label_rwben"><s:textfield name="active.uuid" title="数字编号" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">原编号(S):</div>
            <div class="label_rwben"><s:textfield name="active.uid" title="编号" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">主题(%):</div>
            <div class="label_rwben"><s:textfield name="active.theme" title="主题" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben2">
            	<span class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="active.apply_dept_name" readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="active.apply_dept" readonly="true" />
				</span>
				<span class="lb nw">
				<img class="detail vam" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
				<s:checkbox id="apply_is_sub_dept" name="apply.is_sub_dept" cssClass="regular-checkbox" />
				<label for="apply_is_sub_dept"></label>包含子部门
				<span id="ajax_member_message"></span>
				</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人:</div>
            <div class="label_rwben label_rwb">
            	<div class="iselect">
            	<s:select id="membermanagerid" cssClass="selectKick" name="active.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
            	</div>
            </div>
		</div>
		<div class="label_hang">
            <div class="label_ltit">活动状态:</div>
            <div class="label_rwben label_rwb"><div class="iselect"><s:select name="active.status" cssClass="selectKick" headerKey="" headerValue="-活动状态-" list="#{0:'新申请',1:'申请审批中',2:'申请通过',3:'开始结案',4:'结案审批中',5:'结案通过'}" /></div></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(申)销售状态:</div>
            <div class="label_rwben label_rwb"><div class="iselect"><s:select name="active.sd_status" cssClass="selectKick"
				 list="#{0:'新单',5:'退回',10:'待审核',30:'大区经理已审',40:'运营总监已审',50:'业务副总已审',60:'总经理已审'}"
				 headerKey="" headerValue="--请选择--" /></div>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(申)销管状态:</div>
            <div class="label_rwben label_rwb"><div class="iselect"><s:select name="active.smd_status" cssClass="selectKick"
				 list="#{0:'新单/未签收',5:'退回',10:'已签收',30:'销管经理已审',50:'销管副总已审'}"
				 headerKey="" headerValue="--请选择--" /></div>
            </div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">(结)销售状态:</div>
            <div class="label_rwben label_rwb"><div class="iselect">
            	<s:select name="active.close_sd_status" cssClass="selectKick"
				 list="#{0:'新单',5:'退回',10:'待审核',30:'大区经理已审',40:'运营总监已审',50:'业务副总已审',60:'总经理已审'}"
				 headerKey="" headerValue="--请选择--" /></div>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(结)销管状态:</div>
            <div class="label_rwben label_rwb"><div class="iselect">
            	<s:select name="active.close_smd_status" cssClass="selectKick"
				 list="#{0:'新单/未签收',5:'退回',10:'已签收',30:'销管经理已审',50:'销管副总已审'}"
				 headerKey="" headerValue="--请选择--" /></div>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben label_rwb">
            	<div class="iselect">
            	<s:select name="active.ship_status"  cssClass="selectKick" headerKey="" headerValue="-发货状态-" list="#{0:'未发货',10:'已发货',99:'其他' }" />
            	</div>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请通过时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="jqdate iI iI-f" type="text" name="active.pass_time_start" title="从" value="${it:formatDate(active.pass_time_start,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="jqdate iI iI-t" type="text" name="active.pass_time_end" title="到" value="${it:formatDate(active.pass_time_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">结案通过时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="jqdate iI iI-f" type="text" name="active.close_pass_time_start" title="从" value="${it:formatDate(active.close_pass_time_start,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="jqdate iI iI-t" type="text" name="active.close_pass_time_end" title="到" value="${it:formatDate(active.close_pass_time_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">计划开始时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="jqdate iI iI-f" type="text" name="active.plan_start_begin" title="从" value="${it:formatDate(active.plan_start_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="jqdate iI iI-t" type="text" name="active.plan_start_end" title="到" value="${it:formatDate(active.plan_start_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        </div>
    </div>
 	</div>
 	</s:form>
 	<div class="tab_warp">
 		<table>
 		<tr id="coltr">
	    <th class="td1">编号</th>
		<th class="td2">申请部门</th>
		<th class="td1">申请人</th>
		<th class="td5">主题</th>
		<th class="td5">活动地点</th>
		<th class="td1">活动状态</th>
		<th class="td3">销售审核状态</th>
		<th class="td3">销管审核状态</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="actives" status="sta">
	  	<tr id="showtr${uuid}">
		    <td class="td1 nw">${uuid}</td>
			<td class="td2 nw">${apply_dept_name}</td>
			<td class="td1 nw">${apply_user_name}</td>
			<td class="td5 longnote" title="${theme}">${it:subString(theme,22)}</td>
			<td class="td5 nw" title="${address}" class="nowrap">${it:subString(address,6)}</td>
			<td  class="td1">
				<s:if test="status==-1"><font class="message_error">已作废</font></s:if>
				<s:if test="status==0">新申请</s:if>
				<s:if test="status==1"><font class="message_warning">申请审批中</font></s:if>
				<s:if test="status==2"><font class="message_pass" title="${it:formatDate(pass_time,'yyyy-MM-dd HH:mm:ss')}">申请通过</font></s:if>
				<s:if test="status==3">开始结案</s:if>
				<s:if test="status==4"><font class="message_warning">结案审批中</font></s:if>
				<s:if test="status==5"><font class="message_pass" title="${it:formatDate(close_pass_time,'yyyy-MM-dd HH:mm:ss')}">结案通过</font></s:if>
				<s:if test="status==5">
				<s:if test="ship_status==0"><font class="message_error ship_info"  data="${uuid}">未发货</font></s:if>
				<s:if test="ship_status==10"><font class="message_pass ship_info"  data="${uuid}">已发货</font></s:if>
				<span class="ship_hidden_info" style="display:none;">
					<span id="ship_no_${uuid}">${ship_no}</span>
					<span id="ship_type_${uuid}">${ship_type}</span>
					<span id="ship_date_${uuid}">${it:formatDate(ship_date,"yyyy-MM-dd")}</span>
					<span id="ship_phone_${uuid}">${ship_phone}</span>
					<span id="ship_status_${uuid}">${ship_status}</span>
					<span id="active_remark_${uuid}">${remark}</span>
				</span>
				</s:if>
			</td>
			<td  class="td3">
				<s:if test="status<=2">
					<s:if test="sd_status==0">新单</s:if>
					<s:if test="sd_status==5"><font class="message_error" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
					<s:if test="sd_status==10"><font class="message_warning">待审核</font></s:if>
					<s:if test="sd_status==30"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">大区经理已审</font></s:if>
					<s:if test="sd_status==40"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已审</font></s:if>
					<s:if test="sd_status==50"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">业务副总已审</font></s:if>
					<s:if test="sd_status==60"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审</font></s:if>
				</s:if>
				<s:if test="status>2">
				<s:if test="close_sd_status==0">新单</s:if>
				<s:if test="close_sd_status==5"><font class="message_error" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
				<s:if test="close_sd_status==10"><font class="message_warning">待审核</font></s:if>
				<s:if test="close_sd_status==30"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">大区经理已审</font></s:if>
				<s:if test="close_sd_status==40"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已审</font></s:if>
				<s:if test="close_sd_status==50"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">业务副总已审</font></s:if>
				<s:if test="close_sd_status==60"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审</font></s:if>
				</s:if>
			</td>
			<td  class="td3">
				<s:if test="status<=2">
					<s:if test="smd_status==0">未签收</s:if>
					<s:if test="smd_status==5"><font class="message_error" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
					<s:if test="smd_status==10"><font class="message_warning">已签收</font></s:if>
					<s:if test="smd_status==30"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审</font></s:if>
					<s:if test="smd_status==50"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审</font></s:if>
				</s:if>
				<s:if test="status>2">
				<span class="span_label">
					<s:if test="close_smd_status==0">新单</s:if>
					<s:if test="close_smd_status==5"><font class="message_error" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
					<s:if test="close_smd_status==10"><font class="message_warning">已签收</font></s:if>
					<s:if test="close_smd_status==30"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审</font></s:if>
					<s:if test="close_smd_status==50"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审</font></s:if>
				</span>
				</s:if>
			</td>
			<td class="td4 op-area">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_APPLY')">
				<s:if test="status < 2">
		    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="active_load"><s:param name="viewFlag">mdy</s:param><s:param name="active.uuid" value="uuid"></s:param></s:url>">申请修改</a>
		    	</s:if>
		    	<s:else>
		    	<a class="input-gray" href="<s:url namespace="/qkjmanage" action="active_view"><s:param name="active.uuid" value="uuid" /></s:url>">申请查看</a>
		    	</s:else>
		    	</s:if>
		    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE')">
		    	<s:if test="status == 2">
		    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="uuid"></s:param></s:url>">开始结案</a>
		    	</s:if>
		    	<s:if test="status > 2 && status < 5">
		    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="uuid"></s:param></s:url>">结案修改</a>
		    	</s:if>
		    	<s:if test="status >= 4">
		    	<a class="input-gray" href="<s:url namespace="/qkjmanage" action="active_closeView"><s:param name="active.uuid" value="uuid"></s:param></s:url>">结案查看</a>
		    	</s:if>
		    	</s:if>
		    	<s:if test="status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_DEL')">
		    	<a class="input-red" href="<s:url namespace="/qkjmanage" action="active_del"><s:param name="active.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
		    	</s:if>	   
		    </td>
		    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
	  	</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div class="pagination">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
		</script>
	</div>
</div>
 <!-- HIDDEN AREA BEGIN -->
 <div id="mdyActiveShipInfoForm" class="label_con idialog" title="修改发货信息">
<s:form name="form_mdyActiveShipInfoForm" action="mdyActiveShipInfo" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben"><s:select id="e_active_ship_status" name="active.ship_status" list="#{0:'未发货',10:'已发货',99:'其他' }" /></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">出库日期:</div>
            <div class="label_rwben"><input id="e_active_ship_date" class="jqdate validate[custom[date]]" type="text" name="active.ship_date" title="出库日期" value="${it:formatDate(active.ship_date,'yyyy-MM-dd')}" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">运单号:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_no" cssClass="validate[maxSize[48]]" name="active.ship_no" title="运单号码" /></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">物流名称:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_type" name="active.ship_type" cssClass="validate[maxSize[32]]" title="物流类型/名称" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">物流电话:</div>
            <div class="label_rwben"><s:textfield id="e_ship_phone" name="active.ship_phone"  cssClass="validate[maxSize[48]]" title="物流电话" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">备注:</div>
            <div class="label_rwben"><s:textarea id="e_active_remark" name="active.remark" cssClass="validate[maxSize[65535]]" title="备注" cols="3" rows="4" /></div>
        </div>
        <div class="label_hang label_button tac">
           	<s:hidden id="e_active_uuid" name="active.uuid" value="%{active.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYSHIPINFO')">
			<s:submit id="mdyActiveShipInfo" name="mdyActiveShipInfo" value="确定" action="mdyActiveShipInfo" />
			</s:if>
        </div>
    </div>
</s:form>
</div>
 <div class="hidden_area">
<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
</div>
<!-- HIDDEN AREA END -->
<script type="text/javascript">
//var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_apply_dept = '${active.apply_dept}';
//var curr_apply_user = '${active.apply_user}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	if(curr_apply_dept!='') {
		loadManagers(curr_apply_dept,'${active.apply_user}');
	}
	if($(".ship_info").length>0) {
		$(".ship_info").bind("click",function(){
			setShipVal($(this).attr("data"));
			$("#mdyActiveShipInfoForm").dialog("open");
		});
	}
	$("#mdyActiveShipInfoForm").dialog({
	      autoOpen: false,
	      modal: true
	});
 });
 
function setShipVal(p_uuid) {
	$("#e_active_uuid").val(p_uuid);
	$("#e_active_ship_phone").val($("#ship_phone_"+p_uuid).text());
	$("#e_active_ship_type").val($("#ship_type_"+p_uuid).text());
	$("#e_active_ship_no").val($("#ship_no_"+p_uuid).text());
	$("#e_active_ship_date").val($("#ship_date_"+p_uuid).text());
	$("#e_active_ship_status").val($("#ship_status_"+p_uuid).text());
	$("#e_active_remark").text($("#active_remark_"+p_uuid).text());
}
</script>
</body>
</html>