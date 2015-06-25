<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
			${path} 
			<span class="opb lb op-area">
				<c:if test="${it:checkPermit('QKJ_SALPRO_SALPROMOT_ADD',null)==true && 'view' != viewFlag}">
					<a href="<s:url action="salPromot_list" namespace="/salpro"></s:url>">促销活动列表</a>
				</c:if>
			</span>
		</div>
		<!-- 页面修改 -->
		<s:form id="editForm" name="editForm" cssClass="validForm" action="salPromot_add" namespace="/salpro" method="post" theme="simple">
			<s:hidden name="salPromot.status" value="%{salPromot.status}"></s:hidden>
			<s:hidden name="salPromot.sd_status" value="%{salPromot.sd_status}"></s:hidden>
			<s:hidden name="salPromot.smd_status" value="%{salPromot.smd_status}"></s:hidden>
			<s:hidden name="salPromot.fd_status" value="%{salPromot.fd_status}"></s:hidden>
			<div class="label_con">
				<s:if test="'mdy' == viewFlag">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">编号:</div>
							<div class="label_rwb">
								<s:property value="salPromot.uuid" />
								<s:hidden id="salPromot.uuid" name="salPromot.uuid" value="%{salPromot.uuid}" />

							</div>
						</div>
					</div>
					
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">审核状态:</div>
							<div class="label_rwbenx">
								<div class="zhuangtai">
									单据状态:<!-- 申请单状态 0:新申请 1:申请审批中 2:申请通过 -->
									<s:if test="%{salPromot.status==0}">新申请</s:if>
									<s:if test="%{salPromot.status==1}">审核中</s:if>
									<s:if test="%{salPromot.status==2}">审核通过</s:if>
								</div>
								<div class="zhuangtai" title="${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')}">
									销售部审核状态:
										<s:if test="salPromot.sd_status==10">待审核</s:if>
										<s:if test="salPromot.sd_status==5">
											<span class="message_error" title="${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')}">销售已退回(${salPromot.sd_name }) </span>
										</s:if>
										<s:if test="salPromot.sd_status==30">
											<span class="message_pass" title="${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')}">大区已审(${salPromot.sd_name })</span>
										</s:if>
										<s:if test="salPromot.sd_status==40">
											<span class="message_pass" title="${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已审(${salPromot.sd_name })</span>
										</s:if>
										<s:if test="salPromot.sd_status==50">
											<span class="message_pass" title="${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')}">业务副总已审(${salPromot.sd_name })</span>
										</s:if>
								</div>
								
								<div class="zhuangtai" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">
									销管部审核状态:
									<s:if test="salPromot.smd_status==10">待审核</s:if>
									<s:if test="salPromot.smd_status==5">
										<span class="message_error" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管已退回(${salPromot.smd_name }) </span>
									</s:if>
									<s:if test="salPromot.smd_status==30">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==40">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管部经理已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==50">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==60">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审(${salPromot.smd_name })</span>
									</s:if>
									<s:if test="salPromot.smd_status==70">
										<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">董事已审(${salPromot.smd_name })</span>
									</s:if>
								</div>
								
								<div class="zhuangtai" <s:if test="%{salPromot.fd_status!=0}">title="${it:formatDate(salPromot.fd_time,'yyyy-MM-dd HH:mm:ss')}"</s:if>>
									财务审核状态:
									<s:if test="salPromot.fd_status==0">未确认</s:if>
									<s:if test="salPromot.fd_status==5">
										<font class="message_error">审核退回</font>(${salPromot.fd_name})</s:if>
									<s:if test="salPromot.fd_status==10">
										<font class="message_pass">已通过审</font>(${salPromot.fd_name})</s:if>
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
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,null,'sp');" />
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
				
				<s:if test="'mdy' == viewFlag">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">审阅情况:</div>
							<div class="label_rwbenx approve_list">
								<ul>
									<s:iterator value="approves" status="sta">
										<li>此活动在<span class="approve_ad_time"> ${it:formatDate(ad_time,'yyyy-MM-dd HH:mm:ss')}</span> 被 <span class="approve_check_user"> ${check_user_name}</span> 执行 <span class="approve_flag"> <s:if test="flag==5">
													<span class="approve_flag_fail">审阅不通过</span>
												</s:if> <s:if test="flag==10">
													<span class="approve_flag_pass">审阅通过</span>
												</s:if>
										</span> 操作 <s:if test="advice!=null && advice!=''">
					审阅意见:
					<span class="approve_advice">${advice}</span>
											</s:if>
										</li>
									</s:iterator>
								</ul>
							</div>
						</div>
					</div>
				</s:if>
				
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<span id="message"><s:property value="message" /></span>
							<c:if test="${ 'add' == viewFlag && it:checkPermit('QKJ_SALPRO_SALPROMOT_ADD',null)==true}">
								<s:submit id="add" name="add" value="确定" action="salPromot_add" cssClass="input-blue" />
							</c:if>
							<s:if test="null != salPromot && salPromot.status==0 && 'mdy' == viewFlag">
								<c:if test="${it:checkPermit('QKJ_SALPRO_SALPROMOT_MDY',null)==true}">
									<s:submit id="save" name="save" value="保存" action="salPromot_save" cssClass="input-blue" />
								</c:if>
								<c:if test="${it:checkPermit('QKJ_SALPRO_SALPROMOT_SDSTATUS1',null)==true}">
									<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="salPromot_status1" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
								</c:if>
							</s:if>
							
							<c:if test="${salPromot.status==0 && it:checkPermit('QKJ_SALPRO_SALPROMOT_DEL',null)==true}">
								<s:submit id="delete" name="delete" value="删除" action="salPromot_del" cssClass="input-red" onclick="return isDel();" />
							</c:if>
							
							<s:if test="salPromot.status>0 && 'mdy' == viewFlag">
								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_SALPRO_APPROVE',null)==true}">
								<input type="button" value="审阅" onclick="openApprove();" class="input-yellow" />
								</c:if>
							</s:if>
							<s:if test="salPromot.sd_status>30 && salPromot.status>0">
								<input type="button" onclick="linkurl('<s:url namespace="/salpro" action="salPromot_view"><s:param name="salPromot.uuid" value="salPromot.uuid" /></s:url>');" value="转到打印页面" />
							</s:if>
							
							<s:if test="salPromot.status>0 && 'mdy' == viewFlag">
								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK5',null)==true}">
								<s:submit  cssClass="input-red" value="退回" action="mdySDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
							</s:if>
							
							<s:if test="'view' != viewFlag">
								<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="salPromot_list" namespace="/salpro"><s:param name="salPromot.type" value="%{salPromot.type}"></s:param></s:url>');" />
							</s:if>
							
						</div>
					</div>
				</div>
				
				<s:if test="salPromot.status>0 && 'mdy' == viewFlag">
							<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">销售审核:</div>
									<div class="label_rwbenx">
									<s:if test="salPromot.status<2">
										<c:if test="${salPromot.sd_status==10 && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SDSTATUS30',salPromot.add_user_dept)==true}">
											<s:submit  value="经理/大区审核通过" action="mdySDStatus20" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
										</c:if>
										<c:if test="${salPromot.sd_status==10 && it:checkPermit('QKJ_QKJMANAGE_SALPRO_CHECK5',salPromot.add_user_dept)==true}">
											<s:submit  cssClass="input-red" value="审核不通过" action="mdySDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${salPromot.sd_status==30 && salPromot.smd_status==30 && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SDSTATUS40',salPromot.add_user_dept)==true}">
											<s:submit value="运营总监审核通过" action="mdySDStatus30" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
											<s:submit  cssClass="input-red" value="审核不通过" action="mdySDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										
										<c:if test="${40==salPromot.sd_status && salPromot.smd_status>=40  && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SDSTATUS50',salPromot.add_user_dept)==true}">
											<s:submit  value="业务副总审核通过" action="mdySDStatus40" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
											<s:submit cssClass="input-red" value="审核不通过" action="mdySDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
										<div class="statusInline">
											销售部审核状态:
											<s:if test="salPromot.sd_status==0">初始状态</s:if>
											<s:if test="salPromot.sd_status==5">
												<font class="message_error">审核退回</font>(${salPromot.sd_name} ${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.sd_status==10">
												<font class="message_warning">待审核</font>
											</s:if>
											<s:if test="salPromot.sd_status==30">
												<font class="message_pass">大区已审</font>(${salPromot.sd_name} ${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.sd_status==40">
												<font class="message_pass">总监已审</font>(${salPromot.sd_name} ${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.sd_status==50">
												<font class="message_pass">副总已审</font>(${salPromot.sd_name} ${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
		
										</div>
									</div>
								</div>
							</div>
						
						<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">销管审核:</div>
									<div class="label_rwbenx">
									<s:if test="salPromot.status<2">
										<c:if test="${10==salPromot.smd_status && 30==salPromot.sd_status && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SMDSTATUS30',salPromot.add_user_dept)==true}">
											<s:submit  cssClass="input-green" value="销管经理-审核通过" action="mdySMDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit  cssClass="input-red" value="审核不通过" action="mdySMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${30==salPromot.smd_status && salPromot.sd_status==40 && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SMDSTATUS40',salPromot.add_user_dept)==true}">
											<s:submit cssClass="input-green" value="销管部经理-审核通过" action="mdySMDStatus40" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" value="审核不通过" action="mdySMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${40==salPromot.smd_status && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SMDSTATUS50',salPromot.add_user_dept)==true}">
											<s:submit cssClass="input-green" value="销管副总-审核通过" action="mdySMDStatus50" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" value="审核不通过" action="mdySMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${salPromot.smd_status==50 && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SMDSTATUS60',salPromot.add_user_dept)==true}">
											<s:submit cssClass="input-green" value="总经理-审核通过" action="mdySMDStatus60" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" value="审核不通过" action="mdySMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${salPromot.smd_status==60 && it:checkPermit('QKJ_QKJMANAGE_SALPRO_SMDSTATUS70',salPromot.add_user_dept)==true}">
											<s:submit cssClass="input-green" value="董事-审核通过" action="mdySMDStatus70" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" value="审核不通过" action="mdySMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
										<div class="statusInline">
											销管部审核状态:
											<s:if test="salPromot.smd_status==0">未签收</s:if>
											<s:if test="salPromot.smd_status==5">
												<font class="message_error">审核退回</font>(${salPromot.smd_name} ${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.smd_status==10">
												<font class="message_warning">已签收</font>
											</s:if>
											<s:if test="salPromot.smd_status==30">
												<font class="message_pass">销管经理已审</font>(${salPromot.smd_name} ${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.smd_status==40">
												<font class="message_pass">销管部经理已审</font>(${salPromot.smd_name} ${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.smd_status==50">
												<font class="message_pass">销管副总已审</font>(${salPromot.smd_name} ${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.smd_status==60">
												<font class="message_pass">总经理已审</font>(${salPromot.smd_name} ${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
												<s:if test="salPromot.smd_status==70">
												<font class="message_pass">董事已审</font>(${salPromot.smd_name} ${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										</div>
									</div>
								</div>
							</div>
							
							<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">财务审核:</div>
									<div class="label_rwbenx">
									<s:if test="salPromot.status<2">
										<c:if test="${salPromot.smd_status>=50 && 10!=salPromot.fd_status && it:checkPermit('QKJ_QKJMANAGE_SALPRO_FDSTATUS10',salPromot.add_user_dept)==true}">
											<s:submit  cssClass="input-green" value="财务-审核通过" action="mdyFDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit  cssClass="input-red" value="审核不通过" action="mdyFDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
										<div class="statusInline">
											财务部审核状态:
											<s:if test="salPromot.fd_status==0">未确认</s:if>
											<s:if test="salPromot.fd_status==5">
												<font class="message_error">审核退回</font>(${salPromot.fd_name} ${it:formatDate(salPromot.fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="salPromot.fd_status==10">
												<font class="message_pass">财务已审</font>(${salPromot.fd_name} ${it:formatDate(salPromot.fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										</div>
									</div>
								</div>
							</div>
						</s:if>
			</div>
		</s:form>
		<div id="approveFrom" class="label_con idialog" title="审阅信息">
			<s:form name="form1" action="close_approve" cssClass="validForm" namespace="/salpro" method="post" theme="simple">
				<input type="hidden" name="salPromot.uuid" value="${salPromot['uuid']}" />
				<input type="hidden" id="add_approve_flag" name="approve.flag" />
				<div class="label_main">
					<textarea name="approve.advice" rows="3"></textarea>
				</div>
				<div class="label_main tac" style="padding: 5px 0;">
					<c:if test="${it:checkPermit('QKJ_QKJMANAGE_SALPRO_APPROVE',null)==true}">
						<input type="submit" name="approve_pass" value="审阅通过" onclick="return addApproveCheck(10);" />
						<input type="submit" name="approve_fail" value="审阅不通过" onclick="return addApproveCheck(5);" />
					</c:if>
					<c:if test="${'true'==isApprover && it:checkPermit('QKJ_QKJMANAGE_SALPRO_APPROVE',null)==true}">
						<s:submit name="active_approveDel" value="撤销最后一次审阅" action="close_approveDel" onclick="return isOp('确定进行此操作?');" />
					</c:if>
				</div>
			</s:form>
		</div>
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
	
	$(function(){
		$("#approveFrom").dialog({ autoOpen : false,
		modal : true });
	});

	function openApprove(){
		$("#approveFrom").dialog("open");
	}

	//add_approve_flag
	function addApproveCheck(flag){
		if (window.confirm("确定要审阅吗?")) {
			//alert(flag);
			$("#add_approve_flag").val(flag);
			return true;
		} else {
			return false;
		}
	}
</script>
</html>