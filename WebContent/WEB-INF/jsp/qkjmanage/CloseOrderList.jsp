<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>结案提货单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.ship_info {
cursor: pointer;
}
</style>
<body>
	<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
		<div class="dq_step">
			${path}
			<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD',null)==true}">
				<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">addApply</s:param></s:url>">结案提货单(至事由)</a></span>
			</c:if>
			<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD',null)==true}">
				<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">add</s:param></s:url>">添加结案提货单</a></span>
			</c:if>
		</div>
		<s:form id="serachForm" name="serachForm" action="closeOrder_list" method="get" namespace="/qkjmanage" theme="simple">
		<s:hidden name="per" value="null"></s:hidden>
		    <s:hidden name="finance" id="finance" value="1"></s:hidden>
			<div class="label_con">
				<div class="label_main">
					<div class="label_hang">
			            <div class="label_ltit">快速查询:</div>
			           <div class="label_rwben2" style="size: 30%">
			            	<s:select id="sselect" onchange="kselect();" name="sselect"  cssClass="selectKick" headerKey="" headerValue="-----请选择-----" list="#{0:'业务部经理待审',1:'销管经理待审', 2:'运营总监待审', 3:'总经理待审',4:'营销中心副总待审',5:'财务待审'
			            	}" />
			            </div>
			        </div>
					<div class='label_hang'>
						<div class='label_ltit'>主键:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.uuid' cssClass=' validate[maxSize[10],custom[integer],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>结案时间:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.close_time' cssClass=' datepicker validate[custom[date],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>主题:</div>
						<div class="label_rwben">
							<s:textfield name="closeOrder.theme" title="主题" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">申请部门:</div>
						<div class="label_rwben2">
							<span class="label_rwb"> <s:textfield title="部门名称" id="userdept_nameid" name="closeOrder.apply_dept_name" readonly="true" /> <s:hidden title="部门代码" id="userdept_codeid" name="closeOrder.apply_dept" readonly="true" />
							</span> <span class="lb nw"> <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" /> <s:checkbox id="apply_is_sub_dept" name="closeOrder.is_sub_dept" cssClass="regular-checkbox" /> <label for="apply_is_sub_dept"></label>包含子部门<span
								id="ajax_member_message"></span>
							</span>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">申请人:</div>
						<div class="label_rwben label_rwb">
							<s:select id="membermanagerid" cssClass="selectKick" name="closeOrder.add_user" list="#{}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>

					<div class="label_hang">
						<div class="label_ltit">单据状态:</div>
						<div class="label_rwben label_rwb">
							<s:select id="check_state" name="closeOrder.state" cssClass="selectKick" list="#{0:'新单',1:'审核中',2:'通过'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">销售状态:</div>
						<div class="label_rwben label_rwb">
							<s:select id="check_sdstate" name="closeOrder.sd_state" cssClass="selectKick" list="#{5:'退回',10:'待审核',20:'办事处通过',30:'业务部经理审核通过',40:'总监审核通过',50:'业务副总通过',60:'总经理审核通过',70:'总经理已推送副总',80:'营销副总审核通过'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">销管状态:</div>
						<div class="label_rwben label_rwb">
							<s:select id="check_smdstate" name="closeOrder.smd_status" cssClass="selectKick" list="#{5:'退回',10:'已签收',30:'销管经理已审',40:'销管部经理已审',50:'销管副总通过',60:'总经理通过'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">数据中心:</div>
						<div class="label_rwben label_rwb">
							<s:select id="nd_check_state" name="closeOrder.nd_check_state" cssClass="selectKick" list="#{0:'未确认',5:'退回',10:'已审'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">类型:</div>
						<div class="label_rwben label_rwb">
							<s:select id="nd_check_state" name="closeOrder.typeO" cssClass="selectKick" list="#{0:'促销活动',2:'至事由'}" headerKey="" headerValue="--请选择--" />
						</div>
					</div>
					<div class="label_hang tac">
						<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
						<label for="search_mcondition"></label>更多条件
						<s:submit value="搜索" />
						<s:reset value="重置" />
					</div>
				</div>
			</div>
		</s:form>
		<div class="tab_warp">
			<table>
				<tr id="coltr">
					<th class="td1">主键</th>
					<th class="td2">申请部门</th>
					<th class="td1">申请人</th>
					<th class="td5">主题</th>
					<th class="td3">结案时间</th>
					<th class="td1">单据状态</th>
					<th class="td2">销售状态</th>
					<th class="td2">销管状态</th>
					<th class="td3">类型</th>
					<th class="td4">操作</th>
					<th class="td0">查看</th>
				</tr>
				<s:iterator value="closeOrders" status="sta">
					<tr id="showtr${uuid}">
						<td class="td1 nw">${uuid}</td>
						<td class="td2 nw">${apply_dept_name}</td>
						<td class="td1 nw">${add_user_name}</td>
						<td class="td5 longnote" title="${theme}">${it:subString(theme,18)}</td>
						<td class="td3 nw">${it:formatDate(close_time,'yyyy-MM-dd')}</td>
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
										<font class="message_pass">办事处已审</font>
									</s:if>
									<s:if test="sd_state==30">
										<font class="message_pass">业务部经理已审</font></s:if>
									<s:if test="sd_state==40">
										<font class="message_pass">总监已审</font></s:if>
									<s:if test="sd_state==50">
										<font class="message_pass">副总已审</font></s:if>
										<s:if test="sd_state==60 || sd_state==70">
										<font class="message_pass">总经理已审</font></s:if>
										<s:if test="sd_state==80">
										<font class="message_pass">营销中心副总已审</font></s:if>
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
										
						</td>
						
						<td class="td3 nw">
						<s:if test="type==0">促销活动</s:if>
						<s:if test="type==1">工业旅游</s:if>
						<s:if test="type==2">至事由</s:if>
						</td>
						<td class="td4 op-area">
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_MDY',null)==true}">
								<a class="input-blue" href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">mdy</s:param><s:param name="closeOrder.uuid" value="uuid"></s:param></s:url>">修改</a>
							</c:if> 
							<s:if test="check_state>30">
					    	<a class="input-gray" href="<s:url namespace="/qkjmanage" action="closeOrder_view"><s:param name="closeOrder.uuid" value="uuid" /></s:url>">打印</a>
					    	</s:if>
					    	<c:if test="${check_state<1 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL',null)==true}">
								<a class="input-red" href="<s:url namespace="/qkjmanage" action="closeOrder_del"><s:param name="closeOrder.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
							</c:if></td>
						<td class="td0 op-area"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<div id="listpage" class="pagination"></div>
	</div>
</div>
<div id="mdyActiveShipInfoForm" class="label_con idialog" title="修改发货信息">
<s:form name="form_mdyActiveShipInfoForm" action="mdyCloseOrderShipInfo" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben"><s:select id="e_active_ship_status" name="closeOrder.ship_status" list="#{0:'未发货',10:'已发货',99:'其他' }" /></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">出库日期:</div>
            <div class="label_rwben"><input id="e_active_ship_date" class="datepicker validate[custom[date]]" type="text" name="closeOrder.ship_date" title="出库日期" value="${it:formatDate(closeOrder.ship_date,'yyyy-MM-dd')}" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">运单号:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_no" cssClass="validate[maxSize[48]]" name="closeOrder.ship_no" title="运单号码" /></div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">云单号:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_cloud" cssClass="validate[maxSize[48]]" name="closeOrder.ship_cloud" title="运单号码" /></div>
        </div>
        
		<div class="label_hang">
            <div class="label_ltit">物流名称:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_type" name="closeOrder.ship_type" cssClass="validate[maxSize[32]]" title="物流类型/名称" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">物流电话:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_phone" name="closeOrder.ship_phone"  cssClass="validate[maxSize[48]]" title="物流电话" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">备注:</div>
            <div class="label_rwben"><s:textarea id="e_active_remark" name="closeOrder.remark" cssClass="validate[maxSize[65535]]" title="备注" cols="3" rows="4" /></div>
        </div>
        <div class="label_hang label_button tac">
           	<s:hidden id="e_active_uuid" name="closeOrder.uuid" value="%{closeOrder.uuid}" />
           	<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_MDYSHIPINFO',null)==true}">
				<s:submit id="mdyActiveShipInfo" name="mdyActiveShipInfo" value="确定" action="mdyCloseOrderShipInfo" />
			</c:if>
        </div> 
    </div>
</s:form>
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
 
$(function(){
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
	$("#e_active_ship_cloud").val($("#ship_cloud_"+p_uuid).text());
	$("#e_active_ship_date").val($("#ship_date_"+p_uuid).text());
	$("#e_active_ship_status").val($("#ship_status_"+p_uuid).text());
	$("#e_active_remark").text($("#active_remark_"+p_uuid).text());
}
 
function kselect(){
	var num=$("#sselect").val();
	document.getElementById("finance").value="1";
	document.getElementById("check_state").options[2].selected = true; 
	$("#userdept_codeid").val("");
	$("#userdept_nameid").val("");
	document.getElementById("apply_is_sub_dept").checked=false;
	if(parseInt(num)==0){//(申)大区经理待审
		document.getElementById("check_sdstate").options[3].selected = true; 
		document.getElementById("check_smdstate").options[2].selected = true;
	}
	if(parseInt(num)==1){//(申)销管经理待审
		document.getElementById("check_sdstate").options[4].selected = true; 
		document.getElementById("check_smdstate").options[2].selected = true;
	}
	if(parseInt(num)==2){//总监
		document.getElementById("check_sdstate").options[4].selected = true; 
		document.getElementById("check_smdstate").options[3].selected = true;
		$("#userdept_codeid").val("312");
		$("#userdept_nameid").val("红酒事业部");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==3){//销管部经理待审西北
		document.getElementById("check_sdstate").options[4].selected = true; 
		document.getElementById("check_smdstate").options[3].selected = true;
		document.getElementById("finance").value="3";
		
	}
	if(parseInt(num)==4){//西北业务副总
		document.getElementById("check_sdstate").options[8].selected = true; 
		document.getElementById("check_smdstate").options[3].selected = true;
	}
	if(parseInt(num)==5){//西北销管副总
		document.getElementById("check_sdstate").options[0].selected = true; 
		document.getElementById("check_smdstate").options[0].selected = true;
		document.getElementById("finance").value="2";
		
	}
	
	
	
	document.getElementById("serachForm").action="/qkjmanage/closeOrder_list";
	document.getElementById("serachForm").submit();
}
</script>
</body>
</html>