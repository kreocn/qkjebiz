<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.input-a select{height:auto;}
.even{background:#fff;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;<s:if test="null == user && 'add' == viewFlag">增加</s:if><s:elseif test="null != user && 'mdy' == viewFlag">修改</s:elseif>管理员
			<span class="opb lb op-area"><a href="<s:url namespace="/sys" action="user_list"></s:url>" >管理员列表</a></span>
		</div>
		<s:form id="formEdit" name="form1" cssClass="validForm" action="user_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
			<s:if test="null != user">
			<div class="label_hang">
		       <div class="label_ltit">用户ID:</div>
		       <div class="label_rwben">${user.uuid}<s:hidden name="user.uuid" /></div>
			</div>
			</s:if>
			<div class="label_hang clear">
		       <div class="label_ltit">用户名:</div>
		       <div class="label_rwben"><input type="text" title="用户名" id="user.title" name="user.title" class="validate[required]" value="${user.title}" <s:if test="null != user && 'mdy' == viewFlag">readonly</s:if>  /></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">姓名:</div>
		       <div class="label_rwben"><s:textfield id="user.user_name" name="user.user_name" title="姓名" cssClass="validate[required]" /></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">性别:</div>
		       <div class="label_rwbenx"><s:radio name="user.sex" list="#{0:'保密',1:'男',2:'女'}" /></div>
			</div>
			<div class="label_hang clear">
		       <div class="label_ltit">电话:</div>
		       <div class="label_rwben"><s:textfield id="user.phone" title="电话" name="user.phone" /></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">移动电话:</div>
		       <div class="label_rwben"><s:textfield id="user.mobile" title="移动电话" name="user.mobile" cssClass="validate[custom[integer]]"/></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">电子邮件:</div>
		       <div class="label_rwbenx"><s:textfield id="user.email" title="电子邮件" name="user.email" /></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">职务:</div>
		       <div class="label_rwbenx"><s:select name="user.position" list="positions" listKey="uuid" listValue="position_name" headerKey="" headerValue="--请选择--" cssClass="validate[required]"/></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">部门:</div>
		       <div class="label_rwben2">
		       		<span class="label_rwb">
					<s:textfield title="部门名称" id="userdept_nameid" name="user.dept_cname" readonly="true" />
					<s:hidden title="部门代码" id="userdept_codeid" name="user.dept_code" readonly="true" />
					</span>
					<span class="lb nw">
					<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
					</span>
		       </div>
			</div>
			<div class="label_hang clear">
		       <div class="label_ltit">用户角色:</div>
		       <div class="label_rwbenx">
		       		<s:optiontransferselect            
				     label="用户角色"
				     name="aroles" 
				     leftTitle="未赋予的角色"
				     rightTitle="已经赋予的角色"
				     list="roles" 
				     multiple="true"
				     listKey="uuid"
				     listValue="role_name"
				     headerKey=""
				     headerValue="-- 请选择 --"
				     doubleName="uroles"
				     doubleList="userRoles" 
				     doubleListKey="uuid"
				     doubleListValue="role_name"
				     doubleHeaderKey=""
				     doubleHeaderValue="-- 请选择 --" 
				     doubleMultiple="true"
				     allowUpDownOnLeft="false"
				     allowUpDownOnRight="false"
				     allowAddAllToRight="false"
				     allowSelectAll="false" />
		       </div>
			</div>
			<div class="label_hang clear">
		       <div class="label_ltit">其他描述:</div>
		       <div class="label_rwben"><s:textarea title="其他描述" id="user.descriptions" name="user.descriptions"  cssClass="label_hang_linput"/></div>
			</div>
			<div class="label_hang clear">
		       <div class="label_ltit">文件系统角色:</div>
		       <div class="label_rwbenx"><s:select id="user.filesystem_root" name="user.filesystem_root" headerKey="" headerValue="--请选择--"	list="#{'ck_user':'普通角色','ck_news':'新闻/信息发布者','ck_manager':'管理员','ck_admin':'超级管理员'}" /> </div>
		       <div class="label_rwbenx"><span class="message_prompt" style="padding-left:10px;">当用户既是普通角色,也是新闻/信息发布者时,应当选择管理员角色</span></div>
			</div>
			<div class="label_hang clear">
		       <div class="label_ltit">账户状态:</div>
		       <div class="label_rwbenx"><s:radio name="user.status" list="#{0:'初始',1:'正常',2:'冻结'}" /></div>
			</div>
			<s:if test="null == user && 'add' == viewFlag">
			<div class="label_hang clear">
		       <div class="label_ltit">密码:</div>
		       <div class="label_rwben"><s:password title="密码" name="passwords2" cssClass="validate[required]"/></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">再输一次密码:</div>
		       <div class="label_rwben"><s:password title="再输一次的密码" name="user.passwords"  confirm="passwords2" /></div>
			</div>
			</s:if>
			<s:if test="null != user">	
			<div class="label_hang clear">
		       <div class="label_ltit">修改人:</div>
		       <div class="label_rwben">${user.lm_user}<s:hidden name="user.lm_user" /></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">修改时间:</div>
		       <div class="label_rwbenx">${it:formatDate(user.lm_time,'yyyy-MM-dd HH:mm:ss')}</div>
			</div>
			</s:if>
			<div class="label_hang clear">
		       <div class="label_ltit">相关操作:</div>
		       <div class="label_rwbenx">
		       		<s:if test="null == user && 'add' == viewFlag">
						<s:submit id="add" name="add" value="增加" action="user_add"  cssClass="input-blue"/>
					</s:if>
					<s:elseif test="null != user && 'mdy' == viewFlag">
						<s:submit id="save" name="save" value="保存" action="user_save" cssClass="input-blue"/>
						<s:submit id="delete" name="delete" value="删除" action="user_del" onclick="return isDel();" cssClass="input-red"/>
					</s:elseif>
					<input type="button" value="返回" onclick="linkurl('<s:url action="user_list" namespace="/sys" />');"  class="input-gray"/>
					<input type="button" value="修改密码"  onclick="changePWD();" class="input-yellow"/>
					<span id="message"><s:property value="message" /></span>
		       </div>
			</div>
		</s:form>
	</div>
</div>
<div id="changePWDdiv" style="display: none;" title="修改密码">
	<s:form name="form2" cssClass="validForm" action="user_change" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
		<table class="ilisttable" width="100%" >
		  <tr>
		    <td width="25%" align="right">角色ID:</td>
		    <td>${user.uuid}<s:hidden id="user.uuid" name="user.uuid" /><s:hidden name="viewFlag" value="mdy" /></td>	
		  </tr>
		  <tr>
		    <td align="right">用户名:</td>
		    <td>${user.title}<s:hidden id="user.title" name="user.title" /></td>
		  </tr>
		  <tr>
		    <td align="right">新密码:</td>
		    <td><s:password title="新密码" name="new_passwords" cssClass="validate[required]" /></td>
		  </tr>
		  <tr>
		    <td align="right">再输一次:</td>
		    <td><s:password title="再输一次的密码" name="new_passwords2" confirm="new_passwords" /></td>
		  </tr>
		  <tr>
		  	<td>&nbsp;</td>
			<td class="buttonarea">
				<s:submit value="确定" />
				<input type="button" value="返回" onclick="closemDiv();" />
			</td>	    
		  </tr>
		</table>
	</s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/optiontransferselect.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#changePWDdiv").dialog({
	      autoOpen: false,
	      width: 420,
	      height: 220,
	      modal: true
	});
	addTransferSelect("aroles","uroles");
});
function changePWD() {	
	$("#changePWDdiv").dialog("open");
}
function checkPWD2(obj) {
	if (obj.passwords.value!=obj.passwords2.value) {
		alert("两次密码输入不一致,请重新检查!");
		obj.passwords.focus();
	} else {
		return true;
	}
	return false;
}
function checkPWD(obj) {
	if (obj.new_passwords.value!=obj.new_passwords2.value) {
		alert("两次密码输入不一致,请重新检查!");
		obj.new_passwords.focus();
	} else {
		return true;
	}
	return false;
}
function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('message').innerHTML = str;
}
</script>
</body>
</html>