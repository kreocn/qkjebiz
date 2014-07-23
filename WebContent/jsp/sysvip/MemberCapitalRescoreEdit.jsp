<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员积分消费管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>会员返利积分消费</span>
		<span class="extra1">
			<a href="<s:url action="memberCapitalRescore_list" namespace="/sysvip" />" >会员积分消费列表</a>
		</span>	
	</div>
<s:form id="formEdit" name="form1" action="memberCapitalRescore_add" namespace="/sysvip" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		  <tr>
		<td class='firstRow'><span style="color:red;">*</span> 申请人:</td>
		<td class='secRow'><s:property value="memberCapitalRescore.add_user_name" /></td>
		<td class='firstRow'><span style="color:red;">*</span> 申请时间:</td>
		<td class='secRow'><s:date name="memberCapitalRescore.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 最后修改人:</td>
		<td class='secRow'><s:property value="memberCapitalRescore.lm_user_name" /></td>
		<td class='firstRow'><span style="color:red;">*</span> 最后修改时间:</td>
		<td class='secRow'><s:date name="memberCapitalRescore.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 会员:</td>
		<td class='secRow'>
			<s:hidden name="memberCapitalRescore.uuid"  /><s:hidden name="memberCapitalRescore.member_id" />
			会员号:<s:property value="memberCapitalRescore.member_id" />
			会员名称:<s:property value="memberCapitalRescore.member_name" />
		</td>
		<td class='firstRow'><span style="color:red;">*</span> 状态:</td>
		<td class='secRow'>
			<s:if test='0==memberCapitalRescore.status'>新单</s:if>
			<s:if test='1==memberCapitalRescore.status'>待批</s:if>
			<s:if test='2==memberCapitalRescore.status'>主管已审</s:if>
			<s:if test='3==memberCapitalRescore.status'>经理已审</s:if>
		</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 消费返利积分:</td>
		<td class='secRow'><s:textfield name="memberCapitalRescore.score" title="积分" require="required" dataType="integer" dataBetween="0,${memberCapitalRescore.mscore}" controlName="积分" /></td>
		<td class='firstRow'>会员现有积分:</td>
		<td class='secRow'><s:property value="memberCapitalRescore.mscore" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 消费说明:</td>
		<td class='secRow' colspan="3"><s:textarea name="memberCapitalRescore.note" title="消费说明" require="required" controlName="消费说明" cssStyle="width:80%;"  /></td>
		</tr>
		<tr>
		<td class='firstRow'>相关操作:</td>
		<td class='secRow' colspan="20">
		<s:if test="'add' == viewFlag">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_ADD')">
			<s:submit id="add" name="add" value="确定" action="memberCapitalRescore_add" />
			</s:if>
		</s:if>
		<s:elseif test="'mdy' == viewFlag">
			<s:if test="0==memberCapitalRescore.status">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDY')">
			<s:submit id="save" name="save" value="保存" action="memberCapitalRescore_save" />
			</s:if>
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDYSTATUS0')">
			<s:submit id="mdyStatus0" name="mdyStatus0" value="送审" action="memberCapitalRescore_mdyStatus0" onclick="return isOp('是否送审?\n送审后将不能更改!');" />
			<script type="text/javascript">
			$(function(){
				$("#formEdit :input").change(function(){
					$("#mdyStatus0").attr("disabled","disabled");
					$("#message").text("请先保存后才能报批");
				});
			});
			</script>
			</s:if>
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_DEL')">
			<s:submit id="delete" name="delete" value="删除申请单" action="memberCapitalRescore_del" onclick="return isDel();" />
			</s:if>
			</s:if>
			<s:if test="1==memberCapitalRescore.status">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDYSTATUS1')">
			<s:submit id="mdyStatus1" name="mdyStatus1" value="主管-审核通过" action="memberCapitalRescore_mdyStatus1" onclick="return isOp('是否审核通过?\n审核通过后将不能更改!');" />
			</s:if>
			</s:if>
			<s:if test="2==memberCapitalRescore.status">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SYSVIP_MEMBERCAPITALRESCORE_MDYSTATUS2')">
			<s:submit id="mdyStatus2" name="mdyStatus2" value="经理-审核通过" action="memberCapitalRescore_mdyStatus2" onclick="return isOp('是否审核通过?\n审核通过后将不能更改!');" />
			</s:if>
			</s:if>
		</s:elseif>
		<input type="button" value="返回" onclick="linkurl('<s:url action="memberCapitalRescore_list" namespace="/sysvip"><s:param name="viewFlag">relist</s:param></s:url>');" />
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