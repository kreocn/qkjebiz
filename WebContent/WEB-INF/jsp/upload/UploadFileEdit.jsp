<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传文件列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax.js" />"></script>
<script type="text/javascript">
function addMore() {
	var td = document.getElementById("more");	
	var br = document.createElement("br");
	var input = document.createElement("input");
	var button = document.createElement("input");	
	input.type = "file";
	input.name = "ufiles";	
	button.type = "button";
	button.value = "移除";	
	button.onclick = function()	{
		td.removeChild(br);
		td.removeChild(input);
		td.removeChild(button);
	};
	td.appendChild(br);
	td.appendChild(input);
	td.appendChild(button);
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == file && 'add' == viewFlag">上传</s:if><s:elseif test="null != file && 'mdy' == viewFlag">修改</s:elseif>文件</div>
<s:form name="form1" action="file_add" namespace="/upload" onsubmit="return validator(this);" enctype="multipart/form-data" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != file">	
		<tr>
			<td class="firstRow">文件识标符:</td>
			<td class="secRow" colspan="3"><s:property value="file.uuid" /><s:hidden name="file.uuid" /></td>
		</tr>
		</s:if>
		<tr>
			<td class="firstRow">文件分类:</td>
			<td class="secRow">
				<s:select id="uclass.uuid"
						  name="uclass.uuid" 
						  list="uclasses"
						  headerKey=""
						  headerValue="根节点"
						  listKey="uuid"
						  listValue="c_name"
						  value="file.class_id" require="required" controlName="文件分类" /> <span style="color:red">*</span>
			</td>
			<td class="firstRow">关联外键:</td>
			<td class="secRow"><s:textfield title="关联外键" name="file.union_code" /></td>
		</tr>
		<tr>
			<td class="firstRow">上传文件:</td>
			<td class="secRow" colspan="3" id="more">
				<s:if test="null == file && 'add' == viewFlag">
					<input type="button" value="追加上传文件" onClick="addMore();" />(追加的文件会分成多条记录显示)<br />
				</s:if>
				<s:file name="ufiles" />
			</td>
		</tr>
		<s:if test="null != file">
		<tr>
			<td class="firstRow">文件名:</td>
			<td class="secRow" colspan="3"><s:property value="file.title" /><s:hidden name="file.title" /></td>
		</tr>		
		<tr>
			<td class="firstRow">内部名称:</td>
			<td class="secRow"><s:property value="file.file_name" /><s:hidden name="file.file_name" /></td>	
			<td class="firstRow">文件大小:</td>
			<td class="secRow"><s:property value="file.file_size" /><s:hidden name="file.file_size" /></td>				
		</tr>
		<tr>
			<td class="firstRow">文件类型:</td>
			<td class="secRow" colspan="3"><s:property value="file.file_type" /><s:hidden name="file.file_type" /></td>
		</tr>		
		<tr>
			<td class="firstRow">上传人:</td>
			<td class="secRow"><s:property value="file.lm_user" /><s:hidden name="file.lm_user" /></td>
			<td class="firstRow">上传时间:</td>
			<td class="secRow"><s:date name="file.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>	
		<tr>
	    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
			<s:if test="null == file && 'add' == viewFlag">
				<s:submit id="add" name="add" value="增加" action="file_add" />
			</s:if>
			<s:elseif test="null != file && 'mdy' == viewFlag">
				<s:submit id="save" name="save" value="保存" action="file_save" />
				<s:submit id="delete" name="delete" value="删除" action="file_del" onclick="return isDel();" />
			</s:elseif>
			<input type="button" value="返回" onclick="linkurl('<s:url action="file_list" namespace="/upload" />');" />
		</td>    
	    </tr>
	</table>
</s:form>
	</div>
</div>
</div>
</body>
</html>