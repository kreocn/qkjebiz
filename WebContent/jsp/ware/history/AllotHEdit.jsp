<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调库历史管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>调库历史</span>
		<span class="extra1">
			<a href="<s:url action="allotH_list" namespace="/ware" />" >调库历史列表</a>
		</span>	
	</div>
<s:form name="form1" action="allotH_add" namespace="/ware" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键自增:</td>
<td class='secRow'><s:property value="allotH.uuid" /><s:hidden name="allotH.uuid" title="主键自增" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 调库单号:</td>
<td class='secRow'><s:property value="allotH.ordernum" /><s:hidden name="allotH.ordernum" title="调库单号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 调库日期:</td>
<td class='secRow'><s:date name="allotH.date" format="yyyy-MM-dd HH:mm:ss" /><s:hidden name="allotH.date" title="调库日期" /></td>
</tr>
<tr>
<td class='firstRow'>状态:</td>
<td class='secRow'><s:property value="allotH.state" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 调出仓库:</td>
<td class='secRow'><s:textfield name="allotH.sourceid" title="调出仓库" require="required" dataLength="0,10" dataType="integer" controlName="调出仓库" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 调入仓库:</td>
<td class='secRow'><s:textfield name="allotH.goldid" title="调入仓库" require="required" dataLength="0,10" dataType="integer" controlName="调入仓库" /></td>
</tr>
<tr>
<td class='firstRow'>其它说明:</td>
<td class='secRow'><s:textfield name="allotH.note" title="其它说明" dataLength="0,200" controlName="其它说明" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加人:</td>
<td class='secRow'><s:textfield name="allotH.add_user" title="添加人" require="required" dataLength="0,20" controlName="添加人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加日期:</td>
<td class='secRow'><s:textfield name="allotH.add_timer" title="添加日期" require="required" value="%{getText('global.date',{allotH.add_timer})=='null'?'':getText('global.date',{allotH.add_timer})}" dataType="date" controlName="添加日期" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 修改人:</td>
<td class='secRow'><s:textfield name="allotH.lm_user" title="修改人" require="required" dataLength="0,20" controlName="修改人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 修改日期:</td>
<td class='secRow'><s:textfield name="allotH.lm_timer" title="修改日期" require="required" value="%{getText('global.date',{allotH.lm_timer})=='null'?'':getText('global.date',{allotH.lm_timer})}" dataType="date" controlName="修改日期" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOTH_ADD')">
					<s:submit id="add" name="add" value="确定" action="allotH_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOTH_MDY')">
					<s:submit id="save" name="save" value="保存" action="allotH_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOTH_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="allotH_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="allotH_relist" namespace="/ware" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>