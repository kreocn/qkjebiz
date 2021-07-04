<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>返利申请单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	SimpleLoadMember(ajax_url_action,function(event, ui) {
		//$("#search_form_submit_button").click();
	});
 });
</script>
<style type="text/css">
.ui-menu .ui-menu-item a{font-size:14px;}
</style>
</head>
<body>
<div class="main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="rebates_load"><s:param name="viewFlag">add</s:param></s:url>" >添加返利申请单</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="rebates_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">会员号:</div>
				       <div class="label_rwben"><s:textfield name="rebates.member_id" id="order_user_id" title="会员号" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">会员手机:</div>
				       <div class="label_rwben"><s:textfield name="rebates.member_mobile" id="order_user_mobile" title="会员手机" cssClass="validate[custom[integer]]"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">会员姓名:</div>
				       <div class="label_rwben"><s:textfield name="rebates.member_name" id="order_user_name" title="会员姓名"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">返利类型:</div>
				       <div class="label_rwben"><s:select name="rebates.re_type" title="返利类型" headerKey="" headerValue="--请选择--" list="#{0:'随单返利',1:'季度返利',2:'年度返利',3:'活动返利',4:'其他'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">返利单状态:</div>
				       <div class="label_rwben"><s:select name="rebates.status" title="返利单状态" headerKey="" headerValue="--请选择--" list="#{0:'新单',10:'待审核',20:'主管已审',30:'经理已审',40:'财务已审',50:'总监已审',60:'总经理已审'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">出货状态:</div>
				       <div class="label_rwben"><s:select name="rebates.out_flag" title="出货状态" headerKey="" headerValue="--请选择--" list="#{0:'未出货',1:'已出货'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">最终确认状态:</div>
				       <div class="label_rwben"><s:select name="rebates.fd_check" title="最终确认状态" headerKey="" headerValue="--请选择--" list="#{0:'未确认',1:'已最终确认'}" /></div>
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
						    <th class="td1">编号</th>
							<th class="td1">会员名称</th>
							<th class="td2">返利类型</th>
							<th class="td3">随量积分</th>
							<th class="td3">返利积分</th>
							<th class="td5">返现金数</th>
							<th class="td4">返酒</th>
							<th class="td2">申请人</th>
							<th class="td3">状态</th>
							<th class="td5">操作</th>
							<th class="td0">查看</th>
				  	</tr>
				  	<s:iterator value="rebatess" status="sta">
			  		<tr id="showtr${uuid}">
					    <td class="td1">${uuid}</td>
						<td class="td1">${member_name}</td>
						<td class="td2"><s:if test='0==re_type'>随单返利</s:if><s:if test='1==re_type'>季度返利</s:if><s:if test='2==re_type'>年度返利</s:if><s:if test='3==re_type'>活动返利</s:if><s:if test='4==re_type'>其他</s:if></td>
						<td class="td3">${with_score}</td>
						<td class="td3">${re_score}</td>
						<td class="td5">${re_money}</td>
						<td class="td4">
							<s:if test="product_num!=null && product_num>0">
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_OUT')">
					    	[<a target="_blank" href="<s:url namespace="/qkjmanage" action="rebates_view"><s:param name="viewFlag">view</s:param><s:param name="rebates.uuid" value="uuid"></s:param></s:url>">查看&发货</a>]
					    	</s:if>
					    	<s:if test="1==out_flag">| 已出货</s:if>
							</s:if>
							<s:else>无</s:else>
						</td>
						<td class="td2">${applicant_name}</td>
						<td class="td3">
							<s:if test='0==status'>新单</s:if>
							<s:if test='10==status'>待审核</s:if>
							<s:if test='20==status'>主管已审</s:if>
							<s:if test='30==status'>经理已审</s:if>
							<s:if test='40==status'>财务已审</s:if>
							<s:if test='50==status'>总监已审</s:if>
							<s:if test='60==status'>总经理已审</s:if>
							
							<s:if test='50<=status'>
							<s:if test="1==fd_check">已最终确认</s:if>
							</s:if>
						</td>
						<td class="td5 op-area nw">
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES')">
					    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="rebates_load"><s:param name="viewFlag">mdy</s:param><s:param name="rebates.uuid" value="uuid"></s:param></s:url>">修改&审批</a>
					    	</s:if>
						</td>
						<td class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
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
</body>
</html>