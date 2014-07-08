<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/optiontransferselect.js" />"></script>
<script type="text/javascript">
var md;
var ___change_pwd_html_value;	//由于赋值了form,导致form_name重复而不能使用框架的checkFormx,所以要建立变量保存HTML
var ___select_dept_html_value;
//selectRolesDiv
window.onload = function() {
	___change_pwd_html_value = $('#changePWDdiv').html();
	$('#changePWDdiv').empty();	
	___select_dept_html_value = $('#selectDeptDiv').html();
	$('#selectDeptDiv').empty();
};
function changePWD() {	
	md = new modelDiv();
	md.setTitle_HTML("");
	md.setBottom_HTML("");
	md.createModelDivByContent(580,260,___change_pwd_html_value);	
}
function selectDept() {	
	md = new modelDiv();
	md.setTitle_HTML("");
	md.setBottom_HTML("");
	md.createModelDivByContent(220,400,___select_dept_html_value);	
}

function closemDiv() {
	md.dropModelDiv();
}
function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('message').innerHTML = str;
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == user && 'add' == viewFlag">增加</s:if><s:elseif test="null != user && 'mdy' == viewFlag">修改</s:elseif>用户</div>
<s:form name="form1" action="user_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != user">	
		  <tr>
		    <td class="firstRow">用户ID:</td>
		    <td colspan="3" class="secRow"><s:property value="user.uuid" />
			<s:hidden id="user.uuid" name="user.uuid" /></td>	
		  </tr>
		</s:if>
		  <tr>
		    <td class="firstRow">用户名:</td>
		    <td class="secRow" colspan="3">
<input type="text" title="用户名" id="user.title" name="user.title" require="required" controlName="用户名" value="<s:property value="user.title" />" <s:if test="null != user && 'mdy' == viewFlag">readonly</s:if>  />
			</td>			
		  </tr>
		  <tr>
		    <td class="firstRow">姓名:</td>
		    <td class="secRow"><s:textfield id="user.user_name" name="user.user_name" title="姓名" require="required" controlName="姓名" /></td>
			<td class="firstRow">性别:</td>
			<td class="secRow"><s:radio name="user.sex" list="#{0:'保密',1:'男',2:'女'}" /></td>
		  </tr>
		  <tr>
		    <td class="firstRow">电话:</td>
		    <td class="secRow"><s:textfield id="user.phone" title="电话" name="user.phone" controlName="电话" dataType="phone" /></td>
			<td class="firstRow">移动电话:</td>
			<td class="secRow"><s:textfield id="user.mobile" title="移动电话" name="user.mobile" controlName="移动电话" dataType="mobile" /></td>
		  </tr>
		  <tr>
		    <td class="firstRow">电子邮件:</td>
		    <td class="secRow"><s:textfield id="user.email" title="电子邮件" name="user.email" controlName="电子邮件" dataType="email" /></td>
			<td class="firstRow">职务:</td>
		    <td class="secRow">
		    	<s:select name="user.position" list="positions"
			    	  listKey="uuid" listValue="position_name"
			    	  headerKey="" headerValue="--请选择--"
			    	  require="required" controlName="职务" />
		    </td>
		  </tr>
		  <!--
		  <tr>
		    <td class="firstRow">汇报对象:</td>
			<td class="secRow"><s:textfield id="user.senior" title="职务" name="user.senior" /></td>
			<td class="firstRow">职务说明:</td>
			<td class="secRow"><s:textfield id="user.position_note" title="职务属性" name="user.position_note" /></td>
		  </tr>
		    -->
		  <tr>
		    <td class="firstRow">部门:</td>
		    <td class="secRow" colspan="3">
		    <s:textfield title="部门代码" id="user.dept_code" name="user.dept_code" require="required" controlName="部门代码" readonly="true" />
			<s:textfield title="部门名称" id="user.dept_cname" name="user.dept_cname" require="required" controlName="部门名称" readonly="true" />
			<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
			</td>			
		  </tr>
		  <tr>
		    <td class="firstRow">用户角色:</td>
		    <td class="secRow" colspan="3">
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
			<script type="text/javascript">
			addTransferSelect("aroles","uroles");
			</script>
		    </td>			
		  </tr>
		  <tr>
		    <td class="firstRow">其他描述:</td>
		    <td class="secRow" colspan="3">			
			<s:textarea title="其他描述" id="user.descriptions" name="user.descriptions" cssStyle="width: 400px" />
			</td>			
		  </tr>
		  <tr>
		  	<td class="firstRow">文件系统角色:</td>
			<td class="secRow">
				<s:select id="user.filesystem_root" name="user.filesystem_root"
					headerKey="" headerValue="--请选择--"
					list="#{'ck_user':'普通角色','ck_news':'新闻/信息发布者','ck_manager':'管理员','ck_admin':'超级管理员'}" />
				<br />
				<span class="message_prompt">当用户既是普通角色,也是新闻/信息发布者时,应当选择管理员角色</span>
			</td>
			<td class="firstRow">帐户状态:</td>
			<td class="secRow"><s:radio name="user.status" list="#{0:'初始',1:'正常',2:'冻结'}" /></td>
		  </tr>
		<s:if test="null == user && 'add' == viewFlag">
		  <tr>
		    <td class="firstRow">密码:</td>
		    <td class="secRow"><s:password title="密码" name="passwords2" require="required" dataType="password" controlName="密码" /></td>
		    <td class="firstRow">再输一次密码:</td>
		    <td class="secRow"><s:password title="再输一次的密码" name="user.passwords" controlName="密码确认" confirm="passwords2" /></td>
		  </tr>
		</s:if>
		<s:if test="null != user">	
		  <tr>
		    <td class="firstRow">修改人:</td>
		    <td class="secRow"><s:property value="user.lm_user" />
						<s:hidden name="user.lm_user" /></td>
		    <td class="firstRow">修改时间:</td>
		    <td class="secRow"><s:date name="user.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>
		</s:if>
		<tr>
		    <td colspan="4" class="buttonarea"><span id="message"><s:property value="message" /></span>
				<s:if test="null == user && 'add' == viewFlag">
					<s:submit id="add" name="add" value="增加" action="user_add" />
				</s:if>
				<s:elseif test="null != user && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="user_save" />
					<s:submit id="delete" name="delete" value="删除" action="user_del" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="user_list" namespace="/sys" />');" />
				<input type="button" value="修改密码" onclick="changePWD();" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
