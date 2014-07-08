<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>至事由申请管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == apply && 'add' == viewFlag">增加</s:if><s:elseif test="null != apply && 'mdy' == viewFlag">修改</s:elseif>至事由申请</span>
		<span class="extra1">
			<a href="<s:url action="apply_list" namespace="/qkjmanage" />" >至事由申请列表</a>
		</span>	
	</div>
<s:form name="form1" action="apply_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != apply">
		  <tr>
		<td class='firstRow3'><span style="color:red;">*</span> 申请编号:</td>
		<td class='secRow3'><s:property value="apply.uuid" /><s:hidden name="apply.uuid" title="主键ID" /></td>
		</tr>
		</s:if>
		
		<tr>
		<td class='firstRow3'><span style="color:red;">*</span> 至:</td>
		<td class='secRow3'>
			<s:if test="'add'==viewFlag || apply.status==0 || apply.status==5">
			<s:textfield name="apply.touser" title="至" require="required" dataLength="0,255" controlName="至" cssStyle="width:80%;" />
			</s:if>
			<s:else>${apply.touser}</s:else>
		</td>
		</tr>
		
		<tr>
		<td class='firstRow3'><span style="color:red;">*</span> 事:</td>
		<td class='secRow3'>
			<s:if test="'add'==viewFlag || apply.status==0 || apply.status==5">
			<s:textfield name="apply.title" title="主题" require="required" dataLength="0,255" controlName="主题" cssStyle="width:80%;" />
			</s:if>
			<s:else>${apply.title}</s:else>
		</td>
		</tr>
		
		<tr>
		<td class='firstRow3'>是否需要会审:</td>
		<td class='secRow3'>
			<s:checkbox id="apply_is_fullcheck_box" name="is_fullcheck_box" />
			<s:hidden  id="apply_is_fullcheck" name="apply.is_fullcheck" />
		</td>
		</tr>
		
		<tr id="apply_fullcheck_text" style="display: none;">
		<td class='firstRow3'>会审说明:</td>
		<td class='secRow3'>
			<s:textfield name="apply.fullcheck_text" title="会审说明" dataLength="0,128" cssStyle="width:80%;" />
			<span class="message_prompt">(填写参加会审的领导职位)</span>
		</td>
		</tr>
		
		<s:if test="null != apply">
		<tr>
		<td class='firstRow3'>由:</td>
		<td class='secRow3'><s:property value="apply.apply_dept_name" /> <s:property value="apply.apply_user_name" /> (<s:date name="apply.apply_time" format="yyyy-MM-dd HH:mm:ss" />)</td>
		</tr>
		</s:if>
		
		<tr>
		<td class='firstRow3'>说明:</td>
		<td class='secRow3'>
			<s:if test="apply.status>=10">
			${apply.note}
			</s:if>
			<s:else>
			<s:textarea id="apply_note" name="apply.note" title="详细说明" cssStyle="width:80%;" rows="15" />
			</s:else>
		</td>
		</tr>
		
		<s:if test="null != apply && apply.status>=5">
		<tr>
		<td class='firstRow3'>审核/报审人:</td>
		<td class='secRow3'><s:property value="apply.check_user_name" /></td>
		</tr>
		<tr>
		<td class='firstRow3'>审核/报审时间:</td>
		<td class='secRow3'><s:date name="apply.check_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow3'>审核/报审意见:</td>
		<td class='secRow3'>
			<s:textarea id="apply_check_note" name="apply.check_note" title="审核意见" rows="4" cssStyle="width:80%;" />
		</td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow3'>相关操作:</td>
		<td class='secRow3'>
			<s:if test="null == apply && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_ADD')">
					<s:submit id="add" name="add" value="确定" action="apply_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != apply && 'mdy' == viewFlag">
					<s:if test="apply.status==0||apply.status==5">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_MDY')">
					<s:submit id="save" name="save" value="保存申请单" action="apply_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK0')">
					<s:submit id="apply_check0" name="apply_check0" value="报审" action="apply_check0" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="apply_del" onclick="return isDel();" />
					</s:if>
					</s:if>
					<s:if test="apply.status==10 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK10')">
					<s:submit id="apply_check10" name="apply_check10" value="大区经理审核通过" action="apply_check10" onclick="return isOp('确定进行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK5')">
					<s:submit id="apply_check5" name="apply_check5" value="审核不通过" action="apply_check5" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					</s:if>
					<s:if test="apply.status==20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK20')">
					<s:submit id="apply_check20" name="apply_check20" value="运营总监审核通过" action="apply_check20" onclick="return isOp('确定进行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_APPLY_CHECK5')">
					<s:submit id="apply_check5" name="apply_check5" value="审核不通过" action="apply_check5" onclick="return isOp('确定进行此操作?');" />
					</s:if>
					</s:if>
					<s:if test="apply.status==30">
					<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="apply_print"><s:param name="apply.uuid" value="apply.uuid" /></s:url>');" value="转到打印页面"/>
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="apply_relist" namespace="/qkjmanage" />');" />
		</td>
		</tr>
		<tr>
		    <td colspan="20">
		    	<span id="message"><s:property value="message" /></span>
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
<script type="text/javascript">
var infoeditor01;
$(function(){
	if($("#apply_note").length>0) {
		infoeditor01 = new widget_textarea();
		infoeditor01.init("apply_note");
	}
	
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
});
</script>
</body>
</html>