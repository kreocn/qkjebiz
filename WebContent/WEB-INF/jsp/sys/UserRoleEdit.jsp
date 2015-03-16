<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员组列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
</head>
<style type="text/css">
.specialprivilege_title {font-weight: bold;}
.specialprivilege_list {display: inline-block;}
</style>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == role && 'add' == viewFlag">增加</s:if><s:elseif test="null != role && 'mdy' == viewFlag">修改</s:elseif>会员组</div>
<s:form name="form1" action="role_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
	<colGroup width="50%"></colGroup>
	<colGroup width="50%"></colGroup>
		<tr valign="top">			
			<td>
				<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
				<colGroup width="30%" valign="top" align="right" style="font-weight: bold;"></colGroup>
				<colGroup width="70%" valign="top"></colGroup>
				<tr>
				    <td>会员组权限列表:</td>
				    <td>
<div id="dtree" class="dtree2" style="width:100%; overflow: scroll; height: 500px;">
	<!-- <p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p> -->
	<script type="text/javascript">
		var checkedStr = '';
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
		document.write(d);
	</script>
</div>
					</td>					 
				</tr>
				</table>
			</td>
			
			<td>
			  <table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
				<colGroup width="30%" align="right" style="font-weight: bold;"></colGroup>
				<colGroup width="70%"></colGroup>
				<tr>
					<td class="title2" colspan="2">基本权限配置</td>
				</tr>
				<s:if test="null != role">
				  <tr>
				    <td>会员组ID:</td>
				    <td colspan="3"><s:property value="role.uuid" /><s:hidden name="role.uuid" />
					</td>
				  </tr>
				</s:if>
				  <tr>
				    <td>会员组名称:<s:hidden name="role.role_type" /></td>
				    <td><s:textfield title="会员组名称" name="role.role_name" require="required" controlName="会员组名称" /> <span style="color:red;">*</span></td>
				  </tr>
				  <tr>
				    <td>会员组等级:</td>
				    <td>
				    <s:textfield title="会员组等级" name="role.role_rank" require="required" controlName="会员组等级" /> <span style="color:red;">*</span>
				    </td>
				  </tr>
				  <tr>
				    <td>会员组描述:</td>
				    <td><s:textfield title="会员组描述" name="role.descriptions" /></td>
				  </tr>
				<s:if test="null != role">	
				  <tr>
				    <td>修改人:</td>
				    <td><s:property value="role.lm_user" />
						<s:hidden name="role.lm_user" /></td>
				  </tr>
				  <tr>
				    <td>修改时间:</td>
				    <td><s:date name="role.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
				  </tr>
				</s:if>
				<tr>
					<td class="title2" colspan="2">特殊权限配置</td>
				</tr>
				
				<s:property value="specialPrivilegeHtml" escape="false" />

			  </table>
			</td>
		</tr>
		<tr>
	    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
			<s:if test="null == role && 'add' == viewFlag">
				<s:submit id="add" name="add" value="确定增加" action="role_addsave" />
			</s:if>
			<s:elseif test="null != role && 'mdy' == viewFlag">
				<s:submit id="save" name="save" value="确定保存" action="role_mdysave" />
				<s:submit id="delete" name="delete" value="删除会员组" action="role_del" onclick="return isDel();" />
			</s:elseif>
			<input type="button" value="返回" onclick="window.location.href = '<s:url action="userrole_list" namespace="/sys" />';" />
		</td>    
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div_Imp.js" />"></script>
</body>
</html>