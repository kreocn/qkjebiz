<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员收货地址管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.address_input_area {}
.address_input_area select {width: 150px;}
.address_input_area textarea{width: 420px;height: 48px;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
<div class="dq_step">
	<s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>会员收货地址
	<span class="opb lb op-area"><a href="<s:url action="member_load" namespace="sysvip"><s:param name="viewFlag">mdy</s:param><s:param name="member.uuid" value="%{member_id}" /></s:url>">返回列表</a></span>
</div>
<s:form id="editForm" name="editForm" cssClass="validForm" namespace="/sysvip" method="post" theme="simple">
<div class="label_con">
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">所在地区:</div>
			<div class="label_rwbenx">
				<div class="label_rwb"><s:select id="memberAddress.province" name="memberAddress.province" title="省" list="#{}" cssClass="validate[required]" /></div>
				<div class="label_rwb"><s:select id="memberAddress.city" name="memberAddress.city" title="市" list="#{}" cssClass="validate[required]" data-prompt-position="inline" data-prompt-target="rm_x" /></div>
				<div class="label_rwb"><s:select id="memberAddress.area" name="memberAddress.area" title="县" list="#{}" /></div>
				<span id="rm_x" class="sva"></span>
			</div>
		</div>
	</div>
		<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">邮政编码:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.post" title="邮政编码"  dataType="zipcode" /></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">街道地址:</div>
			<div class="label_rwbenx"><s:textarea name="memberAddress.street" cssClass="label_hang_linput" title="街道地址" /></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">收货人姓名:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.con_name" title="收货人姓名" cssClass="validate[required]" /></div>
		</div>
		<div class="label_hang">
			<div class="label_ltit">联系号码:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.mobile" title="联系号码" cssClass="validate[required,custom[number]" /></div>
		</div>
	</div>
	<s:if test="'mdy' == viewFlag">
	<div class="label_main">
	<div class="label_hang">
			<div class="label_ltit">默认地址:</div>
			<div class="label_rwbenx">
				<s:url id="setDefault" namespace="/sysvip" action="memberAddress_default">
					<s:param name="memberAddress.uuid" value="memberAddress.uuid" />
					<s:param name="memberAddress.member_id" value="memberAddress.member_id" />
					<s:param name="memberAddress.defaultaddress">1</s:param>
				</s:url>
				<s:if test="0==memberAddress.defaultaddress"><a href="${setDefault}"><span class="aI aI-e"></span></a></s:if>
				<s:if test="1==memberAddress.defaultaddress"><span class="aI aI-y"></span></s:if>
			</div>
		</div>
		</div>
		</s:if>
		<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx op-area">
            	<s:hidden name="memberAddress.uuid" />
            	<s:hidden name="memberAddress.member_id" value="%{member_id}" />
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="memberAddress_add" cssClass="input-blue" />
					<s:hidden name="memberAddress.defaultaddress" value="0" />
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="memberAddress_save" cssClass="input-blue" />
					<s:submit id="delete" name="delete" value="删除" action="memberAddress_del" cssClass="input-red" onclick="return isDel();" />
				</s:elseif>
        	</div>
    	</div>
	</div>
</div>
</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/v0.1/area.js" />"></script>
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
<script type="text/javascript">
	var sa = new SArea($("#memberAddress\\.province") ,$("#memberAddress\\.city"),$("#memberAddress\\.area"));
	sa.ajax_url = ajax_url;
	sa.init(toHTML.un('<s:property value="memberAddress.province" />'),toHTML.un('<s:property value="memberAddress.city" />'),toHTML.un('<s:property value="memberAddress.area" />'));
</script>
</body>
</html>