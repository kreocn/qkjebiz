<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">出库列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_OUTSTOCK_OUTSTOCK_ADD')">
			<a href="<s:url namespace="/outStock" action="outStock_load"><s:param name="viewFlag">new</s:param></s:url>" >添加出库</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="outStock_list"  method="get" namespace="/outStock" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>主键自增:</td>
<td class='secRow'><s:property value="outStock.uuid" /><s:hidden name="outStock.uuid" title="主键自增" /></td>
<td class='firstRow'>出库时间:</td>
<td class='secRow'><s:date name="outStock.date" format="yyyy-MM-dd HH:mm:ss" /><s:hidden name="outStock.date" title="出库时间" /></td>
</tr><tr>
<td class='firstRow'>出库仓库:</td>
<td class='secRow'><s:textfield name="outStock.store_id" title="出库仓库" dataLength="0,10" dataType="integer" controlName="出库仓库" /></td>
<td class='firstRow'>经办人:</td>
<td class='secRow'><s:textfield name="outStock.operator_id" title="经办人" dataLength="0,10" dataType="integer" controlName="经办人" /></td>
</tr><tr>
<td class='firstRow'>保管员:</td>
<td class='secRow'><s:textfield name="outStock.take_id" title="保管员" dataLength="0,10" dataType="integer" controlName="保管员" /></td>
<td class='firstRow'>总价:</td>
<td class='secRow'><s:textfield name="outStock.total_price" title="总价" dataLength="0,10" dataType="number" controlName="总价" /></td>
</tr><tr>
<td class='firstRow'>添加人:</td>
<td class='secRow'><s:textfield name="outStock.add_user" title="添加人" dataLength="0,10" dataType="integer" controlName="添加人" /></td>
<td class='firstRow'>确认人姓名:</td>
<td class='secRow'><s:property value="outStock.manager_check_user" /></td>
</tr><tr>
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
	<col width="30" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>主键自增</th>
<th>经办人</th>
<th>保管员</th>
<th>其它说明</th>
<th>总价</th>
<th>添加人</th>
<th>添加时间</th>
<th>修改人</th>
<th>确认人姓名</th>

		<th>操作</th>
	  </tr>
<s:iterator value="outStocks" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
<td><s:property value="operator_id" /></td>
<td><s:property value="take_id" /></td>
<td><s:property value="note" /></td>
<td><s:property value="total_price" /></td>
<td><s:property value="add_user" /></td>
<td><s:date name="add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
<td><s:property value="lm_user" /></td>
<td><s:property value="coo_check_user" /></td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_OUTSTOCK_OUTSTOCK')">
	    	[<a href="<s:url namespace="/outStock" action="outStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="outStock.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_OUTSTOCK_OUTSTOCK_DEL')">
	    	[<a href="<s:url namespace="/outStock" action="outStock_del"><s:param name="outStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>	   
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
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