<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>至事由申请列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.mdyApplyShipInfo_Link {
cursor: pointer;
}
.ship_hidden_info {
display: none;
}
</style>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
 	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="apply_load"><s:param name="viewFlag">add</s:param></s:url>">添加至事由</a></span>
		</s:if>
	</div>
 	<s:form id="serachForm" name="serachForm" action="apply_list"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name='apply.uuid' /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">事(%):</div>
            <div class="label_rwben"><s:textfield name="apply.title"/></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input type="text" class="datepicker iI iI-f" name="apply.apply_time_begin" title="从" value="${it:formatDate(apply.apply_time_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input type="text" class="datepicker iI iI-t" name="apply.apply_time_end" title="到" value="${it:formatDate(apply.apply_time_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben2">
            	<span class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="apply.apply_dept_name" readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="apply.apply_dept" readonly="true" />
				</span>
				<span class="lb nw">
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid');" />
				<s:checkbox id="apply_is_sub_dept" name="apply.is_sub_dept" cssClass="regular-checkbox" />
				<label for="apply_is_sub_dept"></label>包含子部门
				<span id="ajax_member_message"></span>
				</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">审核时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="datepicker iI iI-f" type="text" name="apply.check_time_begin" title="从" value="${it:formatDate(apply.check_time_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="datepicker iI iI-t" type="text" name="apply.check_time_end" title="到" value="${it:formatDate(apply.check_time_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">状态:</div>
            <div class="label_rwben2">
            	<span class="label_rwb">
            	<s:select name="apply.status_sp" title="状态" headerKey="" headerValue="-申请状态-" list="#{-1:'已作废',0:'新申请',5:'审核退回',10:'待审核',20:'经理/大区已审',25:'销管经理已审',30:'运营总监已审',40:'销售副总已审',50:'总经理已审'}" />
				</span>
				<span class="label_rwb">
				<s:select name="apply.ship_status" headerKey="" headerValue="-发货状态-" list="#{0:'未发货',10:'已发货',20:'已受理' }" />
            	</span>
            </div>
        </div>
        <div class="label_hang tac">
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
			    <th>编号</th>
			    <th class="td1">申请时间</th>
			    <th class="td2">申请部门</th>
			    <th class="td1">申请人</th>
				<th class="td3">事</th>
				<th class="td1">状态</th>
				<th class="td4">发货情况</th>
				<th class="td4">操作</th>
				<th class="td0">查看</th>
			</tr>
			<s:iterator value="applys" status="sta">
			<tr id="showtr${uuid}">
			    <td>${uuid}</td>
			    <td class="td1 nw">${it:formatDate(apply_time,'yyyy-MM-dd')}</td>
			    <td class="td2 nw">${apply_dept_name}</td>
			    <td class="td1 nw">${apply_user_name}</td>
				<td class="td3 longnote" title="${title}">${it:subString(title,40)}</td>
				<td class="td1 nw" title="${check_user_name}-${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}-${check_note}">
					<s:if test="-1==status"><span class="message_error">已作废|(${check_user_name})</span></s:if>
					<s:if test="0==status">新申请</s:if>
					<s:if test="5==status"><span class="message_error">已退回(${check_user_name})</span></s:if>
					<s:if test="%{apply_dept==1 || apply_dept.substring(0,3)!='210' || status>=20}">
					<s:if test="10==status"><span class="message_warning">待审核</span></s:if>
					<s:if test="20==status">
					<s:if test="0==sp_check_status || 5==sp_check_status"><span class="message_pass">经理/大区已审</span></s:if>
					<s:elseif test="10==sp_check_status"><span class="message_pass">销管经理已审</span></s:elseif>
					</s:if>
					</s:if>
					<s:else>
					<s:if test="10==status && 10!=sp_check_status"><span class="message_warning">待审核</span></s:if>
					<s:if test="10==status">
					<s:if test="10==sp_check_status"><span class="message_pass">销管经理已审</span></s:if>
					</s:if>
					</s:else>
					<s:if test="30==status"><span class="message_pass">运营总监已审</span></s:if>
					<s:if test="40==status"><span class="message_pass">销售副总已审</span></s:if>
					<s:if test="50==status"><span class="message_pass">总经理已审</span></s:if>
				</td>
				<td class="td4 op-area nw">
					<s:if test="30<=status">
					<a  href="javascript:;" data="${uuid}" class="mdyApplyShipInfo_Link input-nostyle">
					<s:if test="0==ship_status">未发货</s:if>
					<s:if test="10==ship_status"><span class="message_pass">已发货</span></s:if>
		            <s:if test="20==ship_status"><span class="message_warning">已受理</span></s:if>
		            </a>
					<span class="ship_hidden_info" style="display:none;">
						<span id="ship_no_${uuid}">${ship_no}</span>
						<span id="ship_type_${uuid}">${ship_type}</span>
						<span id="ship_date_${uuid}">${it:formatDate(ship_date,"yyyy-MM-dd")}</span>
						<span id="ship_phone_${uuid}">${ship_phone}</span>
						<span id="ship_status_${uuid}">${ship_status}</span>
						<span id="check_note_${uuid}">${check_note}</span>
					</span>
					</s:if>
				</td>
				<td class="td4 op-area">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_VIEW')">
					<s:if test="status>=30">
					<a class="input-gray" href="<s:url namespace="/qkjmanage" action="apply_print"><s:param name="apply.uuid" value="uuid"></s:param></s:url>">打印</a>
					</s:if>
					
			    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="apply_load"><s:param name="viewFlag">mdy</s:param><s:param name="apply.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	
			    	</s:if>
			    	<s:if test="(status==0||status==5)&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_DEL')">
			    	<a class="input-red" href="<s:url namespace="/qkjmanage" action="apply_del"><s:param name="apply.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>
				</td>
				<td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
			</tr>
			</s:iterator>
	    </table>
	</div>
	
	<div id="listpage" class="pagination"></div>
 <!-- <div data-role="footer"></div>  -->
 </div>
 </div>
 <!-- HIDDEN AREA BEGIN -->
 <div class="dn">
 <div id="mdyApplyShipInfoForm" class="label_con idialog idialog500" title="修改发货信息">
<s:form name="form_mdyApplyShipInfoForm" action="mdyApplyShipInfo" cssClass="validForm" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">审核意见:</div>
            <div><span id="form_apply_check_note"></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben"><s:select id="form_apply_ship_status" name="apply.ship_status" list="#{0:'未发货',10:'已发货',20:'已受理' }" /></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">出库日期:</div>
            <div class="label_rwben"><span class="label_rwb"><input id="form_apply_ship_date" class="datepicker validate[custom[date]]" type="text" name="apply.ship_date" title="出库日期" value="${it:formatDate(apply.ship_date,'yyyy-MM-dd')}" /></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">运单号:</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield id="form_apply_ship_no" name="apply.ship_no" title="运单号码" cssClass="validate[maxSize[48]]" /></span></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">物流名称:</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield id="form_apply_ship_type" name="apply.ship_type" title="物流类型/名称" cssClass="validate[maxSize[32]]" /></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">物流电话:</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield id="form_apply_ship_phone" name="apply.ship_phone" title="物流电话"  cssClass="validate[maxSize[48]]" /></span></div>
        </div>
        <div class="label_hang  label_button tac">
           	<s:hidden id="form_apply_uuid" name="apply.uuid" value="%{apply.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYAPPLYSHIPINFO')">
			<s:submit id="mdyApplyShipInfo" name="mdyApplyShipInfo" value="确定" action="mdyApplyShipInfo" />
			</s:if>
        </div>
    </div>
</s:form>
</div>
</div>
<!-- HIDDEN AREA END -->
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"${assets.typea}",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none",
		required:false
	});
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
 });
</script>
<script type="text/javascript">
$(function(){
	$(function(){
		$("#mdyApplyShipInfoForm").dialog({
		      autoOpen: false,
		      modal: true
		});
		$(".mdyApplyShipInfo_Link").click(function(){
			setShipVal($(this).attr("data"));
			$("#mdyApplyShipInfoForm").dialog("open");
		});
		
		$("#infoDetail").delegate(".mdyApplyShipInfo_Link","click",function(){
			setShipVal($(this).attr("data"));
			$("#mdyApplyShipInfoForm").dialog("open");
		});
	});
});

function setShipVal(p_uuid) {
	$("#form_apply_uuid").val(p_uuid);
	$("#form_apply_ship_phone").val($("#ship_phone_"+p_uuid).text());
	$("#form_apply_ship_type").val($("#ship_type_"+p_uuid).text());
	$("#form_apply_ship_no").val($("#ship_no_"+p_uuid).text());
	$("#form_apply_ship_date").val($("#ship_date_"+p_uuid).text());
	$("#form_apply_ship_status").val($("#ship_status_"+p_uuid).text());
	$("#form_apply_check_note").text($("#check_note_"+p_uuid).text());
}
</script>
</body>
</html>