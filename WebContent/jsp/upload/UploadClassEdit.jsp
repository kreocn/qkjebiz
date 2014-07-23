<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文件分类列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax.js" />"></script>
<script type="text/javascript">
var num = 0;
var current_num = 0;
var _classFileTypeTD1 = "";
var _classFileTypeTD2 = "";
var _classFileTypeTD3 = "";
var existsFileType = new Array();
window.onload = function() {
	setStyle("table1");
	var td1 = $("classFileTypeTD1");
	var td2 = $("classFileTypeTD2");
	var td3 = $("classFileTypeTD3");
	if(td1) {
		_classFileTypeTD1 = td1.innerHTML;
		td1.parentNode.removeChild(td1);
	}
	if(td2) {
		_classFileTypeTD2 = td2.innerHTML;
		td2.parentNode.removeChild(td2);
	}
	if(td3) {
		_classFileTypeTD3 = td3.innerHTML;
		td3.parentNode.removeChild(td3);
	}	
}
function getInfo(obj) {
	var num_start = obj.name.indexOf('[');
	var num_end = obj.name.indexOf(']');
	current_num = obj.name.substring(num_start+1,num_end);		
	var ajax = new Ajax_Init("result",true,true,'','','','message2');
	ajax.addParameter("privilege_id","UPLOADFILE_CLASS_AJAX_LOAD_CLASSTYPE");
	ajax.addParameter("parameters","uuid="+obj.value);
	ajax.SendPost('<s:url value="/common/ajax" />');
}
function setAjaxInfo(str) {
	try {
		var json = eval('('+getCHTML(str)+')');
		if(checkExist(json.uuid)) {
			$('classFileType['+current_num+'].filetype_id').value = json.uuid;
			$('classFileType'+current_num+'_extension').innerHTML = json.extension;
			$('classFileType'+current_num+'_mimeType').innerHTML = json.mime_type;			
		} else {
			$('classFileType['+current_num+'].class_id').value = "";
			$('classFileType['+current_num+'].filetype_id').value = "";
			$('classFileType'+current_num+'_extension').innerHTML = "";
			$('classFileType'+current_num+'_mimeType').innerHTML = "";		
			alert('此类型已经被允许!');
		}			
	} catch (e) {
		$('message').innerHTML = "读取失败...";
		iferror(str,e);
	}
}
function createTr() {
	try {
		var tableObj = $("table1");
		var nnum = tableObj.rows.length-1;
		var trObj = tableObj.insertRow(tableObj.rows.length-1);
		trObj.setAttribute('id','classFileType' + num + '_tr');	
		var tdObj1 = trObj.insertCell();
		var __classFileTypeTD1 = _classFileTypeTD1.replace(/{num}/gm, num);
		tdObj1.innerHTML = __classFileTypeTD1;

		var tdObj2 = trObj.insertCell();
		var __classFileTypeTD2 = _classFileTypeTD2.replace(/{num}/gm, num);
		tdObj2.innerHTML = __classFileTypeTD2;

		var tdObj3 = trObj.insertCell();
		var __classFileTypeTD3 = _classFileTypeTD3.replace(/{num}/gm, num);
		tdObj3.innerHTML = __classFileTypeTD3;

		var tdObj4 = trObj.insertCell();
		tdObj4.align = "center";
		tdObj4.innerHTML = '[<a href="javascript:void(0);" onClick="removeRow(this)">移除</a>]';
	} catch (e) {
		alert(e.message)
	}
	num++;
}

function checkExist(uuid) {	
	// 检查数据库中已有的数据
	if(existsFileType) {
		if(existsFileType.length > 0) {
			for ( var i = 0; i < existsFileType.length; i++) {
				if(uuid == existsFileType[i]) {
					return false
				}
			}
		}
	}	
	// 检查现在正在添加的数据
	for ( var j = 0; j < num-1; j++) {
		if($('classFileType['+j+'].filetype_id') && j!=current_num) {
			if(uuid == $('classFileType['+j+'].filetype_id').value) {
				return false;
			}			
		}
	}
	return true;
}

function removeRow(obj) {
	var trObj = findFirstParent(obj,"TR");
	var tableObj = findFirstParent(trObj,"TABLE");
	tableObj.deleteRow(trObj.sectionRowIndex);
}

function showSize(obj) {
	try {
		var size = parseFloat(obj.value);
		if(size <= 1000) {
			$('showSizeSpan').innerText = size + "byte";
		} else if(size > 1000 && size <= 1000000) {
			$('showSizeSpan').innerText = formatFloat(size/1024,2) + "KB";
		} else if(size > 1000000 && size <= 1000000000) {
			$('showSizeSpan').innerText = formatFloat(size/1024/1024,2) + "MB";
		} else if(size > 1000000000) {
			$('showSizeSpan').innerText = formatFloat(size/1024/1024/1024,2) + "GB";
		} else {
			$('showSizeSpan').innerText = "";
		}
	} catch (e) {
		//alert(e.message)
		$('showSizeSpan').innerText = "";
	}
}


function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('message').innerHTML = str;
}

