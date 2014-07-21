<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>至事由申请列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
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
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">至事由申请列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="apply_load"><s:param name="viewFlag">add</s:param></s:url>" >添加至事由申请</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="apply_list"  method="get" namespace="/qkjmanage" theme="simple">
		<s:hidden name="apply.status_start" />
		<s:hidden name="apply.status_end" />
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>申请编号:</td>
			<td class='secRow'><s:textfield name="apply.uuid" /></td>
			<td class='firstRow'>事(%):</td>
			<td class='secRow'><s:textfield name="apply.title"/></td>
			</tr><tr>
			<td class='firstRow'>申请时间:</td>
			<td class='secRow'>
				<span class="nowrap">
				从:
				<input id="apply_apply_time_start" type="text" name="apply.apply_time_begin" title="从" value="${it:formatDate(apply.apply_time_begin,'yyyy-MM-dd')}" />
				</span>
				<script type="text/javascript">$("#apply_apply_time_start").datepicker();</script>
				<span class="nowrap">
				到:
				<input id="apply_apply_time_end" type="text" name="apply.apply_time_end" title="到" value="${it:formatDate(apply.apply_time_end,'yyyy-MM-dd')}" />
				</span>
				<script type="text/javascript">$("#apply_apply_time_end").datepicker();</script>
			</td>
			<td class='firstRow'>审核时间:</td>
			<td class='secRow'>
				<span class="nowrap">
				从:
				<input id="apply_check_time_start" type="text" name="apply.check_time_begin" title="从" value="${it:formatDate(apply.check_time_begin,'yyyy-MM-dd')}" />
				</span>
				<script type="text/javascript">$("#apply_check_time_start").datepicker();</script>
				<span class="nowrap">
				到:
				<input id="apply_check_time_end" type="text" name="apply.check_time_end" title="到" value="${it:formatDate(apply.check_time_end,'yyyy-MM-dd')}" />
				</span>
				<script type="text/javascript">$("#apply_check_time_end").datepicker();</script>
			</td>
			</tr><tr>
			<td class='firstRow'>申请部门:</td>
			<td class='secRow' colspan="">
				<s:textfield title="部门" id="userdept_codeid" name="apply.apply_dept" readonly="true" />
				<s:textfield title="部门名称" id="userdept_nameid" name="apply.apply_dept_name" readonly="true" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
				<s:checkbox id="apply_is_sub_dept" name="apply.is_sub_dept" />
				<label for="apply_is_sub_dept">包含子部门</label>
				<span id="ajax_member_message"></span>
			</td>
			<td class='firstRow'>状态:</td>
			<td class='secRow'><s:select name="apply.status_sp" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'新申请',5:'审核退回',10:'待审核',20:'大区经理已审',25:'销管经理已审',30:'运营总监已审'}" /></td>
			</tr>
			<tr>
			<td class="buttonarea" colspan="4"><s:submit value="搜索" /> <s:reset value="重置" /></td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>申请编号</th>
	    <th>申请时间</th>
	    <th>申请部门</th>
	    <th>申请人</th>
		<th>事</th>
		<th>状态</th>
		<th>发货情况</th>
		<th>操作</th>
	  </tr>
