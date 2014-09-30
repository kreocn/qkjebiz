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

<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
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
			<td class='firstRow'>编号:</td>
			<td class='secRow'><s:textfield name="inStock.uuid" title="编号" />
			
			<td class='firstRow'>单据号:</td>
			<td class='secRow'>
			<s:textfield name="inStock.ordernum" title="单据号" />
			</td>
			
			</tr>
			
			<tr>
			<td class='firstRow'>入库时间:</td>
			<td class='secRow'><s:textfield id="indate" name="inStock.date" title="入库时间" />
			<script type="text/javascript">$("#indate").datepicker();</script></td>
			
			<td class='firstRow'>入库仓库:</td>
			<td class='secRow'>
			<s:select name="inStock.store_id" title="入库仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
			</td>
			
			</tr>
			
			<tr>
			<td class='firstRow'>单据性质:</td>
			<td class='secRow'>
			<select name="inStock.reason" title="状态">
					<option value="-1">---请选择---</option>
					<option value="0">正常入库</option>
					<option value="1">正常退货</option>
					<option value="2" >损坏退货</option>
					<option value="3" >其它</option>
			</select>
			</td>
			
			<td class='firstRow'>状态:</td>
			<td class='secRow'>
			<select name="inStock.send" title="状态">
					<option value="-1">---请选择---</option>
					<option value="0">正常订单</option>
					<option value="1">取消订单</option>
			</select>
			</td>
			
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
	    <th>编号</th>
	    <th>单据号</th>
	    <th>总价</th>
	    <th>单据性质</th>
		<th>经手人</th>
		<th>保管员</th>
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
	    <td><s:property value="ordernum" /></td>
	    <td><s:property value="total_price"/></td>
	    <td>
	    <s:if test="%{reason==0}">正常入库</s:if>
		<s:if test="%{reason==1}">正常退货</s:if>
		<s:if test="%{reason==2 }">损坏退货</s:if>
		
		(<s:if test="confirm==null">未确认</s:if>
		<s:if test="confirm!=null">已确认</s:if>
		)
		(<s:if test="send==0">正常订单</s:if>
		<s:if test="send==1">已取消订单</s:if>
		)
	    </td>
		<td><s:property value="operator_name" /></td>
		<td><s:property value="take_name" /></td>
		<td><s:property value="add_user_name" /></td>
		<td><s:date name="add_timer" format="yyyy-MM-dd" /></td>
		<td><s:property value="lm_user_name" /></td>
		<td><s:date name="lm_timer" format="yyyy-MM-dd" /></td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_MDY') && @com.qkj.ware.action.warepower@checkPermit(store_id,'add')">
	    	[<a href="<s:url namespace="/inStock" action="inStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="inStock.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_DEL') && @com.qkj.ware.action.warepower@checkPermit(store_id,'add') && confirm==null">
	    	[<a href="<s:url namespace="/inStock" action="inStock_del"><s:param name="inStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>	
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_PUTSEAL') && confirm==1 && @com.qkj.ware.action.warepower@checkPermit(store_id,'add')">
	    	[<a target="_blank" href="<s:url namespace="/inStock" action="inStock_view"><s:param name="viewFlag">view</s:param><s:param name="inStock.uuid" value="uuid"></s:param></s:url>">查看/打印</a>]
	    
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