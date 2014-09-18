<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>至事由申请列表--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref" namespace="/manager" executeResult="true" />
<script type="text/javascript">
$(function(){
	//CommonUtil.pickrow('listTable');
 });
 
var sobj01;
var selectDept = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_nameid").val(val2);
		//loadManagers(val1);
	};
	sobj01.create();
	sobj01.open();
};
</script>
<style type="text/css">
.mdyApplyShipInfo_Link {
cursor: pointer;
}
.ship_hidden_info {
display: none;
}
</style>
<body>
<div class="main" >
 	<p class="dq_step">
		${path}
		<a href="#">添加至事由</a>
	</p>
 	<s:form name="form_serach" action="apply_list"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">申请编号:</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield name="apply.uuid" /></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请时间:</div>
            <div class="label_rwben"><span class="label_rwb2">
            	<span class="nowrap label_inline">
				<input type="text" class="jqdate" name="apply.apply_time_begin" title="从" value="${it:formatDate(apply.apply_time_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_inline">-</span>
				<span class="nowrap label_inline">
				<input  class="jqdate" type="text" name="apply.apply_time_end" title="到" value="${it:formatDate(apply.apply_time_end,'yyyy-MM-dd')}" />
				</span>
            </span></div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">事(%):</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield name="apply.title"/></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">审核时间:</div>
            <div class="label_rwben"><span class="label_rwb2">
            	<span class="nowrap label_inline">
				<input  class="jqdate" type="text" name="apply.check_time_begin" title="从" value="${it:formatDate(apply.check_time_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_inline">-</span>
				<span class="nowrap label_inline">
				<input  class="jqdate" type="text" name="apply.check_time_end" title="到" value="${it:formatDate(apply.check_time_end,'yyyy-MM-dd')}" />
				</span>
            </span></div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben"><span class="label_rwb2">
            	<s:textfield title="部门" id="userdept_codeid" name="apply.apply_dept" readonly="true" />
				<s:textfield title="部门名称" id="userdept_nameid" name="apply.apply_dept_name" readonly="true" />
				<img class="mpoint" src='<s:url value="/images/open2.gif" />' onclick="SelectDept01('userdept_codeid','userdept_nameid');" />
				<s:checkbox id="apply_is_sub_dept" name="apply.is_sub_dept" data-theme="ch" />
				<label for="apply_is_sub_dept">包含子部门</label>
				<span id="ajax_member_message"></span>
            </span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">状态:</div>
            <div class="label_rwben"><span class="label_rwb2">
            	<s:select name="apply.status_sp" title="状态" headerKey="" headerValue="-申请状态-" list="#{-1:'已作废',0:'新申请',5:'审核退回',10:'待审核',20:'大区经理已审',25:'销管经理已审',30:'运营总监已审'}" />
				<s:select id="form_apply_ship_status" name="apply.ship_status"  headerKey="" headerValue="-发货状态-" list="#{0:'未发货',10:'已发货',20:'已受理' }" />
            </span></div>
        </div>
        </div>
        <div class="label_main tac"><s:submit value="搜索" /> <s:reset value="重置" /></div>
 	</div>
 	</s:form>
 	<div class="tab_warp">
		<table>
			<tr id="coltr">
			    <th>申请编号</th>
			    <th class="td1">申请时间</th>
			    <th class="td1">申请部门</th>
			    <th>申请人</th>
				<th class="td3">事</th>
				<th class="td2">状态</th>
				<th class="td4">发货情况</th>
				<th class="td4">操作</th>
				<th class="td0">查看</th>
			</tr>
			<s:iterator value="applys" status="sta">
			<tr id="showtr${uuid}">
			    <td>${uuid}</td>
			    <td class="td1 nowrap">${it:formatDate(apply_time,'yyyy-MM-dd')}</td>
			    <td class="td1 nowrap">${apply_dept_name}</td>
			    <td class="nowrap">${apply_user_name}</td>
				<td class="td3 longnote" title="${title}">${it:subString(title,40)}</td>
				<td class="td2 nowrap" title="${check_user_name}-${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}-${check_note}">
					<s:if test="-1==status"><span class="message_error">已作废<br />(${check_user_name})</span></s:if>
					<s:if test="0==status">新申请</s:if>
					<s:if test="5==status"><span class="message_error">已退回<br />(${check_user_name})</span></s:if>
					<s:if test="10==status"><span class="message_warning">待审核</span></s:if>
					<s:if test="20==status">
					<s:if test="0==sp_check_status || 5==sp_check_status"><span class="message_pass">大区经理已审</span></s:if>
					<s:elseif test="10==sp_check_status"><span class="message_pass">销管经理已审</span></s:elseif>
					</s:if>
					<s:if test="30==status"><span class="message_pass">运营总监已审</span></s:if>
				</td>
				<td class="td4 nowrap">
					<s:if test="30==status">
					<a  href="#mdyApplyShipInfoForm" data-rel="popup" data-position-to="window"  data="${uuid}" class="mdyApplyShipInfo_Link">
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
				<td class="td4">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_VIEW')">
					<s:if test="status==30">
					<a data-role="button" data-ajax="false" data-inline="true" data-theme="lb" href="<s:url namespace="/qkjmanage" action="apply_print"><s:param name="apply.uuid" value="uuid"></s:param></s:url>">打印</a>
					</s:if>
					<s:elseif test="status<=20">
			    	<a  data-role="button"  data-ajax="false" data-inline="true" data-theme="lb" href="<s:url namespace="/qkjmanage" action="apply_load"><s:param name="viewFlag">mdy</s:param><s:param name="apply.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:elseif>
			    	</s:if>
			    	<s:if test="(status==0||status==5)&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_DEL')">
			    	<a  data-role="button"  data-inline="true" data-theme="lb" href="<s:url namespace="/qkjmanage" action="apply_del"><s:param name="apply.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>
				</td>
				<td class="td0"><a data-role="button" data-inline="true" data-theme="lb" onClick="showDetail('showtr${uuid}');">查看</a></td>
			</tr>
			</s:iterator>
			<tr>
			    <td colspan="20" class="pagearea">
				<script type="text/javascript">
				var spage = new ShowPage(${currPage});
				spage.show2(${recCount},${pageSize},2);
				</script>
				</td>
		  </tr>
	    </table>
	</div>
 </div>
 <!-- <div data-role="footer"></div>  -->
 <!-- HIDDEN AREA BEGIN -->
 <div class="hidden_area">
 <div id="mdyApplyShipInfoForm" data-role="popup" data-overlay-theme="b" data-theme="a" data-corners="false" class="label_con ui-corner-all idialog" title="修改发货信息" style="width:360px;">
   <div data-role="header" data-theme="th">
 	修改发货信息
 	<a data-role="button" data-icon="delete" data-iconpos="notext" data-inline="true" data-theme="b"  data-ajax="false" data-rel="back" class="ui-btn-right">X</a>
 </div>