<s:iterator value="applys" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td align="center"><s:property value="uuid" /></td>
	    <td align="center"><s:date name="apply_time" format="yyyy-MM-dd  HH:mm:ss" /></td>
	    <td align="center"><s:property value="apply_dept_name" /></td>
		<td align="center"><s:property value="apply_user_name" /></td>
		<td title="${title}">${it:subString(title,40)}</td>
		<td align="center" title="${check_user_name}-${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}-${check_note}">
			<s:if test="0==status">新申请</s:if>
			<s:if test="5==status"><span class="message_error">已退回(${check_user_name})</span></s:if>
			<s:if test="10==status"><span class="message_warning">待审核</span></s:if>
			<s:if test="20==status">
			<s:if test="0==sp_check_status"><span class="message_pass">大区经理已审(${check_user_name})</span></s:if>
			<s:elseif test="10==sp_check_status"><span class="message_pass">销管经理已审(${check_user_name})</span></s:elseif>
			</s:if>
			<s:if test="30==status"><span class="message_pass">运营总监已审(${check_user_name})</span></s:if>
		</td>
		<td align="center">
			<s:if test="30==status">
			<span class="mdyApplyShipInfo_Link"  data="${uuid}">
			<s:if test="0==ship_status">未发货</s:if>
			<s:if test="10==ship_status"><span class="message_pass">已发货</span></s:if>
			</span>
			<span class="ship_hidden_info">
				<span id="ship_no_${uuid}">${ship_no}</span>
				<span id="ship_type_${uuid}">${ship_type}</span>
				<span id="ship_date_${uuid}">${it:formatDate(ship_date,"yyyy-MM-dd")}</span>
				<span id="ship_phone_${uuid}">${ship_phone}</span>
				<span id="ship_status_${uuid}">${ship_status}</span>
				<span id="check_note_${uuid}">${check_note}</span>
			</span>
			</s:if>
		</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_VIEW')">
			<s:if test="status==30">
			[<a href="<s:url namespace="/qkjmanage" action="apply_print"><s:param name="apply.uuid" value="uuid"></s:param></s:url>">打印</a>]
			</s:if>
			<s:elseif test="status<=20">
	    	[<a href="<s:url namespace="/qkjmanage" action="apply_load"><s:param name="viewFlag">mdy</s:param><s:param name="apply.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:elseif>
	    	</s:if>
	    	<s:if test="(status==0||status==5)&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_DEL')">
	    	[<a href="<s:url namespace="/qkjmanage" action="apply_del"><s:param name="apply.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
		</script>
		</td>	    
	  </tr>
	  <tr>
	    <td colspan="20" class="buttonarea">
	    <span id="message"><s:property value="message" /></span>
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>

<div id="mdyApplyShipInfoForm" title="修改发货信息">
<s:form name="form_mdyApplyShipInfoForm" action="mdyApplyShipInfo" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<table class="ilisttable" width="100%">
		<tr>
		<td class='firstRow' colspan="2" style="text-align: left !important;">
		审核意见:<span id="form_apply_check_note"></span>
		</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 发货状态:</td>
		<td class='secRow'><s:select id="form_apply_ship_status" name="apply.ship_status" list="#{0:'未发货',10:'已发货' }" /></td>
		</tr>
		<tr>
		<td class='firstRow'>出库日期:</td>
		<td class='secRow'>
			<input id="form_apply_ship_date" type="text" name="apply.ship_date" title="出库日期" value="${it:formatDate(apply.ship_date,'yyyy-MM-dd')}" dataType="date" controlName="出库日期" />
			<script type="text/javascript">$("#form_apply_ship_date").datepicker();</script>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>运单号:</td>
		<td class='secRow'><s:textfield id="form_apply_ship_no" name="apply.ship_no" title="运单号码" dataLength="0,48" controlName="运单号码" /></td>
		</tr>
		<tr>
		<td class='firstRow'>物流类型/名称:</td>
		<td class='secRow'><s:textfield id="form_apply_ship_type" name="apply.ship_type" title="物流类型/名称" dataLength="0,32" controlName="物流电话" /></td>
		</tr>
		<tr>
		<td class='firstRow'>物流电话:</td>
		<td class='secRow'><s:textfield id="form_apply_ship_phone" name="apply.ship_phone" title="物流电话" dataLength="0,48" controlName="物流电话" /></td>
		</tr>
	<tr>
	    <td colspan="20" class="buttonarea">
	    	<s:hidden id="form_apply_uuid" name="apply.uuid" value="%{apply.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYAPPLYSHIPINFO')">
			<s:submit id="mdyApplyShipInfo" name="mdyApplyShipInfo" value="确定" action="mdyApplyShipInfo" />
			</s:if>
		</td>
    </tr>
</table>	
</s:form>
</div>
<script type="text/javascript">
$(function(){
	$("#mdyApplyShipInfoForm").dialog({
	      autoOpen: false,
	      height: 300,
	      width: 700,
	      modal: true
	});
	$(".mdyApplyShipInfo_Link").click(function(){
		var p_uuid = $(this).attr("data");
		$("#form_apply_uuid").val(p_uuid);
		$("#form_apply_ship_phone").val($("#ship_phone_"+p_uuid).text());
		$("#form_apply_ship_type").val($("#ship_type_"+p_uuid).text());
		$("#form_apply_ship_no").val($("#ship_no_"+p_uuid).text());
		$("#form_apply_ship_date").val($("#ship_date_"+p_uuid).text());
		$("#form_apply_ship_status").val($("#ship_status_"+p_uuid).text());
		$("#form_apply_check_note").text($("#check_note_"+p_uuid).text());
		$("#mdyApplyShipInfoForm").dialog("open");
	});
});

function jsont() {
	var a = $("#message").attr("data");
	 var obj = eval('(' + a + ')');
	 $.each(obj, function(i, n){
		  alert( "Item #" + i + ": " + n );
	});
}
</script>
</body>
</html>