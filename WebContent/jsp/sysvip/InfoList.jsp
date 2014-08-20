<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>留言交流列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">留言交流列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_ADD')">
			<a href="<s:url namespace="/sysvip" action="info_load"><s:param name="viewFlag">add</s:param></s:url>" >添加留言交流</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="info_list"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>主键ID:</td>
<td class='secRow'><s:property value="info.uuid" /><s:hidden name="info.uuid" title="主键ID" /></td>
<td class='firstRow'>信息种类:</td>
<td class='secRow'><s:property value="info.type" /><s:hidden name="info.type" title="信息种类" /></td>
</tr><tr>
<td class='firstRow'>信息类型:</td>
<td class='secRow'><s:property value="info.itype" /><s:hidden name="info.itype" title="信息类型" /></td>
<td class='firstRow'>主UUID:</td>
<td class='secRow'><s:property value="info.reuuid" /><s:hidden name="info.reuuid" title="主UUID" /></td>
</tr><tr>
<td class='firstRow'>私信的接收人:</td>
<td class='secRow'><s:property value="info.tomember" /><s:hidden name="info.tomember" title="私信的接收人" /></td>
<td class='firstRow'>交流分类:</td>
<td class='secRow'><s:select name="info.imode" title="交流分类" headerKey="" headerValue="--请选择--" list="#{'TIPS':'普通','SALES':'买卖','QA':'询问'}" /></td>
</tr><tr>
<td class='firstRow'>标题:</td>
<td class='secRow'><s:textfield name="info.title" title="标题" dataLength="0,85" controlName="标题" /></td>
<td class='firstRow'>信息内容:</td>
<td class='secRow'><s:textfield name="info.content" title="信息内容" dataLength="0,21845" controlName="信息内容" /></td>
</tr><tr>
<td class='firstRow'>审核状态:</td>
<td class='secRow'></td>
<td class='firstRow'>删除标记:</td>
<td class='secRow'></td>
</tr><tr>
<td class='firstRow'>添加人:</td>
<td class='secRow'><s:property value="info.add_member" /></td>
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
	    <th>主键ID</th>
<th>交流分类</th>
<th>标题</th>
<th>信息内容</th>
<th>添加时间</th>

		<th>操作</th>
	  </tr>
<s:iterator value="infos" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
<td><s:if test=''TIPS"==imode'>普通</s:if><s:if test=''SALES"==imode'>买卖</s:if><s:if test=''QA"==imode'>询问</s:if></td>
<td><s:property value="title" /></td>
<td><s:property value="content" /></td>
<td><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>

		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_MDY')">
	    	[<a href="<s:url namespace="/sysvip" action="info_load"><s:param name="viewFlag">mdy</s:param><s:param name="info.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_DEL')">
	    	[<a href="<s:url namespace="/sysvip" action="info_del"><s:param name="info.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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