<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户管理列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.rating.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.rating.pack.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.MetaData.js" />"></script>

<style type="text/css">
.star-rating-control{margin-top:6px; display: inline-block;}
</style>
</head>

<body>
 <!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="customer_load"><s:param name="viewFlag">add</s:param></s:url>" >添加客户</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="customer_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">客户编号:</div>
				       <div class="label_rwben"><s:textfield name="customer.uuid"  title="客户编号" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">客户名称:</div>
				       <div class="label_rwben"><s:textfield name="customer.cus_name"  title="客户名称" cssClass="validate[maxSize[42]]"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">添加时间:</div>
				       <div class="label_rwben"><input id="customer_add_time" class="datepicker validate[custom[date]]" type="text" name="customer.add_time" title="添加时间" value="${it:formatDate(customer.add_time,'yyyy-MM-dd')}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">未成交原因:</div>
				       <div class="label_rwbenx">
				       		<s:select name="customer.failed_reason" title="未成交原因" headerKey="" headerValue="--请选择--" list="#{'MORE':'首单量太多','HAVE':'区域内已有经销商','NOPROD':'没有合适的产品','QA':'对公司的市场支持和企业实力有疑问','OTHER':'其他原因'}" />
				       </div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">客户来源:</div>
				       <div class="label_rwben">
				       		<s:select name="customer.source" title="客户来源" headerKey="" headerValue="--请选择--" list="#{0:'主动联系',1:'朋友介绍',2:'媒体/广告/杂志',3:'互联网',4:'会议会展',5:'其他'}" />
				       </div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">所属阶段:</div>
				       <div class="label_rwben">
				       		<s:select name="customer.stage" title="所属阶段" headerKey="" headerValue="--请选择--" list="#{0:'初步了解',1:'深度了解',2:'开始报价',3:'客户未成交',4:'客户成交'}" />
				       </div>
				</div>
				<div class="label_hang">
		            <div class="label_ltit">所属部门:</div>
		            <div class="label_rwbenx">
		            	<span class="label_rwb" style="float:left;">
							<s:textfield title="部门名称" id="customer_dept_name" name="customer.dept_name" readonly="true" />
							<s:hidden title="部门代码" id="customer_dept_code" name="customer.dept_code" readonly="true" />
						</span>
						<span class="lb nw" style="float:left;">
							<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept2();" />
							<s:checkbox id="customer_is_sub_dept" name="customer.is_sub_dept" cssClass="regular-checkbox" />
							<label for="customer_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
							<s:checkbox id="customer_is_recode" name="customer.is_recode" cssClass="regular-checkbox" />
							<label for="customer_is_recode"></label>有2次以上的回访记录的客户
						</span>
		            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">添加人:</div>
		            <div class="label_rwben">
		            	<s:select id="membermanagerid" cssClass="selectKick" name="customer.manager" list="#{}" headerKey="" headerValue="--请选择--" />
		            </div>
				</div>
				<div class="label_main">
					<div class="label_hang">
			            <div class="label_ltit" style="width:148px;">客户重要等级(>=):</div>
			            <div class="label_rwbenx">
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
			            </div>
					</div>
					<div class="label_hang label_button tac">
			        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
						<label for="search_mcondition"></label>更多条件
			            <s:submit value="搜索" /> <s:reset value="重置" />
			        </div>
				</div>
			</div>
		</div>
	</s:form>
	<div class="tab_warp">
	 		<table id="table1">
	 			<tr id="coltr">
	 				<th class="td1">客户编号</th>
					<th class="td2">所属部门</th>
					<th class="td2">所属阶段</th>
					<th class="td3">客户来源</th>
					<th class="td3">客户名称</th>
					<th class="td4">联系电话</th>
					<th class="td2">回访次数</th>
					<th class="td1">添加人</th>
					<th class="td5">操作</th>
	              	<th class="td0">查看</th>
	            </tr>
	            <s:iterator value="customers" status="sta">
	            	<tr id="showtr${uuid}">
	            		<td class="td1">${uuid}</td>
	            		<td class="td2">${dept_name}</td>
	            		<td class="td2"><s:if test="0==stage">初步了解</s:if><s:if test="1==stage">深度了解</s:if><s:if test="2==stage">开始报价</s:if><s:if test="3==stage">客户未成交</s:if><s:if test="4==stage">客户成交</s:if></td>
	            		<td class="td3"><s:if test="0==source">主动联系</s:if><s:if test="1==source">朋友介绍</s:if><s:if test="2==source">媒体/广告/杂志</s:if><s:if test="3==source">互联网</s:if><s:if test="4==source">会议会展</s:if><s:if test="5==source">其他</s:if></td>
	            		<td class="td3">${cus_name}</td>
	            		<td class="td4">${phone}</td>
	            		<td class="td2">${recode_count}</td>
	            		<td class="td1">${add_user_name}(<s:date name="add_time" format="yyyy-MM-dd" />)</td>
	            		<td class="td5 op-area">
	            			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER')">
					    		<a class="input-blue" href="<s:url namespace="/qkjmanage" action="customer_load"><s:param name="viewFlag">mdy</s:param><s:param name="customer.uuid" value="uuid"></s:param></s:url>">修改</a>
					    	</s:if>
					    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_DEL')">
					    		<a class="input-red" href="<s:url namespace="/qkjmanage" action="customer_del"><s:param name="customer.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
					    	</s:if>	 
	            		</td>
	            		<td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	            	</tr>
	            </s:iterator>
	        </table>
	   </div>
	   <div id="listpage" class="pagination"></div>
</div>
</div>
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
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var manager = '${customer.manager}';
$(function(){
	if($("#customer_dept_code").val()!='') {
		loadManagers($("#customer_dept_code").val());
	}
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
</body>
</html>