<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/words_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/div.js" />"></script>
<script type="text/javascript">
var md;
var ___change_pwd_html_value;	//由于赋值了form,导致form_name重复而不能使用框架的checkFormx,所以要建立变量保存HTML
function changePWD() {	
	md = new modelDiv();
	md.setTitle_HTML("");
	md.setBottom_HTML("");
	md.createModelDivByContent(580,260,___change_pwd_html_value);	
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

$(function(){
	$("#user\\.title").focusout(function() {checkMember("title_check");});	
	$("#user\\.mobile").focusout(function() {checkMember("mobile_check");});	
	$("#user\\.email").focusout(function() {checkMember("email_check");});
});

var checkMember = function(viewFlag) {
	var params,checkValue,showid,type;
	var empty_check = false;
	if("title_check" == viewFlag) {
		showid = "title_warn";
		checkValue = $("#user\\.title").val();
		params = "user.title="+checkValue+"&viewFlag=" + viewFlag;
		type = "english";
		empty_check = true;
	} else if("mobile_check" == viewFlag) {
		showid = "mobile_warn";
		checkValue = $("#user\\.mobile").val();
		params = "user.mobile="+checkValue+"&viewFlag=" + viewFlag;
		type = "mobile";
		empty_check = true;
	} else if("email_check" == viewFlag) {
		checkValue = $("#user\\.email").val();
		params = "user.email="+checkValue+"&viewFlag=" + viewFlag;
		showid = "email_warn";
		type = "email";
		empty_check = false;
	} else {
		checkValue = "";
		params = "";
		showid = "";
		type="";
	}
	
	if(localCheck(checkValue,type,showid,empty_check)) {
		$.ajax({
			type: "POST",
			url: '<s:url namespace="/sys" action="member_check" />',
			data: params,
			beforeSend : function() {
				$("#"+showid).attr("class", "warn_area_load");
			},
			success: function(msg){
				var m = parseInt(msg);
				if(m==0) {
					$("#"+showid).attr("class", "warn_area_success");
					$("#"+showid+" .warn_area_info").empty();
				} else if(m>0) {
					$("#"+showid).attr("class", "warn_area_fail");
					$("#"+showid+" .warn_area_info").text("已经重复");
				}
			}
		});
	}
};

var localCheck = function(checkValue,type,showid,empty_check) {
	if(checkValue==null ||checkValue=='') {
		if(empty_check) {
			$("#"+showid).attr("class", "warn_area_fail");
			$("#"+showid+" .warn_area_info").text("不能为空!");
		}
		return false;
	} else {
		if(words_validator(checkValue,type)) {
			$("#"+showid).attr("class", "warn_area_success");
			$("#"+showid+" .warn_area_info").empty();
			return true;
		} else {
			$("#"+showid).attr("class", "warn_area_fail");
			$("#"+showid+" .warn_area_info").text("这不是有效的格式");
			return false;
		}
	}	
	return true;
};

var setclass = function() {
	//alert($("#title_warn").attr("class"));
	var oclass = $("#title_warn").attr("class");
	if(oclass=="warn_area_fail") {
		$("#title_warn").attr("class", "warn_area_success");
	} else {
		$("#title_warn").attr("class", "warn_area_fail");
	}
}
</script>
<style type="text/css">
.warn_area {height: 16px;display: inline-block;}
.warn_area_img {display: inline-block;height: 16px;width: 16px;}
.warn_area_info {display: inline-block;color: red;}
.warn_area_success {display: inline-block;height: 16px;}
.warn_area_success .warn_area_img {background: url('<s:url value="/images/icon/ico_warn.png" />')  no-repeat 0 0;}
.warn_area_success .warn_area_info {color: #E1E1E1;}
.warn_area_fail {display: inline-block;height: 16px;}
.warn_area_fail  .warn_area_img {background: url('<s:url value="/images/icon/ico_warn.png" />')  no-repeat 0 -50px;}
.warn_area_fail .warn_area_info {color: red;}
.warn_area_load {display: inline-block;height: 16px;}
.warn_area_load .warn_area_img {background: url('<s:url value="/images/loading/loading16x16_01.gif" />')  no-repeat;}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle"><s:if test="null == user && 'add' == viewFlag">添加</s:if><s:elseif test="null != user && 'mdy' == viewFlag">修改</s:elseif>会员</div>
<s:form name="form1" action="user_add" namespace="/sys" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<s:hidden id="user.uuid" name="user.uuid" />
	<table class="ilisttable" width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor="#8B8B8B">
		<s:if test="null != user && 'mdy' == viewFlag">
		  <tr>
		    <td class="firstRow">会员帐号:</td>
		    <td class="secRow">
		    <s:property value="user.title" />
		    <s:hidden name="user.title" />		    
			</td>
		  </tr>
		 </s:if>
		 <s:elseif test="'add' == viewFlag">
		 <tr>
		    <td class="firstRow">会员号:</td>
		    <td class="secRow">
				<input type="text" title="用户名" id="user.title" name="user.title" 
						require="required" controlName="用户名" value="<s:property value="user.title" />"   />
				<span id="title_warn" class="warn_area">
					<span class="warn_area_img" ></span>
		    		<span class="warn_area_info" ></span>
				</span>
			</td>
		  </tr>
		 </s:elseif>
		 
		 <s:if test="null == user && 'add' == viewFlag">
		  <tr>
		    <td class="firstRow">密码:</td>
		    <td class="secRow">
		    	<s:password title="密码" name="passwords2" require="required" dataType="password" controlName="密码" />
		    	<span id="passwords2_warn" class="warn_area">
					<span class="warn_area_img" ></span>
		    		<span class="warn_area_info" >*</span>
				</span>
		    </td>
		  </tr>
		  <tr>
		    <td class="firstRow">再输一次密码:</td>
		    <td class="secRow">
		    	<s:password title="再输一次的密码" name="user.passwords" controlName="密码确认" confirm="passwords2" />
		    	<span id="passwords_warn" class="warn_area">
					<span class="warn_area_img" ></span>
		    		<span class="warn_area_info" >*</span>
				</span>
		    </td>
		  </tr>
		</s:if>
		 
		  <tr>
		    <td class="firstRow">姓名:</td>
		    <td class="secRow">
		    	<s:textfield id="user.user_name" name="user.user_name" title="姓名" require="required" controlName="姓名" />
		    	<span id="user_name_warn" class="warn_area">
					<span class="warn_area_img" ></span>
		    		<span class="warn_area_info" >*</span>
				</span>
		    </td>
		 </tr>
		 <tr>
			<td class="firstRow">移动电话:</td>
			<td class="secRow">
				<s:textfield id="user.mobile" title="移动电话" name="user.mobile" require="required" controlName="移动电话" dataType="mobile" />
				<span id="mobile_warn" class="warn_area">
					<span class="warn_area_img" ></span>
		    		<span class="warn_area_info" >*</span>
				</span>
			</td>
		  </tr>
		  <tr>	
		 	<td class="firstRow">电子邮件:</td>
		    <td class="secRow">
		    	<s:textfield id="user.email" title="电子邮件" name="user.email" controlName="电子邮件" dataType="email" />
		    	<span id="email_warn" class="warn_area">
		    		<span class="warn_area_img" ></span>
		    		<span class="warn_area_info" ></span>
		    	</span>
		    </td>
		 </tr>
		  <tr>	
			<td class="firstRow">性别:</td>
			<td class="secRow"><s:radio name="user.sex" list="#{0:'保密',1:'男',2:'女'}" /></td>
		  </tr>
		  <tr>
		    <td class="firstRow">会员等级:</td>
		    <td class="secRow">
		    <s:select title="会员等级" id="user.user_type" 
		    	name="user.user_type" 
		    	list="roles"
		    	listKey="uuid" 
		    	listValue="role_name"  
		    	require="required" controlName="用户等级" />
            	<span id="user_roles_warn" class="warn_area">
					<span class="warn_area_img" ></span>
		    		<span class="warn_area_info" >*</span>
				</span>
		    </td>			
		  </tr>
		  <tr>
		    <td class="firstRow">其他描述:</td>
		    <td class="secRow">			
			<s:textarea title="其他描述" id="user.descriptions" name="user.descriptions" cssStyle="width: 400px" />
			</td>			
		  </tr>
		<s:if test="null != user">	
		  <tr>
		    <td class="firstRow">修改人:</td>
		    <td class="secRow"><s:property value="user.lm_user" />
						<s:hidden name="user.lm_user" /></td>
		 </tr>
		  <tr>
		    <td class="firstRow">修改时间:</td>
		    <td class="secRow"><s:date name="user.lm_time" format="yyyy-MM-dd HH:mm:ss" /></td>
		  </tr>
		</s:if>
		<tr>
		    <td colspan="20" class="buttonarea"><span id="message"><s:property value="message" /></span>
				<s:if test="null == user && 'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="member_addsave" />
				</s:if>
				<s:elseif test="null != user && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="确定" action="member_addsave" />
					<s:submit id="delete" name="delete" value="删除" action="user_del" onclick="return isDel();" />
					<input type="button" value="修改密码" onclick="changePWD();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="member_list" namespace="/sys" />');" />
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
</body>
</html>