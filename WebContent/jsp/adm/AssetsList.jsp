<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"${assets.typea}",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none",
		required:false
	});
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">资产列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_ADD')">
			<a href="<s:url namespace="/adm" action="assets_load"><s:param name="viewFlag">add</s:param></s:url>" >添加资产</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="assets_list"  method="get" namespace="/adm" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>系统编号:</td>
			<td class='secRow'><s:textfield name="assets.uuid" title="系统编号" /></td>
			<td class='firstRow'>资产分类:</td>
			<td id="mmtype" class='secRow'>
				<select name="assets.typea" title="资产种类" class="prov"></select> 
				<select name="assets.typeb" title="资产类别" class="city" disabled="disabled"></select>
				<select name="assets.typec" title="子类别" class="dist" disabled="disabled"></select>
			</td>
			</tr><tr>
			<td class='firstRow'>资产名称:</td>
			<td class='secRow'><s:textfield name="assets.title" title="资产名称" dataLength="0,128" controlName="资产名称" /></td>
			<td class='firstRow'>所属公司:</td>
			<td class='secRow'><s:select name="assets.company" title="所属公司" headerKey="" headerValue="--请选择--" list="#{0:'北京互助天佑德青稞酒销售有限公司',1:'华实集团',2:'华奥地产',3:'青海互助青稞酒股份有限公司',4:'青海互助青稞酒销售有限公司',5:'北京互助天佑德青稞酒销售有限公司第二分公司'}" /></td>
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
	    <th>系统编号</th>
		<th>资产种类</th>
		<th>资产类别</th>
		<th>子类别</th>
		<th>资产名称</th>
		<th>数量</th>
		<th>总价</th>
		<th>采购时间</th>
		<th>操作</th>
	  </tr>
<s:iterator value="assetss" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td align="center"><s:property value="uuid" /></td>
		<td align="center">${typea}</td>
		<td align="center">${typeb}</td>
		<td align="center">${typec}</td>
		<td><s:property value="title" /></td>
		<td align="center"><s:property value="num" /></td>
		<td align="center"><s:property value="price_scope" /></td>
		<td align="center"><s:date name="p_time" format="yyyy-MM-dd" /></td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS')">
	    	[<a href="<s:url namespace="/adm" action="assets_load"><s:param name="viewFlag">mdy</s:param><s:param name="assets.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_DEL')">
	    	[<a href="<s:url namespace="/adm" action="assets_del"><s:param name="assets.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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