<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库管理权限管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>

<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url action="warepower_list" namespace="/warepower" />" >仓库管理权限列表</a>
		</span>
	</div>
	<!-- 页面修改 -->
	<s:form id="editForm" name="editForm" cssClass="validForm" action="warepower_add" namespace="/warepower"  onsubmit="return validator(this);" method="post" theme="simple">
	<!-- 修改 -->
	<s:if test="warepower!=null">
		<div class="label_main">
			<div class="label_hang">
	            <div class="label_ltit">申请部门:</div>
	            <div class="label_rwben nw">
	            	<s:textfield title="部门名称" id="userdept_nameid"  name="warepower.dept_name"  readonly="true" />
					<s:hidden title="部门代码" id="userdept_codeid" name="warepower.dept_code" readonly="true" />
				</div>
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
		    </div>
		    <div class="label_hang">
	            <div class="label_ltit">申请人:</div>
	            <div class="label_rwben label_rwb">
	            	<s:select id="membermanagerid" cssClass="selectKick" name="warepower.username" list="#{}" headerKey="" headerValue="--请选择--"  controlName="申请人"/>
	            </div>
			 </div>
			 <div class="label_lckname">
	            	<input type="checkbox" name="warepower.son"  value="1"  checked="checked" >是否包含子部门
			 </div>
	     </div>
	     <div class="label_main">
			<div class="label_hang">
            <div class="label_lckname">
            	<s:property value="warepower.ware_name" />(<s:property value="warepower.address" />)
			<s:hidden name="warepower.uuid" />
            </div>
				<div class="label_lckname">
						  	<div class="label_tiaoj">
				            <input type="checkbox" name="warepower.prvg"  value="1"  <s:if test="%{warepower.prvg.indexOf('1')>=0}">checked="checked"</s:if> >入库
				            </div>
				            <div class="label_tiaoj">
				            <input type="checkbox" name="warepower.prvg"  value="2"  <s:if test="%{warepower.prvg.indexOf('2')>=0}">checked="checked"</s:if> > 出库
				            </div>
				            <div class="label_tiaoj">
				            <input type="checkbox" name="warepower.prvg"  value="3"  <s:if test="%{warepower.prvg.indexOf('3')>=0}">checked="checked"</s:if> > 调库
				            </div>
				            <div class="label_tiaoj">
				            <input type="checkbox" name="warepower.prvg"  value="4"  <s:if test="%{warepower.prvg.indexOf('4')>=0}">checked="checked"</s:if> > 查询
				            </div>
					</div>
			</div>
	     </div>
		</s:if>
		<s:else>
			<div class="label_main">
			<div class="label_hang">
            	<div class="label_ltit">申请部门:</div>
	            <div class="label_rwben nw">
	            	<s:textfield title="部门名称" id="userdept_nameid"  name="warepower.dept_name"  readonly="true" />
					<s:hidden title="部门代码" id="userdept_codeid" name="warepower.dept_code" readonly="true" />
				</div>
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
		   </div>
		   <div class="label_hang">
	            <div class="label_ltit">申请人:</div>
	            <div class="label_rwben label_rwb">
	            	<s:select id="membermanagerid" cssClass="selectKick" name="warepower.username" list="#{}" headerKey="" headerValue="--请选择--" />
	            </div>
			 </div>
	            <div class="label_lckname">
	            	<input type="checkbox" name="warepower.son"  value="1"  checked="checked" >是否包含子部门
	            </div>
		     </div>
				<s:iterator value="wares" status="sta">
					<div class="label_main">
						<div class="label_hang">
				            <div class="label_lckname">
				            	<s:property value="ware_name" />(<s:property value="address" />)
								<s:hidden name="warepowers[%{#sta.index}].ware_id" value="%{uuid}" />
				            </div>
						 <div class="label_lckname">
						  	<div class="label_tiaoj"><s:checkbox name="warepowers[%{#sta.index}].prvg"  fieldValue="1"  /> 入库</div>
				            <div class="label_tiaoj"><s:checkbox name="warepowers[%{#sta.index}].prvg" fieldValue="2"/> 出库</div>
				            <div class="label_tiaoj"><s:checkbox name="warepowers[%{#sta.index}].prvg"  fieldValue="3"/> 调库</div>
				            <div class="label_tiaoj"><s:checkbox name="warepowers[%{#sta.index}].prvg"  fieldValue="4"/> 查询</div>
						 </div>
						 </div>
					</div>
				</s:iterator>
		</s:else>
		
	
	<div class="label_con">
        
       <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_ADD')">
					<s:submit id="add" name="add" value="确定" action="warepower_add" cssClass="input-blue" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_MDY')">
					<s:submit id="save" name="save" value="保存" action="warepower_save" cssClass="input-blue"/>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="warepower_del" cssClass="input-red" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="warepower_relist" namespace="/warepower" />');" />
            </div>
		</div>
		</div>
	</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var manager = '${warepower.username}';
