<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>盘点列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">盘点列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_CHECK_CHECK_ADD')">
			<a href="<s:url namespace="/check" action="check_load"><s:param name="viewFlag">add</s:param></s:url>" >添加盘点</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="check_list"  method="post" namespace="/check" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>

<td class='firstRow'>商品:</td>
<td class='secRow'><s:select name="check.product_id" title="商品" headerKey="" headerValue="--请选择--" list="products" listKey="uuid" listValue="title" /></td>
<td class='firstRow'>盘点仓库:</td>
<td class='secRow'><s:select name="check.store_id" title="仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" /></td>
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
	    <th>盘点日期</th>
	    <th>商品名称</th>
	    <th>所在仓库</th>
		<th>库存</th>
		<th>差异数量</th>
		<th>操作</th>
	  </tr>
<s:iterator value="checks" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="date" /></td>
	    <td><s:property value="product_name" /></td>
	    <td><s:property value="ware_name" /></td>
		<td><s:property value="quantity" /></td>
		<td><s:property value="num" /></td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_CHECK_CHECK')">
	    	[<a href="<s:url namespace="/check" action="check_load"><s:param name="viewFlag">mdy</s:param><s:param name="check.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_CHECK_CHECK_DEL')">
	    	[<a href="<s:url namespace="/check" action="check_del"><s:param name="check.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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