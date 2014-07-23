<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动客户管理管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#form1").bind("submit",function(){
		var exp_no = $("#hcusInfo_express_no").val();
		//校验表单
		if(exp_no==null || exp_no=='') {
			alert("快递单号不能为空!");
			return false;
		} 
		
		if(isOp("您扫描的快递单号为:"+exp_no+" \n提交并进入打印页面?")) 
			return true;
			//else
			//alert("NOK");
		return false;
	});
});
</script>
<style type="text/css">
.express_scan {
width: 350px !important;line-height: 40px;height: 40px;font-size: 36px;
}
.basic_info {
}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">发快递</span>
		<span class="extra1">
			<a href="<s:url action="hCusInfo_list" namespace="/webmanager"><s:param name="viewFlag">relist</s:param></s:url>" >活动客户列表</a>
		</span>	
	</div>
<s:form id="form1" name="form1" action="hCusInfo_express" namespace="/webmanager" method="post" theme="simple">
	<div class="basic_info">
		<table class="ilisttable" width="100%">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 系统编号:</td>
			<td class='secRow'>${hcusInfo.uuid}</td>
			</tr>
			<tr>
			<td class='firstRow'>证券帐号:</td>
			<td class='secRow'>${hcusInfo.security}</td>
			</tr>
			<tr>
			<td class='firstRow'>姓名:</td>
			<td class='secRow'>${hcusInfo.fullname}</td>
			</tr>
			<tr>
			<td class='firstRow'>联系手机:</td>
			<td class='secRow'>${hcusInfo.mobile}</td>
			</tr>
			<tr>
				<td class='firstRow'>邮编:</td>
				<td class='secRow'>${hcusInfo.postno}</td>
			</tr>
			<tr>
			<td class='firstRow'>地址:</td>
			<td class='secRow'>${hcusInfo.address}</td>
			</tr>
			<tr>
			<td class='firstRow'>是否已快递:</td>
			<td class='secRow'>
				<s:if test="hcusInfo.express_status==0">
					<span class="message_error">未快递</span>
				</s:if>
				<s:elseif test="hcusInfo.express_status==1">
					<span class="message_pass">已快递</span>
				</s:elseif>
			</td>
			</tr>
			<tr>
			<td class='firstRow'>快递单号:</td>
			<td class='secRow'>
			<s:textfield id="hcusInfo_express_no" cssClass="express_scan" name="hcusInfo.express_no" title="快递单号" />
			</td>
			</tr>
			<!--  -->
			<tr>
			<td class='firstRow'>快递类型:</td>
			<td class='secRow'><s:property value="hcusInfo.express_type" /></td>
			</tr>
			<tr>
			<td class='firstRow'>快递时间:</td>
			<td class='secRow'><s:date name="hcusInfo.express_date" format="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</table>	
	</div>
<s:hidden name="hcusInfo.uuid" title="系统编号" />
<s:hidden name="hcusInfo.linkid" title="投票ID" />
</s:form>
	</div>
</div>
</div>

<div class="express_print">
<table class="ilisttable" width="100%">
<tr>
<td width="50%">
<div></div>
</td>
<td width="50%">
BBB
</td>
</tr>
</table>		
</div>

</body>
</html>