$(function(){
	if($("#userdept_codeid").val()!='') {
		loadManagers($("#userdept_codeid").val());
	}
	$("#customer_stage").bind("change",function(){
		if($(this).val()==0) {
			$("#customer_stage_1").hide();
		} else {
			$("#customer_stage_1").show();
		}
		if($(this).val()==3) {
			$("#failed_reason_tr").show();
		} else {
			$("#failed_reason_tr").hide();
		}
		if($(this).val()==4) {
			$("#contract_end_tr").show();
			$("#customer_contract_end").attr("require","required");
		} else {
			$("#contract_end_tr").hide();
			$("#customer_contract_end").removeAttr("require");
		}
		$("#base_info_td").attr("rowspan",$(".base_info_class:visible").length);
	});
	$("#AddRecode").dialog({
	      autoOpen: false,
	      width: 580,
	      height: 275,
	      modal: true
	});
	$("#base_info_td").attr("rowspan",$(".base_info_class:visible").length);
	
	$("#customer_contract_end").datepicker();
	if(CommonUtil.isVisible($("#customer_contract_end"))) {
		$("#customer_contract_end").attr("require","required");
	} else {
		$("#customer_contract_end").removeAttr("require");
	}
	
	CommonUtil.pickrow('table_recode');
	
	$(".tooltip").tooltip();
 });
 
var sobj01;
var selectDept2 = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_nameid").val(val2);
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
		/* $("#membermanagerid").addOption("暂不分配",""); */
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

function getCurrRowSpan() {
	return $(".base_info_class:visible").length;
}

function openAddRecode() {
	$("#customerRecode_bottonarea").show();
	$("#recode_index_tr").hide();
	$("#customerRecode_recode_time").datepicker();
	$("#customerRecode_next_date").datepicker();
	
	$("#recode_index").empty();
	$("#customerRecode_recode_time").val('');
	$("#customerRecode_type").val('');
	$("#customerRecode_person").val('');
	$("#customerRecode_next_date").val('');
	$("#customerRecode_content").val('');
	$("#customerRecode_promise").val('');
	
	$("#AddRecode").dialog("open");
}

var showRecode = function(r_id) {
	$("#customerRecode_bottonarea").hide();
	$("#recode_index_tr").show();
	$("#customerRecode_recode_time").datepicker("destroy");
	$("#customerRecode_next_date").datepicker("destroy");
	
	$.each($("#recode_" + r_id + " td"), function(i, n){
		if(i==0)$("#recode_index").text(n.innerText);
		if(i==1)$("#customerRecode_recode_time").val(n.innerText);
		if(i==2)$("#customerRecode_type").val(n.innerText);
		if(i==3)$("#customerRecode_person").val(n.innerText);
		if(i==4)$("#customerRecode_next_date").val(n.innerText);
	});
	$("#customerRecode_content").val($("#content_"+r_id).text());
	$("#customerRecode_promise").val($("#promise_"+r_id).text());
	
	$("#AddRecode").dialog("open");
};
</script>
</html>