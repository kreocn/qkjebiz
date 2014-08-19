<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调库列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">调库列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ALLOT_ALLOT_ADD')">
			<a href="<s:url namespace="/allot" action="allot_load"><s:param name="viewFlag">add</s:param></s:url>" >添加调库</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="allot_list"  method="post" namespace="/allot" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
<tr>
<td class='firstRow'>调库日期:</td>
<td class='secRow'>
<s:textfield id="indate" name="allot.date" title="调库时间" controlName="调库时间" />
<script type="text/javascript">$("#indate").datepicker();</script>
<td class='firstRow'>调出仓库:</td>
<td class='secRow'>
		<s:select name="allot.sourceid" title="调出仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
</tr><tr>
<td class='firstRow'>调入仓库:</td>
<td class='secRow'>
	<s:select name="allot.goldid" title="调入仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />

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
	    <th>调库单号</th>
		<th>调入仓库</th>
		<th>调出仓库</th>
		<th>添加人</th>
		<th>添加日期</th>
		<th>修改人</th>
		<th>修改日期</th>

		<th>操作</th>
	  </tr>
<s:iterator value="allots" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
	    <td><s:property value="ordernum" />
	    <s:if test="%{state==0}"><font color="red">（未发货）</font></s:if>
	    <s:if test="%{state==1}"><font color="red">（已发货）</font></s:if>
	    <s:if test="%{state==2}"><font color="red">（取消发货）</font></s:if>
	    <s:if test="%{state==3}"><font color="red">（已收货）</font></s:if>
	    </td>
		<td><s:property value="goldName" /></td>
		<td><s:property value="sourceName" /></td>
		<td><s:property value="add_user_name" /></td>
		<td><s:date name="add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td><s:property value="lm_user_name" /></td>
		<td><s:date name="lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ALLOT_ALLOT')">
	    	[<a href="<s:url namespace="/allot" action="allot_load"><s:param name="viewFlag">mdy</s:param><s:param name="allot.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ALLOT_ALLOT_DEL')">
	    	[<a href="<s:url namespace="/allot" action="allot_del"><s:param name="allot.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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