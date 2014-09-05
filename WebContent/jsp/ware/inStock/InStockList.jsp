<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>入库列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">入库列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_ADD')">
			<a href="<s:url namespace="/inStock" action="inStock_load"><s:param name="viewFlag">add</s:param></s:url>" >添加入库</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="inStock_list"  method="get" namespace="/inStock" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>订单编号:</td>
<td class='secRow'><s:textfield name="inStock.uuid" title="订单商品号"  controlName="订单号" /></td>
<td class='firstRow'>添加人:</td>
<td class='secRow'><s:textfield name="inStock.add_user_name" title="操作人" controlName="操作人IP" /></td>
</tr><tr>
<td class='firstRow'>经手人:</td>
<td class='secRow'><s:textfield name="inStock.operator_id" title="订单商品号"  controlName="订单商品号" /></td>
<td class='firstRow'>保管员:</td>
<td class='secRow'><s:textfield name="inStock.take_id" title="操作类型"  controlName="操作类型" /></td>
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
	    <th>订单编号</th>
		<th>经手人</th>
		<th>保管员</th>
		<th>其它说明</th>
		<th>总价</th>
		<th>添加人</th>
		<th>添加时间</th>
		<th>修改人</th>
		<th>修改时间</th>

		<th>操作</th>
	  </tr>
<s:iterator value="inStocks" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
		<td><s:property value="operator_id" /></td>
		<td><s:property value="take_id" /></td>
		<td><s:property value="note" /></td>
		<td><s:property value="total_price" /></td>
		<td><s:property value="add_user_name" /></td>
		<td><s:date name="add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td><s:property value="lm_user_name" /></td>
		<td><s:date name="lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td align="center">
		<s:if test="">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_MDY')">
	    	[<a href="<s:url namespace="/inStock" action="inStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="inStock.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_DEL')">
	    	[<a href="<s:url namespace="/inStock" action="inStock_del"><s:param name="inStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>	
	    </s:if>
	    <s:else>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_PUTSEAL') && confirm==1">
	    	[<a target="_blank" href="<s:url namespace="/inStock" action="inStock_view"><s:param name="viewFlag">view</s:param><s:param name="inStock.uuid" value="uuid"></s:param></s:url>">查看/打印</a>]
	    	</s:if>
	    </s:else>	   
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
	    <s:actionerror/>
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