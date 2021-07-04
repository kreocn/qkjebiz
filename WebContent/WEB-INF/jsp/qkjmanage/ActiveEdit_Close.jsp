<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动申请单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<style type="text/css">
.active_icost {
	padding: 3px 5px;
}

.active_icost_left {
	
}

.active_icost_right {
	
}

.active_p_title {
	border-bottom: #666 dashed 1px; text-indent: 2px; font-weight: bold; padding-bottom: 5px; margin-bottom: 5px;
}

.active_p_title_second {
	margin-top: 6px;
}

.active_p_list ul {
	padding: 0; margin: 0 0 0 5px; list-style: none;
}

.active_p_list li {
	line-height: 25px; height: 25px; clear: both;
}

.active_p_list li:hover {
	color: #AA0000;
}

.active_p_list span {
	display: block; float: left;
}

.active_p_list .p_n {
	width: 150px;
}

.active_p_list .p_p {
	width: 80px; text-align: center;
}

.active_p_list .p_m {
	width: 80px; text-align: center;
}

.active_p_list .p_t {
	width: 100px; text-align: center;
}

.active_p_list .p_x {
	width: 180px; text-align: left;
}

.active_p_list .p_a {
	float: right;
}

.active_p_list .p_x2 {
	width: 200px; text-align: left;
}

.ui-autocomplete {
	z-index: 200;
}

.money_div {
	padding: 4px; color: #333; border-radius: 4px; border: 1px solid #aaa; margin: 4px;
}

.p_tm {
	text-indent: 70%;
}

#active_remark,#active_remark textarea {
	font-size: 14px;
}

.approve_list {
	
}

.approve_ad_time,.approve_check_user,.approve_flag,.approve_advice {
	font-weight: bold;
}

.approve_flag_fail {
	color: #FF0000;
}

.approve_flag_pass {
	color: #008000;
}
</style>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>

