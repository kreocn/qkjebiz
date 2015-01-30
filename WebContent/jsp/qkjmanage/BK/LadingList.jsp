<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库提货单列表--<s:text name="APP_NAME" /></title>
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
		<span class="title1">销售订单列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="lading_load"><s:param name="viewFlag">add</s:param></s:url>" >添加销售订单</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="lading_list"  method="get" namespace="/qkjmanage" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>申请编号:</td>
			<td class='secRow'><s:textfield name="lading.uuid" title="申请编号" controlName="申请编号" /></td>
			<td class='firstRow'>客户ID:</td>
			<td class='secRow'><s:textfield name="lading.member_id" title="客户ID" controlName="客户ID" /></td>
			</tr><tr>
			<td class='firstRow'>内容:</td>
			<td class='secRow'><s:textfield name="lading.content" title="内容" dataLength="0,21845" controlName="内容" /></td>
			<td class='firstRow'>状态:</td>
			<td class='secRow'>
				<s:select name="lading.status" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'新单',1:'待审核',2:'结案'}" />
				<s:select name="lading.out_flag" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'未出货',1:'已出货'}" />
				<s:select name="lading.rebates_flag" title="状态" headerKey="" headerValue="--请选择--" list="#{0:'未返利',1:'返利中',2:'已返利'}" />
			</td>
			</tr>
			<tr>
			<td colspan="20" class="buttonarea">
				<s:submit value="搜索" /> <s:reset value="重置" />
			</td>
			</tr>
		</table>
</s:form>
	</div>
<s:form name="form1" theme="simple">
	<table class="ilisttable" id="table1" width="100%">
	<col width="30" />
	<col width="90" />
	<col width="65" />
	<col width="" />
	<col width="" />
	<col width="" />
	<col width="" />
	<col width="" />
	<col width="" />
	<col width="" />
	<col width="130" />
	<col width="80" />
	<col width="150" />
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" /></th>
	    <th>申请编号</th>
	    <th>客户编号</th>
	    <th>客户名称</th>
		<th>内容</th>
		<th title="渠道/运营经理确认">M</th>
		<th title="销售部经理确认情况">SD</th>
		<th title="市场部经理确认情况">MD</th>
		<th title="财务确认情况">FD</th>
		<th title="运营总监确认情况">COO</th>
		<th>状态</th>
		<th>申请人</th>
		<th>操作</th>
	  </tr>
<s:iterator value="ladings" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td><s:property value="uuid" /></td>
	    <td><s:property value="member_id" /></td>
	    <td title="<s:property value="member_name" />"><div class="message_ell" style="width: 180px;"><s:property value="member_name" /></div></td>
		<td title="<s:property value="content" />"><div class="message_ell" style="width: 280px;"><s:property value="content" /></div></td>
		<td align="center">
			<s:if test="0==manager_check"><span class="noarea"></span></s:if>
			<s:elseif test="1==manager_check"><span class="yesarea" title="<s:date name="manager_check_time" format="yyyy-MM-dd HH:mm:ss" />"></span></s:elseif>
		</td>
		<td align="center">
			<s:if test="0==sd_check"><span class="noarea"></span></s:if>
			<s:elseif test="1==sd_check"><span class="yesarea" title="<s:date name="sd_check_time" format="yyyy-MM-dd HH:mm:ss" />"></span></s:elseif>
		</td>
		<td align="center">
			<s:if test="0==md_check"><span class="noarea"></span></s:if>
			<s:elseif test="1==md_check"><span class="yesarea" title="<s:date name="md_check_time" format="yyyy-MM-dd HH:mm:ss" />"></span></s:elseif>
		</td>
		<td align="center">
			<s:if test="2>fd_check"><span class="noarea"></span></s:if>
			<s:elseif test="2==fd_check"><span class="yesarea" title="<s:date name="fd_check_time" format="yyyy-MM-dd HH:mm:ss" />"></span></s:elseif>
		</td>
		<td align="center">
			<s:if test="0==coo_check"><span class="noarea"></span></s:if>
			<s:elseif test="1==coo_check"><span class="yesarea" title="<s:date name="coo_check_time" format="yyyy-MM-dd HH:mm:ss" />"></span></s:elseif>
		</td>
		<td align="center">
			<s:if test='0==status'>新单</s:if><s:if test='1==status'>待审核</s:if><s:if test='2==status'>结案</s:if>
			<s:if test='0==out_flag'><span class="message_error">未出货</span></s:if><s:if test='1==out_flag'>已出货</s:if>
			<s:if test='0==rebates_flag'><span class="message_error">未返利</span></s:if><s:if test='1==rebates_flag'><span class="message_pass">返利中</span></s:if><s:if test='2==rebates_flag'>已返利</s:if>
		</td>
		<td align="center">
			<s:property value="applicant_name" />
		</td>
		<td align="center">
	    	[<a href="<s:url namespace="/qkjmanage" action="lading_load"><s:param name="viewFlag">mdy</s:param><s:param name="lading.uuid" value="uuid"></s:param></s:url>">修改&审核</a>]
	    	
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_OUT') && 2==status">
	    	[<a target="_blank" href="<s:url namespace="/qkjmanage" action="lading_view"><s:param name="viewFlag">view</s:param><s:param name="lading.uuid" value="uuid"></s:param></s:url>">查看&出货</a>]
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
	    <td colspan="20">
	    <span id="message"><s:property value="message" /></span>
			<div>符号说明:</div>
			<div>M:渠道/运营经理确认情况</div>
			<div>SD:销售部经理确认情况</div>
			<div>MD:市场部经理确认情况</div>
			<div>FD:财务确认情况</div>
			<div>COO:运营总监确认情况</div>
		</td>
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>