<s:form name="form_mdyApplyShipInfoForm" action="mdyApplyShipInfo" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple" data-ajax="false">
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">审核意见:</div>
            <div class="label_rwben"><span id="form_apply_check_note" class="label_rwb"></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben"><s:select id="form_apply_ship_status" data-role="none" name="apply.ship_status" list="#{0:'未发货',10:'已发货',20:'已受理' }" /></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">出库日期:</div>
            <div class="label_rwben"><span class="label_rwb"><input id="form_apply_ship_date" class="jqdate" data-role="date" type="text" name="apply.ship_date" title="出库日期" value="${it:formatDate(apply.ship_date,'yyyy-MM-dd')}" dataType="date" controlName="出库日期" /></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">运单号:</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield id="form_apply_ship_no" name="apply.ship_no" title="运单号码" dataLength="0,48" controlName="运单号码" /></span></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">物流类型/名称:</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield id="form_apply_ship_type" name="apply.ship_type" title="物流类型/名称" dataLength="0,32" controlName="物流电话" /></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">物流电话:</div>
            <div class="label_rwben"><span class="label_rwb"><s:textfield id="form_apply_ship_phone" name="apply.ship_phone" title="物流电话" dataLength="0,48" controlName="物流电话" /></span></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">相关操作：</div>
            <div class="lb_btns">
            	<s:hidden id="form_apply_uuid" name="apply.uuid" value="%{apply.uuid}" />
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYAPPLYSHIPINFO')">
				<s:submit id="mdyApplyShipInfo" name="mdyApplyShipInfo" value="确定" action="mdyApplyShipInfo" />
				</s:if>
            </div>
        </div>
    </div>
</s:form>
</div>
<div id="infoDetail" data-role="popup" data-theme="a" data-overlay-theme="b" class="label_con ui-corner-all idialog" style="width:450px;">
<div data-role="header" data-theme="th">详情信息
<a data-role="button" data-icon="delete" data-iconpos="notext" data-inline="true" data-theme="b"  data-ajax="false" data-rel="back" class="ui-btn-right">X</a>
</div>
<div id="detailMain" data-role="content" class="label_main"></div>
</div>
</div>
<!-- HIDDEN AREA END -->
</body>
</html>