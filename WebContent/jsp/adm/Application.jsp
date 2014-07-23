<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>请假申请单</title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<style type="text/css">
table {
	font-size: 16px;
	border:0px;
}

.title{
	font-size: 24px;
	font-weight: bold;
	border: none;
	
}
.sh{
width:30%;
display: inline-block;
vertical-align: top;
}
.st{
width:68%;
display: inline-block;
text-align: right;
padding-top: 50px;
}
</style>
</head>


<body>
	<div id="main">
		<div id="result">
			<div class="itablemdy">
				<s:form name="form1" action="" namespace=""
					onsubmit="return validator(this);" method="post" >
					<table  width="100%" border="1" cellspacing="0"
						cellpadding="0" bordercolor="#8B8B8B">
						<tr height="40">
							<td colspan="8" align="center" class="title">请假申请单</td>
						</tr>
						<tr height="30">
							<td colspan="6" align="right" >制表日期：  年    月    日</td>
						</tr>
						<tr height="30" align="center">
							<td  width="17%">部门:</td>
							<td width="17%"></td>
							<td width="17%">姓名:</td>
							<td width="17%"></td>
							<td width="17%">申请日期:</td>
							<td width="17%"></td>
						</tr>
						<tr  height="100" align="center">
							<td>请假时间:</td>
							<td colspan="6" >
							从    年   月    日至      年   月   日，请        假，共计   天。
							</td>
						</tr>
							
						<tr height="140" align="center">
							<td>请假事由:</td>
							<td colspan="8">
							</td>
						</tr>
						<tr height="100">
							<td align="center">部门负责人意见:</td>
							<td colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>

						<tr height="100">
							<td align="center">分管副总经理意见:</td>
							<td colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr height="100">
							<td align="center">人力资源部意见:</td>
							<td colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr height="100">
							<td align="center">行政管理副总经理意见:</td>
							<td  colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr height="100">
							<td align="center">总经理意见:</td>
							<td  colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr >
							<td  colspan="8" align="left">
							&nbsp;&nbsp;备注：1、主管级以下员工请假3天以内由人力资源部经理审批；<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							2、经理级请假或员工请假4-10天由人力资源主管副总经理审批。<br>
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							3、副总级请假或员工请假10天以上由总经理审批。<br></td>
						</tr>
						
					</table>
				</s:form>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
	var infoeditor01;
	$(function() {
		infoeditor01 = new widget_textarea();
		infoeditor01.init("warenoteid");
	});

	$("#orderGoods_storage_date").datepicker();
</script>
</html>