<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>留言交流管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == info && 'add' == viewFlag">增加</s:if><s:elseif test="null != info && 'mdy' == viewFlag">修改</s:elseif>留言交流</span>
		<span class="extra1">
			<a href="<s:url action="info_list" namespace="/sysvip" />" >留言交流列表</a>
		</span>	
	</div>
<s:form name="form1" action="info_add" namespace="/sysvip" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != info">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
<td class='secRow'><s:property value="info.uuid" /><s:hidden name="info.uuid" title="主键ID" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 信息种类:</td>
<td class='secRow'><s:property value="info.type" /><s:hidden name="info.type" title="信息种类" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 信息类型:</td>
<td class='secRow'><s:property value="info.itype" /><s:hidden name="info.itype" title="信息类型" /></td>
</tr>
<tr>
<td class='firstRow'>主UUID:</td>
<td class='secRow'><s:property value="info.reuuid" /><s:hidden name="info.reuuid" title="主UUID" /></td>
</tr>
<tr>
<td class='firstRow'>私信的接收人:</td>
<td class='secRow'><s:property value="info.tomember" /><s:hidden name="info.tomember" title="私信的接收人" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加IP:</td>
<td class='secRow'><s:property value="info.add_ip" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加人:</td>
<td class='secRow'><s:property value="info.add_member" /></td>
</tr>
<tr>
<td class='firstRow'>修改时间:</td>
<td class='secRow'><s:date name="info.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
<tr>
<td class='firstRow'>修改IP:</td>
<td class='secRow'><s:property value="info.lm_ip" /></td>
</tr>
<tr>
<td class='firstRow'>修改人:</td>
<td class='secRow'><s:property value="info.lm_member" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'>交流分类:</td>
<td class='secRow'><s:select name="info.imode" title="交流分类" headerKey="" headerValue="--请选择--" list="#{'TIPS':'普通','SALES':'买卖','QA':'询问'}" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 标题:</td>
<td class='secRow'><s:textfield name="info.title" title="标题" require="required" dataLength="0,85" controlName="标题" /></td>
</tr>
<tr>
<td class='firstRow'>信息内容:</td>
<td class='secRow'><s:textfield name="info.content" title="信息内容" dataLength="0,21845" controlName="信息内容" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 审核状态:</td>
<td class='secRow'></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 删除标记:</td>
<td class='secRow'></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 添加时间:</td>
<td class='secRow'><s:textfield name="info.add_time" title="添加时间" require="required" value="%{getText('global.date',{info.add_time})=='null'?'':getText('global.date',{info.add_time})}" onclick="new Calendar().show(this);"  readonly="true" dataType="date" controlName="添加时间" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == info && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_ADD')">
					<s:submit id="add" name="add" value="确定" action="info_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != info && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_MDY')">
					<s:submit id="save" name="save" value="保存" action="info_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('VIP_SYSVIP_INFO_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="info_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="info_list" namespace="/sysvip" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>