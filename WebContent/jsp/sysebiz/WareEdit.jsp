<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_lite.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery-ui-1.10.3.custom.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
<script type="text/javascript">
var infoeditor01;
$(function(){
	infoeditor01 = new widget_textarea();
	infoeditor01.init("warenoteid");
});
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == ware && 'add' == viewFlag">增加</s:if><s:elseif test="null != ware && 'mdy' == viewFlag">修改</s:elseif>仓库</div>
<s:form name="form1" action="ware_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != ware">	
		  <tr>
		    <td class="firstRow">仓库编号:</td>
		    <td class="secRow"><s:property value="ware.uuid" />
			<s:hidden id="ware.uuid" name="ware.uuid" />
			</td>	
		  </tr>
		</s:if>
		  <tr>
		  <td class="firstRow"><span style="color:red;">*</span>仓库类型:</td>
			<td class="secRow">
				<s:select title="仓库类型" 
					id="ware.ware_class" 
					name="ware.ware_class"
					list="#{0:'普通库', 1:'藏酒库'}"
					value="1"
					require="required" controlName="仓库类型" />
			</td>
		  </tr>
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>仓库名称:</td>
		    <td class="secRow">
		    	<s:textfield id="ware.ware_name" name="ware.ware_name" title="仓库名称" require="required" controlName="仓库名称" />
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">仓库地点:</td>
		    <td class="secRow">
		    	<s:textfield id="ware.address" name="ware.address" title="仓库地点" cssStyle="width:50%;" />
		    	<!-- 
		    	<s:textfield id="ware.map_data" name="ware.map_data" title="仓库地图点" />
		    	 -->
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">仓库简短描述:</td>
		    <td class="secRow">
		    	<s:textarea  name="ware.short_note" cssStyle="width:50%;" rows="3" title="仓库简短描述" />
		    </td>
		  </tr>
		  <tr>
		  	<td class="titleRow" colspan="2">仓库详细描述 </td>
		  </tr>
		  <tr>
		    <td class="secRow" colspan="2">
				<textarea cols="100" id="warenoteid" name="ware.note" rows="6"><s:property value="ware.note" /></textarea>
		    </td>
		  </tr>  
		<s:if test="null != ware">	
		  <tr>
		    <td class="firstRow">修改人:</td>
		    <td class="secRow">
		    	<s:property value="ware.lm_user" />
				<s:hidden name="ware.lm_user" />
			</td>
		  </tr>
		  <tr>
		    <td class="firstRow">修改时间:</td>
		    <td class="secRow"><s:date name="ware.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>
		</s:if>
		<tr>
		    <td colspan="20" class="buttonarea"><span id="message"><s:property value="message" /></span>
				<s:if test="null == ware && 'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="ware_add" />
				</s:if>
				<s:elseif test="null != ware && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="ware_save" />
					<s:submit id="delete" name="delete" value="删除" action="ware_del" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="ware_list" namespace="/sysebiz" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>