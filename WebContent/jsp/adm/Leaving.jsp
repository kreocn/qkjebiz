<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>换休申请单</title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<style type="text/css">
table {
	text-align: center;
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
					onsubmit="return validator(this);" method="post" theme="simple">
					<table width="100%" border="1" cellspacing="0" cellpadding="0"
						bordercolor="#8B8B8B">
						<tr height="40">
							<td colspan="4" align="center" class="title">换休申请单</td>
						</tr>
						<tr height="30">
							<td colspan="4" align="right">制表日期： 年 月 日</td>
						</tr>
						<tr height="30">
							<td width="17%">部门:</td>
							<td width="17%"></td>
							<td width="17%">姓名:</td>
							<td width="17%"></td>
						</tr>
						<tr height="100">
							<td>换休时间:</td>
							<td colspan="4">
								从 年 月 日至 年 月 日，请 假，共计 天。
							</td>
						</tr>

						<tr height="100">
							<td>部门负责人意见:</td>
							<td colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>

						<tr height="100">
							<td>分管副总经理意见:</td>
							<td colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr height="100">
							<td>人力资源部意见:</td>
							<td colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr height="100">
							<td>行政管理副总经理意见:</td>
							<td  colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr height="100">
							<td >总经理意见:</td>
							<td  colspan="8">
							<span class="sh"></span>
							<span  class="st">签字：             日期：      年    月    日</span>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="left">
								&nbsp;&nbsp;备注：1、《换休单》由人力资源部签发，凡未经人力资源部签发的《换休单》一律无效；<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								2、换休时凭《换休单》提前一天告知主管领导，经主管领导同意后方可换休，并将《换休单》交回人力资源部给予考勤处理；<br>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								3、每月换休不能超过5天，签发的《换休单》在一年内有效，过期作废。<br>
							</td>
						</tr>

					</table>
				</s:form>
			</div>
		</div>
	</div>
</body>

</html>