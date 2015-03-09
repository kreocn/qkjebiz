<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员收货地址列表--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">会员收货地址列表</span>
		<span class="extra1">
			<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">add</s:param></s:url>" >添加会员收货地址</a>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="memberAddress_list"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
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
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>省/直辖市</th>
<th>市/区</th>
<th>县</th>
<th>邮编</th>
<th>街道地址</th>
<th>收货人姓名</th>
<th>手机/联系电话</th>
<th>是否默认地址</th>

		<th>操作</th>
	  </tr>
<s:iterator value="memberAddresss" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="province" /></td>
<td><s:property value="city" /></td>
<td><s:property value="area" /></td>
<td><s:property value="post" /></td>
<td><s:property value="street" /></td>
<td><s:property value="con_name" /></td>
<td><s:property value="mobile" /></td>
<td><s:if test='0==defaultaddress'>普通库</s:if><s:if test='1==defaultaddress'>藏酒库</s:if></td>

		<td align="center">
	    	[<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">mdy</s:param><s:param name="memberAddress.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	[<a href="<s:url namespace="/sysvip" action="memberAddress_del"><s:param name="memberAddress.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
		<div id="listpage" class="pagination"></div>
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
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
});
</script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
}
</script>
</body>
</html>