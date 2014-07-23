<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品类型列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_lite.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/ckeditor/ckeditor.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/ckfinder/ckfinder.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == goodsType && 'add' == viewFlag">增加</s:if><s:elseif test="null != goodsType && 'mdy' == viewFlag">修改</s:elseif>商品类型</div>
<s:form name="form1" action="goodsType_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != goodsType">	
		  <tr>
		    <td class="firstRow">类型编号:</td>
		    <td class="secRow"><s:property value="goodsType.uuid" />
			<s:hidden id="goodsType.uuid" name="goodsType.uuid" />
			</td>	
		  </tr>
		</s:if>
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>类型名称:</td>
		    <td class="secRow">
		    	<s:textfield id="goodsType.type_name" name="goodsType.type_name" title="类型名称" require="required" controlName="类型名称" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">[?]属性分组:</td>
		    <td class="secRow">
		    	<s:textfield id="goodsType.type_group" name="goodsType.type_group" title="商品类型地点" cssStyle="width:50%;" /><br />
		    	<span class="description_note">使用','隔开 是在属性内进行分组</span>		    	
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">状态:</td>
		    <td class="secRow">
		    	<s:radio list="#{0:'正常',1:'停用' }" name="goodsType.status" value="0" />
		    </td>
		  </tr>		  
		<s:if test="null != goodsType">	
		  <tr>
		    <td class="firstRow">修改人:</td>
		    <td class="secRow">
		    	<s:property value="goodsType.lm_user" />
				<s:hidden name="goodsType.lm_user" />
			</td>
		  </tr>
		  <tr>
		    <td class="firstRow">修改时间:</td>
		    <td class="secRow"><s:date name="goodsType.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>
		</s:if>
		<tr>
		    <td colspan="20" class="buttonarea"><span id="message"><s:property value="message" /></span>
				<s:if test="null == goodsType && 'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="goodsType_add" />
				</s:if>
				<s:elseif test="null != goodsType && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="goodsType_save" />
					<s:submit id="delete" name="delete" value="删除" action="goodsType_del" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="goodsType_list" namespace="/sysebiz" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>