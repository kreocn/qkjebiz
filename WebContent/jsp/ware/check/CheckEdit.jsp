<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>盘点管理--<s:text name="APP_NAME" /></title>
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
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>盘点</span>
		<span class="extra1">
			<a href="<s:url action="check_list" namespace="/check" />" >盘点列表</a>
		</span>	
	</div>
<s:form name="form1" action="check_add" namespace="/check" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != check">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
		<td class='secRow'><s:property value="check.uuid" /><s:hidden name="check.uuid" title="主键ID" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 商品名称:</td>
		<td class='secRow'><s:property value="check.product_name" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 所在仓库:</td>
		<td class='secRow'><s:property value="check.ware_name" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 库存数量:</td>
		<td class='secRow'><s:property value="check.quantity" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 相差数量:</td>
		<td class='secRow'><s:textfield name="check.num"></s:textfield></td>
		</tr>
		</s:if>
		<s:else>
		<tr>
		    <th>商品名称</th>
		    <th>所在仓库</th>
			<th>库存</th>
			<th>变动数量</th>
	  	</tr>
	  	<s:iterator value="stocks" status="sta">
		  <tr>
		    <td>
		    	<s:property value="product_name" />
		    	<s:hidden name="pageStocks[%{#sta.index}].uuid" value="%{uuid}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].product_id" value="%{product_id}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].store_id" value="%{store_id}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].quantity" value="%{quantity}" />
		    </td>
			<td><s:property value="store_name" /></td>
			<td><s:property value="quantity" /></td>
			<td><s:textfield name="pageStocks[%{#sta.index}].cnum" value="0"></s:textfield></td>
		  </tr>
		</s:iterator>
		</s:else>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_CHECK_CHECK_ADD')">
					<s:submit id="add" name="add" value="确定" action="check_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_CHECK_CHECK_MDY')">
					<s:submit id="save" name="save" value="保存"  action="check_save"  />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_CHECK_CHECK_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="check_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="check_relist" namespace="/check" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
<script type="text/javascript">
function checks(){
	
}
</script>
</html>