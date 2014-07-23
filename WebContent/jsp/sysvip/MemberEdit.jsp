<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/ckeditor/ckeditor.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/ckfinder/ckfinder.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var default_dept_code = '${member.dept_code}';
var default_manager='${member.manager}';
$(function(){
	if(default_dept_code!='') {
		loadManagers(default_dept_code,default_manager);
	}
	//setStyle("table_address");
});
function copyval() {
	$(":input[name='memberAddress.con_name']").val($(":input[name='member.member_name']").val());
	$(":input[name='memberAddress.mobile']").val($(":input[name='member.mobile']").val());
}

var sobj01;
var selectDept = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_select_all_v02" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#userdept_codeid").val(val1);
		$("#userdept_nameid").val(val2);
		loadManagers(val1);
	};
	sobj01.create();
	sobj01.open();
};

function loadManagers(dept_code,p_manager) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#membermanagerid").clearAllOption();
		$("#membermanagerid").addOption("暂不分配","");
		var l = $(data).length;
		if(l==1) {
			$("#membermanagerid").addOption($(data)[0].user_name,$(data)[0].uuid);
			$("#membermanagerid").setSelectedValue($(data)[0].uuid);
		} else if(l>1) {
			$.each(data, function(i, n){
				$("#membermanagerid").addOption(n.user_name,n.uuid);
			});
			//alert(p_manager);
			if(typeof(p_manager) != "undefined" && p_manager!='') {
				$("#membermanagerid").setSelectedValue(p_manager);
			}			
		}
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}

function checkManager() {
	if($("#userdept_codeid").val()=="")
		return isOp("还没有分配部门,确定要提交吗?");
	else 
		return true;
}
</script>
<style type="text/css">
.address_input_area {}
.address_input_area select {width: 150px;}
.address_input_area input {width: 150px;}
.address_input_area textarea{width: 420px;height: 48px;}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1">
			<s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>会员信息
		</span>
		<span class="extra1">
			<a href="<s:url action="member_list" namespace="/sysvip" />" >会员列表</a>
		</span>	
	</div>
<s:form name="form1" action="member_add" namespace="/sysvip" onsubmit="return checkManager()&&validator(this)" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="'mdy'==viewFlag">
		  <tr>
		<td class='firstRow'><span style="color:red;">*</span> 会员号:</td>
		<td class='secRow'><s:property value="member.uuid" /><s:hidden name="member.uuid" title="会员号" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 登录密码:</td>
		<td class='secRow'><s:password name="member.passwords" title="登录密码" dataType="password" controlName="登录密码" confirm="passwords2" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 再次输入:</td>
		<td class='secRow'><s:password name="passwords2" title="再次输入" dataType="password" controlName="再次输入" /></td>
		</tr>
		</s:if>
		  
<tr>
<td class='firstRow'><span style="color:red;">*</span> 会员手机:</td>
<td class='secRow'><s:textfield name="member.mobile" title="会员手机" require="required" dataType="mobile" controlName="会员手机" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 手机验证:</td>
<td class='secRow'><s:radio name="member.is_mobile_check" title="手机验证"  list="#{0:'未验证',1:'已验证'}" value="1" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 会员名称:</td>
<td class='secRow'><s:textfield name="member.member_name" title="会员名称" require="required" dataLength="0,85" controlName="会员名称" /></td>
</tr>
<tr>
<td class='firstRow'>联系人姓名:</td>
<td class='secRow'>
	<s:textfield name="member.contact" title="联系人" />
	<span class="message_prompt">企业会员可以在此填写联系人</span>
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 会员分组:</td>
<td class='secRow'>
	<s:select name="member.user_type" title="会员级别" 
			headerKey="" headerValue="--请选择--" list="roles"
			listKey="uuid" listValue="role_name" />
</td>
</tr>
<tr>
<td class='firstRow'>会员帐号/登录别名:</td>
<td class='secRow'><s:textfield name="member.title" title="会员帐号/登录别名" dataLength="0,85" controlName="会员帐号/登录别名" /></td>
</tr>
<tr>
<td class='firstRow'>会员EMAIL:</td>
<td class='secRow'><s:textfield name="member.email" title="会员EMAIL" dataLength="0,85" controlName="会员EMAIL" dataType="email" /></td>
</tr>
<tr>
<td class='firstRow'>EMAIL验证:</td>
<td class='secRow'><s:radio name="member.is_email_check" title="EMAIL验证"  list="#{0:'未验证',1:'已验证'}" value="0" /></td>
</tr>
<s:if test="'add'==viewFlag">
<tr>
<td class='firstRow'><span style="color:red;">*</span> 客户归属/客户经理:</td>
<td class='secRow'>
所属部门:
<s:textfield title="部门" id="userdept_codeid" name="member.dept_code" readonly="true" />
<s:textfield title="部门名称" id="userdept_nameid" name="member.dept_name" readonly="true" />
<img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
<span id="ajax_member_message"></span><br />
客户经理:
<s:select id="membermanagerid" name="member.manager" list="#{}"
	headerKey="" headerValue="暂不分配"></s:select>
