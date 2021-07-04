<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品类型列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/sysebiz" action="goodsType_list"><s:param name="viewFlag">relist</s:param></s:url>">商品类型列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="goodsType_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<s:if test="null != goodsType">
 					<div class="label_hang">
				       <div class="label_ltit">类型编号:</div>
				       <div class="label_rwbenx">${goodsType.uuid}<s:hidden id="goodsType.uuid" name="goodsType.uuid" /></div>
					</div>	
 				</s:if>
 				<div class="label_hang clear">
			       <div class="label_ltit">类型名称:</div>
			       <div class="label_rwbenx"><s:textfield name="goodsType.type_name" id="goodsType.type_name" title="类型名称" cssClass="validate[required]"/></div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">[?]属性分组:</div>
			       <div class="label_rwbenx">
				       <s:textfield id="goodsType.type_group" name="goodsType.type_group" title="商品类型地点"/>
				       <span class="message_prompt">使用','隔开 是在属性内进行分组</span>
			       </div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">状态:</div>
			       <div class="label_rwbenx"><s:radio list="#{0:'正常',1:'停用' }" name="goodsType.status" value="0" /></div>
				</div>
				<s:if test="null != goodsType">
					<div class="label_hang clear">
				       <div class="label_ltit">修改人:</div>
				       <div class="label_rwbenx">${goodsType.lm_user_name}<s:hidden name="goodsType.lm_user" /></div>
					</div>
					<div class="label_hang clear">
				       <div class="label_ltit">修改时间:</div>
				       <div class="label_rwbenx"><s:date name="goodsType.lm_time" format="yyyy-MM-dd HH:mm:ss" /></div>
					</div>
				</s:if>
				<div class="label_hang clear">
			       <div class="label_ltit">相关操作:</div>
			       <div class="label_rwbenx op-area">
			       		<s:if test="null == goodsType && 'add' == viewFlag">
							<s:submit id="add" name="add" value="确定" action="goodsType_add" cssClass="input-blue"/>
						</s:if>
						<s:elseif test="null != goodsType && 'mdy' == viewFlag">
							<s:submit id="save" name="save" value="保存" action="goodsType_save" cssClass="input-blue"/>
							<s:submit id="delete" name="delete" value="删除" action="goodsType_del" onclick="return isDel();" cssClass="input-red"/>
						</s:elseif>
						<input type="button" value="返回" onclick="linkurl('<s:url action="goodsType_list" namespace="/sysebiz" />');" class="input-gray"/>
						<span id="message"><s:property value="message" /></span>
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