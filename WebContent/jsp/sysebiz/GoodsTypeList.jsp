<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品类型管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
window.onload = function() {
	setStyle("table1");
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">商品类型列表</span>
		<span class="extra1">
			<a href="<s:url namespace="/sysebiz" action="goodsType_load"><s:param name="viewFlag">add</s:param></s:url>" >添加商品类型</a>
		</span>
	</div>	
	<div class="ilistsearch"></div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <colgroup>
		<col width="30" />
		<col />
		<col />
		<col />
		<col />
	  </colgroup>
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
		<th>类型名称</th>
		<th>属性分组</th>
		<th>属性个数</th>
		<th>状态</th>
		<th>操作</th>
	  </tr>
<s:iterator value="goodsTypes" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="type_name" /></td>
	    <td><s:property value="type_group" /></td>
	    <td align="center"><s:property value="item_num" /></td>
	    <td align="center">
	    	<s:if test="0==status"><span class="yesarea"></span></s:if>
			<s:elseif test="1==status"><span class="noarea"></span></s:elseif>
	    </td>
	    <td align="center">
	    	[<a href="javascript:;">编辑属性</a>]
	    	[<a href="<s:url namespace="/sysebiz" action="goodsType_load"><s:param name="viewFlag">mdy</s:param><s:param name="goodsType.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	[<a href="<s:url namespace="/sysebiz" action="goodsType_del"><s:param name="goodsType.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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