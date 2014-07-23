<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员预付款管理--<s:text name="APP_NAME" /></title>
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
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>会员预付款</span>
		<span class="extra1">
			<a href="<s:url action="deposit_list" namespace="/sysvip"><s:param name="viewFlag">relist</s:param></s:url>" >会员预付款列表</a>
		</span>	
	</div>
<s:form name="form1" action="deposit_add" namespace="/sysvip" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		  <tr>
		<td class='firstRow'><span style="color:red;">*</span> 编号:</td>
		<td class='secRow'><s:property value="deposit.uuid" /><s:hidden name="deposit.uuid" title="编号" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 提交人:</td>
		<td class='secRow'><s:property value="deposit.add_user_name" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 提交时间:</td>
		<td class='secRow'><s:date name="deposit.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 客户信息:</td>
		<td class='secRow'>
			${deposit.member_id}
			${deposit.member_name}
			<s:hidden name="deposit.member_id" title="客户ID" require="required" controlName="客户ID" />
		</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 付款日期:</td>
		<td class='secRow'>
			<input type="text" id="deposit_pay_date" name="deposit.pay_date" value="${it:formatDate(deposit.pay_date,'yyyy-MM-dd')}"  require="required" controlName="付款日期" />
			<script type="text/javascript">$("#deposit_pay_date").datepicker();</script>
		</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 付款方式:</td>
		<td class='secRow'><s:select name="deposit.type" title="付款方式" headerKey="" headerValue="--请选择--" list="#{0:'现金',1:'POS',2:'支票',3:'转账',4:'其他'}" require="required" controlName="付款方式" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 付款金额:</td>
		<td class='secRow'><s:textfield name="deposit.amount" title="付款金额" dataLength="0,11" dataType="number"  require="required" controlName="付款金额" /></td>
		</tr>
		<tr>
		<td class='firstRow'>财务确认情况:</td>
		<td class='secRow'>
			<s:if test="deposit.fd_check==0"><span class="message_error">未确认</span></s:if>
			<s:if test="deposit.fd_check==1">
				<span class="message_pass">已确认</span>
				(${deposit.fd_check_user_name} ${it:formatDate(deposit.fd_check_time,'yyyy-MM-dd HH:mm:ss')})
			</s:if>
		</td>
		</tr>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_DEPOSIT_ADD')">
					<s:submit id="add" name="add" value="确定" action="deposit_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="deposit.fd_check==0 && @org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_DEPOSIT_MDY')">
					<s:submit id="save" name="save" value="保存" action="deposit_save" />
					</s:if>
					<s:if test="deposit.fd_check==0 && @org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_DEPOSIT_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="deposit_del" onclick="return isDel();" />
					</s:if>
					<s:if test="deposit.fd_check==0 && @org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_DEPOSIT_FDCHECK')">
					<s:submit id="deposit_fd_check" name="deposit_fd_check" value="财务确定到款" action="deposit_fd_check" onclick="return isOp('确认已到账?\n到账操作完成之后,将直接增加客户资产金额.');" />
					</s:if>
				</s:elseif>
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>