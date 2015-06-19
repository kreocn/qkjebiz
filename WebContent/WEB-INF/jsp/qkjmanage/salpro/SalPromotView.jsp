<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
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
				<s:if test="salstate!=1">
			${path} 
			<span class="opb lb op-area"> <a href="<s:url action="salPromot_list" namespace="/salpro"></s:url>">促销活动列表</a>
					</span>
				</s:if>
			</div>
			<!-- 页面修改 -->
			<s:form id="editForm" name="editForm" cssClass="validForm" action="salPromot_add" namespace="/salpro" method="post" theme="simple">
				<div class="label_con">
					<s:if test="null != salPromot">
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">编号:</div>
								<div class="label_rwb">${salPromot.uuid }</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">添加部门:</div>
								<div class="label_rwben">${salPromot.add_user_dept_name }</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">添加人:</div>
								<div class="label_rwben">${salPromot.add_user_name }</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">范围:</div>
								${salPromot.sal_scopDept_name }
							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">审核状态:</div>
								<div class="label_rwbenx">
									<div class="zhuangtai">
										单据状态:
										<!-- 申请单状态 0:新申请 1:申请审批中 2:申请通过 -->
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
							<div class="label_ltit">签字:</div>
							<div class="label_rwbenx">
								<s:iterator value="allsigns" status="sta">
									<div class="zhuangtai bgcw">
										<s:if test="puser_sign!=null">
											<s:if test="puser_sign==null">	(${puser_name})</s:if>
											<s:else>
												<s:if test="%{sign==null}">
												<span class="user_sign"><img src="${puser_sign}" /></span>
												<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd HH:mm:ss')}</span>
												</s:if>
												<s:else>
												<s:if test="sign.sign50!=puser_sign">
												<span class="user_sign"><img src="${puser_sign}" /></span>
												<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd')}</span>
												</s:if>
												<s:elseif test="sign.sign40!=puser_sign">
												<span class="user_sign"><img src="${puser_sign}" /></span>
												<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd')}</span>
												</s:elseif>
												<s:elseif test="sign.sign60!=puser_sign">
												<span class="user_sign"><img src="${puser_sign}" /></span>
												<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd')}</span>
												</s:elseif>
												<s:elseif test="sign.sign70!=puser_sign">
												<span class="user_sign"><img src="${puser_sign}" /></span>
												<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd')}</span>
												</s:elseif>
												<s:elseif test="sign.sign30!=puser_sign">
												<span class="user_sign"><img src="${puser_sign}" /></span>
												<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd')}</span>
												</s:elseif>
												<s:else>
												<span class="user_sign"><img src="${puser_sign}" /></span>
												<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd')}</span>
												</s:else>
												</s:else>
											</s:else>
										</s:if>
									</div>
								</s:iterator>
							</div>
						</div>
					</div>
					
					<div class="label_main label_main_sep"></div>
					<div class="label_main">
						<div class="label_hang label_hang_sign">
							<div class="label_ltit">财务部:</div>
							<div class="label_rwbenx label_rwb_sign">
								(签字/日期)
								<s:if test="sign!=null && sign.sign50!=null">
									<span class="user_sign"><img src="${sign.sign50}" /></span>

								</s:if>
							</div>
						</div>
					</div>

					<div class="label_main label_main_sep"></div>
					<div class="label_main">
						<div class="label_hang label_hang_sign">
							<div class="label_ltit">销管部经理:</div>
							<div class="label_rwbenx label_rwb_sign">
								(签字/日期)
								<s:if test="sign!=null  && sign.sign40!=null">
									<span class="user_sign"><img src="${sign.sign40}" /></span>
								</s:if>
							</div>
						</div>
					</div>

					<div class="label_main label_main_sep"></div>
					<div class="label_main">
						<div class="label_hang label_hang_sign">
							<div class="label_ltit">销管副总:</div>
							<div class="label_rwbenx label_rwb_sign">
								(签字/日期)
								<s:if test="sign!=null  && sign.sign60!=null">
									<span class="user_sign"><img src="${sign.sign60}" /></span>
								</s:if>
							</div>
						</div>
					</div>

					<div class="label_main label_main_sep"></div>
					<div class="label_main">
						<div class="label_hang label_hang_sign">
							<div class="label_ltit">总经理:</div>
							<div class="label_rwbenx label_rwb_sign">
								(签字/日期)
								<s:if test="sign!=null  && sign.sign70!=null">
									<span class="user_sign"><img src="${sign.sign70}" /></span>
								</s:if>
							</div>
						</div>
					</div>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">主题:</div>
							<div class="label_rwben">${salPromot.sal_title }</div>
						</div>
					</div>

					<div class="label_main">

						<div class="label_hang">
							<div class="label_ltit">申请时间:</div>
							<div class="label_rwbenx">${it:formatDate(salPromot.add_time,'yyyy-MM-dd hh:mm:ss')}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">活动时间:</div>
							<div class="label_rwbenx">${it:formatDate(salPromot.startime,'yyyy-MM-dd')}&nbsp;至&nbsp;${it:formatDate(salPromot.endtime,'yyyy-MM-dd')}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">返利系数:</div>
							<div class="label_rwben">${salPromot.rebate }</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">许可范围:</div>
							<div class="label_rwben label_rwb">
								<span class="label_rwb"> <s:select id="sal_scopUs" name="salPromot.sal_scopUs" cssClass="selectKick" list="#{1:'公有',2:'私有'}" headerKey="" headerValue="--请选择--" onchange="pub();" />
								</span>
							</div>
						</div>

					</div>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">范围说明:</div>
							<div class="label_rwben">${salPromot.sal_scop }</div>
						</div>
					</div>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">促销方案:</div>
						</div>
					</div>
					<div class="label_main">
						<div class="projs">${salPromot.sal_plan}</div>
					</div>

					<s:if test="salstate!=1">
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">相关操作:</div>
								<div class="label_rwbenx">
									<span id="message"><s:property value="message" /></span> <span class="opb lb op-area noprint"><input type="button" onclick="window.print();" value="打印本页" />&nbsp;</span> <input type="button" class="input-gray" value="返回"
										onclick="linkurl('<s:url action="salPromot_list" namespace="/salpro"><s:param name="salPromot.type" value="%{salPromot.type}"></s:param></s:url>');" />
								</div>
							</div>
						</div>
					</s:if>
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
</script>
</html>