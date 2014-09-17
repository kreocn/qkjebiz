<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>至事由申请管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<style type="text/css">
.approve_list {
}
.approve_ad_time, .approve_check_user, .approve_flag,.approve_advice {
font-weight: bold;
}
.approve_flag_fail {
color: #FF0000;
}
.approve_flag_pass {
color: #008000;
}
</style>
</head>
<body>
<div class="main" title="修改发货信息">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="apply_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span>
	</div>
	<s:form id="editForm" name="editForm" action="apply_list"  method="get" namespace="/qkjmanage" theme="simple">
	<div class="label_con">
		<s:if test="'mdy' == viewFlag">
		<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">申请编号:</div>
            <div class="label_rwben"><span class="label_rwb">${apply.uuid}<s:hidden name="apply.uuid" /></span></div>
        </div>
        </div>
        </s:if>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">至:</div>
            <div class="label_rwbenx">
            	<s:if test="'add'==viewFlag || apply.status==0 || apply.status==5">
				<s:textfield name="apply.touser" title="至" require="required" dataLength="0,255" controlName="至" cssClass="label_hang_linput"/>
				</s:if>
				<s:else>${apply.touser}</s:else>
            </div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">事:</div>
            <div class="label_rwbenx">
				<s:if test="'add'==viewFlag || apply.status==0 || apply.status==5">
				<s:textfield name="apply.title" title="主题"  cssClass="label_hang_linput" />
				</s:if>
				<s:else>${apply.title}</s:else>
            </div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">需要会审?</div>
            <div class="label_rwbenx">
				<s:checkbox id="apply_is_fullcheck_box" name="is_fullcheck_box" cssClass="regular-checkbox" />
				<label for="apply_is_fullcheck_box"></label>
				<s:hidden  id="apply_is_fullcheck" name="apply.is_fullcheck" />
            </div>
        </div>
        </div>
        <div id="apply_fullcheck_text" class="label_main" style="display: none;">
        <div class="label_hang">
            <div class="label_ltit">会审说明:</div>
            <div class="label_rwbenx">
            	<span class="message_prompt">填写参加会审的领导职位,如总经理,业务副总经理,销管副总经理</span>
				<s:textfield name="apply.fullcheck_text" title="会审说明" dataLength="0,128" cssClass="label_hang_linput inputNote" />
            </div>
        </div>
        </div>
        <s:if test="'mdy' == viewFlag">
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">由:</div>
            <div class="label_rwbenx">
				<s:if test="null != apply">
				${apply.apply_dept_name} ${apply.apply_user_name} (<s:date name="apply.apply_time" format="yyyy-MM-dd" />)
				</s:if>
            </div>
        </div>
        </div>
        </s:if>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">说明:</div>
            <div class="label_rwbenx">
            </div>
        </div>
        </div>
        <div class="label_main">
        	<div class="note_area">
        	<s:if test="apply.status>=10">
			${apply.note}
			</s:if>
			<s:else>
			<s:textarea name="apply.note" title="详细说明" cssClass="xheditorArea" />
			</s:else>
        	</div>
        </div>
        <s:if test="'mdy' == viewFlag">
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">审核/报审人:</div>
            <div class="label_rwben">${apply.check_user_name}</div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">审核时间:</div>
            <div class="label_rwben2"><s:date name="apply.check_time" format="yyyy-MM-dd HH:mm:ss" /></div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">审核意见:</div>
            <div class="label_rwbenx">
            	<s:textarea id="apply_check_note" name="apply.check_note" title="审核意见" rows="4" cssClass="label_hang_linput" />
            </div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">审阅情况:</div>
            <div class="label_rwbenx approve_list">
            	<ul>
					<s:iterator value="approves" status="sta">
					<li>此至事由在<span class="approve_ad_time"> ${it:formatDate(ad_time,'yyyy-MM-dd HH:mm:ss')}</span>
						被 <span class="approve_check_user"> ${check_user_name}</span> 
						执行
						<span class="approve_flag">
						<s:if test="flag==5">
						<span class="approve_flag_fail">审阅不通过</span>
						</s:if>
						<s:if test="flag==10">
						<span class="approve_flag_pass">审阅通过</span>
						</s:if>
						</span>
						操作
						<s:if test="advice!=null && advice!=''">
						审阅意见:
						<span class="approve_advice">${advice}</span>
						</s:if>
					</li>
					</s:iterator>
				</ul>
            </div>
        </div>
        </div>
        </s:if>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            	<s:if test="null == apply && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_ADD')">
					<s:submit id="add" name="add" value="确定" action="apply_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != apply && 'mdy' == viewFlag">
					<s:if test="apply.status==0||apply.status==5||apply.status==null">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_MDY')">
					<s:submit id="save" name="save" value="保存申请单" action="apply_save" cssClass="input-blue" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK0')">
					<s:submit id="apply_check0" name="apply_check0" value="报审" action="apply_check0" cssClass="input-yellow" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="apply_del" cssClass="input-red" onclick="return isDel();" />
					</s:if>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK_1')">
					<s:submit id="apply_check_1" name="apply_check_1" value="作废" action="apply_check_1"  cssClass="input-red" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					<s:if test="apply.status==10 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK10')">
					<s:submit id="apply_check10" name="apply_check10" value="大区经理审核通过" cssClass="input-green" action="apply_check10" onclick="return isOp('确定进行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK5')">
					<s:submit id="apply_check5" name="apply_check5" value="审核不通过"  cssClass="input-red" action="apply_check5" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					</s:if>
					<s:if test="apply.status==20 && apply.sp_check_status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_SPCHECK10')">
					<s:submit id="apply_spcheck10" name="apply_spcheck10" value="销管经理审核通过" cssClass="input-green" action="apply_spcheck10" onclick="return isOp('确定进行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_SPCHECK5')">
					<s:submit id="apply_spcheck5" name="apply_spcheck5" value="审核不通过"  cssClass="input-red" action="apply_spcheck5" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					</s:if>
					<s:if test="apply.status==20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK20')">
					<s:submit id="apply_check20" name="apply_check20" value="运营总监审核通过" cssClass="input-green" action="apply_check20" onclick="return isOp('确定进行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK5')">
					<s:submit id="apply_check5" name="apply_check5" value="审核不通过"  cssClass="input-red" action="apply_check5" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					</s:if>
					<s:if test="apply.status>=10 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_APPROVE')">
					<input type="button" value="审阅"  onclick="openApprove();" />
					</s:if>
					<s:if test="apply.status==30">
					<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="apply_print"><s:param name="apply.uuid" value="apply.uuid" /></s:url>');" value="转到打印页面"/>
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url namespace="/qkjmanage" action="apply_list"><s:param name="viewFlag">relist</s:param></s:url>');" class="input-gray" />
            </div>
        </div>
        </div>
	</div>
	</s:form>
