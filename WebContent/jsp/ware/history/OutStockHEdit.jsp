<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库历史管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>出库历史</span>
		<span class="extra1">
			<a href="<s:url action="outStockH_list" namespace="/ware" />" >出库历史列表</a>
		</span>	
	</div>
<s:form name="form1" action="outStockH_add" namespace="/ware" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy' == viewFlag">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键自增:</td>
<td class='secRow'><s:property value="outStockH.uuid" /><s:hidden name="outStockH.uuid" title="主键自增" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 单号:</td>
<td class='secRow'><s:property value="outStockH.ordernum" /><s:hidden name="outStockH.ordernum" title="单号" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 出库时间:</td>
<td class='secRow'><s:date name="outStockH.date" format="yyyy-MM-dd HH:mm:ss" /><s:hidden name="outStockH.date" title="出库时间" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 修改时间:</td>
<td class='secRow'><s:date name="outStockH.lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>出库方式:</td>
<td class='secRow'><s:property value="outStockH.reason" /></td>
</tr>
<tr>
<td class='firstRow'>确认人姓名:</td>
<td class='secRow'><s:property value="outStockH.manager_check_user" /></td>
</tr>
<tr>
<td class='firstRow'>确认时间:</td>
<td class='secRow'><s:date name="outStockH.manager_check_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>确认时间:</td>
<td class='secRow'><s:date name="outStockH.coo_check_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>会员号:</td>
<td class='secRow'><s:property value="outStockH.member_id" /></td>
</tr>
<tr>
<td class='firstRow'>手机:</td>
<td class='secRow'><s:property value="outStockH.member_mebile" /></td>
</tr>
<tr>
<td class='firstRow'>姓名:</td>
<td class='secRow'><s:property value="outStockH.member_name" /></td>
</tr>
<tr>
<td class='firstRow'>地址:</td>
<td class='secRow'><s:property value="outStockH.member_adress" /></td>
</tr>
<tr>
<td class='firstRow'>其它费用:</td>
<td class='secRow'><s:property value="outStockH.member_price" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 出库仓库:</td>
<td class='secRow'><s:textfield name="outStockH.store_id" title="出库仓库" require="required" dataLength="0,10" dataType="integer" controlName="出库仓库" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 经办人:</td>
<td class='secRow'><s:textfield name="outStockH.operator_id" title="经办人" require="required" dataLength="0,50" controlName="经办人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 保管员:</td>
<td class='secRow'><s:textfield name="outStockH.take_id" title="保管员" require="required" dataLength="0,50" controlName="保管员" /></td>
</tr>
<tr>
<td class='firstRow'>其它说明:</td>
<td class='secRow'><s:textfield name="outStockH.note" title="其它说明" dataLength="0,200" controlName="其它说明" /></td>
</tr>
<tr>
<td class='firstRow'>总价:</td>
<td class='secRow'><s:textfield name="outStockH.total_price" title="总价" dataLength="0,10" dataType="number" controlName="总价" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加人:</td>
<td class='secRow'><s:textfield name="outStockH.add_user" title="添加人" require="required" dataLength="0,50" controlName="添加人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加时间:</td>
<td class='secRow'><s:textfield name="outStockH.add_timer" title="添加时间" require="required" value="%{getText('global.date',{outStockH.add_timer})=='null'?'':getText('global.date',{outStockH.add_timer})}" dataType="date" controlName="添加时间" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 修改人:</td>
<td class='secRow'><s:textfield name="outStockH.lm_user" title="修改人" require="required" dataLength="0,50" controlName="修改人" /></td>
</tr>
<tr>
<td class='firstRow'>是否归还:</td>
<td class='secRow'><s:textfield name="outStockH.send" title="是否归还" dataLength="0,10" dataType="integer" controlName="是否归还" /></td>
</tr>
<tr>
<td class='firstRow'>渠道/运营经理确认:</td>
<td class='secRow'><s:textfield name="outStockH.manager_check" title="渠道/运营经理确认" dataLength="0,10" dataType="integer" controlName="渠道/运营经理确认" /></td>
</tr>
<tr>
<td class='firstRow'>运营总监确认:</td>
<td class='secRow'><s:textfield name="outStockH.coo_check" title="运营总监确认" dataLength="0,10" dataType="integer" controlName="运营总监确认" /></td>
</tr>
<tr>
<td class='firstRow'>确认人姓名:</td>
<td class='secRow'><s:textfield name="outStockH.coo_check_user" title="确认人姓名" dataLength="0,50" controlName="确认人姓名" /></td>
</tr>
<tr>
<td class='firstRow'>报损原因:</td>
<td class='secRow'><s:textfield name="outStockH.bsreason" title="报损原因" dataLength="0,200" controlName="报损原因" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCKH_ADD')">
					<s:submit id="add" name="add" value="确定" action="outStockH_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCKH_MDY')">
					<s:submit id="save" name="save" value="保存" action="outStockH_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCKH_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="outStockH_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="outStockH_relist" namespace="/ware" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>