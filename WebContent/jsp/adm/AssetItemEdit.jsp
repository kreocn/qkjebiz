<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产物品管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
 <div class="main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/adm" action="assetItem_list"><s:param name="viewFlag">relist</s:param></s:url>">资产物品列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="assetItem_add" namespace="/adm" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<s:if test="null != assetItem">
 					<div class="label_hang">
				       <div class="label_ltit">编号:</div>
				       <div class="label_rwbenx">${assetItem.uuid}<s:hidden name="assetItem.uuid"  title="系统编号"/></div>
					</div>
					<div class="label_hang clear">
				       <div class="label_ltit">所属资产:</div>
				       <div class="label_rwbenx">${assetItem.asset_id}<s:hidden name="assetItem.asset_id" title="所属资产" /></div>
					</div>
 				</s:if>
 				<div class="label_hang clear">
			       <div class="label_ltit">型号:</div>
			       <div class="label_rwbenx"><s:textfield name="assetItem.model" title="型号" cssClass="validate[maxSize[96]]"/></div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">规格:</div>
			       <div class="label_rwbenx"><s:textfield name="assetItem.spec" title="规格" cssClass="validate[maxSize[96]]"/></div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">单价:</div>
			       <div class="label_rwbenx"><s:textfield name="assetItem.price" title="单价" cssClass="validate[custom[number],maxSize[13]]"/></div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">所在位置:</div>
			       <div class="label_rwbenx"><s:textfield name="assetItem.position" title="所在位置" cssClass="validate[maxSize[32]]"/></div>
				</div>
 			</div>
 			<div class="label_main">
 				<div class="label_ltit">相关操作:</div>
 				<div class="label_rwbenx">
	 				<span id="message"><s:property value="message" /></span>
					<s:if test="null == assetItem && 'add' == viewFlag">
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_ADD')">
						<s:submit id="add" name="add" value="确定" action="assetItem_add" cssClass="input-blue" />
						</s:if>
					</s:if>
					<s:elseif test="null != assetItem && 'mdy' == viewFlag">
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_MDY')">
						<s:submit id="save" name="save" value="保存" action="assetItem_save" cssClass="input-blue" />
						</s:if>
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_DEL')">
						<s:submit id="delete" name="delete" value="删除" action="assetItem_del" onclick="return isDel();" cssClass="input-red" />
						</s:if>
					</s:elseif>
					<input type="button" value="返回"  onclick="linkurl('<s:url action="assets_load" namespace="/adm"><s:param name="viewFlag">mdy</s:param><s:param name="assets.uuid" value="%{assetItem.asset_id}" /></s:url>');" />
 				</div>
 			</div>
 		</div>
 	</s:form>
</div>
</body>
</html>