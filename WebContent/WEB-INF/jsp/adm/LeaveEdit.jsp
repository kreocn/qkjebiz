<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工时管理--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-timepicker-addon.js" />"></script>
<body>
<!--  0出差 1请假 2加班 3换休 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		(<s:if test="leave.leave_type==0">出差</s:if><s:if test="leave.leave_type==1">请假</s:if><s:if test="leave.leave_type==2">加班</s:if><s:if test="leave.leave_type==3">换休</s:if><s:if test="leave.leave_type==4">补签</s:if>)
		<span class="opb lb op-area"><a href="<s:url action="leave_relist" namespace="/adm" />">返回列表</a></span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="leave_load" namespace="/adm" method="post" theme="simple">
	<s:hidden name="leave.leave_type" /><s:hidden name="leave.check_status" /><s:hidden name="leave.acheck_status" />
	<div class="label_con">
		<s:if test="'mdy' == viewFlag">
		<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">申请编号:</div>
            <div class="label_rwben"><s:property value="leave.uuid" /><s:hidden name="leave.uuid" title="申请编号" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">当前状态:</div>
            <div class="label_rwbenx">
            	<div class="zhuangtai">
				业务:
				<s:if test="leave.check_status==0">新申请</s:if>
				<s:if test="leave.check_status==5"><span class="message_error">已退回(${leave.check_user_name})</span></s:if>
				<s:if test="leave.check_status==10"><span class="message_warning">待审核</span></s:if>
				<s:if test="leave.check_status==15"><span class="message_pass">主管/办事处已审(${leave.check_user_name})</span></s:if>
				<s:if test="leave.check_status==20"><span class="message_pass">经理/大区已审(${leave.check_user_name})</span></s:if>
				<s:if test="leave.check_status==30"><span class="message_pass">运营总监已审(${leave.check_user_name})</span></s:if>
				<s:if test="leave.check_status==40"><span class="message_pass">业务副总已审(${leave.check_user_name})</span></s:if>
				</div>
				<div class="zhuangtai">
				人事:
				<s:if test="leave.check_status==5"><span class="message_error">已退回</span></s:if>
				<s:elseif test="leave.acheck_status==0">未审核</s:elseif>
				<s:if test="leave.acheck_status==8"><span class="message_pass">已受理(${leave.acheck_user_name})</span></s:if>
				<s:if test="leave.acheck_status==10"><span class="message_pass">人事经理已审(${leave.acheck_user_name})</span></s:if>
				<s:if test="leave.acheck_status==20"><span class="message_pass">行政副总已审(${leave.acheck_user_name})</span></s:if>
				<s:if test="leave.acheck_status==30"><span class="message_pass">总经理已审(${leave.acheck_user_name})</span></s:if>
				</div>
            </div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben nw">
            	<span class="label_rwb">
            	${leave.leave_dept_name}
				<s:hidden id="userdept_codeid" name="leave.leave_dept" readonly="true" />
				</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人:</div>
            <div class="label_rwben label_rwb">
            	${leave.leave_user_name}
            	<s:hidden id="membermanagerid" name="leave.leave_user" readonly="true" />
            </div>
		</div>
		</div>
        </s:if>
        <s:if test="'add' == viewFlag">
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben nw">
            	<s:textfield id="userdept_nameid" name="leave.leave_dept_name" readonly="true" cssClass="validate[required]" />
				<s:hidden id="userdept_codeid" name="leave.leave_dept" />
            </div>
			<!-- <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" /> -->
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人:</div>
            <div class="label_rwben label_rwb">
            	<s:textfield name="leave.leave_user_name" readonly="true" cssClass="validate[required]" />
            	<s:hidden id="leave_user" name="leave.leave_user" />
            	<!--<s:select id="membermanagerid" cssClass="selectKick validate[required]" name="leave.leave_user" list="#{}" headerKey="" headerValue="--请选择--" />-->
            </div>
		</div>
		</div>
        </s:if>
        
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">开始时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb"><input id="leave_leave_start" name="leave.leave_start" type="text" class="datepicker validate[required,custom[date]]" value="${it:formatDate(leave.leave_start,'yyyy-MM-dd')}"  /></span>
				<span class="label_rwb_s"><s:textfield id="leave_leave_start_time" name="leave.leave_start_time"  class="validate[required]" /></span>
				<!--<span class="message_prompt nowrap">如果是一整天,时间请选00:00</span>-->
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">结束时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb"><input id="leave_leave_end" type="text"  class="datepicker validate[required,custom[date]]" name="leave.leave_end" title="结束日期" value="${it:formatDate(leave.leave_end,'yyyy-MM-dd')}" dataType="date" controlName="结束日期" /></span>
				<span class="label_rwb_s"><s:textfield id="leave_leave_end_time" name="leave.leave_end_time" title="结束时间" dataLength="0,15" controlName="结束时间" cssClass="time_input" /></span>
            </div>
		</div>
		
		<!-- 不签单没有共计 -->
		<s:if test="leave.leave_type!=4">
		<div class="label_hang">
            <div class="label_ltit">共计:</div>
            <div class="label_rwben">
            	<span class="label_rwb_s nw"><s:textfield name="leave.totle" title="共计" dataLength="0,10" dataType="number" controlName="共计"  cssClass="time_input" /> 天</span>
            </div>
		</div>
		</s:if>
        </div>
        <div class="label_main">
        <s:if test="leave.leave_type==1">
		<div class="label_hang">
            <div class="label_ltit">请假类型:</div>
            <div class="label_rwben">
            	<div class="label_rwb"><s:select name="leave.leave_mold" list="#{'0':'年假','1':'病假','2':'事假','3':'婚假','4':'产假','5':'丧假','6':'陪产假','7':'其他' }" /></div>
            </div>
		</div>
		</s:if>
		<s:elseif test="leave.leave_type==0">
		<div class="label_hang">
            <div class="label_ltit">出差地点:</div>
            <div class="label_rwben label_rwb">
            	<s:textfield name="leave.leave_mold" class="validate[required]" />
            </div>
		</div>
		<div class="label_hang">
            <div class="label_ltit">同行人员:</div>
            <div class="label_rwbenx"><s:textfield name="leave.peer" title="同行人员" cssClass="label_hang_linput validate[required,maxSize[255]]" /></div>
        </div>
		</s:elseif>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">事由:</div>
            <div class="label_rwbenx label_hang_linput">
            <div class="note_area">
	            <s:if test="leave.check_status>=10">${leave.cause}</s:if>
				<s:else><s:textarea name="leave.cause" title="详细说明" cssClass="xheditorArea validate[maxSize[65535]]" /></s:else>
				<div class="clear"></div>
			</div>
            </div>
        </div>
        </div>
		<s:if test="leave.check_status>=5">
		<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">审核意见:</div>
            <div class="label_rwbenx">
            	<s:textarea name="leave.check_note" cssClass="label_hang_linput validate[maxSize[65535]]" />
            </div>
       </div>
       </div>
       </s:if>
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
            	<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ADD')">
					<s:submit name="add" value="确定" action="leave_add" cssClass="input-blue" />
					</s:if>
				</s:if>
				<s:elseif test="leave.check_status<10 && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_MDY')">
					<s:submit name="save" value="保存" action="leave_save" cssClass="input-blue" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK0')">
					<s:submit name="check0" value="报审" action="leave_check0" cssClass="input-yellow" onclick="return isOp('确定执行此操作?');" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_DEL')">
					<s:submit name="delete" value="删除" action="leave_del" cssClass="input-red" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<s:if test="leave.check_status>=10 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_APPROVE')">
								<input type="button" value="审阅" onclick="openApprove();" />
					</s:if>
				<!-- {0:'新申请',5:'已退回',10:'待审核',20:'经理/大区已审',30:'运营总监已审',40:'业务副总已审' } -->
				<s:if test="leave.check_status>=10 && leave.check_status<20">
				<s:if test="leave.check_status==10&&leave.leave_type==0&&leave.leave_dept.substring(0,3)=='211'&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK9')">
					<!-- 添加办事处经理已审 -->
					<s:submit name="leave_check9" cssClass="input-green" value="主管/办事处经理-审核通过" action="leave_check9" onclick="return isOp('确定执行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
						<s:submit name="leave_check5" value="主管/办事处经理-审核不通过" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
					</s:if>
				</s:if>
				<s:elseif test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK10')">
					<s:submit name="leave_check10" cssClass="input-green" value="经理/大区-审核通过" action="leave_check10" onclick="return isOp('确定执行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
						<s:submit name="leave_check5" value="经理/大区-审核不通过" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
					</s:if>
				</s:elseif>
				</s:if>
				
				<s:if test="leave.check_status==20&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK20')">
					<s:submit name="leave_check20" cssClass="input-green" value="总监-审核通过" action="leave_check20" onclick="return isOp('确定执行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
						<s:submit name="leave_check5" value="总监-审核不通过" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
					</s:if>
				</s:if>
				<s:if test="leave.check_status==30&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK30')">
					<s:submit name="leave_check30" cssClass="input-green" value="业务副总-审核通过" action="leave_check30" onclick="return isOp('确定执行此操作?');" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
						<s:submit name="leave_check5" value="业务副总-审核不通过" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
					</s:if>
				</s:if>
				<!-- {0:'未审核',10:'人事经理已审',20:'人事副总已审',30:'总经理已审' } -->
				<s:if test="leave.check_status>=20">
					<s:if test="leave.acheck_status==0&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ACHECK8')">
						<s:submit name="leave_acheck8" cssClass="input-green" value="已受理" action="leave_acheck8" onclick="return isOp('确定执行此操作?');" />
					</s:if>
					
					<s:if test="(leave.acheck_status==0 || leave.acheck_status==8)&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ACHECK0')">
						<s:submit name="leave_acheck0" cssClass="input-green" value="人事经理-审核通过" action="leave_acheck0" onclick="return isOp('确定执行此操作?');" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
							<s:submit name="leave_check5" value="人事经理-审核不通过" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
						</s:if>
					</s:if>
					<s:if test="leave.acheck_status==10&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ACHECK10')">
						<s:submit name="leave_acheck10" cssClass="input-green" value="行政副总-审核通过" action="leave_acheck10" onclick="return isOp('确定执行此操作?');" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
							<s:submit name="leave_check5" value="行政副总-审核不通过" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
						</s:if>
					</s:if>
					<s:if test="leave.acheck_status==20&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_ACHECK20')">
						<s:submit name="leave_acheck20" cssClass="input-green" value="总经理-审核通过" action="leave_acheck20" onclick="return isOp('确定执行此操作?');" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')">
							<s:submit name="leave_check5" value="总经理-审核不通过" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
						</s:if>
					</s:if>
				</s:if>
				<s:if test="leave.check_status>=10&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5')&&@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_CHECK5X')">
					<s:submit name="leave_check5" value="直接退回" action="leave_check5" cssClass="input-red" onclick="return isOp('确定执行此操作?');" />
				</s:if>
				<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="leave_relist" namespace="/adm" />');" />
            </div>
		</div>
		</div>
	</div>
	</s:form>
	<div id="approveFrom" class="label_con idialog" title="审阅信息">
			<s:form name="form1" action="leave_approve" cssClass="validForm" namespace="/adm" method="post" theme="simple">
				<input type="hidden" name="leave.uuid" value="${leave['uuid']}" />
				<input type="hidden" id="add_approve_flag" name="approve.flag" />
				<div class="label_main">
					<textarea name="approve.advice" rows="3"></textarea>
				</div>
				<div class="label_main tac" style="padding: 5px 0;">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_APPROVE')">
						<input type="submit" name="approve_pass" value="审阅通过" onclick="return addApproveCheck(10);" />
						<input type="submit" name="approve_fail" value="审阅不通过" onclick="return addApproveCheck(5);" />
					</s:if>
					<s:if test="'true'==isApprover && @org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_LEAVE_APPROVEDELLAST')">
						<s:submit name="active_approveDel" value="撤销最后一次审阅" action="leave_approveDel" onclick="return isOp('确定进行此操作?');" />
					</s:if>
				</div>
			</s:form>
		</div>
		<script type="text/javascript">
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
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_dept = '${leave.leave_dept}';
$(function(){
	if(curr_dept!='') {
		loadManagers(curr_dept,'${leave.leave_user}');
	}
	$('#leave_leave_end').datepicker("destroy").datetimepicker({<s:if test="leave.leave_type!=4">stepMinute: 15,</s:if>altField: "#leave_leave_end_time"});
	$('#leave_leave_start').datepicker("destroy").datetimepicker({<s:if test="leave.leave_type!=4">stepMinute: 15,</s:if>altField: "#leave_leave_start_time"});
});
</script>
</body>
</html>