<div id="changePWDdiv" style="display: none;">
<s:form name="form2" action="user_change" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
<div class="itablemdy">
<div class="itabletitle">修改密码</div>
<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
  <tr>
    <td class="firstRow">角色ID:</td>
    <td class="secRow"><s:property value="user.uuid" />
			<s:hidden id="user.uuid" name="user.uuid" />
			<s:hidden name="viewFlag" value="mdy" />
	</td>
  </tr>
  <tr>
    <td class="firstRow">用户名:</td>
    <td class="secRow"><s:property value="user.title" />
			<s:hidden id="user.title" name="user.title" /></td>	
  </tr>
  <tr>
    <td class="firstRow">新密码:</td>
    <td class="secRow"><s:password id="new_passwords" title="新密码" name="new_passwords" require="required" dataType="password" controlName="新密码" /></td>
  </tr>
  <tr>
    <td class="firstRow">再输一次:</td>
    <td class="secRow"><s:password id="new_passwords2" title="再输一次的密码" name="new_passwords2" controlName="密码确认" confirm="new_passwords" /></td>
  </tr>
  <tr>
	<td colspan="2" class="buttonarea">
		<s:submit value="确定" />
		<input type="button" value="返回" onclick="closemDiv();" />
	</td>	    
  </tr>
</table>
</div>
</s:form>
</div>
<div id="selectDeptDiv" style="display: none;">
<div class="dtree2" style="overflow: scroll; height: 400px;">
	<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
	<script type="text/javascript">
		d = new dTree('d');
		d.config.check = 2;
		d.config.useIcons = false;
		d.config.isAddNoRootNode = true;
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
		d.add('0','-1','部门列表');
		<s:iterator value="depts">
		d.add('<s:property value="dept_code" />','<s:property value="parent_dept" />','<s:property value="dept_cname" />',"javascript:void(0);",'<s:property value="dept_cname" />');
		</s:iterator>
		d.add();
		document.write(d);
		function setCheckValue() {
			var deptInfo = getCheckBox("cd");
			if(null==deptInfo||""==deptInfo) {
				if(window.confirm("没有选择任何部门,是否确认?")) {
					closemDiv();
				}
			} else {
				$('#user\\.dept_code').val(deptInfo[1]);
				$('#user\\.dept_cname').val(deptInfo[2]);
				closemDiv();
			}
		}
	</script>
</div>
<div class="dtreebutton"><input type="button" value="确定" onclick="setCheckValue();" /> <input type="button" value="返回" onclick="closemDiv();" /></div>
</div>
</body>
</html>