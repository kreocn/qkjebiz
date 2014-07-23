<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == assets && 'add' == viewFlag">增加</s:if><s:elseif test="null != assets && 'mdy' == viewFlag">修改</s:elseif>资产</span>
		<span class="extra1">
			<a href="<s:url action="assets_list" namespace="/adm" />" >资产列表</a>
		</span>	
	</div>
<s:form name="form1" action="assets_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != assets">
		 <tr>
		<td class='firstRow'><span style="color:red;">*</span> 系统编号:</td>
		<td class='secRow'><s:property value="assets.uuid" /><s:hidden name="assets.uuid" title="系统编号" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 修改时间:</td>
		<td class='secRow'><s:date name="assets.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>
		<tbody id="mmtype">
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 资产分类:</td>
		<td class='secRow'>
			<select name="assets.typea" title="资产种类" class="prov" require="required" controlName="资产种类"></select> 
			<select name="assets.typeb" title="资产类别" class="city" disabled="disabled"></select>
			<select name="assets.typec" title="子类别" class="dist" disabled="disabled"></select>
		</td>
		</tr>
		</tbody>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 资产名称:</td>
		<td class='secRow'><s:textfield name="assets.title" title="资产名称" require="required" dataLength="0,128" controlName="资产名称" /></td>
		</tr>
		<tr>
		<td class='firstRow'>参考型号:</td>
		<td class='secRow'><s:textfield id="assets_model" name="assets.model" title="资产名称" dataLength="0,96" controlName="参考型号" /></td>
		</tr>
		<tr>
		<td class='firstRow'>参考规格:</td>
		<td class='secRow'><s:textfield id="assets_spec" name="assets.spec" title="资产名称" dataLength="0,96" controlName="参考规格" /></td>
		</tr>
		<tr>
		<td class='firstRow'>参考单价:￥</td>
		<td class='secRow'><s:textfield id="assets_price" name="assets.price" title="总价" dataLength="0,10" dataType="number" controlName="参考单价" />元</td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 数量:</td>
		<td class='secRow'><s:textfield id="assets_num" name="assets.num" title="数量" require="required" dataLength="0,10" dataType="integer" controlName="数量" />
		</td>
		</tr>
		<tr>
		<td class='firstRow'>总价:￥</td>
		<td class='secRow'><s:textfield id="assets_price_scope" name="assets.price_scope" title="总价" dataLength="0,10" dataType="number" controlName="总价" />元</td>
		</tr>
		<tr>
		<td class='firstRow'>所属公司:</td>
		<td class='secRow'><s:select name="assets.company" title="所属公司" headerKey="" headerValue="--请选择--" list="#{0:'北京互助天佑德青稞酒销售有限公司',1:'华实集团',2:'华奥地产',3:'青海互助青稞酒股份有限公司',4:'青海互助青稞酒销售有限公司',5:'北京互助天佑德青稞酒销售有限公司第二分公司'}" /></td>
		</tr>
		<tr>
		<td class='firstRow'>采购时间:</td>
		<td class='secRow'>
			<input id="assets_p_time" type="text" name="assets.p_time" title="采购时间" value="${it:formatDate(assets.p_time,'yyyy-MM-dd')}" />
			<script type="text/javascript">$("#assets_p_time").datepicker();</script>
		</td>
		</tr>
		<tr>
		<td class='firstRow'>报废时限(月):</td>
		<td class='secRow'><s:textfield name="assets.p_scrap" title="报废时限(月)" dataLength="0,10" dataType="integer" controlName="报废时限(月)" /> 月</td>
		</tr>
		<tr>
		<td class='firstRow'>可用操作:</td>
		<td class='secRow'>
			<s:if test="null == assets && 'add' == viewFlag">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_ADD')">
				<s:submit id="add" name="add" value="确定" action="assets_add" />
				</s:if>
			</s:if>
			<s:elseif test="null != assets && 'mdy' == viewFlag">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_MDY')">
				<s:submit id="save" name="save" value="保存" action="assets_save" />
				</s:if>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_DEL')">
				<s:submit id="delete" name="delete" value="删除" action="assets_del" onclick="return isDel();" />
				</s:if>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_MDY')">
		    	<input type="button" value="添加物品明细" onclick='openAddAssetItems();' />
		    	</s:if>
			</s:elseif>
			<input type="button" value="返回" onclick="linkurl('<s:url action="assets_relist" namespace="/adm" />');" />
			<span id="message"><s:property value="message" /></span>
		</td>
		</tr>
		<s:if test="'mdy' == viewFlag">
		<tr>
		<td class='titleRow' colspan="2">物品明细</td>
		</tr>
		<tr>
		<td class='secRow' colspan="2">
			<table class="ilisttable" id="table_item" width="100%">
			  <tr>
			    <th>编号</th>
				<th>型号</th>
				<th>规格</th>
				<th>所在位置</th>
				<th>是否已领用</th>
				<th>所属人</th>
				<th>领用时间</th>
				<th>操作</th>
			  </tr>
		<s:iterator value="assetItems" status="sta">
			  <tr id="assetItems_${uuid}" class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
			    <td align="center"><s:property value="uuid" /></td>
				<td align="center"><s:property value="model" /></td>
				<td align="center"><s:property value="spec" /></td>
				<td align="center"><s:property value="position" /></td>
				<td align="center" data="${is_use}"><s:if test="0==is_use">未领用</s:if><s:if test="1==is_use">已领用</s:if></td>
				<td align="center" data="${own_user}"><s:property value="own_user_name" /></td>
				<td align="center"><s:date name="use_time" format="yyyy-MM-dd" /></td>
				<td align="center">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_MDY')">
			    	[<a href="<s:url namespace="/adm" action="assetItem_load"><s:param name="viewFlag">mdy</s:param><s:param name="assetItem.uuid" value="uuid"></s:param></s:url>">修改</a>]
			    	</s:if>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_OWN')">
			    	[<a href="javascript:;" onclick="createMdyOwnDialog('${uuid}');">领用信息</a>]
			    	</s:if>	  
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_DEL')">
			    	[<a href="<s:url namespace="/adm" action="assetItem_del"><s:param name="assetItem.uuid" value="uuid" /><s:param name="assetItem.asset_id" value="asset_id" /></s:url>" onclick="return isDel();">删除</a>]
			    	</s:if>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_ADD')">
			    	[<a href="<s:url namespace="/adm" action="assetItem_addSimilar"><s:param name="assetItem.uuid" value="uuid" /><s:param name="assetItem.asset_id" value="asset_id" /></s:url>" onclick="return isOp('对这条信息进行类似创建吗?');">类似创建</a>]
			    	</s:if>
			    </td>
			  </tr>
			</s:iterator>
			</table>
		</td>
		</tr>
		</s:if>
	</table>	
