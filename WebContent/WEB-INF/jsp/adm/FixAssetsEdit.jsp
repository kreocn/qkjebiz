<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>固定资产管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.pricecss {
	display: inline-block; height: 26px; line-height: 26px;
}

.label_hang {
	clear: both;
}
</style>

<style type="text/css">
.asset{
border-style: solid ; 
border-width: 10px ; 
border-color: pink ;
background-color:#fff;

position: absolute ;
height:200px ;
width:200px ;
bottom:35px; 
height:400px;
overflow:auto;

display: none;
}

</style>
</head>
<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">
				${path} <span class="opb lb op-area"><a href="<s:url namespace="/adm" action="fixassets_list"><s:param name="viewFlag">relist</s:param></s:url>">订单列表</a></span>
			</div>
			<s:form id="formEdit" name="form1" cssClass="validForm" action="fixassets_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
				<div class="label_con">
					<div class="label_main">
						<s:if test="null != fixassets">
							<div class="label_hang">
								<div class="label_ltit">系统编号:</div>
								<div class="label_rwben">${fixassets.uuid}<s:hidden name="fixassets.uuid" title="系统编号" />
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">修改时间:</div>
								<div class="label_rwbenx">${it:formatDate(fixassets.lm_time,'yyyy-MM-dd  HH:mm:ss')}</div>
							</div>
						</s:if>

						<div class="label_hang">
							<div class="label_ltit">资产分类:</div>
							<div class="label_rwben2">
								<span class="label_rwb"> <s:textfield title="资产名称" id="userasset_nameid" name="fixassets.type_title" readonly="true" /> <s:hidden title="资产编号" id="userasset_codeid" name="fixassets.typea" readonly="true" />
								</span> <span class="lb nw"> <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectWarevar('userasset_codeid','userasset_nameid',1);" />
								</span>
							</div>
						</div>

						<%-- <div class="label_hang">
			       <div class="label_ltit">资产分类:</div>
			       <div class="label_rwbenx" id="mmtype">
			       		<div class="label_rwben" style="margin-right:5px;"><select name="assets.typea" title="资产种类" class="prov"></select></div>
						<div class="label_rwben" style="margin-right:5px;"><select name="assets.typeb" title="资产类别" class="city" disabled="disabled"></select></div>
						<div class="label_rwben"><select name="assets.typec" title="子类别" class="dist" disabled="disabled"></select></div>
			       </div>
				</div> --%>
						<div class="label_hang">
							<div class="label_ltit">资产名称:</div>
							<div class="label_rwben">
								<s:textfield name="fixassets.title" title="资产名称" cssClass="validate[required,maxSize[128]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">参考型号:</div>
							<div class="label_rwben">
								<s:textfield id="assets_model" name="fixassets.model" title="参考型号" cssClass="validate[maxSize[96]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">参考规格:</div>
							<div class="label_rwben">
								<s:textfield id="assets_spec" name="fixassets.spec" title="参考规格" cssClass="validate[maxSize[96]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">参考价格:</div>
							<div class="label_rwben">
								<s:textfield id="assets_price" name="fixassets.price" title="参考价格" cssStyle="width:80%;" cssClass="validate[custom[number],maxSize[10]]" />
								<span class="pricecss">&nbsp;元</span>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">数量:</div>
							<div class="label_rwben">
								<s:textfield id="assets_num" name="fixassets.num" title="数量" cssClass="validate[required,custom[number],maxSize[10]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">总价:</div>
							<div class="label_rwben">
								<s:textfield id="assets_price_scope" name="fixassets.price_scope" title="总价" cssStyle="width:80%;" cssClass="validate[custom[number],maxSize[10]]" />
								<span class="pricecss">&nbsp;元</span>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">所属公司:</div>
							<div class="label_rwbenx">
								<s:select name="fixassets.company" title="所属公司" headerKey="" headerValue="--请选择--" list="#{0:'北京互助天佑德青稞酒销售有限公司',1:'华实集团',2:'华奥地产',3:'青海互助青稞酒股份有限公司',4:'青海互助青稞酒销售有限公司',5:'北京互助天佑德青稞酒销售有限公司第二分公司'}" />
							</div>
						</div>

						<div class="label_hang">
							<div class="label_ltit">采购公司:</div>
							<div class="label_rwbenx">
								<s:textfield name="fixassets.p_company" title="采购公司" cssClass="validate[maxSize[128]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">采购公司电话:</div>
							<div class="label_rwbenx">
								<s:textfield id="fixassets.p_mobile" title="电话" name="fixassets.p_mobile" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">保修期限:</div>
							<div class="label_rwbenx">
								<s:textfield id="fixassets.warrantytime" title="保修期限" name="fixassets.warrantytime" />
							</div>
						</div>

						<div class="label_hang">
							<div class="label_ltit">采购时间:</div>
							<div class="label_rwben">
								<input class="datepicker validate[required,custom[date]]" type="text" name="fixassets.p_time" title="采购时间" value="${it:formatDate(fixassets.p_time,'yyyy-MM-dd')}" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">报废时限(月):</div>
							<div class="label_rwben">
								<s:textfield name="fixassets.p_scrap" title="报废时限(月)" cssClass="validate[custom[integer],maxSize[10]]" />
							</div>
						</div>

						<div class="label_hang">
							<div class="label_ltit">所在位置:</div>
							<div class="label_rwbenx">
								<s:textfield name="fixassets.position" title="所在位置" cssClass="validate[maxSize[32]]" />
							</div>
						</div>

						<div class="label_hang">
							<div class="label_ltit">领用人部门:</div>
							<div class="label_rwben2">
								<span class="label_rwb"> <s:textfield title="部门名称" id="userdept_nameid" name="fixassets.own_userdept_name" readonly="true" /> <s:hidden title="部门代码" id="userdept_codeid" name="fixassets.own_userdept" readonly="true" />
								</span> <span class="lb nw"> <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,null,'asset');" /> <span
									id="ajax_member_message"></span>
								</span>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">领用人:</div>
							<div class="label_rwben label_rwb" style="position:relative;">
								<s:textfield name=""  title="" cssClass="validate[maxSize[32]]" onclick="assetDiv();"/>
								<div id="asset" class="asset">
								<!-- <input type="checkbox" checked="checked" value=""> -->
								</div>
								<%-- <select id="membermanagerid" class="selectKick" name="fixassets.own_user">
								<s:if test="%{fixassets.own_user!=null}">
								<option value="${fixassets.own_user_name }">${ fixassets.own_user_name}</option>
								</s:if>
								<s:else>
								<option>---请选择---</option>
								</s:else>
								</select> --%>
							</div>
							
							<div id="asset" style="height: 800px;width: 600px;">
							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">相关操作:</div>
								<div class="label_rwbenx">
									<c:if test="${null == fixassets && 'add' == viewFlag && it:checkPermit('QKJ_ADM_ASSETS_ADD',null)==true}">
										<s:submit id="add" name="add" value="确定" action="fixassets_add" cssClass="input-blue" />
									</c:if>
									<s:if test="null != fixassets && 'mdy' == viewFlag">
										<c:if test="${it:checkPermit('QKJ_ADM_ASSETS_MDY',null)==true}">
											<s:submit id="save" name="save" value="保存" action="fixassets_save" cssClass="input-blue" />
										</c:if>
										<c:if test="${it:checkPermit('QKJ_ADM_ASSETS_DEL',null)==true}">
											<s:submit id="delete" name="delete" value="删除" action="fixassets_del" onclick="return isDel();" cssClass="input-red" />
										</c:if>

										<%-- <c:if test="${it:checkPermit('QKJ_ADM_ASSETITEM_OWN',null)==true}">
											<input type="button" value="领用信息" onclick="createMdyOwnDialog('${fixassets.uuid}');" />
										</c:if> --%>
									</s:if>
									<input type="button" value="返回" onclick="linkurl('<s:url action="fixassetstype_relist" namespace="/adm" />');" /> <span id="message"><s:property value="message" /></span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</s:form>


			<%-- <div id="mdyAssetItemsOwn" title="修改领用信息">
<s:form id="form_ownAssetItems" name="form_ownAssetItems" action="assetItem_own" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
<table class="ilisttable" width="100%">
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
			<c:if test="${it:checkPermit('QKJ_ADM_ASSETITEM_OWN',null)==true}">
				<s:submit id="assetItem_own" name="assetItem_own" value="确定" action="assetItem_own" />
			</c:if>
		</td>
    </tr>
</table>
</s:form>
</div> --%>
		</div>
	</div>
	<!-- 以下为dialog div内容 -->
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
 });
</script>
	<script type="text/javascript">
$(function(){
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
</body>
</html>