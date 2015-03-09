<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>产品管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<style type="text/css">
.label_hang{line-height:26px;}
</style>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="product_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="product_add" namespace="/qkjmanage" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<s:if test="null != product">
				<div class="label_hang">
				       <div class="label_ltit">编号:</div>
				       <div class="label_rwben"><s:property value="product.uuid" /><s:hidden name="product.uuid" /></div>
				</div>
				</s:if>
				<div class="label_hang">
				       <div class="label_ltit">物料统一编码:</div>
				       <div class="label_rwben"><s:textfield name="product.prod_code" title="产品统一编码" cssClass="validate[required,maxSize[16]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">产品系列:</div>
				       <div class="label_rwben"><s:select id="membermanagerid" cssClass="validate[required]" name="product.brand" title="产品类型"  headerKey="" headerValue="--请选择--" list="proTypes" listKey="uuid" listValue="name" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">品名:</div>
				       <div class="label_rwben"><s:textfield name="product.title" title="品名" cssClass="validate[required,maxSize[85]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">规格:</div>
				       <div class="label_rwben"><s:textfield name="product.spec" title="规格(500ml)" cssClass="validate[required,maxSize[85]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">数量:</div>
				       <div class="label_rwben"><s:textfield name="product.case_spec" title="数量" cssClass="validate[required,custom[integer]]" style="width:76%;" />&nbsp;/件</div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">酒精度:</div>
				       <div class="label_rwben"><s:textfield name="product.alcohol" title="酒精度" cssClass="validate[custom[number]]"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">香型:</div>
				       <div class="label_rwben"><s:textfield name="product.flavor" title="香型"  cssClass="validate[maxSize[85]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">原材料:</div>
				       <div class="label_rwben"><s:textfield name="product.raw_materials" title="原材料" cssClass="validate[maxSize[85]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">档次:</div>
				       <div class="label_rwben"><s:select name="product.grade" title="档次" cssClass="validate[required]" headerKey="" headerValue="--请选择--" list="#{1:'低端',2:'中端',3:'中高端',4:'高端'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">市场价:</div>
				       <div class="label_rwben"><s:textfield name="product.market_price" title="市场价" cssClass="validate[required,custom[number]]"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">团购价:</div>
				       <div class="label_rwben"><s:textfield name="product.group_price" title="团购价" cssClass="validate[required,custom[number]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">出厂价:</div>
				       <div class="label_rwben"><s:textfield name="product.dealer_price" title="出厂价" cssClass="validate[required,custom[number]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">返利标准(%):</div>
				       <div class="label_rwben"><s:textfield name="product.group_rebates" title="返利标准" cssClass="validate[required,custom[number]]" style="width:76%;"  />&nbsp;%</div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">协议价1:</div>
				       <div class="label_rwben"><s:textfield name="product.agree_price_1" title="协议价1" cssClass="validate[custom[number]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">协议价2:</div>
				       <div class="label_rwben"><s:textfield name="product.agree_price_2" title="协议价2" cssClass="validate[custom[number]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">协议价3:</div>
				       <div class="label_rwben"><s:textfield name="product.agree_price_3" title="协议价3" cssClass="validate[custom[number]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">是否启用:</div>
				       <div class="label_rwben"><s:select name="product.status" title="产品系列" cssClass="validate[required]"  list="#{0:'启用',1:'禁用'}" /></div>
				</div>
			</div>
		</div>
		<div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit" style="font-size:14px;">相关操作:</div>
	            <div class="label_rwbenx">
	            	<span id="message"><s:property value="message" /></span>
				<s:if test="null == product && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
					<s:submit id="add" name="add" value="确定" action="product_add" class="input-blue" />
					</s:if>
				</s:if>
				<s:elseif test="null != product && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_MDY')">
					<s:submit id="save" name="save" value="保存" action="product_save" class="input-blue" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_DEL')">
					<s:submit id="delete"  name="delete" value="删除" action="product_del"  class="input-red" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="product_list" namespace="/qkjmanage" />');" />
	            </div>
	        </div>
        </div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>