</s:form>
	</div>
</div>
</div>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"${assets.typea}",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none"
	});
	
	$("#assets_price").bind("keyup",function(){
		$("#assets_price_scope").val($("#assets_price").val()*$("#assets_num").val());
	});
	$("#assets_num").bind("keyup",function(){
		$("#assets_price_scope").val($("#assets_price").val()*$("#assets_num").val());
	});

});
</script>
<!-- 以下为dialog div内容 -->
<s:if test="'mdy' == viewFlag">
<!-- 添加/修改明细 -->
<div id="addAssetItems" title="添加/修改明细">
<s:form id="form_addAssetItems" name="form_addAssetItems" action="assetItem_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
<table class="ilisttable" width="100%">
	 <tr>
	<td class='firstRow'>型号:</td>
	<td class='secRow'><s:textfield id="assetItem_model" name="assetItem.model" title="型号" dataLength="0,96" controlName="型号" /></td>
	</tr>
	<tr>
	<td class='firstRow'>规格:</td>
	<td class='secRow'><s:textfield id="assetItem_spec" name="assetItem.spec" title="规格" dataLength="0,96" controlName="规格" /></td>
	</tr>
	<tr>
	<td class='firstRow'>单价:</td>
	<td class='secRow'><s:textfield id="assetItem_price" name="assetItem.price" title="规格" dataLength="0,13" dataType="number" controlName="单价" /></td>
	</tr>
	<tr>
	<td class='firstRow'>所在位置:</td>
	<td class='secRow'><s:textfield id="assetItem_position" name="assetItem.position" title="所在位置" dataLength="0,32" controlName="所在位置" /></td>
	</tr>
	<tr>
	    <td colspan="20" class="buttonarea">
			<s:hidden name="assetItem.asset_id" value="%{assets.uuid}" />
			<s:hidden id="assetItem_uuid" name="assetItem.uuid"/>
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_ADD')">
				<s:submit id="add" name="add" value="确定" action="assetItem_add" />
			</s:if>
		</td>
    </tr>
