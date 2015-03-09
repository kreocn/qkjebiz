<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>促销活动管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>

<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			${path} <span class="opb lb op-area"> <s:if test="'view' != viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT')">
					<a href="<s:url action="salPromot_list" namespace="/salpro"></s:url>">促销活动列表</a>
				</s:if>
			</span>
		</div>
		<!-- 页面修改 -->
		<s:form id="editForm" name="editForm" cssClass="validForm" action="salPromot_add" namespace="/salpro" method="post" theme="simple">
			<s:hidden name="salPromot.add_user_dept" value="%{salPromot.add_user_dept}"></s:hidden>
			<s:hidden name="salPromot.status" value="%{salPromot.status}"></s:hidden>
			<div class="label_con">
				<s:if test="null != salPromot">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">编号:</div>
							<div class="label_rwb">
								<s:property value="salPromot.uuid" />
								<s:hidden id="salPromot.uuid" name="salPromot.uuid" value="%{salPromot.uuid}" />

							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">活动状态:</div>
							<div class="label_rwb">
								<s:if test="%{salPromot.status==0}">新申请</s:if>
								<s:if test="%{salPromot.status==1}">审核中</s:if>
								<s:if test="%{salPromot.status==2}">审核通过</s:if>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">审核状态:</div>
							<div class="label_rwbenx">
								<div class="zhuangtai">
									<s:if test="salPromot.smd_status==0">待审核</s:if>
									<s:if test="salPromot.smd_status==5">
										<span class="message_error" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管已退回(${salPromot.smd_name }) </span>
									</s:if>
									<s:if test="salPromot.smd_status==20">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==30">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==40">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">业务副总已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==50">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==60">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审(${salPromot.smd_name })</span>
									</s:if>
								</div>

							</div>
						</div>
					</div>
				</s:if>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">主题:</div>
						<div class="label_rwben">
							<s:textfield name="salPromot.sal_title" title="主题" cssClass="label_hang_linput validate[required,maxSize[255]]" />
						</div>
					</div>
				</div>

				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">活动时间:</div>
						<div class="label_rwben2">
							<span class="label_rwb nw"> <input class="datepicker iI iI-f validate[required,custom[date]]" type="text" name="salPromot.startime" title="从" value="${it:formatDate(salPromot.startime,'yyyy-MM-dd')}" />
							</span> 
							<span class="label_rwb nw"> <input id="saldate" class="datepicker iI iI-t validate[required,custom[date]]" type="text" name="salPromot.endtime" title="到" value="${it:formatDate(salPromot.endtime,'yyyy-MM-dd')}" />
							</span>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">返利系数:</div>
						<div class="label_rwben">
							<s:textfield id="rebate" name="salPromot.rebate" cssClass="validate[required,custom[number]]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_rwben">&nbsp;%</div>
					</div>
				</div>
				
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">添加部门:</div>
						<div class="label_rwben nw">
							<s:textfield id="useradddept_nameid" name="salPromot.add_user_dept_name" readonly="true" cssClass="validate[required]" />
							<s:hidden id="useradddept_codeid" name="salPromot.add_user_dept" />
						</div>
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('useradddept_codeid','useradddept_nameid',true,null,1);" />
					</div>
				</div>
				
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">范围:</div>
						<div class="label_rwben nw">
							<s:textfield id="userdept_nameid" name="salPromot.sal_scopDept_name" readonly="true" cssClass="validate[required]" />
							<s:hidden id="userdept_codeid" name="salPromot.sal_scopDept" />
							
						</div>
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" />
					</div>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">范围说明:</div>
						<div class="label_rwben">
							<s:textfield name="salPromot.sal_scop" title="范围" cssClass="label_hang_linput validate[maxSize[255]]" />
						</div>
					</div>
				</div>
				
				<div class="label_hang">
							<div class="label_ltit">许可范围:</div>
							<div class="label_rwben label_rwb">
								<span class="label_rwb">
								 <s:select id="sal_scopUs" name="salPromot.sal_scopUs" cssClass="selectKick" list="#{1:'公有',2:'私有'}" headerKey="" headerValue="--请选择--"  onchange="pub();"/>
								</span>
							</div>
				</div>
						
				<div class="label_hang">
							<div class="label_rwbenx">
								<span id="scopValue"></span>
						</div>
				</div>
				<s:if test="%{salPromot!=null}">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">申请人:</div>
							<div class="label_rwben">${salPromot.add_user_name }</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">申请时间:</div>
							<div class="label_rwbenx">${it:formatDate(salPromot.add_time,'yyyy-MM-dd hh:mm:ss')}</div>
						</div>
						
					
					</div>

				</s:if>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">促销方案:</div>
						<div class="label_rwbenx"></div>
					</div>
				</div>
				<div class="label_main">
					<div class="note_area">
						<s:textarea name="salPromot.sal_plan" title="促销方案" cssClass="xheditorArea validate[maxSize[65535]]" />
					</div>
				</div>

				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">备注:</div>
						<div class="label_rwbenx">
							<span class="message_prompt">任何保存/报审/审核操作都会同时保存备注</span>
							<s:textarea id="salPromot_remark" name="salPromot.note" title="活动备注" cssClass="label_hang_linput inputNote validate[maxSize[65535]]" />
						</div>
					</div>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">优先级:</div>
						<div class="label_rwben">
							<s:select name="salPromot.priority" cssClass="selectKick" list="#{1:1,2:2,3:3,4:4,5:5,6:6,7:7,8:8,9:9,10:10}" headerKey="0" headerValue="0" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_rwbenx">
							<font color="red">说明：优先级越高排名越靠前</font>
						</div>
					</div>
				</div>

				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<span id="message"><s:property value="message" /></span>
							<s:if test="null == salPromot  && 'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_ADD')">
								<s:submit id="add" name="add" value="确定" action="salPromot_add" cssClass="input-blue" onclick="return check();" />
							</s:if>
							<s:elseif test="null != salPromot && salPromot.status==0 && 'mdy' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_MDY')">
									<s:submit id="save" name="save" value="保存" action="salPromot_save" cssClass="input-blue" onclick="return check();" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SDSTATUS1')">
									<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="salPromot_status1" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
								</s:if>
							</s:elseif>
							<s:if test="null != salPromot && salPromot.status>=1 && 'mdy' == viewFlag">
								<!-- 审核中 -->
								<s:if test="salPromot.smd_status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SMDSTATUS20')">
									<s:submit id="mdyStatus20" name="mdyStatus20" value="经理/大区审核通过" action="salPromot_smdstatus20" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyStatus5" name="mdyStatus5" value="审核不通过" action="salPromot_smdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>
								<s:if test="salPromot.smd_status==20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SMDSTATUS30')">
									<s:submit id="mdysdStatus30" name="mdysdStatus30" value="运营总监审核通过" action="salPromot_smdstatus30" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdysdStatus5" name="mdysdStatus5" value="审核不通过" action="salPromot_smdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>

								<s:if test="salPromot.smd_status==30 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SMDSTATUS40')">
									<s:submit id="mdysdStatus40" name="mdysdStatus40" value="业务副总审核通过" action="salPromot_smdstatus40" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdysdStatus5" name="mdysdStatus5" value="审核不通过" action="salPromot_smdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>

								<s:if test="salPromot.smd_status==40 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SMDSTATUS50')">
									<s:submit id="mdysdStatus50" name="mdysdStatus50" value="销管副总审核通过" action="salPromot_smdstatus50" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdysdStatus5" name="mdysdStatus5" value="审核不通过" action="salPromot_smdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>

								<s:if test="salPromot.smd_status==50 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SMDSTATUS60')">
									<s:submit id="mdysdStatus60" name="mdysdStatus60" value="总经理审核通过" action="salPromot_smdstatus60" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdysdStatus5" name="mdysdStatus5" value="审核不通过" action="salPromot_smdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>

								<!--<s:if test="salPromot.smd_status==20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_SDSTATUS30')">
								<s:submit id="mdysdStatus30" name="mdysdStatus30" value="运营总监审核通过" action="salPromot_sdstatus30" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
								<s:submit id="mdysdStatus5" name="mdysdStatus5" value="运营总监审核不通过" action="salPromot_sdstatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
								</s:if>-->
							</s:if>
							<s:if test="salPromot.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT_DEL')">
								<s:submit id="delete" name="delete" value="删除" action="salPromot_del" cssClass="input-red" onclick="return isDel();" />
							</s:if>

							<s:if test="'view' != viewFlag">
								<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="salPromot_list" namespace="/salpro"><s:param name="salPromot.type" value="%{salPromot.type}"></s:param></s:url>');" />
							</s:if>
						</div>
					</div>
				</div>
			</div>
		</s:form>
	</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
	$("#sendee").click(function(){
		sendeeForm();
	});
	$("#delsend").click(function(){
		var ru = $("#r_uuid").val();
		var a = ru.substring(0, ru.lastIndexOf(";"));
		var b = a.substring(0, a.lastIndexOf(";")) + ";";
		if (b == ";") {
			$("#r_uuid").val(null);
		} else {
			$("#r_uuid").val(b);
		}

	});

	function sendeeForm(){
		//接收人
		var ruid = $("#r_uuid").val();
		//接收人的下拉
		var rl = $("#membermanagerid").val();
		var type = document.getElementById("membermanagerid");
		var rlname = type[type.selectedIndex].text;
		var depat = $("#userdept_codeid").val();
		var depname = $("#userdept_nameid").val();
		if (rl == null || rl == "") {
			$("#r_uuid").val(ruid + depname + " " + depat + ";");
		} else {
			$("#r_uuid").val(ruid + rlname + " " + rl + ";");
		}

	}

	function check(){
		var num = $("#rebate").val();
		var pub= $("#sal_scopUs ").val();
		var cdate= new Date($("#saldate ").val());
		var myDate = new Date();
		if (parseInt(num) == num) {
			if(pub==null || pub==""){
				alert("许可范围必填！");
				return false;
			}else{
				if(cdate<myDate){
					alert("结束日期一定要大于当前日期！");
					return false;
				}else{
					return true;
				}
			}
		} else {
			alert('一定要为整数呀！');
			return false;
		}
	}
	
	function pub(){
		var pub= $("#sal_scopUs ").val();
		if(pub==1){
			$("#scopValue ").text("公有说明会员所属部门下的所有部门都可以选到。");
		}else if(pub==2){
			$("#scopValue ").text("私有说明只有管理员所属部门及以上领导可以选到。");
		}
	}
</script>
</html>