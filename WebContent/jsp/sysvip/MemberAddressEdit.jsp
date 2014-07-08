<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员收货地址管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_lite.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript">
$(function(){
	var add_member_name = toHTML.un('<s:property value="member.member_name" />');	
	var add_member_mobile = '<s:property value="member.mobile" />';
	if(add_member_name!='') {
		$(":input[name='memberAddress.con_name']").val(add_member_name);
	}
	if(add_member_mobile!='') {
		$(":input[name='memberAddress.mobile']").val(add_member_mobile);
	}
});
</script>
<style type="text/css">
.address_input_area {}
.address_input_area select {width: 150px;}
.address_input_area textarea{width: 420px;height: 48px;}
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == memberAddress && 'add' == viewFlag">增加</s:if><s:elseif test="null != memberAddress && 'mdy' == viewFlag">修改</s:elseif>会员收货地址</span>
		<span class="extra1">
			<a href="<s:url action="member_load" namespace="sysvip"><s:param name="viewFlag">mdy</s:param><s:param name="member.uuid" value="%{member_id}" /></s:url>" >返回会员信息页面</a>
		</span>	
	</div>
<s:form name="form1" action="memberAddress_add" namespace="/sysvip" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != memberAddress">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键ID:</td>
<td class='secRow'><s:property value="memberAddress.uuid" /><s:hidden name="memberAddress.uuid" title="主键ID" /></td>
</tr>

		</s:if>
<tbody class="address_input_area">
<tr>
<td class='firstRow'><span style="color:red;">*</span> 所在地区:</td>
<td class='secRow'>
<s:select id="memberAddress.province" name="memberAddress.province" title="省" list="#{}" require="required" controlName="所在地区"></s:select>
<s:select id="memberAddress.city" name="memberAddress.city" title="市" list="#{}" require="required" controlName="所在地区"></s:select>
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
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>联系号码:</td>
<td class='secRow'>
	<s:textfield name="memberAddress.mobile" title="联系号码" controlName="联系号码" require="required" />
</td>
</tr>
<tr>
<td class='firstRow'>默认地址:</td>
<td class='secRow'>
<s:url id="setDefault" namespace="/sysvip" action="memberAddress_default">
	<s:param name="memberAddress.uuid" value="memberAddress.uuid" />
	<s:param name="memberAddress.member_id" value="memberAddress.member_id" />
	<s:param name="memberAddress.defaultaddress">1</s:param>
</s:url>

<s:if test="0==memberAddress.defaultaddress"><a href="${setDefault}"><span class="noarea"></span></a></s:if>
<s:if test="1==memberAddress.defaultaddress"><span class="yesarea"></span></s:if>
</tr>
</tbody>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	<s:hidden name="memberAddress.member_id" title="会员号" value="%{member_id}" />

		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == memberAddress && 'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="memberAddress_add" />
				</s:if>
				<s:elseif test="null != memberAddress && 'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="memberAddress_save" />
					<s:submit id="delete" name="delete" value="删除" action="memberAddress_del" onclick="return isDel();" />
				</s:elseif>
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>