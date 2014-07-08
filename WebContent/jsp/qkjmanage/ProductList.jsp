<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">产品列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="product_load"><s:param name="viewFlag">add</s:param></s:url>" >添加产品</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="product_list"  method="get" namespace="/qkjmanage" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>品名:</td>
			<td class='secRow'><s:textfield name="product.title" title="品名" dataLength="0,85" controlName="品名" /></td>
			<td class='firstRow'>档次:</td>
			<td class='secRow'><s:select name="product.grade" title="档次 1低端 2中端 3中高端 4高端" headerKey="" headerValue="--请选择--" list="#{1:'低端',2:'中端',3:'中高端',4:'高端'}" /></td>
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
	    <th>品名</th>
		<th>规格</th>
		<th>数量</th>
		<th>档次</th>
		<th>市场价</th>
		<th>团购价</th>
		<th>出厂价</th>
		<th>返利标准</th>
		<th>操作</th>
	  </tr>
<s:iterator value="products" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="title" /></td>
		<td align="center"><s:property value="spec" /></td>
		<td align="center"><s:property value="case_spec" />/件</td>
		<td align="center"><s:if test='1==grade'>低端</s:if><s:if test='2==grade'>中端</s:if><s:if test='3==grade'>中高端</s:if><s:if test='4==grade'>高端</s:if></td>
		<td align="center"><s:property value="market_price" /></td>
		<td align="center"><s:property value="group_price" /></td>
		<td align="center"><s:property value="dealer_price" /></td>
		<td align="center"><s:property value="group_rebates" />%</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_MDY')">
	    	[<a href="<s:url namespace="/qkjmanage" action="product_load"><s:param name="viewFlag">mdy</s:param><s:param name="product.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_DEL')">
	    	[<a href="<s:url namespace="/qkjmanage" action="product_del"><s:param name="product.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>	   
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