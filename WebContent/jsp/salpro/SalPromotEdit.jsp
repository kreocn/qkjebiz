<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>促销活动管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>

<body>

	<div class="main">
		<div class="dq_step">
			${path} 
			<span class="opb lb op-area"> <s:if test="'view' != viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_LIST')"><a
				href="<s:url action="salPromot_list" namespace="/salpro"></s:url>">促销活动列表</a></s:if>
			</span>
		</div>
		<!-- 页面修改 -->
		<s:form id="editForm" name="editForm" cssClass="validForm"
			action="salPromot_add" namespace="/salpro" method="post" theme="simple">
			<div class="label_con">
				<s:if test="null != salPromot">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">编号:</div>
							<div class="label_rwb">
								<s:property value="salPromot.uuid" />
								<s:hidden id="salPromot.uuid" name="salPromot.uuid" value="%{salPromot.uuid}"/>
								
							</div>
						</div>
					</div>
				</s:if>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">主题:</div>
						<div class="label_rwben">
							<s:textfield name="salPromot.sal_title" title="主题"
								cssClass="label_hang_linput validate[required,maxSize[255]]" />
						</div>
					</div>
				</div>
				
				<div class="label_main">
			        <div class="label_hang">
			            <div class="label_ltit">活动时间:</div>
			            <div class="label_rwben2">
			            	<span class="label_rwb nw">
							<input  class="datepicker iI iI-f validate[required,custom[date]]" type="text" name="salPromot.startime" title="从" value="${it:formatDate(salPromot.startime,'yyyy-MM-dd')}" />
							</span>
							<span class="label_rwb nw">
							<input  class="datepicker iI iI-t validate[required,custom[date]]" type="text" name="salPromot.endtime" title="到" value="${it:formatDate(salPromot.endtime,'yyyy-MM-dd')}" />
			            	</span>
			            </div>
			        </div>
			      </div>

			    <div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">范围:</div>
						<div class="label_rwben">
							<s:textfield name="salPromot.sal_scop" title="范围"
								cssClass="label_hang_linput validate[required,maxSize[255]]" />
						</div>
					</div>
				</div>
				<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">促销方案:</div>
		            <div class="label_rwbenx">
		            </div>
		        </div>
		        </div>
				<div class="label_main">
					<div class="note_area">
						<s:textarea name="salPromot.sal_plan" title="促销方案"
							cssClass="xheditorArea validate[maxSize[65535]]" />
					</div>
				</div>
				
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<span id="message"><s:property value="message" /></span>
							<s:if test="null == salPromot  && 'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_ADD')">
								<s:submit id="add" name="add" value="确定" action="salPromot_add"
									cssClass="input-blue" />
							</s:if>
							<s:elseif test="null != salPromot && salPromot.status==0 && 'mdy' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_MDY')">
								<s:submit id="save" name="save" value="保存" action="salPromot_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SDSTATUS1')">
								<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="salPromot_status1" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
								</s:if>
							</s:elseif>
							<s:if test="null != salPromot && salPromot.status==1 && 'mdy' == viewFlag"><!-- 审核中 -->
								<s:if test="salPromot.smd_status!=20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SMDSTATUS20')">
								<s:submit id="mdyStatus20" name="mdyStatus20" value="销管经理审核通过" action="salPromot_smdstatus20" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
								<s:submit id="mdyStatus5" name="mdyStatus5" value="销管经理审核不通过" action="salPromot_smdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>
								
								<s:if test="salPromot.smd_status==20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SDSTATUS30')">
								<s:submit id="mdysdStatus30" name="mdysdStatus30" value="运营总监审核通过" action="salPromot_sdstatus30" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
								<s:submit id="mdysdStatus5" name="mdysdStatus5" value="运营总监审核不通过" action="salPromot_sdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>
							</s:if>
							<s:if test="salPromot.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_DEL')">
								<s:submit id="delete" name="delete" value="删除" action="salPromot_del"
									cssClass="input-red" onclick="return isDel();" />
							</s:if>
							
							<s:if test="'view' != viewFlag">
							<input type="button" class="input-gray" value="返回"
								onclick="linkurl('<s:url action="salPromot_list" namespace="/salpro"><s:param name="salPromot.type" value="%{salPromot.type}"></s:param></s:url>');" />
							</s:if>
						</div>
					</div>
				</div>
			</div>
		</s:form>
	</div>
</body>
<script type="text/javascript">
$("#sendee").click(function() {
	sendeeForm();
});
$("#delsend").click(function() {
	var ru=$("#r_uuid").val();
	var a = ru.substring(0,ru.lastIndexOf(";"));
	var b=a.substring(0,a.lastIndexOf(";"))+";";
	if(b==";"){
		$("#r_uuid").val(null);
	}else{
		$("#r_uuid").val(b);
	}
	
	
});

function sendeeForm() {
	//接收人
	var ruid=$("#r_uuid").val();
	//接收人的下拉
	var  rl=$("#membermanagerid").val();
	var type = document.getElementById("membermanagerid");
	var rlname=type[type.selectedIndex].text;
	var  depat=$("#userdept_codeid").val();
	var depname=$("#userdept_nameid").val();
	if(rl==null||rl==""){
		$("#r_uuid").val(ruid+depname+" "+depat+";");
	}else{
		$("#r_uuid").val(ruid+rlname+" "+rl+";");
	}
	
}
</script>
</html>