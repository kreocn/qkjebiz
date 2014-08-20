<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>系统更新保存</title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<!-- 文本编辑器 -->
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
<!-- 日期样式 -->
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<!-- 日期样式 --1992-01-02-->
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>



<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == sche && 'add' == viewFlag">增加</s:if><s:elseif test="null != sche && 'mdy' == viewFlag">修改</s:elseif>系统</div>
<s:form name="form1" action="sche_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != sche">	
		  <tr>
		    <td class="firstRow">编号:</td>
		    <td class="secRow"><s:property value="sche.ssid" />
			<s:hidden id="sche.ssid" name="sche.ssid" />
			</td>	
		  </tr>
		</s:if>
		  
		  <tr>
		    <td class="firstRow"><span style="color:red;">*</span>标题:</td>
		    <td class="secRow">
		    	<s:textfield id="sche.title" name="sche.title" title="标题" require="required" controlName="标题" cssStyle="width:40%;" />
		    	
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">日期:</td>
		    <td class="secRow">
		    <input id="active_plan_start" type="text" name="sche.sdate" title="活动开始时间" value="${sche.sdate}" dataType="date" controlName="计划开始时间" require="required" />
		    	<script type="text/javascript">$("#active_plan_start").datepicker();</script>
		    	<!-- 
		    	<s:textfield id="ware.map_data" name="ware.map_data" title="仓库地图点" />
		    	 -->
		    </td>
		  </tr>
		 
		  <tr>
		  	<td class="titleRow" colspan="2">内容 </td>
		  </tr>
		  <tr>
		    <td class="secRow" colspan="2">
				<textarea cols="100" id="warenoteid" name="sche.content" rows="6"><s:property value="sche.content" /></textarea>
		    </td>
		  </tr>  
		
		<tr>
		    <td colspan="20" class="buttonarea"><span id="message"><s:property value="message" /></span>
				<s:if test="null == sche && 'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="schedule_add" />
				</s:if>
				<s:elseif test="null != sche && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="schedule_save" />
					<s:submit id="delete" name="delete" value="删除" action="sche_del" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="sche_list" namespace="/sysebiz" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>

<script type="text/javascript">
var infoeditor01;
$(function(){
	infoeditor01 = new widget_textarea();
	infoeditor01.init("warenoteid");
});

$("#orderGoods_storage_date").datepicker();
</script>
</html>