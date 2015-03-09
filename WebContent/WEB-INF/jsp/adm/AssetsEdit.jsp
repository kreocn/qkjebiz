<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.pricecss{display:inline-block; height:26px; line-height:26px;}
.label_hang{clear:both;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/adm" action="assets_list"><s:param name="viewFlag">relist</s:param></s:url>">订单列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="assets_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<s:if test="null != assets">
 					<div class="label_hang">
				       <div class="label_ltit">系统编号:</div>
				       <div class="label_rwben">${assets.uuid}<s:hidden name="assets.uuid"  title="系统编号"/></div>
					</div>
					<div class="label_hang">
				       <div class="label_ltit">修改时间:</div>
				       <div class="label_rwbenx">${it:formatDate(assets.lm_time,'yyyy-MM-dd  HH:mm:ss')}</div>
					</div>
 				</s:if>
 				<div class="label_hang">
			       <div class="label_ltit">资产分类:</div>
			       <div class="label_rwbenx" id="mmtype">
			       		<div class="label_rwben" style="margin-right:5px;"><select name="assets.typea" title="资产种类" class="prov"></select></div>
						<div class="label_rwben" style="margin-right:5px;"><select name="assets.typeb" title="资产类别" class="city" disabled="disabled"></select></div>
						<div class="label_rwben"><select name="assets.typec" title="子类别" class="dist" disabled="disabled"></select></div>
			       </div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">资产名称:</div>
			       <div class="label_rwben"><s:textfield name="assets.title" title="资产名称" cssClass="validate[required,maxSize[128]]"/></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">参考型号:</div>
			       <div class="label_rwben"><s:textfield id="assets_model" name="assets.model" title="参考型号" cssClass="validate[maxSize[96]]"/></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">参考规格:</div>
			       <div class="label_rwben"><s:textfield id="assets_spec" name="assets.spec" title="参考规格" cssClass="validate[maxSize[96]]"/></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">参考价格:</div>
			       <div class="label_rwben"><s:textfield id="assets_price" name="assets.price" title="参考价格" style="width:80%;" cssClass="validate[custom[number],maxSize[10]]"/><span class="pricecss">&nbsp;元</span></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">数量:</div>
			       <div class="label_rwben"><s:textfield id="assets_num" name="assets.num" title="数量" cssClass="validate[required,custom[number],maxSize[10]]"/></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">总价:</div>
			       <div class="label_rwben"><s:textfield id="assets_price_scope" name="assets.price_scope" title="总价" style="width:80%;" cssClass="validate[custom[number],maxSize[10]]"/><span class="pricecss">&nbsp;元</span></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">所属公司:</div>
			       <div class="label_rwbenx"><s:select name="assets.company" title="所属公司" headerKey="" headerValue="--请选择--" list="#{0:'北京互助天佑德青稞酒销售有限公司',1:'华实集团',2:'华奥地产',3:'青海互助青稞酒股份有限公司',4:'青海互助青稞酒销售有限公司',5:'北京互助天佑德青稞酒销售有限公司第二分公司'}" /></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">采购时间:</div>
			       <div class="label_rwben"><input class="datepicker validate[required,custom[date]]" type="text" name="assets.p_time" title="采购时间" value="${it:formatDate(assets.p_time,'yyyy-MM-dd')}" /></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">报废时限(月):</div>
			       <div class="label_rwben"><s:textfield name="assets.p_scrap" title="报废时限(月)" cssClass="validate[custom[integer],maxSize[10]]"/></div>
				</div>
				<div class="label_main">
					<div class="label_hang">
			       		<div class="label_ltit">相关操作:</div>
			       		<div class="label_rwbenx">
			       			<s:if test="null == assets && 'add' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_ADD')">
								<s:submit id="add" name="add" value="确定" action="assets_add"  cssClass="input-blue"/>
								</s:if>
							</s:if>
							<s:elseif test="null != assets && 'mdy' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_MDY')">
								<s:submit id="save" name="save" value="保存" action="assets_save"  cssClass="input-blue"/>
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETS_DEL')">
								<s:submit id="delete" name="delete" value="删除" action="assets_del" onclick="return isDel();"  cssClass="input-red"/>
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_MDY')">
						    	<input type="button" value="添加物品明细" onclick='openAddAssetItems();' class="input-green"/>
						    	</s:if>
							</s:elseif>
							<input type="button" value="返回" onclick="linkurl('<s:url action="assets_relist" namespace="/adm" />');" />
							<span id="message"><s:property value="message" /></span>
			       		</div>
			        </div>
				</div>
				<s:if test="'mdy' == viewFlag">
					<fieldset class="clear">
						<legend>物品明细</legend>
						<table class="lb_jpin" id="table_item" width="100%">
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
								  <tr>
								    <td>${uuid}</td>
									<td>${model}</td>
									<td>${spec}</td>
									<td>${position}</td>
									<td><s:if test="0==is_use">未领用</s:if><s:if test="1==is_use">已领用</s:if></td>
									<td>${own_user_name}</td>
									<td>${it:formatDate(use_time,'yyyy-MM-dd')}</td>
									<td>
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
					</fieldset>
				</s:if>
 			</div>
 		</div>
 	</s:form>
</div>
</div>
<!-- 以下为dialog div内容 -->
<s:if test="'mdy' == viewFlag">
<!-- 添加/修改明细 -->
<div id="addAssetItems" title="添加/修改明细">
<s:form id="form_addAssetItems" name="form_addAssetItems" action="assetItem_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
<table class="ilisttable" width="100%">
	 <tr>
		<td align="right">型号:</td>
		<td><s:textfield id="assetItem_model" name="assetItem.model" title="型号" cssClass="validate[maxSize[96]]" /></td>
	</tr>
	<tr>
		<td align="right">规格:</td>
		<td><s:textfield id="assetItem_spec" name="assetItem.spec" title="规格" cssClass="validate[maxSize[96]]"/></td>
	</tr>
	<tr>
		<td align="right">单价:</td>
		<td><s:textfield id="assetItem_price" name="assetItem.price" title="规格" cssClass="validate[custom[number],maxSize[13]]" /></td>
	</tr>
	<tr>
		<td align="right">所在位置:</td>
		<td><s:textfield id="assetItem_position" name="assetItem.position" title="所在位置" cssClass="validate[maxSize[32]]" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	    <td>
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
		<td align="right"><span style="color:red;">*</span> 是否已领用:</td>
		<td><s:select id="assetItem_is_use" name="assetItem.is_use" title="是否已领用" list="#{0:'未领用',1:'已领用'}" /></td>
	</tr>
	<tr>
		<td align="right">所属人:</td>
		<td><s:select id="assetItem_own_user" name="assetItem.own_user" title="所属人" headerKey="" headerValue="--请选择--" list="ownusers" listKey="uuid" listValue="user_name" /></td>
	</tr>
	<tr>
		<td align="right">领用时间:</td>
		<td><input class="datepicker validate[required,custom[date]]"  id="assetItem_use_time" type="text" name="assetItem.use_time" title="领用时间" value="${it:formatDate(assetItem.use_time,'yyyy-MM-dd')}" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	    <td>
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

<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript">
$(function(){
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
	$("#addAssetItems").dialog({
	      autoOpen: false,
	      height: 220,
	      width: 600,
	      modal: true
	});
	$("#mdyAssetItemsOwn").dialog({
	      autoOpen: false,
	      height:190,
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