<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url action="proType_list" namespace="/qkjmanage" />" >返回列表</a>
		</span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="proType_add" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_con">
	<s:if test="null != proType">
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">编号:</div>
		         <div class="label_rwb"><s:property value="proType.uuid" /> <s:hidden id="proType.uuid" name="proType.uuid" /></div>
	       	</div>
	 </div>
	</s:if>
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">类型:</div>
		        <div class="label_rwben2">
		         <div class="label_rwb"><s:select name="proType.type" title="类型" list="#{0:'产品',1:'促销物料'}" cssClass="validate[required]" /></div>
	       	</div>
	 </div>
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">名称:</div>
		        <div class="label_rwben2">
		         <div class="label_rwb"><s:textfield id="proType.name" name="proType.name" title="名称" require="required" cssClass="validate[required]" /></div>
		         </div>
	       	</div>
	 </div>
        <s:if test="null != proType">
        	<div class="label_main">
        		<div class="label_hang">
		            <div class="label_ltit">修改人:</div>
		            <div class="label_rwben">
		           <s:property value="proType.lm_user_name" /> <s:hidden name="proType.lm_user" value="%{proType.lm_user}" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">修改时间:</div>
		            <div class="label_rwbenx">
		            <s:date name="proType.lm_time" format="yyyy-MM-dd HH:mm:ss" />
		            </div>
	       		</div>
        	</div>
	    </s:if>
	    <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            	
            	<s:if test="null == proType && 'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PROTYPE_ADD')">
				<s:submit id="add" name="add" value="确定" action="proType_add" cssClass="input-blue"/>
				</s:if>
				<s:elseif test="null != proType && 'mdy' == viewFlag">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PROTYPE_MDY')">
				<s:submit id="save" name="save" value="保存" action="proType_save" cssClass="input-blue"/>
				</s:if>
				 <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PROTYPE_DEL')">
				<s:submit id="delete" name="delete" value="删除" action="proType_del" onclick="return isDel();" cssClass="input-red"/>
				</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="proType_list" namespace="/qkjmanage" />');" />
				
            </div>
		</div>
		</div>
	</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>