<body onload="checks();">
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">
				<div class="opb lb op-area noprint">
					<p class="more_j">更多操作</p>
					<div class="mcz_list subHide">
						<a class="input-gray" href="<s:url namespace="/qkjmanage" action="active_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a>
						<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_HISTORY',null)==true}">
							<!-- <a class="input-gray" href="<s:url namespace="/qkjmanage" action="active_history"><s:param name="active.uuid" value="active.uuid" /></s:url>">查看操作记录</a> -->
							<a href="javascript:;" onclick="openCustomerView(${active.uuid});">查看操作记录</a>
						</c:if>
						<s:if test="active.status >= 4">
							<a href="<s:url namespace="/qkjmanage" action="active_closeView"><s:param name="active.uuid" value="active.uuid"></s:param></s:url>">转到打印页面</a>
						</s:if>
						<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_NEXTACTIVE',null)==true}">
							<s:if test="%{maxUid!=active.uuid}">
								<a href="<s:url namespace="/qkjmanage" action="active_nextListClose"><s:param name="viewFlag">relist</s:param><s:param name="befUid" value="active.uuid" /><s:param name="up" value="1" /></s:url>">上一页</a>
							</s:if>
							<s:if test="%{minUid!=1}">
								<a href="<s:url namespace="/qkjmanage" action="active_nextListClose"><s:param name="viewFlag">relist</s:param><s:param name="befUid" value="active.uuid" /></s:url>">下一页</a>
							</s:if>
						</c:if>
					</div>
				</div>
			</div>
			<s:form id="editForm" name="editForm" cssClass="validForm" action="active_load" namespace="/qkjmanage" method="post" theme="simple">
				<s:hidden name="active.apply_dept" value="%{active.apply_dept}"></s:hidden>
				<div class="label_con">
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
							<div class="label_ltit">申请部门:</div>
							<div class="label_rwbenx">${active.apply_dept_name}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">申请人员:</div>
							<div class="label_rwben">${active.apply_user_name}</div>
						</div>
					</div>
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
								<div class="zhuangtai" title="${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')}">
									销售部审核状态:
									<s:if test="active.close_sd_status==0">新单</s:if>
									<s:if test="active.close_sd_status==5">
										<font class="message_error">审核退回</font>(${active.close_sd_user_name})</s:if>
									<s:if test="active.close_sd_status==10">
										<font class="message_warning">待审核</font>
									</s:if>
									<s:if test="active.close_sd_status==20">
										<font class="message_pass">办事处已审</font>(${active.close_sd_user_name})</s:if>
										
										<s:if test="active.close_sd_status==25">
										<font class="message_pass">初审</font>(${active.close_sd_user_name})</s:if>
										
										<s:if test="active.close_sd_status==26">
											<font class="message_pass">区域经理已审</font>(${active.close_sd_user_name})
									</s:if>
									<s:if test="active.close_sd_status==30">
											<font class="message_pass">业务部经理已审</font>(${active.close_sd_user_name})
									</s:if>
									<s:if test="active.close_sd_status==40">
										<font class="message_pass">总监已审</font>(${active.close_sd_user_name})</s:if>
									<s:if test="active.close_sd_status==50">
										<font class="message_pass">副总已审</font>(${active.close_sd_user_name})</s:if>
									<s:if test="active.close_sd_status==60">
										<font class="message_pass">总经理已审</font>(${active.close_sd_user_name})</s:if>

									<s:if test="active.close_sd_status==70">
										<font class="message_pass">营销中心副总已审</font>(${active.close_sd_user_name})</s:if>
								</div>
								<div class="zhuangtai" title="${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')}">
									销管部审核状态:
									<s:if test="active.close_smd_status==0">未签收</s:if>
									<s:if test="active.close_smd_status==5">
										<font class="message_error">审核退回</font>(${active.close_smd_user_name})</s:if>
									<s:if test="active.close_smd_status==10">
										<font class="message_warning">已签收</font>
									</s:if>
									<s:if test="active.close_smd_status==30">
										<font class="message_pass">销管经理已审</font>(${active.close_smd_user_name})</s:if>
									<s:if test="active.close_smd_status==40">
										<font class="message_pass">销管部经理已审</font>(${active.close_smd_user_name})</s:if>
									<s:if test="active.close_smd_status==50">
										<font class="message_pass">销管副总已审</font>(${active.close_smd_user_name})</s:if>

								</div>
								<div class="zhuangtai" <s:if test="%{active.close_fd_status!=0}">title="${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')}"</s:if>>
									<s:if test="active.apply_dept.substring(0,1)==4">
									股份公司：
								</s:if>
									<s:else>
								财务审核状态:
								</s:else>
									<s:if test="active.close_fd_status==0 || active.fd_status==null">未确认</s:if>
									<s:if test="active.close_fd_status==5">
										<font class="message_error">审核退回</font>(${active.close_fd_name})</s:if>
									<s:if test="active.close_fd_status==10">
										<font class="message_pass">已审</font>(${active.close_fd_name})</s:if>
										<s:if test="active.close_fd_status==20">
										<font class="message_pass">财务经理已审</font>(${active.close_fd_name})</s:if>
										<s:if test="active.close_fd_status==30">
										<font class="message_pass">营销中心已审</font>(${active.close_fd_name})</s:if>
								</div>
								<div class="zhuangtai" <s:if test="%{active.close_nd_status!=0}">title="${it:formatDate(active.close_nd_time,'yyyy-MM-dd HH:mm:ss')}"</s:if>>
									数据中心审核状态:
									<s:if test="active.close_nd_status==0 || active.close_nd_status==null">未确认</s:if>
									<s:if test="active.close_nd_status==5">
										<font class="message_error">审核退回</font>(${active.close_nd_name})</s:if>
									<s:if test="active.close_nd_status==10">
										<font class="message_pass">数据中心已审</font>(${active.close_nd_name})</s:if>
								</div>
								<s:hidden name="active.status" />
								<s:hidden name="active.close_sd_status" />
								<s:hidden name="active.close_smd_status" />
								<span id="message"><s:property value="message" /></span>
							</div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">主题:</div>
							<div class="label_rwbenx">${active.theme}</div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">目的:</div>
							<div class="label_rwbenx">${active.purpose}</div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">活动时间:</div>
							<div class="label_rwben2 nw">${it:formatDate(active.plan_start,'yyyy-MM-dd')}-${it:formatDate(active.plan_end,'yyyy-MM-dd')}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">活动地点:</div>
							<div class="label_rwben">${active.address}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">执行人:</div>
							<div class="label_rwben">${active.person}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">活动类型:</div>
							<div class="label_rwben label_rwb">
								<s:select id="sd_status" name="active.active_type" cssClass="selectKick validate[required]" list="#{1:'一桌式品鉴会',2:'公关赠酒',3:'会议赞助',4:'赛事赞助',5:'晚宴赞助',6:'婚宴赞助',7:'活动推广',8:'工业旅游',9:'门店试饮',10:'其它'}" headerKey="" headerValue="--请选择--" />
							</div>
						</div>
						
						
						<div class="label_hang">
							<div class="label_rwben">
								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYTYPE',null)==true}">
									<s:submit value="修改类型" action="mdyActiveType" />
								</c:if>
							</div>
						</div>
						
						<div class="label_hang">
					            <div class="label_ltit">费用类型:</div>
					            <div class="label_rwben label_rwb">
									 <s:if test="active.cost_types==1">渠道建设</s:if>
									 <s:elseif test="active.cost_types==2">消费者建设</s:elseif>
									 <s:elseif test="active.cost_types==3">基础运营</s:elseif>
									 <s:elseif test="active.cost_types==4">品牌费用</s:elseif>
									 <s:else>无</s:else>
					            </div>
					     </div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">活动预期:</div>
							<div class="label_rwbenx">${active.expect}</div>
						</div>
					</div>
					<div class="label_main">
						<div class="lb_xxsm" style="border-color: #059c77;">
							<p class="lb_yjtit fy_hide">预计活动费用</p>
							<div class="lb_lgsfy">
								<p class="lb_yjtit">
									公司预计费用
									<c:if test="${active.status==0 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD',null)==true}">
										<input type="button" id="addProduct" value="添加酒品" />
									</c:if>
									<c:if test="${active.status==0 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_ADD',null)==true}">
										<input type="button" id="addPosm" value="添加物料" />
									</c:if>
								</p>
								<div class="lb_yjcon">
									<p class="lb_gstit">公司提供酒品</p>
									<p class="lb_gstit">非海拔系列</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>品名</th>
											<th>单价</th>
											<th>数量(瓶)</th>
											<th>合计</th>
										</tr>
										<s:iterator value="otherActiveProducts" status="sta">
											<tr>
												<td class="nw">${product_name}</td>
												<td class="nw">￥${per_price}</td>
												<td class="nw">${num}</td>
												<td class="nw">￥${total_price}</td>
											</tr>
										</s:iterator>
									</table>

									<p class="lb_gstit">海拔系列</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>品名</th>
											<th>单价</th>
											<th>数量(瓶)</th>
											<th>合计</th>
										</tr>
										<s:iterator value="indActiveProducts" status="sta">
											<tr>
												<td class="nw">${product_name}</td>
												<td class="nw">￥${per_price}</td>
												<td class="nw">${num}</td>
												<td class="nw">￥${total_price}</td>
											</tr>
										</s:iterator>
									</table>

									<p class="lb_gstit">公司销售物料(除酒品之外的其他费用,全部算物料)</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>名目</th>
											<th>名目说明</th>
											<th>金额</th>
										</tr>
										<s:iterator value="activePosms" status="sta">
											<tr>
												<td>${title}</td>
												<td>${note}</td>
												<td class="nw">￥${total_price}</td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">公司预计费用合计</p>
									<p class="lb_jwei">￥${active.it_price}</p>
								</div>
							</div>
							<div class="lb_gsfy">
								<p class="lb_yjtit">
									参与客户&预计费用
									<c:if test="${active.status==0 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOST_ADD',null)==true}">
										<input type="button" id="addMember" value="添加客户" />
									</c:if>
								</p>
								<div class="lb_yjcon">
									<p class="lb_gstit">参与活动客户</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>客户</th>
											<th>名目</th>
											<th>名目说明</th>
											<th>金额</th>
										</tr>
										<s:iterator value="activeMemcosts" status="sta">
											<tr>
												<td><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
												<td>${title}</td>
												<td>${note}</td>
												<td class="nw">￥${total_price}</td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">客户预计费用合计</p>
									<p class="lb_jwei">￥${active.mt_price}</p>
								</div>
							</div>
							<div class="clear"></div>
							<p class="lb_yjbot">方案预计费用总计: ${active.it_price} + ${active.mt_price} = ￥${active.it_price+active.mt_price}</p>
						</div>
					</div>

					<fieldset class="clear">
						<legend>预计费用信息</legend>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">随量费用:</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
								<div class="label_rwben label_rwb">
									<s:if test="%{active.m_upprice==null}">&nbsp;(未填写)</s:if>
									<s:else>&nbsp;${active.m_upprice}</s:else>
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
								<div class="label_rwben label_rwb">
									<s:if test="%{active.m_price==null}">&nbsp;(未填写)</s:if>
									<s:else>&nbsp;${active.m_price }</s:else>
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
								<div class="label_rwben label_rwb">
									<s:if test="%{active.m_bprice==null}">&nbsp;(未填写)</s:if>
									<s:else>&nbsp;${active.m_bprice }</s:else>
								</div>
							</div>
						</div>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">市场基金:</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
								<div class="label_rwben label_rwb">
									<s:if test="%{active.f_upprice==null}">&nbsp;(未填写)</s:if>
									<s:else>&nbsp;${active.f_upprice }</s:else>
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
								<div class="label_rwben label_rwb">
									<s:if test="%{active.f_price==null}">&nbsp;(未填写)</s:if>
									<s:else>&nbsp;${active.f_price }</s:else>
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
								<div class="label_rwben label_rwb">
									<s:if test="%{active.f_bprice==null}">&nbsp;(未填写)</s:if>
									<s:else>&nbsp;${active.f_bprice }</s:else>
								</div>
							</div>
						</div>
					</fieldset>

					<div class="label_main">
						<div class="lb_xxsm" style="border-color: #f00;">
							<p class="lb_yjtit fy_hide">实际活动费用</p>
							<div class="lb_lgsfy">
								<p class="lb_yjtit">
									公司费用
									<c:if test="${active.status==3 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD',null)==true}">
										<s:url id="ladingAddProductsUrl" action="qkjm_addProducts" namespace="qkjmanage">
											<s:param name="uuidKey">active.uuid</s:param>
											<s:param name="uuidValue" value="active.uuid" />
											<s:param name="backUrl">/qkjmanage/active_load?viewFlag=mdy&</s:param>
											<s:param name="actionUrl">/qkjmanage/activeProductClose_add</s:param>
											<s:param name="keyName">activeProduct.active_id</s:param>
											<s:param name="prodName">activeProduct.product_id</s:param>
											<s:param name="perName">activeProduct.per_price</s:param>
											<s:param name="numName">activeProduct.num</s:param>
											<s:param name="totalName">activeProduct.total_price</s:param>
										</s:url>
										<input type="button" id="product" onclick="window.location.href='${ladingAddProductsUrl}';" value="添加酒品" />
									</c:if>
									<c:if test="${active.status==3 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_ADD',null)==true}">
										<input type="button" id="addPosm" value="销售物料" />
									</c:if>
								</p>
								<div class="lb_yjcon">
									<p class="lb_gstit">公司提供酒品</p>
									<p class="lb_gstit">非海拔系列</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>品名</th>
											<th>单价</th>
											<th>数量(瓶)</th>
											<th>合计</th>
											<th>操作</th>
										</tr>
										<s:iterator value="otherActiveProductsClose" status="sta">
											<tr>
												<td class="nw">${product_name}</td>
												<td class="nw">￥${per_price}</td>
												<td class="nw">${num}</td>
												<td class="nw">￥${total_price}</td>
												<td class="nw"><c:if test="${active.status==3 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL',null)==true}">
														<a href="<s:url action="activeProductClose_del"><s:param name="activeProduct.uuid" value="%{uuid}" /><s:param name="activeProduct.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</c:if></td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">海拔系列</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>品名</th>
											<th>单价</th>
											<th>数量(瓶)</th>
											<th>合计</th>
											<th>操作</th>
										</tr>
										<s:iterator value="indActiveProductsClose" status="sta">
											<tr>
												<td class="nw">${product_name}</td>
												<td class="nw">￥${per_price}</td>
												<td class="nw">${num}</td>
												<td class="nw">￥${total_price}</td>
												<td class="nw"><c:if test="${active.status==3 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL',null)==true}">
														<a href="<s:url action="activeProductClose_del"><s:param name="activeProduct.uuid" value="%{uuid}" /><s:param name="activeProduct.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</c:if></td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">公司销售物料(除酒品之外的其他费用,全部算物料)</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>名目</th>
											<th>名目说明</th>
											<th>金额</th>
											<th>操作</th>
										</tr>
										<s:iterator value="activePosmsClose" status="sta">
											<tr>
												<td>${title}</td>
												<td>${note}</td>
												<td class="nw">￥${total_price}</td>
												<td class="nw"><c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_DEL',null)==true && active.status==3}">
														<a href="<s:url action="activePosmClose_del"><s:param name="activePosm.uuid" value="%{uuid}" /><s:param name="activePosm.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</c:if></td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">公司预计费用合计</p>
									<p class="lb_jwei">￥${active.close_it_price}</p>
								</div>
							</div>
							<div class="lb_gsfy">
								<p class="lb_yjtit">
									参与客户费用
									<c:if test="${active.status==3 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOST_ADD',null)==true}">
										<input type="button" id="addMember" value="添加客户" />
									</c:if>
								</p>
								<div class="lb_yjcon">
									<p class="lb_gstit">参与活动客户</p>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>客户</th>
											<th>名目</th>
											<th>名目说明</th>
											<th>金额</th>
											<th>操作</th>
										</tr>
										<s:iterator value="activeMemcostsClose" status="sta">
											<tr>
												<td><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
												<td>${title}</td>
												<td>${note}</td>
												<td class="nw">￥${total_price}</td>
												<td class="nw"><c:if test="${active.status==3 && it:checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOST_DEL',null)==true}">
														<a href="<s:url action="activeMemcostClose_del"><s:param name="activeMemcost.uuid" value="%{uuid}" /><s:param name="activeMemcost.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</c:if></td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">客户费用合计</p>
									<p class="lb_jwei">￥${active.close_mt_price}</p>
								</div>
							</div>
							<div class="clear"></div>
							<p class="lb_yjbot cr">方案实际费用总计: ${active.close_it_price} + ${active.close_mt_price} = ￥${active.close_it_price+active.close_mt_price}</p>
						</div>
					</div>
					<s:if test="%{active.status==3}">
						<fieldset class="clear">
							<legend>费用信息</legend>
							<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">随量费用:</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
									<div class="label_rwben label_rwb">

										<s:textfield id="upprice" name="active.close_m_upprice" cssClass="validate[required,custom[number]]" />
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
									<div class="label_rwben label_rwb">
										<s:if test="%{active.close_m_price!=null}">
											<s:textfield id="price" name="active.close_m_price" cssClass="validate[required,custom[number]]" />
										</s:if>
										<s:else>
											<s:textfield id="price" name="active.close_m_price" value="%{active.close_it_price}" cssClass="validate[required,custom[number]]" />
										</s:else>
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
									<div class="label_rwben label_rwb">
										<s:textfield id="bprice" name="active.close_m_bprice" readonly="true" />
									</div>
								</div>
							</div>
							<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">市场基金:</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
									<div class="label_rwben label_rwb">
										<s:textfield id="fupprice" name="active.close_f_upprice" cssClass="validate[required,custom[number]]"></s:textfield>
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
									<div class="label_rwben label_rwb">
										<s:if test="%{active.close_f_price!=null}">
											<s:textfield id="fprice" name="active.close_f_price" cssClass="validate[required,custom[number]]"></s:textfield>
										</s:if>
										<s:else>
											<s:textfield id="fprice" name="active.close_f_price" value="%{active.close_mt_price}" cssClass="validate[required,custom[number]]"></s:textfield>
										</s:else>
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
									<div class="label_rwben label_rwb">
										<s:textfield id="fbprice" name="active.close_f_bprice" readonly="true" />
									</div>
								</div>
							</div>
						</fieldset>
					</s:if>
					<s:if test="%{active.status>3}">
						<fieldset class="clear">
							<legend>费用信息</legend>
							<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">随量费用:</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
									<div class="label_rwben label_rwb">${ active.close_m_upprice}</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
									<div class="label_rwben label_rwb">${active.close_m_price }</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
									<div class="label_rwben label_rwb">${active.close_m_bprice }</div>
								</div>
							</div>
							<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">市场基金:</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
									<div class="label_rwben label_rwb">${active.close_f_upprice }</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
									<div class="label_rwben label_rwb">${active.close_f_price }</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
									<div class="label_rwben label_rwb">${active.close_f_bprice }</div>
								</div>
							</div>
						</fieldset>
					</s:if>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">方案说明:</div>
							<div class="label_rwbenx"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="note_area">
							${active.note}
							<div class="clear"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">活动概况:</div>
							<div class="label_rwbenx"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="note_area">
							<s:if test="active.status==3">
								<s:textarea name="active.close_note" title="详细说明" cssClass="xheditorArea validate[maxSize[65535]]" />
							</s:if>
							<s:elseif test="active.status>3">
				${active.close_note}
				</s:elseif>
							<div class="clear"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">备注:</div>
							<div class="label_rwbenx label_hang_linput">
								<span class="message_prompt">任何保存/报审/审核操作都会同时保存备注</span>
								<s:textarea id="active_remark" name="active.remark" title="活动备注" cssClass="label_hang_linput inputNote validate[maxSize[65535]]" />
							</div>
						</div>
					</div>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">添加时间:</div>
							<div class="label_rwbenx">${it:formatDate(active.add_time,'yyyy-MM-dd hh:mm:ss')}</div>
						</div>
						<s:if test="%{active.status!=0}">
							<div class="label_hang">
								<div class="label_ltit">报审时间:</div>
								<div class="label_rwbenx">${it:formatDate(activeTime.baotime,'yyyy-MM-dd hh:mm:ss')}</div>
							</div>
						</s:if>

					</div>
					<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYSPE',null)==true && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SELSPE',null)==true && active.uuid!=null}">
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">特殊备注:</div>
								<div class="label_rwbenx label_hang_linput">
									<span class="message_prompt">此字段，不能直接保存，请点击"保存特殊备注"保存</span>
									<s:textarea id="spe_remark" name="active.spe_remark" title="活动备注" cssClass="label_hang_linput inputNote validate[maxSize[65535]]" />
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">&nbsp;</div>
								<s:submit cssClass="input-blue" name="mdyStatus2" value="保存特殊备注" action="mdyCloseSPE" onclick="return isOp('确定执行此操作?');" />
							</div>
						</div>
					</c:if>
					<!--<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_SELSPE',null)==true}">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">特殊备注:</div>
							<div class="label_rwbenx label_hang_linput">${active.spe_remark }</div>
						</div>
					</div>
				</c:if>-->
					<s:if test="active.status>=3">
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
					<div class="label_main noprint">
						<div class="label_hang">
							<div class="label_ltit">相关操作:</div>
							<div class="label_rwbenx">
								<s:if test="null != active">
									<c:if test="${active.status==2 && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS2',null)==true}">
										<s:submit cssClass="input-blue" name="mdyStatus2" value="结案&填写实际费用明细" action="mdyStatus2" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									<s:if test="active.status==3">
										<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_MDY',null)==true}">
											<s:submit cssClass="input-blue" name="mdyCloseActive" value="保存活动概况" action="mdyCloseActive" />
										</c:if>
										<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS3',null)==true}">
											<s:submit id="mdyStatus0" cssClass="input-yellow" name="mdyStatus3" value="结案报审" action="mdyStatus3" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									<%-- <s:if test="active.status==4&&active.close_sd_status>=40&&active.close_smd_status>=30 &&@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS4')">
				<s:submit cssClass="input-green" name="mdyStatus4" value="结案通过" action="mdyStatus4" onclick="return isOp('确定执行此操作?');" />
				</s:if> --%>
									<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS_1',null)==true}">
										<s:submit cssClass="input-red" name="active_mdyStatus_1" value="作废" action="active_mdyStatus_1" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									<c:if test="${(active.status==4 || active.status==3) && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_APPROVE',null)==true}">
										<input type="button" value="审阅" onclick="openApprove();" />
									</c:if>
								</s:if>
								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_HISTORY',null)==true}">
									<input type="button" value="查看操作记录" class="input-gray" onclick="openCustomerView(${active.uuid});" />
								</c:if>
								<input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="active_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" />
								<c:if test="${active.status==4 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_TH',null)==true}">
									<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="退回" action="mdycloseTH" onclick="return isOp('确定执行此操作?将退回到未审核状态');" />
								</c:if>
								<s:if test="active.status >= 4">
									<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="active_closeView"><s:param name="active.uuid" value="active.uuid"></s:param></s:url>');" value="转到打印页面" />
								</s:if>
								<font color="red"><span id="messages"></span></font>
							</div>
						</div>
					</div>
					<s:if test="null != active && active.status>=4 && active.status!=5">
						<div class="label_main noprint">
							<div class="label_hang">
								<div class="label_ltit">销售部审核:</div>
								<div class="label_rwbenx">
									<c:if test="${10==active.close_sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS20',active.apply_dept)==true}">
										<s:submit cssClass="input-green" value="办事处/负责人-审核通过" action="mdyCloseActiveSDStatus20" onclick="return isOp('确定执行此操作?');" />
										<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>

									<s:if test="active.apply_dept.substring(0,3)=='220'"><!-- 甘肃 隆东（办事处，大区，销冠，财务，总经理）其它（办事处，销冠，财务，总经理）-->
										<s:if test="active.apply_dept.substring(0,4)=='2201'"><!-- 甘肃 隆东-->
											<c:if test="${20==active.close_sd_status  && active.close_smd_status>=30 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10',active.apply_dept)==true}">
												<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus10" value="业务部经理-审核通过" action="mdyCloseActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
											</c:if>
											<c:if test="${30==active.close_sd_status && 30==active.close_smd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10',active.apply_dept)==true}">
												<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus10" value="财务-审核通过" action="mdyCloseActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
												<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:if>
										<s:else>
											<c:if test="${active.close_sd_status>=20 && 10!=active.close_fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_FDSTATUS10',active.apply_dept)==true}">
												<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus10" value="财务-审核通过" action="mdyActiveFDCSTATUS10Two" onclick="return isOp('确定执行此操作?');" />
												<s:submit cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if>
											
										</s:else>

									</s:if>
									<s:else>
										<%-- <s:if test="active.apply_dept.substring(0,5)=='31411' || active.apply_dept.substring(0,7)=='3120320'">
										<c:if test="${20==active.close_sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS26',active.apply_dept)==true}">
											<s:submit cssClass="input-green" value="区域经理-审核通过" action="mdyCloseActiveSDStatus26" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${26==active.close_sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus10" value="业务部经理-审核通过" action="mdyCloseActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										</s:if> --%>
										<s:if test="active.apply_dept.substring(0,3)=='408'">
										<c:if test="${20==active.close_sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS26',active.apply_dept)==true}">
											<s:submit cssClass="input-green" value="区域经理-审核通过" action="mdyCloseActiveSDStatus26" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${26==active.close_sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus10" value="业务部经理-审核通过" action="mdyCloseActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										</s:if>
										<s:else>
										
										
										<s:if test="active.apply_dept.substring(0,3)=='314'">
										<c:if test="${20==active.close_sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS26',active.apply_dept)==true}">
											<s:submit cssClass="input-green" value="区域经理-审核通过" action="mdyCloseActiveSDStatus26" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${26==active.close_sd_status  && active.close_smd_status==30  && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus10" value="业务部经理-审核通过" action="mdyCloseActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										</s:if>
										<s:else>
										<c:if test="${(20==active.close_sd_status || 26==active.close_sd_status) && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS10',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus10" value="业务部经理-审核通过" action="mdyCloseActiveSDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										</s:else>
										</s:else>
										
									</s:else>

									<c:if test="${10==active.close_sd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS25',active.apply_dept)==true}">
										<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									
										<s:if test="(active.apply_dept.substring(0,1)!=2 && active.apply_dept.substring(0,1)!=5 && active.apply_dept.substring(0,1)!=3 )|| active.apply_dept.substring(0,3)=='312'">
											<c:if test="${active.close_sd_status>=20 && active.close_sd_status<40 && 30==active.close_smd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS30',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus30" value="运营总监-审核通过" action="mdyCloseActiveSDStatus30" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:if>
									
									<c:if test="${40==active.close_sd_status && active.close_smd_status>=40  && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS40',active.apply_dept)==true}">
										<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus40" value="业务副总-审核通过" action="mdyCloseActiveSDStatus40" onclick="return isOp('确定执行此操作?');" />
										<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>

									<s:if test="active.apply_dept.substring(0,3)!='312' && active.apply_dept.substring(0,1)!=4">
									
										<s:if test="active.apply_dept.substring(0,1)==5">
										<c:if test="${(active.close_sd_status>=20 && 30==active.close_smd_status) && active.close_sd_status<60  && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS50',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus50" value="总经理-审核通过" action="mdyCloseActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />

											<s:if test="active.apply_dept.substring(0,1)!=3">
												<s:submit cssClass="input-green" value="送审到副总" action="mdyCloseActiveSDStatus30Two" onclick="return isOp('确定执行此操作?');" />
											</s:if>

											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									
									<s:if test="active.apply_dept.substring(0,3)=='220'"><!-- 甘肃总经理 -->
									<c:if test="${active.close_fd_status==10 && active.close_sd_status<60  && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS50',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus50" value="总经理-审核通过" action="mdyCloseActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />

											<s:if test="active.apply_dept.substring(0,1)!=3">
												<s:submit cssClass="input-green" value="送审到副总" action="mdyCloseActiveSDStatus30Two" onclick="return isOp('确定执行此操作?');" />
											</s:if>

											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									<s:elseif test="active.apply_dept.substring(0,1)==3"><!-- 北京总经理 -->
									<c:if test="${active.close_sd_status==30 && 30==active.close_smd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS50',active.apply_dept)==true}">
											<s:submit cssClass="input-green" name="mdyCloseActiveSDStatus50" value="总经理-审核通过" action="mdyCloseActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:elseif>
										
									</s:if>
									<s:else>
										<c:if test="${(active.close_smd_status==50 || active.close_fd_status==20) && active.close_sd_status<60&& it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS50',active.apply_dept)==true}">
											<s:submit cssClass="input-green" value="总经理-审核通过" action="mdyCloseActiveSDStatus50" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-green" value="送审到副总" action="mdyCloseActiveSDStatus30Two" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:else>

									<s:if test="active.apply_dept.substring(0,3)!='312' && active.apply_dept.substring(0,1)==3">
										<!-- 北京红酒 以外副 总在业务部经理之后出现 -->
										<c:if test="${30==active.close_sd_status && 30==active.close_smd_status && active.fstauts!=1 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS60',active.apply_dept)==true}">
											<s:submit cssClass="input-green" value="营销中心副总-审核通过" action="mdyCloseActiveSDStatus60" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									<s:else>

										<c:if test="${active.close_sd_status==60 && active.fstauts!=1&& it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SDSTATUS60',active.apply_dept)==true}">
											<s:submit cssClass="input-green" value="营销中心副总-审核通过" action="mdyCloseActiveSDStatus60" onclick="return isOp('确定执行此操作?');" />
											<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="审核不通过" action="mdyCloseActiveSDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:else>
									<s:if test="active.close_sd_status>0">
										<div class="statusInline">
											销售部审核状态:
											<s:if test="active.close_sd_status==0">新单</s:if>
											<s:if test="active.close_sd_status==5">
												<font class="message_error">审核退回</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="active.close_sd_status==10">
												<font class="message_warning">待审核</font>
											</s:if>
											<s:if test="active.close_sd_status==20">
												<font class="message_pass">办事处已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
												
												<s:if test="active.close_sd_status==25">
												<font class="message_pass">初审通过</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>

											<s:if test="active.close_sd_status==30">
												<s:if test="active.apply_dept.substring(0,1)==4">
													<font class="message_pass">财务已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})
											</s:if>
											<s:else>
													<font class="message_pass">业务部经理已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})
											</s:else>
											</s:if>
											<s:if test="active.close_sd_status==40">
												<font class="message_pass">总监已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="active.close_sd_status==50">
												<font class="message_pass">副总已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>

											<s:if test="active.close_sd_status==60">
												<font class="message_pass">总经理已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>

											<s:if test="active.close_sd_status==70">
												<font class="message_pass">营销中心副总已审</font>(${active.close_sd_user_name} ${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										</div>
									</s:if>
								</div>
							</div>
						</div>
						<div class="label_main noprint">
							<div class="label_hang">
								<div class="label_ltit">销管部审核:</div>
								<div class="label_rwbenx">
								<%-- 	<s:if test="active.apply_dept.substring(0,3)=='220'">
									<c:if test="${10==active.close_smd_status && active.close_sd_status>=25 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS10',active.apply_dept)==true}">
										<s:submit cssClass="input-green" name="mdyCloseActiveSMDStatus10" value="销管经理-审核通过" action="mdyCloseActiveSMDStatus10" onclick="return isOp('确定执行此操作?');" />
										<s:submit cssClass="input-red" name="mdyCloseActiveSMDStatus5" value="审核不通过" action="mdyCloseActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									</s:if>
									<s:else> --%>
									<c:if test="${10==active.close_smd_status && active.close_sd_status>=20 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS10',active.apply_dept)==true}">
										<s:submit cssClass="input-green" name="mdyCloseActiveSMDStatus10" value="销管经理-审核通过" action="mdyCloseActiveSMDStatus10" onclick="return isOp('确定执行此操作?');" />
										<s:submit cssClass="input-red" name="mdyCloseActiveSMDStatus5" value="审核不通过" action="mdyCloseActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									<%-- </s:else> --%>
									<s:if test="active.apply_dept.substring(0,1)!=4">
									<c:if test="${30==active.close_smd_status && active.close_sd_status==40 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS50',active.apply_dept)==true}">
										<s:submit id="mdyCloseActiveSMDStatus50" name="mdyCloseActiveSMDStatus50" cssClass="input-green" value="销管部经理-审核通过" action="mdyCloseActiveSMDStatus50" onclick="return isOp('确定执行此操作?');" />
										<s:submit id="mdyCloseActiveSMDStatus5" name="mdyCloseActiveSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									</s:if>
									<s:else>
									<c:if test="${30==active.close_smd_status && active.close_sd_status==40 && active.close_fd_status==0  && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS50',active.apply_dept)==true}">
										<s:submit id="mdyCloseActiveSMDStatus50" name="mdyCloseActiveSMDStatus50" cssClass="input-green" value="销管部经理-审核通过" action="mdyCloseActiveSMDStatus50" onclick="return isOp('确定执行此操作?');" />
										<s:submit id="mdyCloseActiveSMDStatus5" name="mdyCloseActiveSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									</s:else>
									
									<c:if test="${40==active.close_smd_status && (active.close_sd_status>20 || active.close_fd_status==10)  && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_SMDSTATUS30',active.apply_dept)==true}">
										<s:submit cssClass="input-green" name="mdyCloseActiveSMDStatus30" value="销管副总-审核通过" action="mdyCloseActiveSMDStatus30" onclick="return isOp('确定执行此操作?');" />
										<s:submit cssClass="input-red" name="mdyCloseActiveSMDStatus5" value="审核不通过" action="mdyCloseActiveSMDStatus5" onclick="return isOp('确定执行此操作?');" />
									</c:if>

									<s:if test="active.close_smd_status>0">
										<div class="statusInline">
											销管部审核状态:
											<s:if test="active.close_smd_status==0">新单</s:if>
											<s:if test="active.close_smd_status==5">
												<font class="message_error">审核退回</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="active.close_smd_status==10">
												<font class="message_warning">已签收</font>
											</s:if>
											<s:if test="active.close_smd_status==30">
												<font class="message_pass">销管经理已审</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="active.close_smd_status==40">
												<font class="message_pass">销管部经理已审</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="active.close_smd_status==50">
												<font class="message_pass">销管副总已审</font>(${active.close_smd_user_name} ${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										</div>
									</s:if>
								</div>
							</div>
						</div>
					</s:if>

					<s:if test="null != active && active.status>=4">
						<div class="label_main">
							<div class="label_hang">
								<s:if test="active.apply_dept.substring(0,1)==4">
									<div class="label_ltit">股份公司:</div>
									<div class="label_rwbenx">
										<!-- 财务 -->
											<%-- <c:if test="${active.close_sd_status>=30 && 0==active.close_fd_status &&it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10',null)==true}">
												<s:submit  cssClass="input-green" value="会计-审核通过" action="mdyActiveFDCSTATUS101" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyActiveFDCStatus5" name="mdyActiveFDCStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if> --%>
											<s:if test="active.apply_dept.substring(0,1)==4">
											<c:if test="${active.close_smd_status>=40 && active.close_sd_status>=40 && active.close_fd_status<20 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS20',null)==true}">
												<s:submit  cssClass="input-green" value="财务经理-审核通过" action="mdyActiveFDCSTATUS20" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyActiveFDCStatus5" name="mdyActiveFDCStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if>
											</s:if>
											<s:else>
											<c:if test="${active.close_smd_status>=30  && active.close_fd_status<20 && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS20',null)==true}">
												<s:submit  cssClass="input-green" value="财务经理-审核通过" action="mdyActiveFDCSTATUS20" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyActiveFDCStatus5" name="mdyActiveFDCStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if>
											</s:else>
											
											
											<c:if test="${active.close_sd_status>=70 && 20==active.close_fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS30',null)==true}">
												<s:submit  cssClass="input-green" value="营销中心财务-审核通过" action="mdyActiveFDCSTATUS30" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyActiveFDCStatus5" name="mdyActiveFDCStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										<div class="statusInline">
											股份公司审核状态:
											<s:if test="active.close_fd_status==0 || active.fd_status==null">未确认</s:if>
											<s:if test="active.close_fd_status==5">
												<font class="message_error">审核退回</font>(${active.close_fd_name} ${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="active.close_fd_status==10">
												<font class="message_pass">已审</font>(${active.close_fd_name} ${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
												
												<s:if test="active.close_fd_status==20">
												<font class="message_pass">财务经理已审</font>(${active.close_fd_name} ${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
												
												<s:if test="active.close_fd_status==30">
												<font class="message_pass">营销中心财务已审</font>(${active.close_fd_name} ${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										</div>
									</div>
								</s:if>
								<s:else>
									<div class="label_ltit">财务审核:</div>
									<div class="label_rwbenx">
										<!-- 财务 -->
										<s:if test="%{10!=active.close_fd_status}">
											<!-- 
										<s:if test="%{(active.apply_dept.substring(0,2)=='21' || active.apply_dept.substring(0,2)=='30') && active.close_smd_status!=50}">
											<c:if test="${null != active && active.sd_status>=40 && 10!=active.fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10',null)==true}">
												<s:submit id="mdyActiveFDCSTATUS10" name="mdyActiveFDCSTATUS10" cssClass="input-green" value="财务-审核通过" action="mdyActiveFDCSTATUS10" onclick="return isOp('确定执行此操作?');" />
													<s:submit id="mdyActiveFDCStatus5" name="mdyActiveFDCStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:if> -->
										<s:if test="active.apply_dept.substring(0,3)=='312'">
											<c:if test="${active.close_sd_status>=40 && 10!=active.close_fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10',active.apply_dept)==true}">
												<s:submit id="mdyActiveFDCSTATUS10" name="mdyActiveFDCSTATUS10" cssClass="input-green" value="财务-审核通过" action="mdyActiveFDCSTATUS10" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyActiveFDCStatus5" name="mdyActiveFDCStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:if>
										<s:else>
											<c:if test="${(active.close_sd_status>=70 ||(active.close_sd_status>=60 && active.fstauts==1)) && 10!=active.close_fd_status &&it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_FDCSTATUS10',null)==true}">
												<s:submit id="mdyActiveFDCSTATUS10" name="mdyActiveFDCSTATUS10" cssClass="input-green" value="财务-审核通过" action="mdyActiveFDCSTATUS10" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyActiveFDCStatus5" name="mdyActiveFDCStatus5" cssClass="input-red" value="审核不通过" action="mdyActiveFDCSTATUS" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:else>
											
										</s:if>
										<div class="statusInline">
											财务部审核状态:
											<s:if test="active.close_fd_status==0 || active.fd_status==null">未确认</s:if>
											<s:if test="active.close_fd_status==5">
												<font class="message_error">审核退回</font>(${active.close_fd_name} ${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
											<s:if test="active.close_fd_status==10">
												<font class="message_pass">财务已审</font>(${active.close_fd_name} ${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										</div>
									</div>

								</s:else>

							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">数据中心审核:</div>
								<div class="label_rwbenx">
									<!-- 财务 -->
									<s:if test="%{10!=active.close_nd_status}">
										<s:if test="%{(active.apply_dept.substring(0,2)=='21' || active.apply_dept.substring(0,2)=='30') && active.smd_status!=50}">
											<c:if test="${null != active && active.sd_status>=40 && 10!=active.fd_status && it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_NDCSTATUS10',null)==true}">
												<s:submit id="mdyActiveNDCSTATUS10" name="mdyActiveNDCSTATUS10" cssClass="input-green" value="数据中心-审核通过" action="mdyActiveNDCSTATUS10" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyActiveNDCSTATUS5" name="mdyActiveNDCSTATUS5" cssClass="input-red" value="审核不通过" action="mdyActiveNDCSTATUS5" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:if>
										<c:if test="${(50==active.close_smd_status || 60==active.close_smd_status) &&it:checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_NDCSTATUS10',null)==true}">
											<s:submit id="mdyActiveNDCSTATUS10" name="mdyActiveNDCSTATUS10" cssClass="input-green" value="数据中心-审核通过" action="mdyActiveNDCSTATUS10" onclick="return isOp('确定执行此操作?');" />
											<s:submit id="mdyActiveNDCSTATUS5" name="mdyActiveNDCSTATUS5" cssClass="input-red" value="审核不通过" action="mdyActiveNDCSTATUS5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									<div class="statusInline">
										数据中心审核状态:
										<s:if test="active.close_nd_status==0 || active.close_nd_status==null">未确认</s:if>
										<s:if test="active.close_nd_status==5">
											<font class="message_error">审核退回</font>(${active.close_nd_name} ${it:formatDate(active.close_nd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="active.close_nd_status==10">
											<font class="message_pass">数据中心已审</font>(${active.close_nd_name} ${it:formatDate(active.close_nd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									</div>
								</div>
							</div>

						</div>
					</s:if>
				</div>

			</s:form>
		</div>
	</div>
	<!-- HIDDEN AREA BEGIN -->
	<div class="dn">
		<!-- 添加酒品 -->
		<div id="addProductForm" class="label_con idialog" title="添加酒品">
			<s:form id="form_addProductForm" name="form_addProductForm" action="activeProductClose_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">产品:</div>
						<div class="label_rwben label_rwb">
							<select name="activeProduct.product_id" title="产品" class="validate[required]">
								<option>-请选择-</option>
								<s:iterator value="products" status="sta">
									<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />'
										value='<s:property value="uuid" />'><s:property value="title" /></option>
								</s:iterator>
							</select>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">单价:</div>
						<div class="label_rwben">
							<span class="label_rwb"><s:textfield name="activeProduct.per_price" cssClass="validate[required,custom[number],maxSize[11]]" /></span>
							<div id="per_price_select_area" class="label_rwb">
								<select id="per_price_select"></select>
							</div>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">数量:</div>
						<div class="label_rwben">
							<div class="nw">
								<s:textfield name="activeProduct.num" cssClass="validate[required,custom[integer],maxSize[11]]" />
								瓶
							</div>
							<span id="ladingItemnumCase nw"></span>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">合计:</div>
						<div class="label_rwben nw">
							<s:textfield name="activeProduct.total_price" title="合计" cssClass="validate[required,custom[number],maxSize[11]]" />
							元
						</div>
					</div>
					<div class="label_hang label_button tac">
						<s:hidden name="activeProduct.active_id" value="%{active.uuid}" />
						<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCTCLOSE_ADD',null)==true}">
							<s:submit id="activeProduct_add" name="activeProduct_add" value="确定" action="activeProductClose_add" />
						</c:if>
					</div>
				</div>
			</s:form>
		</div>


		<!-- 添加销售物料(公司) -->
		<div id="addPosmForm" class="label_con idialog" title="添加销售物料(公司)">
			<s:form name="form_addPosmForm" action="activePosmClose_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">名目:</div>
						<div class="label_rwben label_rwb">
							<s:textfield name="activePosm.title" title="名目" cssClass="validate[required,maxSize[32]]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">名目说明:</div>
						<div class="label_rwben label_rwb">
							<s:textfield name="activePosm.note" title="名目说明" cssClass="validate[required,maxSize[255]]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">金额:</div>
						<div class="label_rwben label_rwb nw">
							<s:textfield name="activePosm.total_price" title="名目" cssClass="validate[required,custom[number],maxSize[11]]" />
							元
						</div>
					</div>
					<div class="label_hang label_button tac">
						<s:hidden name="activePosm.active_id" value="%{active.uuid}" />
						<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVEPOSMCLOSE_ADD',null)==true}">
							<s:submit id="add" name="add" value="确定" action="activePosmClose_add" />
						</c:if>
					</div>
				</div>
			</s:form>
		</div>

		<div id="addMemberForm" class="label_con idialog" title="添加参与客户">
			<s:form id="addMemberFormTag" name="form_addMemberForm" action="activeMemcostClose_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">会员编号:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_id" name="activeMemcost.member_id" cssClass="validate[required,maxSize[85]]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">会员手机:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_mobile" name="activeMemcost.member_mobile" cssClass="validate[custom[mobile]]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">会员名称:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="order_user_name" name="activeMemcost.member_name" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">名目:</div>
						<div class="label_rwben label_rwb">
							<s:textfield id="activeMemcost_title" name="activeMemcost.title" cssClass="validate[required]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">名目说明:</div>
						<div class="label_rwben label_rwb">
							<s:textarea id="activeMemcost_note" name="activeMemcost.note" cssClass="validate[required]" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">金额:</div>
						<div class="label_rwben label_rwb nw">
							<s:textfield id="activeMemcost_total_price" name="activeMemcost.total_price" cssClass="validate[required]" />
							元
						</div>
					</div>
					<div class="label_hang label_button tac">
						<s:hidden id="activeMemcost_active_id" name="activeMemcost.active_id" value="%{active.uuid}" />
						<s:hidden name="activeMemcost.with_score" value="0" />
						<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOSTCLOSE_ADD',null)==true}">
							<input id="addMe" type="button" value="确定" />
							<font id="addMemcost" color="red"></font>
						</c:if>
					</div>
				</div>
			</s:form>
		</div>

		<!-- 添加随量信息 -->


		<div id="viewMember" class="label_con idialog" title="客户实时信息">
			<div class="label_main">
				<div class="label_hang">
					<div class="label_ltit">会员编号:</div>
					<div id="view_member_uuid" class="label_rwben label_rwb"></div>
				</div>
				<div class="label_hang">
					<div class="label_ltit">会员手机:</div>
					<div id="view_member_mobile" class="label_rwben label_rwb"></div>
				</div>
				<div class="label_hang">
					<div class="label_ltit">会员名称:</div>
					<div id="view_member_name" class="label_rwben label_rwb"></div>
				</div>
				<div class="label_hang">
					<div class="label_ltit">随量积分:</div>
					<div id="view_member_with_score" class="label_rwben label_rwb"></div>
				</div>
			</div>
		</div>
		<div id="approveFrom" class="label_con idialog" title="审阅信息">
			<s:form name="form1" action="active_approve" cssClass="validForm" namespace="/qkjmanage" method="post" theme="simple">
				<input type="hidden" name="active.uuid" value="${active['uuid']}" />
				<input type="hidden" id="add_approve_flag" name="approve.flag" />
				<div class="label_main">
					<textarea name="approve.advice" rows="3"></textarea>
				</div>
				<div class="label_main tac" style="padding: 5px 0;">
					<c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE_APPROVE',null)==true}">
						<input type="submit" name="approve_pass" value="审阅通过" onclick="return addApproveCheck(10);" />
						<input type="submit" name="approve_fail" value="审阅不通过" onclick="return addApproveCheck(5);" />
					</c:if>
					<c:if test="${'true'==isApprover && it:checkPermit('QKJ_QKJMANAGE_ACTIVE_APPROVEDELLAST',null)==true}">
						<s:submit name="active_approveDel" value="撤销最后一次审阅" action="active_approveDel" onclick="return isOp('确定进行此操作?');" />
					</c:if>
				</div>
			</s:form>
		</div>
		<s:action name="ref_foot" namespace="/manager" executeResult="true" />
		<script type="text/javascript">
		function checks(){
			var n=${nextUuid};
			if(n!=0){
				if(confirm("操作成功,是否跳转下一条？")){
					 location.href="/qkjmanage/active_nextListClose?befUid="+${active.uuid}+"&viewFlag='relist'";
				}
			}
		}
		
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
		<script type="text/javascript">
			var add_per_price_input = $("#form_addProductForm :input[name='activeProduct.per_price']");
			var add_num_input = $("#form_addProductForm :input[name='activeProduct.num']");
			var add_total_price_input = $("#form_addProductForm :input[name='activeProduct.total_price']");
			var add_product_id = $("#form_addProductForm :input[name='activeProduct.product_id']");

			$(function(){
				add_per_price_input.bind("keyup", function(){
					add_total_price_input.val($(this).val() * add_num_input.val());

				});
				add_num_input.bind("keyup", function(){
					add_total_price_input.val($(this).val() * add_per_price_input.val());
					setDataCase();
				});

				$("#per_price_select_area").hide();
				add_product_id.bind("change", function(){
					add_per_price_input.val("");
					$("#per_price_select").clearAllOption();
					if ($(this).getSelectedAttr("data") == null || $(this).getSelectedAttr("data") == '') {
						$("#per_price_select_area").hide();
					} else {
						var ps = $(this).getSelectedAttr("data").split("#");
						if (ps.length >= 3) {
							$("#per_price_select").addOption("自定义", "");
							$("#per_price_select").addOption("市场价(" + ps[0] + ")", ps[0]);
							$("#per_price_select").addOption("团购价(" + ps[1] + ")", ps[1]);
							$("#per_price_select").addOption("出厂价(" + ps[2] + ")", ps[2]);
							if (ps[3] != '') $("#per_price_select").addOption("协议价1(" + ps[3] + ")", ps[3]);
							if (ps[4] != '') $("#per_price_select").addOption("协议价2(" + ps[4] + ")", ps[4]);
							if (ps[5] != '') $("#per_price_select").addOption("协议价3(" + ps[5] + ")", ps[5]);
							$("#per_price_select_area").fadeIn(1000);
						}
					}
				});

				$("#per_price_select").bind("change", function(){
					add_per_price_input.val($(this).val());
					add_total_price_input.val($(this).val() * add_num_input.val());
					setDataCase();
				});
			});

			function setDataCase(){
				var data_case = add_product_id.getSelectedAttr("data_case");
				var num_value = add_num_input.val();
				if (!(data_case == null || data_case == '' || num_value == null || num_value == '')) {
					$("#ladingItemnumCase").text((num_value / data_case) + '件');
				}
			}
		</script>
		<script type="text/javascript">
		$("#addMe").click(function(){
			 $.ajax({
			     type:'POST',
			     url: '/sysvip/getMember',
			     data: "params="+$("#order_user_id").val(),
			     beforeSend:function() {
			    	 $("#addMemcost").text("正在验证...");
			     },
			     success: function(data){
			    	 if(data=="false"){
			 			alert("此客户不存在\n请到[会员管理>添加会员]处添加会员信息后再继续填写.");
			 		} else if($("#activeMemcost_title").val()=='') {
			 			alert("【名目】不许为空!");
			 			$("#activeMemcost_title").focus();
			 		} else if($("#activeMemcost_note").val()=='') {
			 			alert("【名目说明】不许为空!");
			 			$("#activeMemcost_note").focus();
			 		} else if($("#activeMemcost_total_price").val()=='') {
			 			alert("【金额】不许为空!");
			 			$("#activeMemcost_total_price").focus();
			 		} else {
			 			$("#addMemberFormTag").submit();
			 		}
			    },
			    complete:function(){
			    	$("#addMemcost").text("");
			    }				    
			  });
			});
		
			$("#upprice").bind("change", function(){
				$("#bprice").val($("#upprice").val() - $("#price").val());
			});
		</script>

		<script type="text/javascript">
			$("#price").bind("change", function(){
				$("#bprice").val($("#upprice").val() - $("#price").val());
			});
		</script>


		<!-- 添加市场基金信息 -->
		<script type="text/javascript">
			$("#fupprice").bind("change", function(){
				$("#fbprice").val($("#fupprice").val() - $("#fprice").val());
			});
		</script>

		<script type="text/javascript">
			$("#fprice").bind("change", function(){
				$("#fbprice").val($("#fupprice").val() - $("#fprice").val());
			});
		</script>
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
		<script type="text/javascript">
	var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
	var infoeditor01;
	$(function(){
		$("#addMpriceForm").dialog({ autoOpen : false,
		modal : true });

		$("#addFpriceForm").dialog({ autoOpen : false,
		modal : true });

		$("#addFprice").click(function(){
			$("#addFpriceForm").dialog("open");
		});

		$("#addMprice").click(function(){
			$("#addMpriceForm").dialog("open");
		});

		$("#addProductForm").dialog({ autoOpen : false,
		modal : true });

		$("#addProduct").click(function(){
			$("#addProductForm").dialog("open");
		});

		$("#addPosmForm").dialog({ autoOpen : false,
		modal : true });
		$("#addPosm").click(function(){
			$("#addPosmForm").dialog("open");
		});
		SimpleLoadMember(ajax_url_action, function(event, ui){
			loadMember(ui.item.order_user_id);
		});
		$("#addMemberForm").dialog({ autoOpen : false,
		modal : true });
		$("#addMember").click(function(){
			$("#with_score_remain").empty();
			$("#addMemberForm").dialog("open");
		});

		$("#viewMember").dialog({ autoOpen : false,
		modal : true });
	});

	function loadMember(member_id){
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url_action;
		ajax.config._success = function(data, textStatus){
			var m = data[0];
			$("#activeMemcost_with_score").attr("dataBetween", "0," + m.with_score);
			$("#with_score_remain").text("此客户还有随量积分:" + m.with_score);
		};
		ajax.addParameter("work", "AutoComplete");
		ajax.addParameter("parameters", "privilege_id=QKJ_QKJMANAGER_AJAXLOAD_MEMBER&uuid=" + member_id);
		ajax.sendAjax();
	}

	function loadMemberInfo(member_id){
		$("#view_member_uuid").text("正在加载...");
		$("#view_member_mobile").empty();
		$("#view_member_name").empty();
		$("#view_member_with_score").empty();

		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url_action;
		ajax.config._success = function(data, textStatus){
			var m = data[0];
			$("#view_member_uuid").text(m.uuid);
			$("#view_member_mobile").text(m.mobile);
			$("#view_member_name").text(m.member_name);
			$("#view_member_with_score").text(m.with_score);
			$("#viewMember").dialog("open");
		};
		ajax.addParameter("work", "AutoComplete");
		ajax.addParameter("parameters", "privilege_id=QKJ_QKJMANAGER_AJAXLOAD_MEMBER&uuid=" + member_id);
		ajax.sendAjax();
	}
</script>
		<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var add_user='${customerRecode.add_user}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	$("#customerRecode_recode_time").datepicker();
	$("#customerRecode_next_date").datepicker();
	
	if($("#userdept_codeid").val()!='') {
		loadManagers($("#userdept_codeid").val());
	}
	createCustomerView();
 });

var sobj02;
var createCustomerView = function() {
	//http://localhost:8888/qkjmanage/customer_load?viewFlag=mdy&customer.uuid=3
	var w_width = $(window).width();
	var w_height = $(window).height();
	sobj02 = new DialogIFrame({
		src:'',
		title:"查看操作历史",
		width:w_width*0.85,
		height:w_height*0.85
	});
	sobj02.selfAction = function(val1,val2) {};
	sobj02.create();
	//sobj02.open();
};

var openCustomerView = function(customer_uuid) {
	var iframeId = sobj02.getConid() + "iframe";
	$("#"+iframeId).attr("src","/qkjmanage/active_history?active.uuid=" + customer_uuid);
	sobj02.open();
};

</script>
	</div>
	<!-- HIDDEN AREA END -->
</body>
</html>