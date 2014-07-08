<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户回访记录管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == customerRecode && 'add' == viewFlag">增加</s:if><s:elseif test="null != customerRecode && 'mdy' == viewFlag">修改</s:elseif>客户回访记录</span>
		<span class="extra1">
			<a href="<s:url action="customerRecode_list" namespace="/qkjmanage" />" >客户回访记录列表</a>
		</span>	
	</div>
<s:form name="form1" action="customerRecode_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != customerRecode">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
<td class='secRow'><s:property value="customerRecode.uuid" /><s:hidden name="customerRecode.uuid" title="主键ID" /></td>
</tr>
<tr>
<td class='firstRow'>添加人:</td>
<td class='secRow'><s:property value="customerRecode.add_user" /></td>
</tr>
<tr>
<td class='firstRow'>添加时间:</td>
<td class='secRow'><s:date name="customerRecode.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>修改人:</td>
<td class='secRow'><s:property value="customerRecode.lm_user" /></td>
</tr>
<tr>
<td class='firstRow'>修改时间:</td>
<td class='secRow'><s:date name="customerRecode.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 回访客户ID:</td>
<td class='secRow'><s:textfield name="customerRecode.customer_id" title="回访客户ID" require="required" dataLength="0,10" dataType="integer" controlName="回访客户ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 拜访日期:</td>
<td class='secRow'><s:textfield name="customerRecode.recode_time" title="拜访日期" require="required" value="%{getText('global.date',{customerRecode.recode_time})=='null'?'':getText('global.date',{customerRecode.recode_time})}" onclick="new Calendar().show(this);"  readonly="true" dataType="date" controlName="拜访日期" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 回访方式:</td>
<td class='secRow'><s:radio name="customerRecode.type" title="回访方式"  list="#{0:'主动电话拜访',1:'被动电话来访',2:'主动上门拜访',3:'被动上门来访',4:'会展会场来访',5:'网络、邮件、信息形式来访',6:'其他方式'}" /></td>
</tr>
<tr>
<td class='firstRow'>受访人:</td>
<td class='secRow'><s:textfield name="customerRecode.person" title="受访人" dataLength="0,21" controlName="受访人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 访谈内容:</td>
<td class='secRow'><s:textfield name="customerRecode.content" title="访谈内容" require="required" dataLength="0,21845" controlName="访谈内容" /></td>
</tr>
<tr>
<td class='firstRow'>给予客户承诺:</td>
<td class='secRow'><s:textfield name="customerRecode.promise" title="给予客户承诺" dataLength="0,21845" controlName="给予客户承诺" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 下次拜访时间:</td>
<td class='secRow'><s:textfield name="customerRecode.next_date" title="下次拜访时间" require="required" value="%{getText('global.date',{customerRecode.next_date})=='null'?'':getText('global.date',{customerRecode.next_date})}" onclick="new Calendar().show(this);"  readonly="true" dataType="date" controlName="下次拜访时间" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == customerRecode && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMERRECODE_ADD')">
					<s:submit id="add" name="add" value="确定" action="customerRecode_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != customerRecode && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMERRECODE_MDY')">
					<s:submit id="save" name="save" value="保存" action="customerRecode_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMERRECODE_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="customerRecode_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="customerRecode_list" namespace="/qkjmanage" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>