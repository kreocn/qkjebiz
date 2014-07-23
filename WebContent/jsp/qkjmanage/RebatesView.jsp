<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>返利申请单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	CommonUtil.pickrow('rebatesProductsTable');	
	/*<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_OUTFLAG')">*/
	$("#out_flag_no").bind("click",function(){
		$("#OUT_Operation #lading_out").unbind().bind("click",function(){
			if(isOp('是否确定已出货?\n出货操作不能更改!')) 
			location.href='<s:url namespace="/qkjmanage" action="rebates_mdyOutFlag"><s:param name="rebates.uuid" value="rebates.uuid" /></s:url>';
		});
		$("#OUT_Operation").dialog("open");
	});
	$("#OUT_Operation").dialog({
	      autoOpen: false,
	      width: 200,
	      height: 80,
	      modal: true
	});
	/*</s:if>*/
});

function bindLis() {
	$("#ladings li").unbind().bind({mouseenter : function() {
			$(this).addClass("active");
		}, mouseleave : function() {
			$(this).removeClass("active");
		}
	});
	
	$("#ladings :checkbox").unbind().bind({
		click:function(){
			if($(this).is(":checked")) {
				$(this).parent("li").css("background-color", "#DFDFDF");
			} else {
				$(this).parent("li").css("background-color", "");
			}
		}
	});
}
</script>
<style type="text/css">
.showladings {list-style: none;padding: 5px;margin: 0px;}
.showladings li {display: inline-block;zoom:1;*display: inline;}
.showladings li {line-height: 20px;padding: 3px; margin: 3px;}
.showladings .inputcheckbox {vertical-align:middle;}
.showladings label {vertical-align:middle;}
.showladings li.active {background-color: #DFDFDF;}
#out_flag_no{cursor: pointer;}
.dialog_button{text-align: center;line-height: 80px;}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == rebates && 'add' == viewFlag">增加</s:if><s:elseif test="null != rebates && 'mdy' == viewFlag">修改</s:elseif>返利申请单</span>
	</div>
<s:form name="form1" action="rebates_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != rebates">
		<tr>
		<td class='firstRow'>申请编号:</td>
		<td class='secRow'><s:property value="rebates.uuid" /><s:hidden name="rebates.uuid" /></td>
		<td class='firstRow'><span style="color:red;">*</span> 状态:</td>
		<td class='secRow'>
		<s:if test='0==rebates.status'>新单</s:if>
		<s:if test='10==rebates.status'>总监已审</s:if>
		<s:if test='20==rebates.status'>主管已审</s:if>
		<s:if test='30==rebates.status'>经理已审</s:if>
		<s:if test='40==rebates.status'>财务已审</s:if>
		<s:if test='50==rebates.status'>总监已审</s:if>
		<s:if test='60==rebates.status'>总经理已审</s:if>
		
		<s:if test='0==rebates.out_flag'><span id="out_flag_no" class="message_error">未出货</span></s:if><s:if test='1==rebates.out_flag'>已出货</s:if>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>申请人:</td>
		<td class='secRow'><s:property value="rebates.applicant_name" /></td>
		<td class='firstRow'>申请时间:</td>
		<td class='secRow'><s:date name="rebates.apply_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		  
		<tr>
		<td class='firstRow'>会员:</td>
		<td class='secRow' colspan="3">
		会员号:<s:property value="rebates.member_id" /><s:hidden name="rebates.member_id" title="会员号" />
		手机:<s:property value="rebates.member_mobile" /><s:hidden name="rebates.member_mobile" title="手机" />
		姓名:<s:property value="rebates.member_name" /><s:hidden name="rebates.member_name" title="姓名" />
		</td>
		</tr>
		<tr>
		<td class='firstRow'>需返利出货单:</td>
		<td class='secRow' colspan="3">
			<ul id="ladings" class="showladings">
			<s:iterator value="rebatesLadings">
				<li class="active">(<s:date name="lading_time" format="yyyy-MM-dd" />)<a href='<s:url namespace="qkjmanage" action="lading_view"><s:param name="lading.uuid" value="lading_id" /><s:param name="viewFlag">view</s:param></s:url>' target="_blank"><s:property value="lading_id" /></a></li>
			</s:iterator>
			</ul>			
		</td>
		</tr>
		<tr>
		<td class='firstRow'>
		实体返利内容:
		</td>
		<td class='secRow' colspan="3">
<!-- ---------------------------------------------------------------------- -->
<table class="ilisttable" id="rebatesProductsTable" width="80%">
	  <tr>
	    <th>产品名称</th>
		<th>数量</th>
	  </tr>
<s:iterator value="rebatesProducts" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
	    <td><s:property value="product_name" /></td>
		<td align="center"><s:property value="num" /></td>
	  </tr>
</s:iterator>
</table>
<!-- ---------------------------------------------------------------------- -->
		</td>
		</tr>
		<tr>
		<td class='firstRow'>返利说明:</td>
		<td class='secRow' colspan="3">
			<s:property value="rebates.note" />
		</td>
		</tr>
	</table>	
</s:form>
	</div>
</div>
</div>
<div class="printarea"><input type="button" onclick="window.print();" value="打印本页"/></div>
<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_OUTFLAG')">
<div id="OUT_Operation" title="出货操作">
<div class="dialog_button"><span id="lading_out" class="ui_button_100x24_shallow">确定出货完成</span></div>
</div>
</s:if>
</body>
</html>