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
			<td class='secRow'><s:select name="apply.status" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'新申请',5:'审核退回',10:'待审核',20:'大区经理已审',30:'运营总监已审'}" /></td>
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
		<td align="center" title="${check_user_name}-${it:formatDate(check_time,'yyyy-MM-dd HH:mm:ss')}">
			<s:if test="0==status">新申请</s:if>
			<s:if test="5==status"><span class="message_error">已退回</span></s:if>
			<s:if test="10==status"><span class="message_warning">待审核</span></s:if>
			<s:if test="20==status"><span class="message_pass">大区经理已审</span></s:if>
			<s:if test="30==status"><span class="message_pass">运营总监已审</span></s:if></td>
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
</body>
</html>