<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>取酒订单列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	$("#cellarOrder_add_time").datepicker();
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">取酒订单列表</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="cellarOrder_list"  method="get" namespace="/sysebiz" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>取酒订单号:</td>
			<td class='secRow'><s:textfield name="cellarOrder.uuid" title="取酒订单号" /></td>
			<td class='firstRow'>收货人姓名:</td>
			<td class='secRow'><s:textfield name="cellarOrder.con_name" title="收货人姓名" /></td>
			</tr>
			<tr>
			<td class='firstRow'>取酒仓库:</td>
			<td class='secRow'>
				<s:select name="cellarOrder.ware_id" list="wares" listKey="uuid" listValue="ware_name" headerKey="" headerValue="--请选择--" />
			</td>
			<td class='firstRow'>下单时间:</td>
			<td class='secRow'><s:textfield id="cellarOrder_add_time" name="cellarOrder.add_time" value="%{getText('global.date',{cellarOrder.add_time})=='null'?'':getText('global.date',{cellarOrder.add_time})}" title="下单时间" /></td>
			</tr>
			<tr>
			<td class='firstRow'>取酒位置(%):</td>
			<td class='secRow'><s:textfield name="cellarOrder.cellar_position" title="取酒位置" /></td>
			<td class='firstRow'>订单状态:</td>
			<td class='secRow'><s:select name="cellarOrder.status" title="订单状态" headerKey="" headerValue="--请选择--" list="#{10:'新订单',20:'已灌装',30:'已发货',40:'已收货',50:'已评价'}" /></td>
			</tr>
			<tr>
			<td colspan="4" class="buttonarea">
				<s:submit value="搜索" />
				<s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	  <col style="width: 30px;" />
	  <col style="width: 130px;"   />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>取酒订单号</th>
	    <th>取酒位置号</th>
		<th>取酒数量</th>
		<th>收货人姓名</th>
		<th>所送地区</th>
		<th>手机/联系电话</th>
		<th>状态</th>
		<th>来源</th>
		<th>操作</th>
	  </tr>
<s:iterator value="cellarOrders" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td align="center"><s:property value="uuid" /></td>
	    <td align="center"><s:property value="cellar_position" /></td>
		<td align="center"><s:property value="order_num" /> <s:property value="cellar_unit" /></td>
		<td align="center"><s:property value="con_name" /></td>
		<td align="center"><s:property value="con_province" /> <s:property value="con_city" /></td>
		<td align="center"><s:property value="con_mobile" /></td>
		<td align="center">
			<s:if test="0==status">作废订单</s:if>
			<s:if test="10==status">新订单</s:if>	
			<s:if test="20==status">已灌装</s:if>
			<s:if test="30==status">已发货</s:if>	
			<s:if test="40==status">已收货</s:if>
			<s:if test="50==status">已评价</s:if>
			<s:if test="(null==order_video||''==order_video)&&status>10">
			<span style="color:red;">无视频</span>
			</s:if>
		</td>
		<td align="center">
			<s:if test="0==order_source"><span class="message_pass">客户自助下单</span></s:if>
			<s:if test="1==order_source">代客下单</s:if>
		</td>
		<td align="center">
	    	[<a href="<s:url namespace="/sysebiz" action="cellarOrder_load"><s:param name="viewFlag">mdy</s:param><s:param name="cellarOrder.uuid" value="uuid"></s:param></s:url>">修改&操作</a>]
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage();
		spage.show2(<s:property value="recCount" />,<s:property value="pageSize" />,2);
		</script>
		</td>	    
	  </tr>
	  <tr>
	    <td colspan="20" class="buttonarea">
	    <span id="message"><s:property value="message" /></span>
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>