<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
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

.ui-autocomplete {
	z-index: 200;
}

#active_remark,#active_remark textarea {
	font-size: 14px;
}

.kss {
	display: none;
}
</style>

<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			<span id="hs" class="pt">活动结案单</span> <span id="ks" class="pt kss">活动客户结案通知单</span> <span class="opb lb op-area noprint"><a href="<s:url namespace="/qkjmanage" action="active_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span> <span class="opb lb op-area noprint"><a
				href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="%{active.uuid}"></s:param></s:url>">返回修改页面</a></span> 
				<span class="opb lb op-area noprint"><input type="button" onclick="ypri();window.print();" value="打印本页" />
				&nbsp;</span>
				<span class="opb lb op-area noprint"><input type="button" onclick="indprint();" value="打印海拔系列" />&nbsp;</span> 
				<span class="opb lb op-area noprint"><input type="button" onclick="otherprint();" value="打印非海拔系列" />&nbsp;</span> 
				 <span class="opb lb op-area noprint"><input
				type="button" onclick="nopri();window.print();" value="打印结案通知单" />&nbsp;</span>
		</div>
		<s:form id="editForm" name="editForm" action="apply_list" method="get" namespace="/qkjmanage" theme="simple">
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
							<div class="zhuangtai">
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
								销售部审核:
								<s:if test="active.close_sd_status==0">新单</s:if>
								<s:if test="active.close_sd_status==5">
									<font class="message_error">审核退回</font>(${active.close_sd_user_name})</s:if>
								<s:if test="active.close_sd_status==10">
									<font class="message_warning">待审核</font>
								</s:if>
								<s:if test="active.close_sd_status==30">
									<font class="message_pass">大区已审</font>(${active.close_sd_user_name})</s:if>
								<s:if test="active.close_sd_status==40">
									<span class="message_pass">总监已审</span>(${active.close_sd_user_name})</s:if>
								<s:if test="active.close_sd_status==50">
									<font class="message_pass">副总已审</font>(${active.close_sd_user_name})</s:if>
								<s:if test="active.close_sd_status==60">
									<font class="message_pass">总经理已审</font>(${active.close_sd_user_name})</s:if>
							</div>
							<div class="zhuangtai" title="${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')}">
								销管部状态:
								<s:if test="active.close_smd_status==0">未签收</s:if>
								<s:if test="active.close_smd_status==5">
									<font class="message_error">审核退回</font>(${active.close_smd_user_name})</s:if>
								<s:if test="active.close_smd_status==10">
									<font class="message_warning">已签收</font>
								</s:if>
								<s:if test="active.close_smd_status==30">
									<span class="message_pass">销管经理已审</span>(${active.close_smd_user_name})</s:if>
								<s:if test="active.close_smd_status==40">
									<font class="message_pass">销管部经理已审</font>(${active.close_smd_user_name})</s:if>
								<s:if test="active.close_smd_status==50">
									<font class="message_pass">销管副总已审</font>(${active.close_smd_user_name})</s:if>
							</div>
							<div class="zhuangtai" title="${it:formatDate(active.close_fd_time,'yyyy-MM-dd HH:mm:ss')}">
								财务部审核状态:
								<s:if test="active.close_fd_status==0 || active.fd_status==null">未确认</s:if>
								<s:if test="active.close_fd_status==5">
									<font class="message_error">审核退回</font>(${active.close_fd_name})</s:if>
								<s:if test="active.close_fd_status==10">
									<font class="message_pass">财务已审</font>(${active.close_fd_name})</s:if>
							</div>
							<div class="zhuangtai" title="${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')}">
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
						</div>
					</div>
				</div>

				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">签字:</div>
						<div class="label_rwbenx">
							<s:iterator value="activeSing" status="sta">
								<div class="zhuangtai bgcw">
									<s:if test="puser_sign!=null ">
									<s:if test="caiActive==null||guanActive==null ||fuActive==null">
											<s:if test="caiActive!=null"><s:if test="%{caiActive.puser_sign!=puser_sign}"><span class="user_sign"><img src="${puser_sign}" /></span>
										<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd HH:mm:ss')}</span></s:if></s:if>
											<s:elseif test="guanActive!=null"><s:if test="%{guanActive.puser_sign!=puser_sign}"><span class="user_sign"><img src="${puser_sign}" /></span>
										<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd HH:mm:ss')}</span></s:if></s:elseif>
											<s:elseif test="fuActive!=null"><s:if test="%{fuActive.puser_sign!=puser_sign}"><span class="user_sign"><img src="${puser_sign}" /></span>
										<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd HH:mm:ss')}</span></s:if></s:elseif>
											</s:if>
											<s:else>
									<s:if test="%{caiActive.puser_sign!=puser_sign && guanActive.puser_sign!=puser_sign && fuActive.puser_sign!=puser_sign}">
										<span class="user_sign"><img src="${puser_sign}" /></span>
										<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd HH:mm:ss')}</span>
										</s:if>
									</s:else>
									</s:if>
								</div>
							</s:iterator>

							<%-- <div class="zhuangtai bgcw">
			<s:if test="active.close_sd_status==40">
				<s:if test="active.close_sd_user_sign==null">	(${active.close_sd_user_name})</s:if>
				<s:else><span class="user_sign"><img src="${active.close_sd_user_sign}" /></span></s:else>
				<span class="vab">${it:formatDate(active.close_sd_time,'yyyy-MM-dd HH:mm:ss')}</span>
			</s:if>
		</div>
		
		<div class="zhuangtai bgcw">
			<s:if test="active.close_smd_status==30">
				<s:if test="active.close_smd_user_sign==null">(${active.close_smd_user_name})</s:if>
				<s:else><span class="user_sign"><img src="${active.close_smd_user_sign}" /></span></s:else>
				<span class="vab">${it:formatDate(active.close_smd_time,'yyyy-MM-dd HH:mm:ss')}</span>
			</s:if>
		</div> --%>
						</div>
					</div>
				</div>

				<div class="label_main label_main_sep"></div>
				<div class="label_main">
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">财务部:</div>
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							<s:if test="caiActive!=null">
								<span class="user_sign"><img src="${caiActive.puser_sign}" /></span>

							</s:if>
						</div>
					</div>
				</div>
				<div class="label_main label_main_sep"></div>
				<div class="label_main">
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">数据中心:</div>
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							<s:if test="shuActive!=null">
								<span class="user_sign"><img src="${shuActive.puser_sign}" /></span>

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
							<s:if test="guanActive!=null">
								<span class="user_sign"><img src="${guanActive.puser_sign}" /></span>

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
							<s:if test="fuActive!=null">
								<span class="user_sign"><img src="${fuActive.puser_sign}" /></span>
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
							<s:if test="zongActive!=null">
								<span class="user_sign"><img src="${zongActive.puser_sign}" /></span>
							</s:if>
						</div>
					</div>
				</div>
				<div class="label_main label_main_sep"></div>
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
						<div class="label_rwben2 nw" style="line-height: 34px;">${it:formatDate(active.plan_start,'yyyy-MM-dd')}-${it:formatDate(active.plan_end,'yyyy-MM-dd')}</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">活动地点:</div>
						<div class="label_rwben">${active.address}</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">执行人:</div>
						<div class="label_rwben2 nw" style="line-height: 34px;">${active.person}</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">活动类型:</div>
			            <div class="label_rwben label_rwb">
							 <s:if test="active.active_type==1">一桌式品鉴会</s:if>
							 <s:if test="active.active_type==2">公关赠酒</s:if>
							 <s:if test="active.active_type==3">会议赞助</s:if>
							 <s:if test="active.active_type==4">赛事赞助</s:if>
							 <s:if test="active.active_type==5">晚宴赞助</s:if>
							 <s:if test="active.active_type==6">婚宴赞助</s:if>
							 <s:if test="active.active_type==7">活动推广</s:if>
							 <s:if test="active.active_type==8">工业旅游</s:if>
							 <s:if test="active.active_type==9">门店试饮</s:if>
							 <s:if test="active.active_type==10">其它</s:if>
							 
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
					<div class="lb_xxsm">
						<p class="lb_yjtit fy_hide">实际活动费用</p>
						<div class="lb_lgsfy">
							<p class="lb_yjtit">公司费用</p>
							<div class="lb_yjcon">
								<p class="lb_gstit">公司提供酒品</p>
								<p id="other1" class="lb_gstit">非海拔系列</p>
								<table  id="other2" width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
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
											<td class="nw"><s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL')">
													<a href="<s:url action="activeProductClose_del"><s:param name="activeProduct.uuid" value="%{uuid}" /><s:param name="activeProduct.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
												</s:if></td>
										</tr>
									</s:iterator>
								</table>
								<p id="ind1" class="lb_gstit">海拔系列</p>
								<table id="ind2" width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
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
											<td class="nw"><s:if test="active.status==3 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL')">
													<a href="<s:url action="activeProductClose_del"><s:param name="activeProduct.uuid" value="%{uuid}" /><s:param name="activeProduct.active_id" value="%{active.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
												</s:if></td>
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
									<s:iterator value="activePosmsClose" status="sta">
										<tr>
											<td>${title}</td>
											<td>${note}</td>
											<td class="nw">￥${total_price}</td>
										</tr>
									</s:iterator>
								</table>
								<p class="lb_gstit">公司费用合计</p>
								<p id="totel1" class="lb_jwei">￥${active.close_it_price}</p>
								<p id="indprice" class="lb_jwei kss ">￥${indprice} </p>
								<p id="otherprice" class="lb_jwei kss">￥${active.close_it_price-indprice}</p>
							</div>
						</div>
						<div class="lb_gsfy">
							<p class="lb_yjtit">参与客户费用</p>
							<div class="lb_yjcon">
								<p class="lb_gstit">参与活动客户</p>
								<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
									<tr>
										<th>客户</th>
										<th>名目</th>
										<th>名目说明</th>
										<th>金额</th>
									</tr>
									<s:iterator value="activeMemcostsClose" status="sta">
										<tr>
											<td><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
											<td>${title}</td>
											<td>${note}</td>
											<td class="nw">￥${total_price}</td>
										</tr>
									</s:iterator>
								</table>
								<p class="lb_gstit">客户费用合计</p>
								<p class="lb_jwei">￥${active.close_mt_price}</p>
							</div>
						</div>
						<div class="clear"></div>
						<p id="totel2"  class="lb_yjbot cr">方案实际费用总计: ${active.close_it_price} + ${active.close_mt_price} = ￥${active.close_it_price+active.close_mt_price}</p>
						<p id="indprice2" class="lb_yjbot kss">方案预计费用总计: ${indprice} + ${active.close_mt_price} = ￥${indprice+active.mt_price}</p>
						<p id="otherprice2" class="lb_yjbot kss">方案预计费用总计: ${active.close_it_price-indprice} + ${active.mt_price} = ￥${active.close_it_price-indprice+active.mt_price}</p>
					</div>
				</div>
				<fieldset class="clear">
					<legend>实际费用信息</legend>
					<div class="label_main" id="mprice">
						<div class="label_hang">
							<div class="label_ltit">随量费用:</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
							<div class="label_rwben label_rwb">
								<s:if test="%{active.close_m_upprice==null}">&nbsp;(未填写)</s:if>
								<s:else>&nbsp;${active.close_m_upprice}</s:else>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
							<div class="label_rwben label_rwb">
								<s:if test="%{active.close_m_price==null}">&nbsp;(未填写)</s:if>
								<s:else>&nbsp;${active.close_m_price }</s:else>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
							<div class="label_rwben label_rwb">
								<s:if test="%{active.close_m_bprice==null}">&nbsp;(未填写)</s:if>
								<s:else>&nbsp;${active.close_m_bprice }</s:else>
							</div>
						</div>
					</div>
					<div class="label_main" id="fprice">
						<div class="label_hang">
							<div class="label_ltit">市场基金:</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
							<div class="label_rwben label_rwb">
								<s:if test="%{active.close_f_upprice==null}">&nbsp;(未填写)</s:if>
								<s:else>&nbsp;${active.close_f_upprice }</s:else>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
							<div class="label_rwben label_rwb">
								<s:if test="%{active.close_f_price==null}">&nbsp;(未填写)</s:if>
								<s:else>&nbsp;${active.close_f_price }</s:else>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
							<div class="label_rwben label_rwb">
								<s:if test="%{active.close_f_bprice==null}">&nbsp;(未填写)</s:if>
								<s:else>&nbsp;${active.close_f_bprice }</s:else>
							</div>
						</div>
					</div>
				</fieldset>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">活动概况:</div>
						<div class="label_rwbenx label_hang_linput"></div>
					</div>
				</div>
				<div class="label_main">
					<div class="note_area">
						${active.close_note}
						<div class="clear"></div>
					</div>
				</div>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_SELSPE')">
					<div class="label_main noprint">
						<div class="label_hang">
							<div class="label_ltit">特殊备注:</div>
							<div class="label_rwbenx label_hang_linput">${active.spe_remark }</div>
						</div>
					</div>
				</s:if>

				<div class="label_main noprint">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE_TH')">
								<s:submit cssClass="input-red" name="mdyCloseActiveSDStatus5" value="退回" action="mdycloseTH" onclick="return isOp('确定执行此操作?将退回到未审核状态');" />
							</s:if>
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_STATUS_1')">
								<s:submit id="active_mdyStatus_1" name="active_mdyStatus_1" value="作废" action="active_mdyStatus_1" onclick="return isOp('确定执行此操作?');" />
							</s:if>
							<input type="button" value="返回" onclick="linkurl('<s:url action="active_relist" namespace="/qkjmanage" />');" /> <input type="button" onclick="window.print();" value="打印本页" /> <input type="button" onclick="nopri();window.print();" value="打印结案通知单" />&nbsp; <input type="button" value="返回修改页面"
								onclick="linkurl('<s:url action="active_closeLoad" namespace="/qkjmanage"><s:param name="active.uuid" value="%{active.uuid}"></s:param></s:url>');" />

							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYSHIPINFO')">	(发货信息功能已移动到列表页)</s:if>
						</div>
					</div>
				</div>
			</div>
		</s:form>
	</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript">
	function indprint(){
		yindpri();
		window.print();
		$("#totel1").removeClass("kss"); //添加样式
		$("#totel2").removeClass("kss"); //添加样式
		$("#otherprice2").addClass("kss"); //添加样式
		$("#otherprice").addClass("kss"); //添加样式
		$("#indprice").addClass("kss"); //添加样式
		$("#indprice2").addClass("kss"); //添加样式
	}
	function otherprint(){
		otherpri();
		window.print();
		$("#totel1").removeClass("kss"); //添加样式
		$("#totel2").removeClass("kss"); //添加样式
		$("#otherprice2").addClass("kss"); //添加样式
		$("#otherprice").addClass("kss"); //添加样式
		$("#indprice").addClass("kss"); //添加样式
		$("#indprice2").addClass("kss"); //添加样式
	}
	function nopri(){
		$("#mprice").addClass("noprint"); //添加样式
		$("#fprice").addClass("noprint"); //添加样式
		$("#ks").removeClass("kss"); //添加样式
		$("#hs").addClass("kss"); //添加样式
	}
	function ypri(){
		$("#mprice").removeClass("noprint"); //添加样式
		$("#fprice").removeClass("noprint"); //添加样式
		$("#hs").removeClass("kss"); //添加样式
		$("#ks").addClass("kss"); //添加样式
	}
	
	function yindpri(){
		$("#mprice").removeClass("noprint"); //添加样式
		$("#fprice").removeClass("noprint"); //添加样式
		$("#hs").removeClass("kss"); //添加样式
		$("#ks").addClass("kss"); //添加样式
		$("#ind1").removeClass("noprint"); //添加样式
		$("#ind2").removeClass("noprint"); //添加样式
		$("#other2").addClass("noprint"); //添加样式
		$("#other1").addClass("noprint"); //添加样式
		
		$("#totel1").addClass("kss"); //添加样式
		$("#totel2").addClass("kss"); //添加样式
		$("#indprice").removeClass("kss"); //添加样式
		$("#indprice2").removeClass("kss"); //添加样式
		
		$("#indprice").removeClass("noprint"); //添加样式
		$("#indprice2").removeClass("noprint"); //添加样式
		$("#otherprice").addClass("noprint"); //添加样式
		$("#otherprice2").addClass("noprint"); //添加样式
	}
	
	function otherpri(){
		$("#mprice").removeClass("noprint"); //添加样式
		$("#fprice").removeClass("noprint"); //添加样式
		$("#hs").removeClass("kss"); //添加样式
		$("#ks").addClass("kss"); //添加样式
		$("#other1").removeClass("noprint"); //添加样式
		$("#other2").removeClass("noprint"); //添加样式
		$("#ind1").addClass("noprint"); //添加样式
		$("#ind2").addClass("noprint"); //添加样式
		
		$("#totel1").addClass("kss"); //添加样式
		$("#totel2").addClass("kss"); //添加样式
		$("#otherprice").removeClass("kss"); //添加样式
		$("#otherprice2").removeClass("kss"); //添加样式
		$("#otherprice").removeClass("noprint"); //添加样式
		$("#otherprice2").removeClass("noprint"); //添加样式
		$("#indprice").addClass("noprint"); //添加样式
		$("#indprice2").addClass("noprint"); //添加样式
	}
</script>
</body>
</html>