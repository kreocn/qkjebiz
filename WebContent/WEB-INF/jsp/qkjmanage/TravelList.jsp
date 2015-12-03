<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<c:if test="${it:checkPermit('QKJ_QKJMANAGE_TRAVEL_ADD',null)==true}">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">add</s:param></s:url>" >添加工业旅游申请</a></span>
			<span class="opb lb op-area">
			<s:hidden id="marketimgid"></s:hidden>
			</span>
		</c:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="travel_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">申请编号:</div>
				       <div class="label_rwben"><s:textfield name="travel.uuid"  title="申请编号" cssClass="validate[custom[number],maxSize[24]]" /></div>
				</div>
				<div class="label_hang">
		            <div class="label_ltit">申请部门:</div>
		            <div class="label_rwben2">
		            	<span class="label_rwb">
						<s:textfield title="部门名称" id="userdept_nameid" name="travel.apply_dept_name" readonly="true" />
						<s:hidden title="部门代码" id="userdept_codeid" name="travel.apply_dept" readonly="true" />
						</span>
						<span class="lb nw">
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
						<s:checkbox id="apply_is_sub_dept" name="active.is_sub_dept" cssClass="regular-checkbox" />
						<label for="apply_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
						</span>
		            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">申请人:</div>
		            <div class="label_rwben label_rwb">
		            	<s:select id="membermanagerid" cssClass="selectKick" name="travel.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
		            </div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">业务审核状态:</div>
				       <div class="label_rwben"><s:select name="travel.check_status" title="业务审核状态" headerKey="" headerValue="--请选择--" list="#{0:'新申请',5:'已退回',10:'待审核',20:'经理/大区已审',30:'总监已审',40:'业务副总已审'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">行政审核状态:</div>
				       <div class="label_rwben"><s:select name="travel.acheck_status" title="行政审核状态" headerKey="" headerValue="--请选择--" list="#{0:'新申请',5:'已退回',10:'待审核',20:'行政经理已审',30:'行政副总已审',40:'总经理已审'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">查询日期:</div>
				       <div class="label_rwben"><input id="travel_travel_date_search" class="datepicker validate[custom[date]]" type="text" name="travel.travel_date_search" title="查询日期" value="${it:formatDate(travel.travel_date_search,'yyyy-MM-dd')}" /></div>
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
	 		<table id="table1">
	 			<tr id="coltr">
	              <th  class="td1">申请编号</th>
	              <th  class="td2">申请部门</th>
	              <th  class="td1">申请人</th>
	              <th  class="td2">执行日期</th>
	              <th  class="td3">业务审核状态</th>
	              <th  class="td3">行政审核状态</th>
	              <th class="td1">结案活动状态</th>
				  <th class="td3">结案销售状态</th>
				  <th class="td3">结案销管状态</th>
	              <th  class="td4">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="travels" status="sta">
	            	<tr id="showtr${uuid}">
	            		<td  class="td1">${uuid}</td>
	            		<td  class="td2">${apply_dept_name}</td>
	            		<td  class="td1">${apply_user_name}</td>
	            		<td  class="td2">${it:formatDate(travel_date,'yyyy-MM-dd')} -- ${it:formatDate(travel_date_end,'yyyy-MM-dd')}</td>
	            		<td  class="td3">
           						<s:if test="check_status==0">新申请</s:if>
								<s:if test="check_status==5"><span class="message_error" title="${check_user_name}">已退回</span></s:if>
								<s:if test="check_status==10"><span class="message_warning">待审核</span></s:if>
								<s:if test="check_status==20"><span class="message_pass"  title="${check_user_name}">经理/大区已审</span></s:if>
								<s:if test="check_status==30"><span class="message_pass"  title="${check_user_name}">总监已审</span></s:if>
								<s:if test="check_status==40"><span class="message_pass"  title="${check_user_name}">业务副总已审</span></s:if>
	            		</td>
	            		<td  class="td3">
								<s:if test="acheck_status==0">新申请</s:if>
								<s:if test="acheck_status==5"><span class="message_error" title="${acheck_user_name}">已退回</span></s:if>
								<s:if test="acheck_status==10"><span class="message_warning">待审核</span></s:if>
								<s:if test="acheck_status==20"><span class="message_pass"  title="${acheck_user_name}">行政经理已审</span></s:if>
								<s:if test="acheck_status==30"><span class="message_pass"  title="${acheck_user_name}">行政副总已审</span></s:if>
								<s:if test="acheck_status==40"><span class="message_pass"  title="${acheck_user_name}">总经理已审</span></s:if>
	            		</td>
	            		
	            		<td class="td1 nw">
						<s:if test="state==0">新单</s:if>
						<s:if test="state==1">审批中</s:if>
						<s:if test="state==2">通过</s:if>
						
						<s:if test="state==2">
							<span class="op-area">
							<s:if test="ship_status==0"><a class="ship_info input-nostyle"  data="${uuid}">未发货</a></s:if>
							<s:if test="ship_status==10"><a class="ship_info input-nostyle"  data="${uuid}"><span class="message_pass">已发货</span></a></s:if>
							<s:if test="ship_status==99"><a class="ship_info input-nostyle"  data="${uuid}">&nbsp;其它&nbsp;</a></s:if>
							</span>
							<span class="ship_hidden_info" style="display:none;">
								<span id="ship_no_${uuid}">${ship_no}</span>
								<span id="ship_cloud_${uuid}">${ship_cloud}</span>
								<span id="ship_type_${uuid}">${ship_type}</span>
								<span id="ship_date_${uuid}">${it:formatDate(ship_date,"yyyy-MM-dd")}</span>
								<span id="ship_phone_${uuid}">${ship_phone}</span>
								<span id="ship_status_${uuid}">${ship_status}</span>
								<span id="active_remark_${uuid}">${remark}</span>
							</span>
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_OUTSTOCK',null)==true && goflag==0}">
							<span class="opb lb op-area">
								<a style="background-color: #FFF;border-color: #363636;color: #363636;" href="<s:url namespace="/qkjmanage" action="closeOrder_outStock"><s:param name="closeOrder.uuid" value="uuid"></s:param></s:url>">出库</a>
							</span>
							</c:if> 
							
							<!-- .outClass {
background-color: #FFF;
  border-color: #363636;
  color: #363636;
} -->
						</s:if>
						</td>
						<td class="td2 nw" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">
						<s:if test="sd_state==0">新单</s:if>
									<s:if test="sd_state==5">
										<font class="message_error">审核退回</font></s:if>
									<s:if test="sd_state==10">
										<font class="message_warning">待审核</font>
									</s:if>
									<s:if test="sd_state==20">
										<font class="message_pass">办事处已审</font></s:if>
									<s:if test="sd_state==30">
										<font class="message_pass">大区已审</font></s:if>
									<s:if test="sd_state==40">
										<font class="message_pass">总监已审</font></s:if>
									<s:if test="sd_state==50">
										<font class="message_pass">副总已审</font></s:if>
						</td>
						<td class="td2 nw" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">
						<s:if test="smd_status==0">未签收</s:if>
									<s:if test="smd_status==5">
										<font class="message_error">审核退回</font></s:if>
									<s:if test="smd_status==10">
										<font class="message_warning">已签收</font>
									</s:if>
									<s:if test="smd_status==30">
										<font class="message_pass">销管经理已审</font></s:if>
									<s:if test="smd_status==40">
										<font class="message_pass">销管部经理已审</font></s:if>
									<s:if test="smd_status==50">
										<font class="message_pass">销管副总已审</font></s:if>
										<s:if test="smd_status==60">
										<font class="message_pass">总经理已审</font></s:if>
										<s:if test="smd_status==70">
										<font class="message_pass">董事已审</font></s:if>
						</td>
						
						
	            		<td  class="td4 op-area nw">
	            				<c:if test="${it:checkPermit('QKJ_QKJMANAGE_TRAVEL',null)==true}">
				    	    		<a class="input-blue"  href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">mdy</s:param><s:param name="travel.uuid" value="uuid"></s:param></s:url>">修改</a>
				    	    	</c:if>
				    	    	<c:if test="${it:checkPermit('QKJ_QKJMANAGE_TRAVEL',null)==true && status<1 && check_status>=30}">
				    	    		<a class="input-blue"  href="<s:url namespace="/qkjmanage" action="travel_closeLoad"><s:param name="viewFlag">add</s:param><s:param name="travel.uuid" value="uuid"></s:param></s:url>">开始结案</a>
				    	    	</c:if>
				    	    	<c:if test="${it:checkPermit('QKJ_QKJMANAGE_TRAVEL',null)==true && status>=1&& check_status>=30}">
				    	    	<a class="input-blue"  href="<s:url namespace="/qkjmanage" action="travel_closeLoad"><s:param name="viewFlag">add</s:param><s:param name="travel.uuid" value="uuid"></s:param></s:url>">结案修改</a>
				    	    	</c:if>
				    	    	
				                <c:if test="${(check_status<=5 || acheck_status<=5) && it:checkPermit('QKJ_QKJMANAGE_TRAVEL_DEL',null)==true}">
				      	    		<a class="input-red" href="<s:url namespace="/qkjmanage" action="travel_del"><s:param name="travel.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
				      	    	</c:if>
				      	    	
				      	    	<c:if test="${it:checkPermit('QKJ_QKJMANAGE_TRAVEL',null)==true}">
									<a class="input-blue" href="javascript:;" onclick="linkurl('<s:url action="travel_out" namespace="/qkjmanage" ><s:param name="travel.uuid" value="uuid"></s:param></s:url>');" >客户信息模板</a>
								</c:if>
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
 
function refurbish(){
	window.location.href="/qkjmanage/travel_list";
}

$(function(){
	$.fn.xhupload("Travel",refurbish);
	$("#marketimgid").xhupload();
});

$(document).ready(function(){
	$("#filebtn").removeClass("filearea"); //添加样式marketimgid_filebutton
	$("#marketimgid_filebutton").val("选择导入文件");
});


</script>


</body>
</html>