function viewx(obj) {
	$('message').innerHTML = obj;
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == uclass && 'add' == viewFlag">增加</s:if><s:elseif test="null != uclass && 'mdy' == viewFlag">修改</s:elseif>文件分类</div>
<s:form name="form1" action="uclass_add" namespace="/upload" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != uclass">	
		<tr>
			<td class="firstRow">分类ID:</td>
			<td class="secRow" colspan="3"><s:property value="uclass.uuid" /><s:hidden name="uclass.uuid" /></td>	
		</tr>
		</s:if>
		<tr>
			<td class="firstRow">分类编号:</td>
			<td class="secRow"><s:textfield title="角色名称" name="uclass.c_id" require="required" controlName="分类编号" dataType="english" /> <span style="color:red;">*</span></td>
			<td class="firstRow">分类名称:</td>
			<td class="secRow"><s:textfield title="角色名称" name="uclass.c_name" require="required" controlName="分类名称" /> <span style="color:red;">*</span></td>
		</tr>
		<tr>
			<td class="firstRow">分类目录:</td>
			<td class="secRow"><s:textfield title="分类目录" name="uclass.c_dir" /></td>		
			<td class="firstRow">单个文件限制:</td>
			<td class="secRow">
				<s:textfield title="限制大小" name="uclass.max_size" onkeyup="showSize(this);" controlName="单个文件限制" dataType="integer" />
				<span id="showSizeSpan" style="color:red;"></span>
			</td>				
		</tr>
		<tr>
			<td class="firstRow">外键类型:</td>
			<td class="secRow"><s:select name="uclass.union_type" list="#{'USER':'用户','OTHERS':'自定义'}" /></td>
			<td class="firstRow">外键限制:</td>
			<td class="secRow"><s:textfield title="外键限制" name="uclass.union_num" controlName="外键限制" dataType="integer" /></td>
		</tr>
		<tr>
			<td class="firstRow">分类描述:</td>
			<td class="secRow" colspan="3"><s:textfield title="分类描述" name="uclass.descriptions" cssStyle="width:80%;" /></td>
		</tr>
		<s:if test="null != uclass">	
		<tr>
			<td class="firstRow">修改人:</td>
			<td class="secRow"><s:property value="uclass.lm_user" /><s:hidden name="uclass.lm_user" /></td>
			<td class="firstRow">修改时间:</td>
			<td class="secRow"><s:date name="uclass.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		</s:if>	
		<tr>
	    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
			<s:if test="null == uclass && 'add' == viewFlag">
				<s:submit id="add" name="add" value="增加" action="uclass_add" />
			</s:if>
			<s:elseif test="null != uclass && 'mdy' == viewFlag">
				<s:submit id="save" name="save" value="保存" action="uclass_save" />
				<s:submit id="delete" name="delete" value="删除" action="uclass_del" onclick="return isDel();" />
			</s:elseif>
			<input type="button" value="返回" onclick="linkurl('<s:url action="uclass_list" namespace="/upload" />');" />
		</td>    
	    </tr>
	</table>
</s:form>
	</div>
	<div class="itablemdy" style="margin-top: 15px;">
		<div class="itabletitle">允许上传文件类型</div>	
	<s:form name="form_list" namespace="/upload" action="add_relation" theme="simple" onsubmit="return validator(this);">
		<table class="ilisttable" id="table1" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		  <tr>
		    <th>类型名称<s:hidden name="uclass.uuid" /></th>
			<th>扩展名</th>
			<th>MIME_TYPE</th>
			<th>操作</th>
		  </tr>
		<s:iterator value="classFileType" status="sta">		
		  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" onclick="pickrow(this);">
		    <td><s:property value="filetype_title" /></td>
		    <td><s:property value="filetype_extension" /></td>
			<td><s:property value="filetype_mime_type" /></td>
			<td align="center">
			<s:url id="removeFileType" namespace="/upload" action="remove_relation">
				<s:param name="cfileType.filetype_id" value="filetype_id" />
				<s:param name="cfileType.class_id" value="uclass.uuid" />
			</s:url>
			[<s:a href="%{removeFileType}">删除</s:a>]</td>
		  </tr>
			<script type="text/javascript">
				existsFileType.push('<s:property value="filetype_id" />');
			</script>
		</s:iterator>
		<tr>
	    <td colspan="4" class="buttonarea"><span id="message2" style="color:red;"><s:property value="message2" /></span>
			<input type="button" value="添加" onclick="createTr();" />&nbsp;
			<s:submit type="button" value="保存" />
		</td>    
	    </tr>
		</table>
	</s:form>
	</div>
</div>
</div>
<div id="classFileTypeTD1" style="display: none">
	<s:select title="文件类型" theme="simple"
						id="classFileType[{num}].filetype_id" 
						name="classFileType[{num}].filetype_id"
						list="fileTypes"
						listKey="uuid" 
						listValue="title"
						headerKey="" 
						headerValue="根节点" onchange="getInfo(this)" require="required" controlName="文件类型" />
	<s:hidden id="classFileType[{num}].class_id" name="classFileType[{num}].class_id" value="%{uclass.uuid}" />
</div>
<div id="classFileTypeTD2" style="display: none">
	<span id="classFileType{num}_extension"></span>
</div>
<div id="classFileTypeTD3" style="display: none">
	<span id="classFileType{num}_mimeType"></span>
</div>
</body>
</html>