</table>
</s:form>
</div>
<!-- 修改领用信息 -->
<div id="mdyAssetItemsOwn" title="修改领用信息">
<s:form id="form_ownAssetItems" name="form_ownAssetItems" action="assetItem_own" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
<table class="ilisttable" width="100%">
	<tr>
	<td class='firstRow'><span style="color:red;">*</span> 是否已领用:</td>
	<td class='secRow'><s:select id="assetItem_is_use" name="assetItem.is_use" title="是否已领用" list="#{0:'未领用',1:'已领用'}" /></td>
	</tr>
	<tr>
	<td class='firstRow'>所属人:</td>
	<td class='secRow'>
		<s:select id="assetItem_own_user" name="assetItem.own_user" title="所属人"
			headerKey="" headerValue="--请选择--" 
			list="ownusers" listKey="uuid" listValue="user_name" />
	</td>
	</tr>
	<tr>
	<td class='firstRow'>领用时间:</td>
	<td class='secRow'>
		<input id="assetItem_use_time" type="text" name="assetItem.use_time" title="领用时间" value="${it:formatDate(assetItem.use_time,'yyyy-MM-dd')}" />
		<script type="text/javascript">$("#assetItem_use_time").datepicker();</script>
	</td>
	</tr>
	<tr>
	    <td colspan="20" class="buttonarea">
			<s:hidden name="assetItem.asset_id" value="%{assets.uuid}" />
			<s:hidden id="assetItem_uuid_add_own" name="assetItem.uuid"/>
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_OWN')">
				<s:submit id="assetItem_own" name="assetItem_own" value="确定" action="assetItem_own" />
			</s:if>
		</td>
    </tr>
</table>
</s:form>
</div>
<script type="text/javascript">
$(function(){
	$("#addAssetItems").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#mdyAssetItemsOwn").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
});

function openAddAssetItems() {
	$("#assetItem_model").val($("#assets_model").val());
	$("#assetItem_spec").val($("#assets_spec").val());
	$("#assetItem_price").val($("#assets_price").val());
	$("#addAssetItems").dialog("open");
}

function createMdyOwnDialog(item_id) {
	var tr_id = "assetItems_" + item_id;
	var td_objs = $("#"+tr_id + " td");
	var i_use = $(td_objs[4]).attr("data");
	var i_own = $(td_objs[5]).attr("data");
	var i_date = $(td_objs[6]).text();
	$("#assetItem_uuid_add_own").val(item_id);
	//alert(i_use + "---" + i_own + "---" + i_date);
	//assetItem_is_use assetItem_own_user assetItem_use_time
	$("#assetItem_is_use").val(i_use);
	$("#assetItem_own_user").val(i_own);
	$("#assetItem_use_time").val(i_date);
	$("#mdyAssetItemsOwn").dialog("open");
}
</script>
</s:if>
</body>
</html>