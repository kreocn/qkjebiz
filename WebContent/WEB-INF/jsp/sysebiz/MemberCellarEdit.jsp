<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户藏酒信息管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="null == memberCellar && 'add' == viewFlag">增加</s:if><s:elseif test="null != memberCellar && 'mdy' == viewFlag">修改</s:elseif>客户藏酒信息</span>
		<span class="extra1">
			<a href="<s:url action="memberCellar_list" namespace="/sysebiz" />" >客户藏酒信息列表</a>
		</span>	
	</div>
<s:form name="form1" action="memberCellar_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != memberCellar">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
<td class='secRow'><s:property value="memberCellar.uuid" /><s:hidden name="memberCellar.uuid" title="主键ID" /></td>
</tr>
<tr>
<td class='firstRow'>最后修改人:</td>
<td class='secRow'><s:property value="memberCellar.lm_user" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 最后修改时间:</td>
<td class='secRow'><s:date name="memberCellar.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 客户ID:</td>
<td class='secRow'><s:textfield name="memberCellar.member_id" title="客户ID" require="required" dataLength="0,6" controlName="客户ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 所属订单细项:</td>
<td class='secRow'><s:textfield name="memberCellar.order_goods_id" title="所属订单细项" require="required" dataLength="0,10" dataType="integer" controlName="所属订单细项" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 初始藏酒编号:</td>
<td class='secRow'><s:select name="memberCellar.cellar_no" title="初始藏酒编号" headerKey="" headerValue="--请选择--" list="cellar_no.cellar_nolist" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 初始库存:</td>
<td class='secRow'><s:textfield name="memberCellar.num" title="初始库存" require="required" dataLength="0,10" dataType="number" controlName="初始库存" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 剩余库存:</td>
<td class='secRow'><s:textfield name="memberCellar.stock" title="剩余库存" require="required" dataLength="0,10" dataType="number" controlName="剩余库存" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 冻结库存:</td>
<td class='secRow'><s:textfield name="memberCellar.frozen" title="冻结库存" require="required" dataLength="0,10" dataType="number" controlName="冻结库存" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 藏酒位置号:</td>
<td class='secRow'><s:textfield name="memberCellar.cellar_position" title="藏酒位置号" require="required" dataLength="0,85" controlName="藏酒位置号" /></td>
</tr>
<tr>
<td class='firstRow'>实时摄像头链接:</td>
<td class='secRow'><s:textfield name="memberCellar.camera" title="实时摄像头链接" dataLength="0,85" controlName="实时摄像头链接" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == memberCellar && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('MEMBER_CELLAR_SYSEBIZ_MEMBERCELLAR_ADD')">
					<s:submit id="add" name="add" value="确定" action="memberCellar_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != memberCellar && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('MEMBER_CELLAR_SYSEBIZ_MEMBERCELLAR_MDY')">
					<s:submit id="save" name="save" value="保存" action="memberCellar_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('MEMBER_CELLAR_SYSEBIZ_MEMBERCELLAR_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="memberCellar_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="memberCellar_list" namespace="/sysebiz" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>