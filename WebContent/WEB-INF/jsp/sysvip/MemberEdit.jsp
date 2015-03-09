<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/v0.1/area.js" />"></script>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
<div class="dq_step">
	${path}
	<span class="opb lb op-area"><a href="<s:url action="member_list" namespace="/sysvip"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span>
</div>
<s:form id="editForm" name="editForm" cssClass="validForm" namespace="/sysvip" method="post" theme="simple">
<div class="label_con">
	<s:if test="'mdy' == viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">会员号:</div>
		<div class="label_rwben">${member.uuid}<s:hidden name="member.uuid" title="会员号" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">登录密码:</div>
		<div class="label_rwben label_rwb"><s:password id="passwords" name="member.passwords" cssClass="validate[required]" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">再次输入:</div>
		<div class="label_rwben label_rwb"><s:password id="passwords2" name="passwords2" cssClass="validate[required,equals[passwords]]" /></div>
	</div>
	</div>
	</s:if>
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">会员手机:</div>
		<div class="label_rwben2">
			<span class="label_rwb label_rwbx"><s:textfield name="member.mobile" title="会员手机" cssClass="validate[required,custom[mobile]]" /></span>
			<span class="label_rwb nw"><s:radio name="member.is_mobile_check" title="手机验证"  list="#{0:'未验证',1:'已验证'}" value="1" cssClass="regular-radio" /></span>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员名称:</div>
		<div class="label_rwben label_rwb"><s:textfield name="member.member_name" cssClass="validate[required,maxSize[85]]" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">联系人姓名:</div>
		<div class="label_rwben label_rwb"><span class="message_prompt">企业联系人</span><s:textfield name="member.contact" title="联系人" cssClass="inputNote" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员分组:</div>
		<div class="label_rwben">
			<div class="label_rwb"><s:select name="member.user_type" title="会员级别"  list="roles" listKey="uuid" listValue="role_name" /></div></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员EMAIL:</div>
		<div class="label_rwben2">
			<span class="label_rwb label_rwbx"><s:textfield name="member.email" cssClass="validate[maxSize[85]]" /></span>
			<span class="label_rwb nw"><s:radio name="member.is_email_check" title="EMAIL验证"  list="#{0:'未验证',1:'已验证'}" value="0" cssClass="regular-radio" /></span>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">登录别名:</div>
		<div class="label_rwben label_rwb"><s:textfield name="member.title" cssClass="validate[maxSize[85]]" /></div>
	</div>
	<s:if test="'mdy'==viewFlag">
	<div class="label_hang">
		<div class="label_ltit">所属办事处:</div>
		<div class="label_rwben">${member.dept_name}</div>
	</div>
	<div class="label_hang">
	<div class="label_ltit">所属人:</div>
	<div class="label_rwben">${member.manager_name}</div>
	</div>
	</s:if>
	<s:if test="'add'==viewFlag">
	<div class="label_hang">
		<div class="label_ltit">所属办事处:</div>
		<div class="label_rwben nw">
			<div class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="member.dept_name" readonly="true" /></div>
				<s:hidden id="userdept_codeid" name="member.dept_code" />
			</div>
			<img class="imglink vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" />
	</div>
	<div class="label_hang">
	<div class="label_ltit">所属人:</div>
	<div class="label_rwben">
		<div class="label_rwb">
			<s:select id="membermanagerid" name="member.manager" list="#{}"	headerKey="" headerValue="--请选择--" />
		</div>
	</div>
	</div>
	</s:if>
	</div>
	<s:if test="'mdy'==viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">注册来源:</div>
		<div class="label_rwben label_rwb">
			<s:if test="0==member.reg_type">自行注册</s:if>
			<s:if test="1==member.reg_type">管理员添加</s:if>
			<s:if test="2==member.reg_type">批量导入</s:if>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">注册时间:</div>
		<div class="label_rwben" style="width:auto;"><s:date name="member.reg_time" format="yyyy-MM-dd HH:mm:ss" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">最后登录时间:</div>
		<div class="label_rwben" style="width:auto;"><s:date name="member.last_login_time" format="yyyy-MM-dd HH:mm:ss" /></div>
	</div>
	</div>
	</s:if>
	<fieldset class="clear">
	<legend>收货地址</legend>
	<!--<span class="shaddress">--------------------收货地址--------------------</span>-->
	<s:if test="'add' == viewFlag">
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
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.post" title="邮政编码" controlName="邮政编码" dataType="zipcode" /></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">街道地址:</div>
			<div class="label_rwbenx"><s:textarea name="memberAddress.street" cssClass="label_hang_linput" title="街道地址" controlName="街道地址" require="required" /></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">收货人姓名:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.con_name" title="收货人姓名" controlName="收货人姓名" require="required" /></div>
		</div>
		<div class="label_hang">
			<div class="label_ltit">联系号码:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.mobile" title="联系号码" controlName="联系号码" require="required" /></div>
		</div>
		<div class="label_hang label_button tac">
			<a href="javascript:;" onclick="copyval();">复制会员姓名和手机</a>
		</div>
	</div>
	</s:if>
	<s:if test="'mdy'==viewFlag">
		 <div class="label_main">
		 	<!--
		 	<p class="lb_yjtit bn">
			<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">add</s:param><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" >添加收货地址</a>
		 	</p>
		 	-->
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
			<tr>
				<th>所在地区</th>
				<th>邮编</th>
				<th>街道地址</th>
				<th>收货人姓名</th>
				<th>手机/联系电话</th>
				<th>默认地址</th>
				<th><a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">add</s:param><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" >添加收货地址</a></th>
			</tr>
			<s:iterator value="memberAddresses" status="sta">
			  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
				<td><s:property value="province" /> <s:property value="city" /> <s:property value="area" /></td>
				<td><s:property value="post" /></td>
				<td><s:property value="street" /></td>
				<td><s:property value="con_name" /></td>
				<td><s:property value="mobile" /></td>
				<td>
				<s:url id="setDefault" namespace="/sysvip" action="memberAddress_default">
					<s:param name="memberAddress.uuid" value="uuid" />
					<s:param name="memberAddress.member_id" value="member.uuid" />
					<s:param name="memberAddress.defaultaddress">1</s:param>
				</s:url>
				<s:if test="0==defaultaddress"><a href="${setDefault}"><span class="aI aI-e"></span></a></s:if>
				<s:if test="1==defaultaddress"><span class="aI aI-y"></span></s:if>
				</td>
				<td>
			    	[<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">mdy</s:param><s:param name="memberAddress.uuid" value="uuid"></s:param></s:url>">修改</a>]
			    	[<a href="<s:url namespace="/sysvip" action="memberAddress_del"><s:param name="memberAddress.uuid" value="uuid" /><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" onclick="return isDel();">删除</a>]
			    </td>
			  </tr>
			</s:iterator>
			</table>
        </div>
		
	</s:if>
	</fieldset>
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            	<s:if test="'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="member_add" />
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="member_save" cssClass="input-blue" />
					<s:submit id="delete" name="delete" value="删除" action="member_del" cssClass="input-red" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="member_list" namespace="/sysvip" />');"  class="input-gray" />
				<s:if test="'mdy' == viewFlag">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_LIST')">
				<input type="button" value="生成会员库存盘点模板" onclick="linkurl('<s:url action="memberStock_out" namespace="/sysvip" ><s:param name="member.member_name" value="%{member.member_name}"></s:param><s:param name="member.uuid" value="%{member.uuid}"></s:param></s:url>');"  class="input-blue" />
				</s:if>
				</s:if>
        	</div>
    	</div>
	</div>
</div>
</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
					var sa = new SArea($("#memberAddress\\.province") ,$("#memberAddress\\.city"),$("#memberAddress\\.area"));
					sa.ajax_url = ajax_url;
					sa.init(toHTML.un('<s:property value="memberAddress.province" />'),toHTML.un('<s:property value="memberAddress.city" />'),toHTML.un('<s:property value="memberAddress.area" />'));
				</script>
</body>
<script type="text/javascript">
var curr_dept = '${member.dept_code}';
$(function(){
	if(curr_dept!='') {
		loadManagers(curr_dept,'${member.manager}');
	}
});
function copyval() {
	$(":input[name='memberAddress.con_name']").val($(":input[name='member.member_name']").val());
	$(":input[name='memberAddress.mobile']").val($(":input[name='member.mobile']").val());
}
function checkManager() {
	if($("#userdept_codeid").val()=="")
		return isOp("还没有分配部门,确定要提交吗?");
	else 
		return true;
}
</script>
</html>