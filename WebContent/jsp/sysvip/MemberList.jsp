<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">会员列表</span>
		<span class="extra1">
			<a href="<s:url namespace="/sysvip" action="member_load"><s:param name="viewFlag">add</s:param></s:url>" >添加会员</a>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="member_list"  method="get" namespace="/sysvip" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>会员号:</td>
			<td class='secRow'><s:textfield name="member.uuid" title="会员号" /></td>
			<td class='firstRow'>(%)会员姓名:</td>
			<td class='secRow'><s:textfield name="member.member_name" title="会员姓名"  /></td>
			</tr><tr>
			<td class='firstRow'>会员手机:</td>
			<td class='secRow'><s:textfield name="member.mobile" title="会员手机"  /></td>
			<td class='firstRow'>(%)会员EMAIL:</td>
			<td class='secRow'><s:textfield name="member.email" title="会员EMAIL"  /></td>
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
	    <th>会员号</th>
		<th>会员手机</th>
		<th>会员姓名</th>
		<th>会员分组</th>
		<th>资产</th>
		<th>随量积分</th>
		<th>返利积分</th>
		<th>消费积分</th>
		<th>所属部门</th>
		<th>客户经理</th>
		<th>操作</th>
	  </tr>
<s:iterator value="members" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
		<td><s:property value="mobile" /></td>
		<td>${member_name}<s:if test="contact!=null">(${contact})</s:if></td>
		<td align="center"><s:property value="user_type_name" /></td>
		<td align="center">￥<s:property value="money" /></td>
		<td align="center"><s:property value="with_score" /></td>
		<td align="center"><s:property value="re_score" /></td>
		<td align="center"><s:property value="score" /></td>
		<td align="center"><s:property value="dept_name" /></td>
		<td align="center"><s:property value="manager_name" /></td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYSVIP_MEMBER_MDY')">
	    	[<a href="<s:url namespace="/sysvip" action="member_load"><s:param name="viewFlag">mdy</s:param><s:param name="member.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYSVIP_MEMBER_DEL')">
	    	[<a href="<s:url namespace="/sysvip" action="member_del"><s:param name="member.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>
	    </td>
	  </tr>
</s:iterator>
	  <tr>
	    <td colspan="20" class="buttonarea">
    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_ADD')">
    	<input type="button" value="返利积分消费" onclick="return forward('<s:url value="/sysvip/memberCapitalRescore_load?viewFlag=add" />','uuid','memberCapitalRescore.member_id',false);" />
    	</s:if>
	    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_DEPOSIT_ADD')">
    	<input type="button" value="添加会员预付款" onclick="return forward('<s:url value="/sysvip/deposit_load?viewFlag=add" />','uuid','deposit.member_id',false);" />
    	</s:if>
		</td>
	  </tr>
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