</td>
</tr>
</s:if>
<s:if test="'mdy'==viewFlag">
<tr>
<td class='firstRow'>客户归属/客户经理:</td>
<td class='secRow'>
所属部门:<s:property value="member.dept_name" /> 客户经理:<s:property value="member.manager_name" />
</tr>
<tr>
<td class='firstRow'>注册方式/时间:</td>
<td class='secRow'>
	<s:if test="0==member.reg_type">自行注册</s:if>
	<s:if test="1==member.reg_type">管理员添加</s:if>
	<s:if test="2==member.reg_type">批量导入</s:if>
	<s:date name="member.reg_time" format="yyyy-MM-dd HH:mm:ss" />
</td>
</tr>
<tr>
<td class='firstRow'>最后登录时间:</td>
<td class='secRow'><s:date name="member.last_login_time" format="yyyy-MM-dd HH:mm:ss" /></td>
</tr>
</s:if>

<s:if test="'add' == viewFlag">
<tbody class="address_input_area">
<tr><td class="titleRow" colspan="20">收货地址</td></tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span> 所在地区:</td>
<td class='secRow'>
<s:select id="memberAddress.province" name="memberAddress.province" title="省" list="#{}" require="required" controlName="所在地区"></s:select>
<s:select id="memberAddress.city" name="memberAddress.city" title="市" list="#{}"></s:select>
<s:select id="memberAddress.area" name="memberAddress.area" title="县" list="#{}"></s:select>
<script type="text/javascript">
	var sa = new SArea($("#memberAddress\\.province") ,$("#memberAddress\\.city"),$("#memberAddress\\.area"));
	sa.ajax_url = '<s:url value="/common_ajax/json_ajax" />';
	sa.init(toHTML.un('<s:property value="memberAddress.province" />'),toHTML.un('<s:property value="memberAddress.city" />'),toHTML.un('<s:property value="memberAddress.area" />'));
</script>
</td>
</tr>
<tr>
<td class='firstRow'>邮政编码:</td>
<td class='secRow'><s:textfield name="memberAddress.post" title="邮政编码" controlName="邮政编码" dataType="zipcode" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>街道地址:</td>
<td class='secRow'><s:textarea name="memberAddress.street" title="街道地址" controlName="街道地址" require="required" /></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>收货人姓名:</td>
<td class='secRow'>
	<s:textfield name="memberAddress.con_name" title="收货人姓名" controlName="收货人姓名" require="required" />
	[<a href="javascript:;" onclick="copyval();">复制会员姓名和手机</a>]	
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>联系号码:</td>
<td class='secRow'><s:textfield name="memberAddress.mobile" title="联系号码" controlName="联系号码" require="required" /></td>
</tr>
</tbody>
</s:if>
<s:if test="'mdy' == viewFlag">
<tr><td class="titleRow" colspan="20">
收货地址
[<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">add</s:param><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" >添加地址</a>]
</td></tr>
<td class='secRow' colspan="3" style="padding: 0px;margin: 0px 3px;">
<table class="ilisttable" id="table_address" width="100%" style="padding-top: 0px;margin-top: 0px;">
	<col width="30" />
	  <tr>
	    <th ><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
	    <th>所在地区</th>
		<th>邮编</th>
		<th>街道地址</th>
		<th>收货人姓名</th>
		<th>手机/联系电话</th>
		<th>默认地址</th>
		<th>操作</th>
	  </tr>
<s:iterator value="memberAddresses" status="sta">
	  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
	    <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	    
<td><s:property value="province" /> <s:property value="city" /> <s:property value="area" /></td>
<td><s:property value="post" /></td>
<td><s:property value="street" /></td>
<td><s:property value="con_name" /></td>
<td><s:property value="mobile" /></td>
<td align="center">
<s:url id="setDefault" namespace="/sysvip" action="memberAddress_default">
	<s:param name="memberAddress.uuid" value="uuid" />
	<s:param name="memberAddress.member_id" value="member.uuid" />
	<s:param name="memberAddress.defaultaddress">1</s:param>
</s:url>
<s:if test="0==defaultaddress"><a href="${setDefault}"><span class="noarea"></span></a></s:if>
<s:if test="1==defaultaddress"><span class="yesarea"></span></s:if>
</td>

		<td align="center">
	    	[<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">mdy</s:param><s:param name="memberAddress.uuid" value="uuid"></s:param></s:url>">修改</a>]
	    	[<a href="<s:url namespace="/sysvip" action="memberAddress_del"><s:param name="memberAddress.uuid" value="uuid" /><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" onclick="return isDel();">删除</a>]
	    </td>
	  </tr>
</s:iterator>
	</table>
</td>
</s:if>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="member_add" />
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="member_save" />
					<s:submit id="delete" name="delete" value="删除" action="member_del" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="member_list" namespace="/sysvip" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>