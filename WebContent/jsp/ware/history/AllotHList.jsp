<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调库历史列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">调库历史列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOTH_ADD')">
			<a href="<s:url namespace="/ware" action="allotH_load"><s:param name="viewFlag">add</s:param></s:url>" >添加调库历史</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="allotH_list"  method="get" namespace="/ware" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>主键自增:</td>
<td class='secRow'><s:property value="allotH.uuid" /><s:hidden name="allotH.uuid" title="主键自增" /></td>
<td class='firstRow'>调库单号:</td>
<td class='secRow'><s:property value="allotH.ordernum" /><s:hidden name="allotH.ordernum" title="调库单号" /></td>
</tr><tr>
<td class='firstRow'>调库日期:</td>
<td class='secRow'><s:date name="allotH.date" format="yyyy-MM-dd HH:mm:ss" /><s:hidden name="allotH.date" title="调库日期" /></td>
<td class='firstRow'>调出仓库:</td>
<td class='secRow'><s:textfield name="allotH.sourceid" title="调出仓库" dataLength="0,10" dataType="integer" controlName="调出仓库" /></td>
</tr><tr>
<td class='firstRow'>调入仓库:</td>
<td class='secRow'><s:textfield name="allotH.goldid" title="调入仓库" dataLength="0,10" dataType="integer" controlName="调入仓库" /></td>
<td class='firstRow'>其它说明:</td>
<td class='secRow'><s:textfield name="allotH.note" title="其它说明" dataLength="0,200" controlName="其它说明" /></td>
</tr><tr>
<td class='firstRow'>添加日期:</td>
<td class='secRow'><s:textfield name="allotH.add_timer" title="添加日期" value="%{getText('global.date',{allotH.add_timer})=='null'?'':getText('global.date',{allotH.add_timer})}" dataType="date" controlName="添加日期" /></td>
<td class='firstRow'>修改人:</td>
<td class='secRow'><s:textfield name="allotH.lm_user" title="修改人" dataLength="0,20" controlName="修改人" /></td>
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
<th>调入仓库</th>
<th>其它说明</th>
<th>添加人</th>
<th>添加日期</th>
<th>修改人</th>
<th>修改日期</th>

		<th>操作</th>
	  </tr>
<s:iterator value="allotHs" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
<td><s:property value="goldid" /></td>
<td><s:property value="note" /></td>
<td><s:property value="add_user" /></td>
<td><s:date name="add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
<td><s:property value="lm_user" /></td>
<td><s:date name="lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOTH')">
	    	[<a href="<s:url namespace="/ware" action="allotH_load"><s:param name="viewFlag">mdy</s:param><s:param name="allotH.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOTH_DEL')">
	    	[<a href="<s:url namespace="/ware" action="allotH_del"><s:param name="allotH.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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