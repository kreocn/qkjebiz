<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>返利申请单列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	setStyle("table1");
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	
	SimpleLoadMember(ajax_url_action,function(event, ui) {
		//$("#search_form_submit_button").click();
	});
 });
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">返利申请单列表</span>
		<span class="extra1">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_ADD')">
			<a href="<s:url namespace="/qkjmanage" action="rebates_load"><s:param name="viewFlag">add</s:param></s:url>" >添加返利申请单</a>
			</s:if>
		</span>
	</div>	
	<div class="ilistsearch">
<s:form name="form_serach" action="rebates_list"  method="get" namespace="/qkjmanage" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%">
			<tr>
			<td class='firstRow'>会员:</td>
			<td class='secRow' colspan="3">
			会员号:
			<s:textfield id="order_user_id" name="rebates.member_id" title="会员号" require="required" controlName="会员号" />
			手机:
			<s:textfield id="order_user_mobile" name="rebates.member_mobile" title="手机" controlName="手机" />
			姓名:
			<s:textfield id="order_user_name" name="rebates.member_name" title="姓名" controlName="姓名" />
			</td>
			</tr><tr>
			<td class='firstRow'>返利类型&方式:</td>
			<td class='secRow'>
				<s:select name="rebates.re_type" title="返利类型" 
					list="#{0:'随单返利',1:'季度返利',2:'年度返利',3:'活动返利',4:'其他'}"	
					headerKey="" headerValue="--请选择--" />
			</td>
			<td class='firstRow'>状态:</td>
			<td class='secRow'>
				<s:select name="rebates.status" title="返利单状态" 
					list="#{0:'新单',10:'待审核',20:'主管已审',30:'经理已审',40:'财务已审',50:'总监已审',60:'总经理已审'}"
					headerKey="" headerValue="--请选择--" />
				<s:select name="rebates.out_flag" title="出货状态" 
					list="#{0:'未出货',1:'已出货'}"	
					headerKey="" headerValue="--请选择--" />
				<s:select name="rebates.fd_check" title="最终确认状态" 
					list="#{0:'未确认',1:'已最终确认'}"	
					headerKey="" headerValue="--请选择--" />
			</td>
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
	    <th>会员名称</th>
		<th>返利类型</th>
		<th>随量积分</th>
		<th>返利积分</th>
		<th>返现金数</th>
		<th>返酒</th>
		<th>申请人</th>
		<th>状态</th>
		<th>操作</th>
	  </tr>
<s:iterator value="rebatess" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td align="center"><s:property value="uuid" /></td>
	    <td><s:property value="member_name" /></td>
		<td align="center"><s:if test='0==re_type'>随单返利</s:if><s:if test='1==re_type'>季度返利</s:if><s:if test='2==re_type'>年度返利</s:if><s:if test='3==re_type'>活动返利</s:if><s:if test='4==re_type'>其他</s:if></td>
		<td align="center">${with_score}</td>
		<td align="center"><s:property value="re_score" /></td>
		<td align="center"><s:property value="re_money" /></td>
		<td align="center">
		<s:if test="product_num!=null && product_num>0">
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_OUT')">
    	[<a target="_blank" href="<s:url namespace="/qkjmanage" action="rebates_view"><s:param name="viewFlag">view</s:param><s:param name="rebates.uuid" value="uuid"></s:param></s:url>">查看&发货</a>]
    	</s:if>
    	<s:if test="1==out_flag">| 已出货</s:if>
		</s:if>
		<s:else>无</s:else>
		</td>
		<td align="center"><s:property value="applicant_name" />(<s:date name="apply_time" format="yyyy-MM-dd" />)</td>
		<td align="center">
			<s:if test='0==status'>新单</s:if>
			<s:if test='10==status'>待审核</s:if>
			<s:if test='20==status'>主管已审</s:if>
			<s:if test='30==status'>经理已审</s:if>
			<s:if test='40==status'>财务已审</s:if>
			<s:if test='50==status'>总监已审</s:if>
			<s:if test='60==status'>总经理已审</s:if>
			
			<s:if test='50<=status'>
			<s:if test="1==fd_check">已最终确认</s:if>
			</s:if>
		</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_MDY')">
	    	[<a href="<s:url namespace="/qkjmanage" action="rebates_load"><s:param name="viewFlag">mdy</s:param><s:param name="rebates.uuid" value="uuid"></s:param></s:url>">修改&审批</a>]
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