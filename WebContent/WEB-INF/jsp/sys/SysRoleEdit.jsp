<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统角色列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<style type="text/css">
.qx_set tr{height:35px;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="main">
		<div class="dq_step">
			<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;<s:if test="null == role && 'add' == viewFlag">增加</s:if><s:elseif test="null != role && 'mdy' == viewFlag">修改</s:elseif>系统角色
			<span class="opb lb op-area"><a href="<s:url namespace="/sys" action="role_list"></s:url>">系统角色列表</a></span>
		</div>
		<s:form name="form1" cssClass="validForm" action="role_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_main"><b>系统角色权限列表:</b></div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200" style="background-color: #F0F0F0;" valign="top">
					<div id="dtree">
						<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
					</div>
				</td>
				<td width="10"></td>
				<td valign="top">
					<div class="label_main"><b>基本权限配置&nbsp;&gt;</b></div>
						<table width="50%" border="0" cellspacing="0" cellpadding="0" class="qx_set">
							<s:if test="null != role">
							<tr>
								<td width="12%" align="right"><b>角色ID:</b>&nbsp;</td>
								<td width="38%">${role_uuid}<s:hidden name="role.uuid" /></td>
							</tr>
							</s:if>
							<tr>
								<td width="12%" align="right"><b>角色名称:</b><s:hidden name="role.role_type" />&nbsp;</td>
								<td width="38%"><s:textfield title="角色名称" name="role.role_name" cssClass="validate[required]" /></td>
							</tr>
							<tr>
								<td align="right"><b>角色描述:</b>&nbsp;</td>
								<td><s:textfield title="角色描述" name="role.descriptions" /></td>
							</tr>
							<s:if test="null != role">
							<tr>
								<td align="right"><b>修改人:</b>&nbsp;</td>
								<td>${role.lm_user}<s:hidden name="role.lm_user" /></td>
							</tr>
							<tr>
								<td align="right"><b>修改时间:</b>&nbsp;</td>
								<td>${it:formatDate(role.lm_time,'yyyy-MM-dd  HH:mm:ss')}</td>
							</tr>
							</s:if>
							<tr>
								<td colspan="2"><b>特殊权限配置&nbsp;&gt;</b></td>
							</tr>
							<s:property value="specialPrivilegeHtml" escape="false" />
							<tr>
								<td align="right"><b>相关操作:</b>&nbsp;</td>
								<td class="op-area">
									<s:if test="null == role && 'add' == viewFlag">
										<s:submit id="add" name="add" value="增加" action="role_add" cssClass="input-blue"/>
									</s:if>
									<s:elseif test="null != role && 'mdy' == viewFlag">
										<s:submit id="save" name="save" value="保存" action="role_save" cssClass="input-blue"/>
										<!-- <input type="button" value="细项编辑" onclick="createRolePrvgModelDiv();" /> -->
										<s:submit id="delete" name="delete" value="删除" action="role_del" onclick="return isDel();" cssClass="input-red"/>
									</s:elseif>
									<input class="input-gray" type="button" value="返回" onclick="window.location.href = '<s:url action="role_list" namespace="/sys" />';" />
									<span id="message"><s:property value="message" /></span>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</s:form>
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div_Imp.js" />"></script>
<script type="text/javascript">
	var checkedStr = '';
	var divID =document.getElementById("dtree");  
	d = new dTree('d');
	d.config.check = 1;
	d.config.useIcons = false;
	//d.config.extra_radio_type01 = true;
	d.icon = {
			root		: '<s:url value="/include/dtree/" />'+'img/globe.gif',
			folder		: '<s:url value="/include/dtree/" />'+'img/folder.gif',
			folderOpen	: '<s:url value="/include/dtree/" />'+'img/folderopen.gif',
			node		: '<s:url value="/include/dtree/" />'+'img/page.gif',
			empty		: '<s:url value="/include/dtree/" />'+'img/empty.gif',
			line		: '<s:url value="/include/dtree/" />'+'img/line.gif',
			join		: '<s:url value="/include/dtree/" />'+'img/join.gif',
			joinBottom	: '<s:url value="/include/dtree/" />'+'img/joinbottom.gif',
			plus		: '<s:url value="/include/dtree/" />'+'img/plus.gif',
			plusBottom	: '<s:url value="/include/dtree/" />'+'img/plusbottom.gif',
			minus		: '<s:url value="/include/dtree/" />'+'img/minus.gif',
			minusBottom	: '<s:url value="/include/dtree/" />'+'img/minusbottom.gif',
			nlPlus		: '<s:url value="/include/dtree/" />'+'img/nolines_plus.gif',
			nlMinus		: '<s:url value="/include/dtree/" />'+'img/nolines_minus.gif'
	};
	d.add(0,-1,'用户权限列表');		
	/*<s:iterator value="rolePrvgs">*/
	d.add('<s:property value="privilege_id" />','<s:property value="parent_privilege" />','<s:property value="privilege_name" />','javascript:void(0);');
	/*<s:if test="null != role_id">*/
	checkedStr += '<s:property value="privilege_id" />' + ',';
	/*</s:if>*/
	/*</s:iterator>*/
	checkedStr = checkedStr.substring(0,checkedStr.length-1);
	d.setCheck(checkedStr);
	divID.innerHTML = d;
</script>
</body>
</html>