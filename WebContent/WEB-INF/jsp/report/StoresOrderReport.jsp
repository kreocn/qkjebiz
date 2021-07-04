<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>门店订单报表</title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">
				<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;活动/至事由统计报表
			</div>
			<s:form id="serachForm" name="serachForm" action="stores_order_list_report" method="get" namespace="/storpt" theme="simple">
				<div class="label_con">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">月份: </div>
							<div class="label_rwben label_rwb">
								<input type="text" id="datepicker" name="month">
							</div>
						</div>

						<div class="label_hang tac">
							&nbsp;&nbsp;
							<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
							<label for="search_mcondition"></label>更多条件
							<s:submit value="搜索" />
							<s:reset value="重置" />
							<span id="message"><s:property value="message" /></span>
						</div>
					</div>
				</div>
			</s:form>

			<div class="tab_warp">
				<table>
					<tr id="coltr">
						<th class="td1">日期</th>
						<th class="td1">订单金额</th>
						<th class="td1">订单数量(笔)</th>
						<th class="td0">查看</th>

					</tr>
					<s:iterator value="storesorderlist" status="sta">
						<tr>
							<td class="td1 nw">${report_time}</td>
							<td class="td1 nw">${report_price}</td>
							<td class="td1 nw">${report_num}</td>
							<td class="td0 op-area"><a onClick="showDetail('showtr${apply_dept}');" href="javascript:;" class="input-nostyle">查看</a></td>
						</tr>
					</s:iterator>
				</table>
			</div>


		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	  <script>
  $(function() {
    $( "#datepicker" ).datepicker({
        dateFormat: 'yy-mm',
    })
  });
  </script>
</body>
</html>