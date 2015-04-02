<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员积分消费列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">会员返利积分消费列表</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="memberCapitalRescore_list"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
<td class='firstRow'>主键ID:</td>
<td class='secRow'><s:textfield name="memberCapitalRescore.uuid" title="主键ID" dataLength="0,10" dataType="integer" controlName="主键ID" /></td>
<td class='firstRow'>会员ID:</td>
<td class='secRow'><s:textfield name="memberCapitalRescore.member_id" title="会员ID" dataLength="0,85" controlName="会员ID" /></td>
</tr><tr>
<td class='firstRow'>状态:</td>
<td class='secRow'><s:select name="memberCapitalRescore.status" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'新单',1:'待批',2:'主管已审',3:'经理已审'}" /></td>
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
	    <th>会员</th>
		<th>消费积分</th>
		<th>状态</th>
		<th>申请人</th>
		<th>申请时间</th>
		<th>操作</th>
	  </tr>
<s:iterator value="memberCapitalRescores" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td align="center"><s:property value="uuid" /></td>
	    <td><s:property value="member_name" /></td>
		<td align="center"><s:property value="score" /></td>
		<td align="center"><s:if test='0==status'>新单</s:if><s:if test='1==status'>待批</s:if><s:if test='2==status'>主管已审</s:if><s:if test='3==status'>经理已审</s:if></td>
		<td align="center"><s:property value="add_user_name" /></td>
		<td align="center"><s:date name="add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDY')">
	    	[<a href="<s:url namespace="/sysvip" action="memberCapitalRescore_load"><s:param name="viewFlag">mdy</s:param><s:param name="memberCapitalRescore.uuid" value="uuid"></s:param></s:url>">修改&审核</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_DEL') && status==0">
	    	[<a href="<s:url namespace="/sysvip" action="memberCapitalRescore_del"><s:param name="memberCapitalRescore.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
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