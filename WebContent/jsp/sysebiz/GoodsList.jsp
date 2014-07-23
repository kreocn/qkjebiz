<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript">
$(function(){
	setStyle("table1");
	
	$("#SaveInStockArea").dialog({
	      autoOpen: false,
	      height: 120,
	      width: 400,
	      modal: true
	});
});

function openSaveInStockArea(goods_id) {
	$("#SaveInStockArea :input[name='goods.uuid']").val(goods_id);
	$("#SaveInStockArea").dialog("open");
}

</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">商品列表</span>
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_ADDLOAD')">
		<span class="extra1">
			<s:url id="goods_addload_uid" value="goods_addload" namespace="/sysebiz">
				<s:param name="viewFlag">add</s:param>
			</s:url>
			<s:a href="%{goods_addload_uid}" >添加新商品</s:a>
		</span>
		</s:if>
	</div>
	<div class="ilistsearch">
<s:form name="form_serach" action="goods_list"  method="get" namespace="/sysebiz" theme="simple">
		<table class="ilisttable" id="serach_table" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
			<tr>
				<td class="firstRow">商品名称(%):</td>
	    		<td class="secRow"><s:textfield title="商品名称" name="goods.goods_name" /></td>
				<td class="firstRow">是否上架:</td>
	    		<td class="secRow">
	    			<s:select name="goods.goods_sales" list="#{1:'下架',0:'上架'}" headerKey="" headerValue="--请选择--" />
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
	<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	  <colgroup>
		<col width="30" />
		<col width="40" />
		<col width="80" />
		<col width="" />
		<col width="80" />
		<col width="80" />
		<col width="80" />
		<col width="80" />
		<col width="80" />
		<col width="80" />
		<col width="130" />
	  </colgroup>
	
	  <tr>
	    <th><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>编号</th>
	    <th>货号</th>
		<th>商品名称</th>
		<th>售价</th>
		<th>初始库存</th>
		<th>剩余库存</th>
		<th>已冻结</th>
		<th>实际可用</th>
		<th>上架</th>
		<th>操作</th>
	  </tr>
<s:iterator value="goodx" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    <td align="center"><s:property value="uuid" /></td>
	    <td align="center"><s:property value="goods_code" /></td>
		<td><s:property value="goods_name" /></td>
		<td align="center"><s:property value="goods_price" /> /<s:property value="goods_unit" /></td>
		<td align="center"><s:property value="goods_num" /> <s:property value="goods_unit" /></td>
		<td align="center"><s:property value="stock_num" /> <s:property value="goods_unit" /></td>
		
		<td align="center"><s:property value="froze_num" /> <s:property value="goods_unit" /></td>
		<td align="center"><s:property value="stock_num-froze_num" /> <s:property value="goods_unit" /></td>
		
		<td align="center">
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SALESDOWN')"><s:url id="op_salesdown" namespace="/sysebiz" action="goods_salesdown"><s:param name="goods.uuid" value="uuid" /></s:url></s:if>
		<s:else><s:url id="op_salesdown" value="javascript:alert('您没有商品下架的权限!');" /></s:else>		
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SALESUP')"><s:url id="op_salesup" namespace="/sysebiz" action="goods_salesup"><s:param name="goods.uuid" value="uuid" /></s:url></s:if>
		<s:else><s:url id="op_salesup" value="javascript:alert('您没有商品上架的权限!');" /></s:else>
		<s:if test="0==goods_sales"><a  class="yesarea" href="${op_salesdown}"></a></s:if>
		<s:elseif test="1==goods_sales"><a  class="noarea" href="${op_salesup}"></a></s:elseif>
		</td>
		<td align="center">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SAVELOAD')">
	    	[<a href="<s:url namespace="/sysebiz" action="goods_load"><s:param name="viewFlag">mdy</s:param><s:param name="goods.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYS_EBIZ_GOODS_SAVEINSTOCK')">
	    	[<a href="javascript:;" onclick="openSaveInStockArea('<s:property value="uuid" />');">补库存</a>]
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
	  </tr>
	</table>
</s:form>
	</div>
</div>
</div>
<div id="SaveInStockArea" title="添加商品库存">
<s:form name="form_saveInStock" action="goods_saveInStock" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span>添加库存数量:</td>
<td class='secRow'>
<s:textfield name="stockNum" title="库存数量" dataType="integer" require="required" controlName="库存数量" />
</td>
</tr>
		<tr>
		    <td colspan="20" class="buttonarea">
				<s:hidden name="goods.uuid" />
				<s:submit id="add" name="add" value="确定" action="goods_saveInStock" />
				<s:reset value="重置" />
			</td>
	    </tr>
	</table>
</s:form>
</div>
</body>
</html>