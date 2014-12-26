<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>返利申请单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function(){
	CommonUtil.pickrow('rebatesProductsTable');	
	/*<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_OUTFLAG')">*/
	$("#out_flag_no").bind("click",function(){
		$("#OUT_Operation #lading_out").unbind().bind("click",function(){
			if(isOp('是否确定已出货?\n出货操作不能更改!')) 
			location.href='<s:url namespace="/qkjmanage" action="rebates_mdyOutFlag"><s:param name="rebates.uuid" value="rebates.uuid" /></s:url>';
		});
		$("#OUT_Operation").dialog("open");
	});
	$("#OUT_Operation").dialog({
	      autoOpen: false,
	      width: 200,
	      height: 105,
	      modal: true
	});
	/*</s:if>*/
});
</script>
<style type="text/css">
.showladings li{line-height:28px;}
#out_flag_no{cursor: pointer;}
.dialog_button{font-size:14px; font-family: "微软雅黑"; text-align:center; display:inherit; margin-top:10px;}
.printarea{text-align:center;}
</style>
</head>
<body>
<div class="main" >
	<div class="dq_step"><s:if test="null == rebates && 'add' == viewFlag">增加</s:if><s:elseif test="null != rebates && 'mdy' == viewFlag">修改</s:elseif>返利申请单</div>
	<s:form id="formEdit" name="form1" action="rebates_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<s:if test="null != rebates">
					<div class="label_hang">
					       <div class="label_ltit">申请编号:</div>
					       <div class="label_rwben">${rebates.uuid}<s:hidden name="rebates.uuid" /></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">状态:</div>
					       <div class="label_rwben">
					       		<s:if test='0==rebates.status'>新单</s:if>
								<s:if test='10==rebates.status'>待审核</s:if>
								<s:if test='20==rebates.status'>主管已审</s:if>
								<s:if test='30==rebates.status'>经理已审</s:if>
								<s:if test='40==rebates.status'>财务已审</s:if>
								<s:if test='50==rebates.status'>总监已审</s:if>
								<s:if test='60==rebates.status'>总经理已审</s:if>
								<s:if test='0==rebates.out_flag'><span id="out_flag_no" class="message_error">未出货</span></s:if><s:if test='1==rebates.out_flag'>已出货</s:if>
					       </div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">申请人:</div>
					       <div class="label_rwben">${rebates.applicant_name}</div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">申请时间:</div>
					       <div class="label_rwbenx">${it:formatDate(rebates.apply_time,"yyyy-MM-dd HH:mm:ss")}</div>
					</div>
				</s:if>
				<div class="label_hang">
				       <div class="label_ltit">会员号:</div>
				       <div class="label_rwben">${rebates.member_id}<s:hidden name="rebates.member_id" title="会员号" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">会员手机:</div>
				       <div class="label_rwben">${rebates.member_mobile}<s:hidden name="rebates.member_mobile" title="会员手机" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">会员姓名:</div>
				       <div class="label_rwbenx">${rebates.member_name}<s:hidden name="rebates.member_name" title="会员姓名" /></div>
				</div>
				<div class="label_hang">
					 <div class="label_ltit">需返利出货单:</div>
					 <div class="label_rwbenx">
						 	<ul id="ladings" class="showladings">
								<s:iterator value="rebatesLadings">
									<li class="active">(<s:date name="lading_time" format="yyyy-MM-dd" />)<a href='<s:url namespace="qkjmanage" action="lading_view"><s:param name="lading.uuid" value="lading_id" /><s:param name="viewFlag">view</s:param></s:url>' target="_blank"><s:property value="lading_id" /></a></li>
								</s:iterator>
							</ul>
					 </div>
				</div>
				<fieldset class="clear">
					<legend>实体返利内容</legend>
					<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin" id="rebatesProductsTable">
						<tr>
						    <th>产品名称</th>
							<th>数量</th>
						  </tr>
						<s:iterator value="rebatesProducts" status="sta">
							  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
							    <td>${product_name}</td>
								<td>${num}</td>
							  </tr>
						</s:iterator>
						</table>
				</fieldset>
				<div class="label_main">
					<div class="label_hang">
					       <div class="label_ltit">返利说明:</div>
					       <div class="label_rwbenx">${rebates.note}</div>
					</div>
				</div>
 			</div>
 		</div>
	</s:form>
</div>
<div class="printarea input-a"><input type="button" onclick="window.print();" value="打印本页"/></div>
<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_REBATES_OUTFLAG')">
	<div id="OUT_Operation" title="出货操作">
		<span class="dialog_button op-area"><a id="lading_out" class="input-blue" href="javascript:;">确定出货完成</a></span>
	</div>
</s:if>
</body>
</html>