<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游客户名单列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">工业旅游客户名单列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="travelCustomer_load"><s:param name="viewFlag">add</s:param></s:url>" >添加工业旅游客户名单</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="travelCustomer_list"  method="get" namespace="/qkjmanage" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>主键自增:</td>
<td class='secRow'><s:property value="travelCustomer.uuid" /><s:hidden name="travelCustomer.uuid" title="主键自增" /></td>
<td class='firstRow'>旅游单ID:</td>
<td class='secRow'><s:textfield name="travelCustomer.travel_id" title="旅游单ID" dataLength="0,10" dataType="integer" controlName="旅游单ID" /></td>
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
<th>客户姓名</th>
<th>性别</th>
<th>单位名称</th>
<th>联系电话</th>

		<th>操作</th>
	  </tr>
<s:iterator value="travelCustomers" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
<td><s:property value="cus_name" /></td>
<td><s:property value="cus_sex" /></td>
<td><s:property value="cus_company" /></td>
<td><s:property value="cus_phone" /></td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER')">
	    	[<a href="<s:url namespace="/qkjmanage" action="travelCustomer_load"><s:param name="viewFlag">mdy</s:param><s:param name="travelCustomer.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_DEL')">
	    	[<a href="<s:url namespace="/qkjmanage" action="travelCustomer_del"><s:param name="travelCustomer.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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