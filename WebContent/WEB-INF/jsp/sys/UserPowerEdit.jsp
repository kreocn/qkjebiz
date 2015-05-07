<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.input-a select{height:auto;}
.even{background:#fff;}
.checkbox{height: 18px;width: 18px;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url namespace="/sys" action="user_load"><s:param name="viewFlag">mdy</s:param><s:param name="user.uuid" value="userDept.user_id"></s:param></s:url>">返回编辑页面</a>
		</span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="user_dept_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="label_con">
	<s:if test="null != userDept && 'mdy' == viewFlag">
	<div class="label_main">
	       <div class="label_hang">
		         <div class="label_ltit">编号:</div>
		         <div class="label_rwb"><s:property value="userDept.uuid" /> <s:hidden id="userDept.uuid" name="userDept.uuid" /></div>
	       	</div>
	 </div>
	</s:if>
	
	<div class="label_main">
			<div class="label_hang">
		       <div class="label_ltit">用户编号:</div>
		       <div class="label_rwbenx"><s:textfield title="用户编号" name="userDept.user_id" /></div>
			</div>
			
	       <div class="label_hang">
		       <div class="label_ltit">职务:</div>
		       <div class="label_rwbenx"><s:select name="userDept.position" list="positions" listKey="uuid" listValue="position_name" headerKey="" headerValue="--请选择--" cssClass="validate[required]"/></div>
			</div>
			<div class="label_hang">
		       <div class="label_ltit">部门:</div>
		       <div class="label_rwben2">
		       		<span class="label_rwb">
					<s:textfield title="部门名称" id="userdept_nameid" name="userDept.dept_cname" readonly="true" />
					<s:hidden title="部门代码" id="userdept_codeid" name="userDept.dept_code" readonly="true" />
					</span>
					<span class="lb nw">
					<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
					</span>
		       </div>
			</div>
			<div class="label_hang">
		         <div class="label_ltit">部门权限:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb">
		         <input id="fatherSub" type="checkbox" name="userDept.depsubover" value="1"  class="checkbox"
		         <s:if test="%{userDept.depsubover==1}">checked="checked"</s:if>
		         />
		         </div>
		         </div>
	       	</div>
			<div class="label_hang">
		         <div class="label_ltit">子部门权限:</div>
		         <div class="label_rwben2">
		         <div class="label_rwb">
		         <input id="sonSub" type="checkbox" name="userDept.subover" value="1"  class="checkbox"
		         <s:if test="%{userDept.subover==1}">checked="checked"</s:if>
		         <s:if test="%{userDept.depsubover==0}"> style="display: none;"</s:if>
		         />
		         </div>
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
			 
	 </div>
	 </div>
	 
	 <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            	
            	<s:if test="'add' == viewFlag">
				<s:submit id="add" name="add" value="添加" action="user_dept_add" cssClass="input-blue"/>
				</s:if>
				<s:elseif test="null != userDept && 'mdy' == viewFlag">
				<s:submit id="save" name="save" value="保存" action="user_dept_save" cssClass="input-blue"/>
				<s:submit id="delete" name="delete" value="删除" action="user_dept_del" onclick="return isDel();" cssClass="input-red"/>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="user_load" namespace="/sys"><s:param name="viewFlag">mdy</s:param><s:param name="user.uuid" value="%{userDept.user_id}"></s:param></s:url>');" />
            </div>
		</div>
		</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
$(function(){
	$.fn.xhuploadinit();
	$("#marketimgid").xhupload();
	addTransferSelect("aroles","uroles");
});

$("#fatherSub").click(function(){
	if($("#fatherSub").is(':checked')) {
		document.getElementById("sonSub").style.display="block";
		document.getElementById("sonSub").value=1;
	}else{
		document.getElementById("sonSub").style.display="none";
		document.getElementById("sonSub").value=0;
	}
	
});


</script>
<script type="text/javascript" src="<s:url value="/js/optiontransferselect.js" />"></script>
</html>