</div>
<div id="approveFrom" class="label_con idialog" title="审阅信息">
<s:form name="form1" action="apply_approve" namespace="/qkjmanage" method="post"  theme="simple">
<input type="hidden" name="apply.uuid" value="${apply['uuid']}" />
<input type="hidden" id="add_approve_flag" name="approve.flag" />
<div class="label_main">
	<div class="label_hang">
	    <div class="label_ltit">审阅意见:</div>
	</div>
</div>
<div class="label_main"><textarea name="approve.advice" rows="3" ></textarea></div>
<div class="label_main tac" style="padding: 5px 0;">
    <input type="submit" name="approve_pass" value="审阅通过" onclick="return addApproveCheck(10);" />
	<input type="submit" name="approve_fail" value="审阅不通过" onclick="return addApproveCheck(5);" />
	<s:if test="'true'==isApprover">
	<s:submit name="apply_approveDel" value="撤销最后一次审阅" action="apply_approveDel" onclick="return isOp('确定进行此操作?');" />
	</s:if>
</div>
</s:form>
</div>
<script type="text/javascript">
$(function(){
	if($("#apply_is_fullcheck").val()==1) {
		$("#apply_is_fullcheck_box").attr("checked","checked");
		$("#apply_fullcheck_text").show();
	}
	$("#apply_is_fullcheck_box").bind("click",function(){
		if(!!$(this).attr("checked")) {
			//alert("checked");
			$("#apply_is_fullcheck").val(1);
			$("#apply_fullcheck_text").show();
		}else {
			//alert("unchecked");
			$("#apply_is_fullcheck").val(0);
			$("#apply_fullcheck_text").hide();
		}
	});
	$("#approveFrom").dialog({
	      autoOpen: false,
	      modal: true
	});
});
function openApprove() {
	$("#approveFrom").dialog("open");
}
//add_approve_flag
function addApproveCheck(flag) {
	if(window.confirm("确定要审阅吗?")) {
		$("#add_approve_flag").val(flag);
		return true;
	} else {
		return false;
	}
}
</script>
</body>
</html>