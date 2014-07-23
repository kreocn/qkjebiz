<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户管理列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.rating.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.rating.pack.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.MetaData.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var manager = '${customer.manager}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	
	if($("#customer_dept_code").val()!='') {
		loadManagers($("#customer_dept_code").val());
	}
	
	$("#customer_add_time").datepicker();
 });
 
var sobj01;
var selectDept2 = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#customer_dept_code").val(val1);
		$("#customer_dept_name").val(val2);
		loadManagers(val1);
	};
	sobj01.create();
	sobj01.open();
};

function loadManagers(dept_code) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#membermanagerid").clearAllOption();
		$("#membermanagerid").addOption("--请选择--","");
		$.each(data, function(i, n){
			$("#membermanagerid").addOption(n.user_name,n.uuid);
		});
		
		if(manager!='') {
			$("#membermanagerid").setSelectedValue(manager);
		};
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">客户列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="customer_load"><s:param name="viewFlag">add</s:param></s:url>" >添加客户</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="customer_list"  method="get" namespace="/qkjmanage" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow3'>客户编号:</td>
			<td class='secRow3'><s:textfield name="customer.uuid" title="添加时间" /></td>
			<td class='firstRow3'>客户名称:</td>
			<td class='secRow3'><s:textfield name="customer.cus_name" title="客户名称" dataLength="0,42" controlName="客户名称" /></td>
			<td class='firstRow3'>添加时间:</td>
			<td class='secRow3'><s:textfield id="customer_add_time" name="customer.add_time" title="添加时间" value="%{getText('global.date',{customer.add_time})=='null'?'':getText('global.date',{customer.add_time})}" /></td>
			</tr>
			<tr>
			<td class='firstRow3'>未成交原因:</td>
			<td class='secRow3'><s:select name="customer.failed_reason" title="未成交原因" headerKey="" headerValue="--请选择--" list="#{'MORE':'首单量太多','HAVE':'区域内已有经销商','NOPROD':'没有合适的产品','QA':'对公司的市场支持和企业实力有疑问','OTHER':'其他原因'}" /></td>
			<td class='firstRow3'>客户来源:</td>
			<td class='secRow3'><s:select name="customer.source" title="客户来源" headerKey="" headerValue="--请选择--" list="#{0:'主动联系',1:'朋友介绍',2:'媒体/广告/杂志',3:'互联网',4:'会议会展',5:'其他'}" /></td>
			<td class='firstRow3'>所属阶段:</td>
			<td class='secRow3'><s:select name="customer.stage" title="所属阶段" headerKey="" headerValue="--请选择--" list="#{0:'初步了解',1:'深度了解',2:'开始报价',3:'客户未成交',4:'客户成交'}" /></td>
			</tr><tr>
			<td class='firstRow3'>所属部门:</td>
			<td class='secRow3' colspan="3">
				<s:textfield id="customer_dept_code" name="customer.dept_code" title="所属部门" readonly="readonly" />
				<s:textfield id="customer_dept_name" name="customer.dept_name" title="所属部门" readonly="readonly" />
				<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept2();" />
				<s:select id="membermanagerid" name="customer.manager" list="#{}" headerKey="" headerValue="--请选择--"  require="required" controlName="所属人"  />
				<s:checkbox id="customer_is_sub_dept" name="customer.is_sub_dept" />
				<label for="customer_is_sub_dept">包含子部门</label>
			</td>
			<td class='firstRow3'>客户重要等级(>=):</td>
			<td class='secRow3'>
				<input name="customer.rating" type="radio" class="star {split:2}" value="0.5" <s:if test="customer.rating==0.5"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="1.0" <s:if test="customer.rating==1.0"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="1.5" <s:if test="customer.rating==1.5"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="2.0" <s:if test="customer.rating==2.0"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="2.5" <s:if test="customer.rating==2.5"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="3.0" <s:if test="customer.rating==3.0"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="3.5" <s:if test="customer.rating==3.5"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="4.0" <s:if test="customer.rating==4.0"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="4.5" <s:if test="customer.rating==4.5"> checked="checked"</s:if> />
				<input name="customer.rating" type="radio" class="star {split:2}" value="5.0" <s:if test="customer.rating==5.0"> checked="checked"</s:if> />
			</td>
			</tr>
			<tr>
			<td colspan="6" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>客户编号</th>
		<th>所属部门</th>
		<th>所属阶段</th>
		<th>客户来源</th>
		<th>客户名称</th>
		<th>联系电话</th>
		<th>回访次数</th>
		<th>添加人</th>
		<th>操作</th>
	  </tr>
<s:iterator value="customers" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
		<td><s:property value="dept_name" /></td>
		<td><s:if test="0==stage">初步了解</s:if><s:if test="1==stage">深度了解</s:if><s:if test="2==stage">开始报价</s:if><s:if test="3==stage">客户未成交</s:if><s:if test="4==stage">客户成交</s:if></td>
		<td><s:if test="0==source">主动联系</s:if><s:if test="1==source">朋友介绍</s:if><s:if test="2==source">媒体/广告/杂志</s:if><s:if test="3==source">互联网</s:if><s:if test="4==source">会议会展</s:if><s:if test="5==source">其他</s:if></td>
		<td><s:property value="cus_name" /></td>
		<td><s:property value="phone" /></td>
		<td><s:property value="recode_count" /></td>
		<td>${add_user_name}(<s:date name="add_time" format="yyyy-MM-dd" />)</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_MDY')">
	    	[<a href="<s:url namespace="/qkjmanage" action="customer_load"><s:param name="viewFlag">mdy</s:param><s:param name="customer.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_DEL')">
	    	[<a href="<s:url namespace="/qkjmanage" action="customer_del"><s:param name="customer.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>	   
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
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