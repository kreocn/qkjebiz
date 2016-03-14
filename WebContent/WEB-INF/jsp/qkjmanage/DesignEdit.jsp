<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动申请单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body onload="check();">
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			${path}
			<div class="opb lb op-area noprint">
				<p class="more_j">更多操作</p>
				<div class="mcz_list subHide">
					<a class="input-gray" href="<s:url namespace="/qkjmanage" action="design_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a>
					<s:if test="40<=active.sd_status">
						<a href="<s:url namespace="/qkjmanage" action="active_view"><s:param name="active.uuid" value="active.uuid" /></s:url>">转到打印页面</a>
					</s:if>
				</div>
			</div>
		</div>
		<s:form id="editForm" name="editForm" cssClass="validForm" action="active_load" namespace="/qkjmanage" method="post" theme="simple">
		<s:hidden name="perWorkFlag" value="%{perWorkFlag}"></s:hidden>
		<s:hidden name="nextFlag" value="%{nextFlag}"></s:hidden>
			<div class="label_con">
				<s:if test="'mdy' == viewFlag">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">申请编号:</div>
							<div class="label_rwben">${active.uuid}<s:hidden name="active.uuid" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">原编号:</div>
							<div class="label_rwben">${active.uid }</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">申请人员:</div>
							<div class="label_rwben">${active.apply_user_name}</div>
						</div>
					</div>
					</s:if>
					
					<s:if test="'mdy' == viewFlag">
						<s:if test="active.apply_user==userappid">
							<div class="label_main">
							<div class="label_hang">
										<div class="label_ltit">申请部门:</div>
										<div class="label_rwbenx">
										<s:select  name="active.apply_dept" list="getapply_depts" listKey="apply_dept" listValue="apply_dept_name"	 cssClass="validate[required]" />
										</div>
								</div>
							</div>
						</s:if>
						<s:else>
						
						<div class="label_main">
							<div class="label_hang">
										<div class="label_ltit">申请部门:</div>
										<div class="label_rwbenx">${active.apply_dept_name}
										<s:hidden name="active.apply_dept" value="%{active.apply_dept}"></s:hidden>
										</div>
								</div>
							</div>
						
						</s:else>
					</s:if>
					<s:else>
						<div class="label_main">
							<div class="label_hang">
										<div class="label_ltit">申请部门:</div>
										<div class="label_rwbenx">
										<select name="active.apply_dept" class="validate[required]">
											<s:iterator value="getapply_depts" status="sta">
											<option value ="${apply_dept }" 
											<s:if test="apply_dept==userdepta">selected="selected"</s:if>
											>${apply_dept_name }</option>
											</s:iterator>
										</select>
										</div>
								</div>
							</div>
					</s:else>
				
					<s:if test="'mdy' == viewFlag">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">状态:</div>
							<div class="label_rwbenx">
								<div class="zhuangtai" <s:if test="%{active.status==0}">
                title="${it:formatDate(activeTime.stars,'yyyy-MM-dd HH:mm:ss')}"
                </s:if> <s:if test="%{active.status==1}">
                 title="${it:formatDate(activeTime.sing,'yyyy-MM-dd HH:mm:ss')}"
                </s:if>
									<s:if test="%{active.status==2}">
                 title="${it:formatDate(activeTime.spass,'yyyy-MM-dd HH:mm:ss')}"
                </s:if> <s:if test="%{active.status==3}">
                 title="${it:formatDate(activeTime.starj,'yyyy-MM-dd HH:mm:ss')}"
                </s:if>
									<s:if test="%{active.status==4}">
                 title="${it:formatDate(activeTime.jing,'yyyy-MM-dd HH:mm:ss')}"
                </s:if> <s:if test="%{active.status==5}">
                 title="${it:formatDate(activeTime.jpass,'yyyy-MM-dd HH:mm:ss')}"
                </s:if>>
									申请单状态:
									<s:if test="active.status==-1">
										<font class="message_error">已作废</font>
									</s:if>
									<s:if test="active.status==0">新申请</s:if>
									<s:if test="active.status==1">
										<font class="message_warning">申请审批中</font>
									</s:if>
									<s:if test="active.status==2">
										<font class="message_pass">申请通过-可以执行</font>
									</s:if>
									<s:if test="active.status==3">开始结案</s:if>
									<s:if test="active.status==4">
										<font class="message_warning">结案审批中</font>
									</s:if>
									<s:if test="active.status==5">
										<font class="message_pass">结案通过</font>
									</s:if>
								</div>
								<div class="zhuangtai" title="${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')}">
									销售部审核状态:
									<s:if test="active.sd_status==0">新单</s:if>
									<s:if test="active.sd_status==5">
										<font class="message_error">审核退回</font>(${active.sd_user_name})</s:if>
									<s:if test="active.sd_status==10">
										<font class="message_warning">待审核</font>
									</s:if>
									<s:if test="active.sd_status==20">
										<font class="message_pass">办事处已审</font>(${active.sd_user_name})</s:if>
									<s:if test="active.sd_status==30">
									
									<s:if test="active.apply_dept.substring(0,1)==4">
											<font class="message_pass">财务已审</font>(${active.sd_user_name})
										</s:if>
										<s:else>
											<font class="message_pass">大区已审</font>(${active.sd_user_name})
										</s:else>
									
										</s:if>
									<s:if test="active.sd_status==40">
										<font class="message_pass">总监已审</font>(${active.sd_user_name})</s:if>
									<s:if test="active.sd_status==50">
										<font class="message_pass">副总已审</font>(${active.sd_user_name})</s:if>
									<s:if test="active.sd_status==60">
										<font class="message_pass">总经理已审</font>(${active.sd_user_name})</s:if>
										
								</div>
								<div class="zhuangtai" title="${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')}">
									销管部审核状态:
									<s:if test="active.smd_status==0">未签收</s:if>
									<s:if test="active.smd_status==5">
										<font class="message_error">审核退回</font>(${active.smd_user_name})</s:if>
									<s:if test="active.smd_status==10">
										<font class="message_warning">已签收</font>
									</s:if>
									<s:if test="active.smd_status==30">
										<font class="message_pass">销管经理已审</font>(${active.smd_user_name})</s:if>
									<s:if test="active.smd_status==40">
										<font class="message_pass">销管部经理已审</font>(${active.smd_user_name})</s:if>
									<s:if test="active.smd_status==50">
										<font class="message_pass">销管副总已审</font>(${active.smd_user_name})</s:if>
										<s:if test="active.smd_status==60">
										<font class="message_pass">总经理已审</font>(${active.smd_user_name})</s:if>
										<s:if test="active.smd_status==70">
										<s:if test="active.apply_dept.substring(0,1)!=4">
										<font class="message_pass">副总已审</font>(${active.smd_user_name})</s:if>
										<s:else>
										<font class="message_pass">董事会已审</font>(${active.smd_user_name})
										</s:else></s:if>
								</div>
								<div class="zhuangtai" <s:if test="%{active.fd_status!=0}">title="${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')}"</s:if>>
								<s:if test="active.apply_dept.substring(0,1)==4">
									股份公司：
								</s:if>
								<s:else>
								财务审核状态:
								</s:else>
									<s:if test="active.fd_status==0">未确认</s:if>
									<s:if test="active.fd_status==5">
										<font class="message_error">审核退回</font>(${active.fd_user_name})</s:if>
									<s:if test="active.fd_status==10">
										<font class="message_pass">已审</font>(${active.fd_user_name})</s:if>
								</div>

								<s:hidden name="active.status" />
								<s:hidden name="active.sd_status" />
								<s:hidden name="active.smd_status" />
								<span id="message"><s:property value="message" /></span>
							</div>
						</div>
					</div>
				</s:if>

				<s:if test="%{active.status>=1 }">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">门店名称:</div>
							<div class="label_rwbenx">${active.design_name }</div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">类型:</div>
							<div class="label_rwbenx">${active.design_type}</div>
						</div>
					</div>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">制作材料:</div>
								<div class="label_rwben">${active.store_material }</div>
							</div>
						</div>
						<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">使用日期:</div>
							<div class="label_rwben2">
								<span class="label_rwb nw"> ${it:formatDate(active.plan_start,'yyyy-MM-dd')} </span> <span class="label_rwb nw"> ${it:formatDate(active.plan_end,'yyyy-MM-dd')} </span>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">数量:</div>
							<div class="label_rwben">${active.design_num }</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">单价:</div>
							<div class="label_rwben">${active.design_price }</div>
						</div>
						
						<div class="label_hang">
							<div class="label_ltit">尺寸:</div>
							<div class="label_rwben">${active.store_size}</div>
						</div>
						
						<div class="label_hang">
							<div class="label_ltit">总价:</div>
							<div class="label_rwben">${active.design_total}</div>
						</div>
						
						<div class="label_hang">
							<div class="label_ltit">费用承担:</div>
							<div class="label_rwben">${active.assumed }</div>
						</div>
						
						
					</div>

				</s:if>
				<s:else>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">门店名称:</div>
							<div class="label_rwbenx">
								<s:textfield name="active.design_name" title="主题" cssClass="label_hang_linput validate[required,maxSize[255]]" />
							</div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">类型:</div>
							<div class="label_rwbenx">
								<s:textfield name="active.design_type" title="类型" cssClass="label_hang_linput validate[required,maxSize[255]]" />
							</div>
						</div>
					</div>
					
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">制作材料:</div>
							<div class="label_rwbenx">
								<s:textfield name="active.store_material" title="类型" cssClass="label_hang_linput validate[required,maxSize[255]]" />
							</div>
						</div>
					</div>
					
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">使用日期:</div>
							<div class="label_rwben2">
								<span class="label_rwb nw"> <input class="datepicker iI iI-f validate[required,custom[date]]" type="text" name="active.plan_start" title="从" value="${it:formatDate(active.plan_start,'yyyy-MM-dd')}" />
								</span> <span class="label_rwb nw"> <input class="datepicker iI iI-t validate[required,custom[date]]" type="text" name="active.plan_end" title="到" value="${it:formatDate(active.plan_end,'yyyy-MM-dd')}" />
								</span>
							</div>
						</div>
						
						<div class="label_hang">
							<div class="label_ltit">数量:</div>
							<div class="label_rwben">
								<s:textfield name="active.design_num" title="数量"  cssClass="validate[required,custom[integer]]"/>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">单价:</div>
							<div class="label_rwben">
								<s:textfield name="active.design_price" title="单价" cssClass="validate[required,custom[number]]"/>
							</div>
						</div>
						
						<div class="label_hang">
							<div class="label_ltit">尺寸:</div>
							<div class="label_rwben">
								<s:textfield name="active.store_size" title="执行人" cssClass="validate[required,maxSize[128]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">总价:</div>
							<div class="label_rwben">
								<s:textfield name="active.design_total" title="总价" cssClass="validate[required,custom[number]]"/>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">费用承担:</div>
							<div class="label_rwben">
								<s:textfield name="active.assumed" title="执行人" cssClass="validate[required,maxSize[128]]" />
							</div>
						</div>
						
						
						
					</div>
				</s:else>


				<s:if test="%{active.status>=1 }">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">方案说明/照片:</div>
							<div class="label_rwbenx"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="note_area">
							${active.note}
							<div class="clear"></div>
						</div>
					</div>

				</s:if>
				<s:else>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">方案说明/照片:</div>
							<div class="label_rwbenx"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="note_area">
							<s:if test="'add' == viewFlag || active.status==0">
								<s:textarea name="active.note" title="详细说明" cssClass="xheditorArea validate[maxSize[65535]]" />
							</s:if>
							<s:else>${active.note}</s:else>
							<div class="clear"></div>
						</div>
					</div>
				</s:else>



				<!-- 西北：（申请）办事处，总监（或副总）（结案）办事处，销管，大区，总监（或副总） -->
				<!--北京：（其它）办事处，大区，总监，财务（红酒）总监，财务  -->
				<!-- 省外：办事处，大区，总监 ，财务-->
				<!-- 传奇：办事处，财务，副总，总经理，董事会，财务 -->
				<!--新疆：跳过销管  -->
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<font color="red"><span id="messages"></span></font>
							<c:if test="${'add' == viewFlag && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_ADD',null)==true}">
								<s:submit id="add" name="add" value="增加" action="design_add" cssClass="input-blue" />
							</c:if>
							<s:if test="null != active && 'mdy' == viewFlag && active.status==0">
								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_MDY',null)==true}">
									<s:submit name="save" value="保存" action="design_save" cssClass="input-blue" />
								</c:if>
								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS0',null)==true}">
									<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="mdyStatus0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
								</c:if>
								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_DEL',null)==true}">
									<s:submit id="delete" name="delete" value="删除" action="design_del" onclick="return isDel();" cssClass="input-red" />
								</c:if>
							</s:if>
							<%-- <s:elseif test="null != active && 'mdy' == viewFlag && (active.status==1&&active.sd_status>=40&&active.smd_status>=30)">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS1')">
				<s:submit id="mdyStatus1" name="mdyStatus1" value="申请通过-可以执行" action="mdyStatus1" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
				</s:if>
				</s:elseif> --%>
							<c:if test="${(active.status==1 || active.status==2) && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS_1',null)==true}">
								<s:submit id="active_mdyStatus_1" name="active_mdyStatus_1" value="作废" action="active_mdyStatus_1" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
							</c:if>
							<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="design_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" />
							<c:if test="${(active.status==1 || active.status==2) && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_TH',null)==true}">
								<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="退回" action="mdyActiveSDStatusT" onclick="return isOp('确定执行此操作?将退回到未审核状态');" />
							</c:if>
							<c:if test="${40<=active.sd_status}">
								<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="active_view"><s:param name="active.uuid" value="active.uuid" /></s:url>');" value="转到打印页面" />
							</c:if>
						</div>
					</div>
				</div>
				<s:if test="null != active && (active.status==1||active.status==2) && active.fd_status!=10">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">销售审核:</div>
							<div class="label_rwbenx">
								<c:if test="${10==active.sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS20',active.apply_dept)==true}">
								<s:submit cssClass="input-green" value="办事处-审核通过" action="mdyActiveSDStatus20" onclick="return isOp('确定执行此操作?');" />
								<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								<s:if test="active.apply_dept.substring(0,1)==4">
								<c:if test="${20==active.sd_status && 30==active.smd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS10',active.apply_dept)==true}">
									<s:submit id="mdyActiveSDStatus10" name="mdyActiveSDStatus10" cssClass="input-green" value="财务-审核通过" action="mdyActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								</s:if>
								<s:else>
								<c:if test="${20==active.sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS10',active.apply_dept)==true}">
									<s:submit id="mdyActiveSDStatus10" name="mdyActiveSDStatus10" cssClass="input-green" value="经理/大区-审核通过" action="mdyActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								</s:else>
								
								<c:if test="${10==active.sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS25',active.apply_dept)==true}">
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								<c:if test="${30==active.sd_status && 30==active.smd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS30',active.apply_dept)==true}">
									<s:if test="active.apply_dept.substring(0,1)!=2 && active.apply_dept.substring(0,1)!=5 && active.apply_dept.substring(0,1)!=3 || active.apply_dept.substring(0,3)!='312'">
									<s:submit id="mdyActiveSDStatus30" name="mdyActiveSDStatus30" cssClass="input-green" value="运营总监-审核通过" action="mdyActiveSDStatus30" onclick="return isOp('确定执行此操作?');" />
									
									<s:if test="active.apply_dept.substring(0,3)=='220'">
									<s:submit cssClass="input-green" value="送审到副总" action="mdyActiveSDStatus30Two" onclick="return isOp('确定执行此操作?');" />
									</s:if>
									
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
									</s:if>
								</c:if>
								<c:if test="${40==active.sd_status && active.smd_status>=40 && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS40',active.apply_dept)==true}">
									<s:submit id="mdyActiveSDStatus40" name="mdyActiveSDStatus40" cssClass="input-green" value="业务副总-审核通过" action="mdyActiveSDStatus40" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								<div class="statusInline">
									销售部审核状态:
									<s:if test="active.sd_status==0">初始状态</s:if>
									<s:if test="active.sd_status==5">
										<font class="message_error">审核退回</font>(${active.sd_user_name} ${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.sd_status==10">
										<font class="message_warning">待审核</font>
									</s:if>
									<s:if test="active.sd_status==20">
										<font class="message_pass">办事处已审</font>(${active.sd_user_name} ${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.sd_status==30">
										<s:if test="active.apply_dept.substring(0,1)==4">
										<font class="message_pass">财务已审</font>(${active.sd_user_name} ${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')})
										</s:if>
										<s:else>
										<font class="message_pass">大区已审</font>(${active.sd_user_name} ${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')})
										</s:else>
										</s:if>
									<s:if test="active.sd_status==40">
										<font class="message_pass">总监已审</font>(${active.sd_user_name} ${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.sd_status==50">
										<font class="message_pass">副总已审</font>(${active.sd_user_name} ${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>

								</div>
							</div>
						</div>
					</div>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">销管审核:</div>
							<div class="label_rwbenx">
								<c:if test="${10==active.smd_status && active.sd_status>=20 && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SMDSTATUS10',active.apply_dept)==true}">
									<s:submit id="mdyActiveSMDStatus10" name="mdyActiveSMDStatus10" cssClass="input-green" value="销管经理-审核通过" action="mdyActiveSMDStatus10" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSMDStatus5" name="mdyActiveSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								
								<c:if test="${30==active.smd_status && active.sd_status==40 && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SMDSTATUS50',active.apply_dept)==true}">
									<s:submit id="mdyActiveSMDStatus50" name="mdyActiveSMDStatus50" cssClass="input-green" value="销管部经理-审核通过" action="mdyActiveSMDStatus50" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSMDStatus5" name="mdyActiveSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								<c:if test="${40==active.smd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SMDSTATUS40',active.apply_dept)==true}">
									<s:submit id="mdyActiveSMDStatus40" name="mdyActiveSMDStatus40" cssClass="input-green" value="销管副总-审核通过" action="mdyActiveSMDStatus40" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSMDStatus5" name="mdyActiveSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								<%-- <c:if test="${active.smd_status==50 && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS50',active.apply_dept)==true}">
									<s:submit id="mdyActiveSDStatus50" name="mdyActiveSDStatus50" cssClass="input-green" value="总经理-审核通过" action="mdyActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if> --%>
								
								
								<s:if test="active.apply_dept.substring(0,3)!='312' && active.apply_dept.substring(0,1)!=4">
								<c:if test="${(30>=active.sd_status && active.smd_status<60 && 30==active.smd_status || active.smd_status==50) && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS50',active.apply_dept)==true}">
									<s:submit id="mdyActiveSDStatus50" name="mdyActiveSDStatus50" cssClass="input-green" value="总经理-审核通过" action="mdyActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />
									<s:if test="active.apply_dept.substring(0,3)=='220'">
									<s:submit cssClass="input-green" value="送审到副总" action="mdyActiveSDStatus30Two" onclick="return isOp('确定执行此操作?');" />
									</s:if>
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								</s:if>
								<s:else>
								<c:if test="${active.smd_status==50 && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SDSTATUS50',active.apply_dept)==true}">
									<s:submit id="mdyActiveSDStatus50" name="mdyActiveSDStatus50" cssClass="input-green" value="总经理-审核通过" action="mdyActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								</s:else>
								
								<c:if test="${active.smd_status>=60 &&active.smd_status<70 && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SMDSTATUS60',active.apply_dept)==true}">
									<s:if test="active.apply_dept.substring(0,1)!=4">
									<s:submit id="mdyActiveSDStatus50" name="mdyActiveSDStatus50" cssClass="input-green" value="副总-审核通过" action="mdyActiveSMDStatus70" onclick="return isOp('确定执行此操作?');" />
									</s:if>
									<s:else>
									<s:submit id="mdyActiveSDStatus50" name="mdyActiveSDStatus50" cssClass="input-green" value="董事会-审核通过" action="mdyActiveSMDStatus70" onclick="return isOp('确定执行此操作?');" />
									</s:else>
									<s:submit id="mdyActiveSDStatus5" name="mdyActiveSDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
									
								</c:if>
								<div class="statusInline">
									销管部审核状态:
									<s:if test="active.smd_status==0">未签收</s:if>
									<s:if test="active.smd_status==5">
										<font class="message_error">审核退回</font>(${active.smd_user_name} ${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.smd_status==10">
										<font class="message_warning">已签收</font>
									</s:if>
									<s:if test="active.smd_status==30">
										<font class="message_pass">销管经理已审</font>(${active.smd_user_name} ${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.smd_status==40">
										<font class="message_pass">销管部经理已审</font>(${active.smd_user_name} ${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.smd_status==50">
										<font class="message_pass">销管副总已审</font>(${active.smd_user_name} ${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.smd_status==60">
										<font class="message_pass">总经理已审</font>(${active.smd_user_name} ${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.smd_status==70">
										<s:if test="active.apply_dept.substring(0,1)!=4">
									<font class="message_pass">副总已审</font>
									</s:if>
									<s:else>
									<font class="message_pass">董事会已审</font>
									</s:else>
										董事会已审(${active.smd_user_name} ${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
								</div>
							</div>
						</div>
					</div>
				</s:if>
				<s:if test="null != active&&(active.status>=1)">
					<div class="label_main">
						<div class="label_hang">
						<s:if test="active.apply_dept.substring(0,1)==4">
						<div class="label_ltit">股份公司:</div>
							<div class="label_rwbenx">
								<c:if test="${active.smd_status>=70 && 10!=active.fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_FDSTATUS10',active.apply_dept)==true}">
									<s:submit id="mdyActiveFDSTATUS10" name="mdyActiveFDSTATUS10" cssClass="input-green" value="股份公司-审核通过" action="mdyActiveFDSTATUS10" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveFDStatus5" name="mdyActiveFDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDStatus" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								<div class="statusInline">
									股份公司审核状态:
									<s:if test="active.fd_status==0">未确认</s:if>
									<s:if test="active.fd_status==5">
										<font class="message_error">审核退回</font>(${active.fd_user_name} ${it:formatDate(active.fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.fd_status==10">
										<font class="message_pass">已审</font>(${active.fd_user_name} ${it:formatDate(active.fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
								</div>
							</div>
						</s:if>
						<s:else>
						<div class="label_ltit">财务审核:</div>
							<div class="label_rwbenx">
							<!-- 
								<s:if test="%{(active.apply_dept.substring(0,2)=='21' || active.apply_dept.substring(0,2)=='30') && active.smd_status!=50}">
									<c:if test="${null != active && active.sd_status>=40 && 10!=active.fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_FDSTATUS10',active.apply_dept)==true}">
										<s:submit id="mdyActiveFDSTATUS10" name="mdyActiveFDSTATUS10" cssClass="input-green" value="财务-审核通过" action="mdyActiveFDSTATUS10" onclick="return isOp('确定执行此操作?');" />
										<s:submit id="mdyActiveFDStatus5" name="mdyActiveFDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDStatus" onclick="return isOp('确定执行此操作?');" />
									</c:if>
								</s:if> -->
								<c:if test="${active.smd_status>=50 && 10!=active.fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_FDSTATUS10',active.apply_dept)==true}">
									<s:submit id="mdyActiveFDSTATUS10" name="mdyActiveFDSTATUS10" cssClass="input-green" value="财务-审核通过" action="mdyActiveFDSTATUS10" onclick="return isOp('确定执行此操作?');" />
									<s:submit id="mdyActiveFDStatus5" name="mdyActiveFDStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDStatus" onclick="return isOp('确定执行此操作?');" />
								</c:if>
								<div class="statusInline">
									财务部审核状态:
									<s:if test="active.fd_status==0">未确认</s:if>
									<s:if test="active.fd_status==5">
										<font class="message_error">审核退回</font>(${active.fd_user_name} ${it:formatDate(active.fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									<s:if test="active.fd_status==10">
										<font class="message_pass">财务已审</font>(${active.fd_user_name} ${it:formatDate(active.fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
								</div>
							</div>
						</s:else>
							
						</div>
					</div>
				</s:if>
			</div>
		</s:form>
	</div>
		
		<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	</div>
	<!-- HIDDEN AREA END -->
	
	<script type="text/javascript">
										$(function(){
											$("#editForm :input").change(function(){
												//if()cellarOrder_check0 10 15 20
												//$("#rebates_mdyRebatesStatus0").attr("disabled","disabled");
												if ($("#mdyStatus0").length > 0) {
													$("#mdyStatus0").attr("disabled", "disabled");
												}

												$("#messages").text("请先保存后才能做其他操作!");
											});
										});
									</script>
</body>
</html>