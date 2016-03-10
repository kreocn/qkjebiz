<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>结案提货单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
#win {
	/*窗口的高度和宽度*/
	width: 300px; height: 200px;
	/*窗口的位置*/ position: absolute; top: 100px; left: 350px;
	/*开始时窗口不可见*/ display: none;
}
/*控制背景色的样式*/
#title {
	/*控制标题栏的左内边距*/
	padding-left: 3px;
}

#cotent {
	padding-left: 3px; padding-top: 5px;
}
/*控制关闭按钮的位置*/
#close {
	margin-left: 188px;
	/*当鼠标移动到X上时，出现小手的效果*/ cursor: pointer;
}
s
</style>
</head>

<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
		<div class="tab_warp main">
			<div class="dq_step">${path}
				<span class="opb lb op-area"> <s:if test="closeOrder.type==1">
						<a href="<s:url action="travel_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>">返回工业旅游列表</a>
					</s:if> <s:else>
						<a href="<s:url action="closeOrder_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a>
					</s:else>


				</span> <span class="opb lb op-area"> <s:if test="closeOrder.sd_state>30 && closeOrder.state>0">
						<a class="input-gray" href="<s:url namespace="/qkjmanage" action="closeOrder_view"><s:param name="closeOrder.uuid" value="closeOrder.uuid" /></s:url>">转到打印页面</a>
					</s:if>
				</span>
			</div>
			<s:form id="editForm" name="editForm" cssClass="validForm" action="apply_load" namespace="/qkjmanage" method="post" theme="simple">
				<s:hidden name="closeOrder.state" value="%{closeOrder.state}"></s:hidden>
				<s:hidden name="closeOrder.sd_state" value="%{closeOrder.sd_state}"></s:hidden>
				<s:hidden name="closeOrder.smd_status" value="%{closeOrder.smd_status}"></s:hidden>
				<s:hidden name="closeOrder.fd_check_state" value="%{closeOrder.fd_check_state}"></s:hidden>
				<s:hidden name="closeOrder.nd_check_state" value="%{closeOrder.nd_check_state}"></s:hidden>
				<s:hidden name="closeOrder.type" value="%{closeOrder.type}"></s:hidden>
				<s:hidden name="closeOrder.apply_id" value="%{closeOrder.apply_id}"></s:hidden>
				<div class="label_con">
					<div class="label_main">
						<s:if test="'mdy' == viewFlag">
							<div class='label_hang'>
								<div class='label_ltit'>主键:</div>
								<div class='label_rwben'>${closeOrder.uuid}<s:hidden name="closeOrder.uuid" />
								</div>
							</div>

							<div class="label_hang">
								<div class="label_ltit">单据编号:</div>
								<div class="label_rwben2">
									<s:textfield name="closeOrder.close_num" title="单据编号" />
								</div>
							</div>
						</s:if>

						<s:if test="'mdy' == viewFlag">
							<div class='label_hang'>
								<div class='label_ltit'>申请人:</div>
								<div class='label_rwben'>${closeOrder.add_user_name}</div>
							</div>
						</s:if>

						<s:if test="'mdy' == viewFlag">
							<s:if test="closeOrder.add_user==userappid">
								<div class="label_main">
									<div class="label_hang">
										<div class="label_ltit">申请部门:</div>
										<div class="label_rwbenx">
											<s:select name="closeOrder.apply_dept" list="getapply_depts" listKey="apply_dept" listValue="apply_dept_name" cssClass="validate[required]" />
										</div>
									</div>
								</div>
							</s:if>
							<s:else>

								<div class="label_main">
									<div class="label_hang">
										<div class="label_ltit">申请部门:</div>
										<div class="label_rwbenx">${closeOrder.apply_dept_name}
											<s:hidden name="closeOrder.apply_dept" value="%{closeOrder.apply_dept}"></s:hidden>
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
										<select name="closeOrder.apply_dept" class="validate[required]">
											<s:iterator value="getapply_depts" status="sta">
												<option value="${apply_dept }" <s:if test="apply_dept==userdepta">selected="selected"</s:if>>${apply_dept_name }</option>
											</s:iterator>
										</select>
									</div>
								</div>
							</div>
						</s:else>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">审核状态:</div>
								<div class="label_rwbenx">
									<div class="zhuangtai">
										单据状态:
										<!-- 申请单状态 0:新申请 1:申请审批中 2:申请通过 -->
										<s:if test="closeOrder.state==0">新单</s:if>
										<s:if test="closeOrder.state==1">
											<font class="message_warning">申请审批中</font>
										</s:if>
										<s:if test="closeOrder.state==2">
											<font class="message_warning">申请通过</font>
										</s:if>
									</div>
									<div class="zhuangtai" title="${it:formatDate(closeOrder.sd_time,'yyyy-MM-dd HH:mm:ss')}">
										销售部审核状态:
										<s:if test="closeOrder.sd_state==0">新单</s:if>
										<s:if test="closeOrder.sd_state==5">
											<font class="message_error">审核退回</font>(${closeOrder.sd_user_name})</s:if>
										<s:if test="closeOrder.sd_state==10">
											<font class="message_warning">待审核</font>
										</s:if>
										<s:if test="closeOrder.sd_state==20">
											<font class="message_pass">办事处已审</font>(${closeOrder.sd_user_name})</s:if>

										<s:if test="closeOrder.sd_state==30">
											<font class="message_pass">业务部经理已审</font>(${closeOrder.sd_user_name})</s:if>
										<s:if test="closeOrder.sd_state==40">
											<font class="message_pass">总监已审</font>(${closeOrder.sd_user_name})</s:if>
										<s:if test="closeOrder.sd_state==50">
											<font class="message_pass">副总已审</font>(${closeOrder.sd_user_name})</s:if>
									</div>

									<div class="zhuangtai" title="${it:formatDate(closeOrder.smd_time,'yyyy-MM-dd HH:mm:ss')}">
										销管部审核状态:
										<s:if test="closeOrder.smd_status==0">未签收</s:if>
										<s:if test="closeOrder.smd_status==5">
											<font class="message_error">审核退回</font>(${closeOrder.smd_user_name})</s:if>
										<s:if test="closeOrder.smd_status==10">
											<font class="message_warning">已签收</font>
										</s:if>
										<s:if test="closeOrder.smd_status==30">
											<font class="message_pass">销管经理已审</font>(${closeOrder.smd_user_name})</s:if>
										<s:if test="closeOrder.smd_status==40">
											<font class="message_pass">销管部经理已审</font>(${closeOrder.smd_user_name})</s:if>
										<s:if test="closeOrder.smd_status==50">
											<font class="message_pass">销管副总已审</font>(${closeOrder.smd_user_name})</s:if>
										<s:if test="closeOrder.smd_status==60">
											<font class="message_pass">总经理已审</font>(${closeOrder.smd_user_name})</s:if>
										<s:if test="closeOrder.smd_status==70">
										<s:if test="closeOrder.apply_dept.substring(0,1)!=4">
										<font class="message_pass">副总已审</font>
										</s:if>
										<s:else>
										<font class="message_pass">董事已审</font>
										</s:else>
											(${closeOrder.smd_user_name})</s:if>
									</div>

									<div class="zhuangtai" <s:if test="%{closeOrder.fd_check_state!=0}">title="${it:formatDate(closeOrder.fd_check_time,'yyyy-MM-dd HH:mm:ss')}"</s:if>>
										财务审核状态:
										<s:if test="closeOrder.fd_check_state==0">未确认</s:if>
										<s:if test="closeOrder.fd_check_state==5">
											<font class="message_error">审核退回</font>(${closeOrder.fd_user_name})</s:if>
										<s:if test="closeOrder.fd_check_state==10">
											<font class="message_pass">已通过审</font>(${closeOrder.fd_user_name})</s:if>
									</div>

									<div class="zhuangtai" <s:if test="%{closeOrder.nd_check_state!=0}">title="${it:formatDate(closeOrder.nd_check_time,'yyyy-MM-dd HH:mm:ss')}"</s:if>>
										数据中心审核状态:
										<s:if test="closeOrder.nd_check_state==0">未确认</s:if>
										<s:if test="closeOrder.nd_check_state==5">
											<font class="message_error">审核退回</font>(${closeOrder.nd_check_user_name})</s:if>
										<s:if test="closeOrder.nd_check_state==10">
											<font class="message_pass">已通过审</font>(${closeOrder.nd_check_user_name})</s:if>
									</div>
								</div>
							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">主题:</div>
								<div class="label_rwbenx">
									<s:textfield name="closeOrder.theme" title="主题" cssClass="label_hang_linput validate[required,maxSize[255]]" />
								</div>
							</div>
						</div>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">结案时间:</div>
								<div class="label_rwben2">
									<span class="label_rwb nw"> <input class="datepicker validate[required,custom[date]]" type="text" name="closeOrder.close_time" value="${it:formatDate(closeOrder.close_time,'yyyy-MM-dd')}" />
									</span>
								</div>
							</div>
						</div>

						<div class="label_main">
							<s:if test="'add' == viewFlag||closeOrder.type!=2">
								<div class="label_hang">
									<div class="label_ltit">会员号:</div>
									<div class="label_rwb">
										<s:textfield id="order_user_id" name="closeOrder.member_id" title="会员号" cssClass="validate[required]" />
									</div>
								</div>
							</s:if>
							<div class="label_hang">
								<div class="label_ltit">手机:</div>
								<div class="label_rwb">
									<s:textfield id="order_user_mobile" name="closeOrder.member_phone" title="手机" controlName="手机" />
								</div>
							</div>
							<s:if test="'add' == viewFlag||closeOrder.type!=2">
								<div class="label_hang">
									<div class="label_ltit">收货人姓名:</div>
									<div class="label_rwb">
										<s:textfield id="order_user_name" name="closeOrder.member_name" title="姓名" controlName="姓名" cssClass="validate[required,maxSize[85]]" />
									</div>
								</div>
							</s:if>
							<s:else>
								<div class="label_hang">
									<div class="label_ltit">收货人姓名:</div>
									<div class="label_rwb">
										<s:textfield name="closeOrder.m_name" title="姓名" controlName="姓名" cssClass="validate[required,maxSize[85]]" />
									</div>
								</div>
							</s:else>

							<div class="label_hang">
								<div class="label_ltit">名目:</div>
								<div class="label_rwben label_rwb">
									<s:textfield id="CloseOrderMemcost_title" name="closeOrder.member_title" />
								</div>
							</div>

							<div class="label_hang">
								<div class="label_ltit">金额:</div>
								<div class="label_rwben label_rwb nw">
									<s:textfield id="CloseOrderMemcost_total_price" name="closeOrder.mt_price" cssClass="validate[required,custom[number],maxSize[11]]" />
									元
								</div>
							</div>
						</div>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">名目说明:</div>
								<div class="label_rwbenx">
									<s:textarea id="CloseOrderMemcost_note" name="closeOrder.member_note" cssClass="label_hang_linput validate[maxSize[128]]" />
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">配送地点:</div>
								<div class="label_rwbenx">
									<s:textarea id="address" name="closeOrder.member_address" title="配送地点" rows="4" cssClass="label_hang_linput validate[maxSize[128]]"></s:textarea>
									<br /> 选择预设地址:<select id="selectAddress"></select>
								</div>
							</div>
						</div>

						<s:if test="'mdy'==viewFlag && closeOrder.type==2">
							<div class="label_main">
								<fieldset class="clear">
									<legend>已选择的至事由</legend>
									<s:if test="closeOrder.state==0">
										<input type="button" onclick="window.location.href='<s:url namespace="/qkjmanage" action="apply_listt"><s:param name="closeOrder.uuid" value="closeOrder.uuid" /></s:url>';" value="添加至事由" />
									</s:if>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>编号</th>
											<th>事</th>
											<th>申请时间</th>

										</tr>
										<!-- lading.promotions -->
										<s:iterator value="applysed" status="sta">
											<tr>
												<td class="nw">${uuid }</td>
												<td class="nw"><a href="<s:url namespace="/qkjmanage" action="apply_loadt"><s:param name="viewFlag">mdy</s:param><s:param name="apply.uuid" value="uuid"></s:param><s:param name="closeOrder.uuid" value="closeOrder.uuid" /></s:url>">${title}</a></td>
												<td class="nw">${it:formatDate(apply_time,'yyyy-MM-dd')}</td>
												<!-- <td><a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a></td> -->
											</tr>
										</s:iterator>
									</table>
								</fieldset>
							</div>

							<s:if test="closeOrder.state==0">
								<%-- <div class="label_main">
									<fieldset class="clear">
										<legend>可选择至事由</legend>
										<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
											<tr>
												<th>选择</th>
												<th>事</th>
												<th>申请时间</th>
												
											</tr>
											<!-- lading.promotions -->
											<s:iterator value="cApplys" status="sta">
												<tr>
													<td class="nw"><input type="checkbox" name="closeOrder.salPro_id" value="${uuid}" /></td>
													<td class="nw">
													<a  href="<s:url namespace="/qkjmanage" action="apply_loadt"><s:param name="viewFlag">mdy</s:param><s:param name="apply.uuid" value="uuid"></s:param><s:param name="closeOrder.uuid" value="closeOrder.uuid" /></s:url>">${title}</a>
													</td>
													<td class="nw">${it:formatDate(apply_time,'yyyy-MM-dd')}</td>
													<!-- <td><a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a></td> -->
												</tr>
											</s:iterator>
										</table>
									</fieldset>
								</div> --%>
							</s:if>

						</s:if>

						<s:if test="'mdy'==viewFlag && closeOrder.type==0">
							<div class="label_main">
								<fieldset class="clear">
									<legend>已参与的促销活动</legend>
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>活动名称</th>
											<th>开始时间</th>
											<th>结束时间</th>

										</tr>
										<!-- lading.promotions -->
										<s:iterator value="salPromotsed" status="sta">
											<tr>
												<td class="nw"><a href="<s:url namespace="/salpro" action="salPromot_loadt"><s:param name="viewFlag">view</s:param><s:param name="salPromot.uuid" value="uuid"></s:param><s:param name="salstate" value="1"></s:param></s:url>">${sal_title}</a></td>
												<td class="nw">${it:formatDate(startime,'yyyy-MM-dd')}</td>
												<td class="nw">${it:formatDate(endtime,'yyyy-MM-dd')}</td>
												<!-- <td><a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a></td> -->
											</tr>
										</s:iterator>
									</table>
								</fieldset>
							</div>
							<s:if test="closeOrder.state==0">
								<div class="label_main">
									<fieldset class="clear">
										<legend>可参与促销活动</legend>
										<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
											<tr>
												<th>参加</th>
												<th>活动名称</th>
												<th>开始时间</th>
												<th>结束时间</th>

											</tr>
											<!-- lading.promotions -->
											<s:iterator value="salPromots" status="sta">
												<tr>
													<td class="nw"><input type="checkbox" name="closeOrder.salPro_id" value="${uuid}" /></td>
													<td class="nw"><a href="<s:url namespace="/salpro" action="salPromot_loadt"><s:param name="viewFlag">view</s:param><s:param name="salPromot.uuid" value="uuid"></s:param><s:param name="salstate" value="1"></s:param></s:url>">${sal_title}</a></td>
													<td class="nw">${it:formatDate(startime,'yyyy-MM-dd')}</td>
													<td class="nw">${it:formatDate(endtime,'yyyy-MM-dd')}</td>
													<!-- <td><a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a></td> -->
												</tr>
											</s:iterator>
										</table>
									</fieldset>
								</div>
							</s:if>
						</s:if>
						<s:if test="'mdy' == viewFlag">
							<fieldset class="clear">
								<legend>结案单明细</legend>
								<div class="lb_xxsm">
									<div class="lb_lgsfy">
										<div class="lb_yjtit">
											<c:if test="${closeOrder.state==0 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD',null)==true}">
												<s:url id="ladingAddProductsUrl" action="qkjm_addProducts" namespace="qkjmanage">
													<s:param name="uuidKey">closeOrder.uuid</s:param>
													<s:param name="uuidValue" value="closeOrder.uuid" />
													<s:param name="backUrl">/qkjmanage/closeOrder_load?viewFlag=mdy&</s:param>
													<s:param name="actionUrl">/qkjmanage/closeOrderPro_add</s:param>
													<s:param name="keyName">closeOrderPro.order_id</s:param>
													<s:param name="prodName">closeOrderPro.product_id</s:param>
													<s:param name="perName">closeOrderPro.product_price</s:param>
													<s:param name="numName">closeOrderPro.product_num</s:param>
													<s:param name="totalName">closeOrderPro.total_price</s:param>
												</s:url>
												<input type="button" id="product" onclick="window.location.href='${ladingAddProductsUrl}';" value="添加酒品/公司物料" />
											</c:if>



										</div>
										<p class="lb_gstit">公司酒品/公司物料</p>
										<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
											<tr>
												<th>品名</th>
												<th>单价</th>
												<th>数量(瓶)</th>
												<th>合计</th>
												<c:if test="${closeOrder.state==0 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL',null)==true}">
													<th>操作</th>
												</c:if>
											</tr>
											<s:iterator value="closeOrderPros" status="sta">
												<tr>
													<td class="nw">${product_name}</td>
													<td class="nw">￥${product_price}</td>
													<td class="nw">${product_num}</td>
													<td class="nw">￥${total_price}</td>
													<c:if test="${closeOrder.state==0 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL',null)==true}">
														<td><a href="<s:url action="closeOrderPro_del"><s:param name="closeOrderPro.uuid" value="%{uuid}" /><s:param name="closeOrderPro.order_id" value="%{closeOrder.uuid}" /></s:url>" onclick="return isDel();">[删除]</a></td>
													</c:if>
												</tr>
											</s:iterator>
										</table>

										<p class="lb_gstit">公司费用合计</p>
										<p class="lb_jwei">￥${closeOrder.totel_price}</p>
									</div>
									<div class="lb_gsfy">
										<p class="lb_yjtit">
											<c:if test="${closeOrder.state==0 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD',null)==true}">
												<input type="button" id="addPosm" value="添加物料" />
											</c:if>
										</p>

										<p class="lb_gstit">其它物料</p>
										<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
											<tr>
												<th>名目</th>
												<th>名目说明</th>
												<th>金额</th>
												<c:if test="${closeOrder.state==0 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL',null)==true}">
													<th>操作</th>
												</c:if>
											</tr>
											<s:iterator value="closePosms" status="sta">
												<tr>
													<td>${title}</td>
													<td>${note}</td>
													<td class="nw">￥${total_price}</td>
													<c:if test="${closeOrder.state==0 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL',null)==true}">
														<td class="nw"><a href="<s:url action="closePosm_del"><s:param name="closePosm.uuid" value="%{uuid}" /><s:param name="closePosm.closeOrder_id" value="%{closeOrder.uuid}" /></s:url>" onclick="return isDel();">[删除]</a></td>
													</c:if>
												</tr>
											</s:iterator>
										</table>

									</div>
									<div class="clear"></div>
									<p class="lb_yjbot">方案费用总计: ${closeOrder.totel_price} + ${closeOrder.mt_price} = ￥${closeOrder.totel_price+closeOrder.mt_price}</p>
								</div>
							</fieldset>
						</s:if>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">需要填加费用?</div>
								<div class="label_rwbenx">
									<s:checkbox id="apply_is_fullcheck_box" name="is_fullcheck_box" cssClass="regular-checkbox" />
									<label for="apply_is_fullcheck_box"></label>
									<s:hidden id="apply_is_fullcheck" name="closeOrder.is_fullcheck" />
								</div>
							</div>
						</div>

						<fieldset id="apply_fullcheck_text" class="clear" style="display: none;">
							<legend>费用信息</legend>
							<div class="label_main">
								<div class="label_hang">
									<div class="label_ltit">随量费用:</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">当前结余:</div>
									<div class="label_rwben label_rwb">
										<s:textfield id="upprice" name="closeOrder.m_upprice" cssClass="validate[required,custom[number]]" />
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
									<div class="label_rwben label_rwb">
										<s:if test="%{closeOrder.m_price!=null}">
											<s:textfield id="price" name="closeOrder.m_price" cssClass="validate[required,custom[number]]" />
										</s:if>
										<s:else>
											<s:textfield id="price" name="closeOrder.m_price" value="%{closeOrder.it_price}" cssClass="validate[required,custom[number]]" />
										</s:else>
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
									<div class="label_rwben label_rwb">
										<s:textfield id="bprice" name="closeOrder.m_bprice" readonly="true" />
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
										<s:textfield id="fupprice" name="closeOrder.f_upprice" cssClass="validate[required,custom[number]]"></s:textfield>
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期费用:</div>
									<div class="label_rwben label_rwb">
										<s:if test="%{closeOrder.f_price!=null}">
											<s:textfield id="fprice" name="closeOrder.f_price" cssClass="validate[required,custom[number]]"></s:textfield>
										</s:if>
										<s:else>
											<s:textfield id="fprice" name="closeOrder.f_price" value="%{closeOrder.mt_price}"></s:textfield>
										</s:else>
									</div>
								</div>
								<div class="label_hang">
									<div class="label_ltit" style="font-weight: normal;">本期结余:</div>
									<div class="label_rwben label_rwb">
										<s:textfield id="fbprice" name="closeOrder.f_bprice" readonly="true"></s:textfield>
									</div>
								</div>
							</div>
						</fieldset>
						<div style="height: 10px;"></div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">结案说明:</div>
								<div class="label_rwbenx"></div>
							</div>
						</div>
						<div class="label_main">
							<div class="note_area">
								<s:if test="closeOrder.state==0">
									<s:textarea name="closeOrder.close_note" title="详细说明" cssClass="xheditorArea validate[maxSize[65535]]" />
								</s:if>
								<s:else>
						${closeOrder.close_note}
						</s:else>
								<div class="clear"></div>
							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">其它说明:</div>
								<div class="label_rwbenx">
									<s:textarea id="closeOrder.content" name="closeOrder.content" title="活动说明" cssClass="label_hang_linput inputNote validate[maxSize[65535]]" />
								</div>
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
								<font color="red"><span id="messages"></span></font>
								<s:if test="'add' == viewFlag||'addApply' == viewFlag">
									<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD',closeOrder.apply_dept)==true}">
										<s:submit id="add" name="add" value="下一步&填写费用明细" action="closeOrder_add" cssClass="input-blue" />
									</c:if>
								</s:if>
								<s:elseif test="closeOrder.state==0  && 'mdy' == viewFlag">
									<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_MDY',null)==true}">
										<s:submit id="save" name="save" value="保存" action="closeOrder_save" cssClass="input-blue" />
									</c:if>
									<s:if test="closeOrder.type==0">
										<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK0',null)==true && salPromotsed.size()>0}">
											<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="closeOrder_check0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
										</c:if>
									</s:if>
									<s:elseif test="closeOrder.type==2">
										<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK0',null)==true && applysed.size()>0}">
											<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="closeOrder_check0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
										</c:if>
									</s:elseif>
									<s:else>
										<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK0',null)==true}">
											<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="closeOrder_check0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
										</c:if>
									</s:else>
									<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL',null)==true}">
										<s:submit id="delete" name="delete" value="删除" action="closeOrder_del" onclick="return isDel();" cssClass="input-red" />
									</c:if>
								</s:elseif>
								<s:elseif test="closeOrder.state>0 && 'mdy' == viewFlag">
									<c:if test="${closeOrder.state>=1 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_APPROVE',null)==true}">
										<input type="button" value="审阅" onclick="openApprove();" class="input-yellow" />
									</c:if>
								</s:elseif>

								<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECKZ5',null)==true && closeOrder.state>0}">
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="退回" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</c:if>

								<s:if test="closeOrder.sd_state>30 && closeOrder.state>0">
									<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="closeOrder_view"><s:param name="closeOrder.uuid" value="closeOrder.uuid" /></s:url>');" value="转到打印页面" />
								</s:if>

								<s:if test="closeOrder.type==1">
									<input type="button" value="返回" onclick="linkurl('<s:url action="travel_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" class="input-gray" />
								</s:if>
								<s:else>
									<input type="button" value="返回" onclick="linkurl('<s:url action="closeOrder_relist" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" class="input-gray" />
								</s:else>
							</div>
						</div>
					</div>
					<s:if test="closeOrder.state>0">
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">销售审核:</div>
								<div class="label_rwbenx">
									<s:if test="closeOrder.state<2">
										<c:if test="${closeOrder.sd_state==10 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK10',closeOrder.apply_dept)==true}">
											<s:submit value="办事处-审核通过" action="closeOrder_check10" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
											<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
										</c:if>

										<s:if test="closeOrder.apply_dept.substring(0,1)==4 || closeOrder.apply_dept.substring(0,5)==22033">
											<c:if test="${closeOrder.sd_state==20 && closeOrder.smd_status==30  && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK20',closeOrder.apply_dept)==true}">
												<s:submit id="mdyStatus20" name="mdyStatus20" value="业务部经理审核通过" action="closeOrder_check20" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
												<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:if>
										<s:else>
											<c:if test="${closeOrder.sd_state==20 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK20',closeOrder.apply_dept)==true}">
												<s:submit id="mdyStatus20" name="mdyStatus20" value="业务部经理审核通过" action="closeOrder_check20" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
												<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:else>
										<!-- 
										<c:if test="${closeOrder.sd_state==10 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK5',closeOrder.apply_dept)==true}">
											<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
										</c:if> -->
										<c:if test="${closeOrder.sd_state==30 && closeOrder.smd_status==30 && closeOrder.apply_dept.substring(0,3)=='312' && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK30',closeOrder.apply_dept)==true}">
										<s:if test="closeOrder.apply_dept.substring(0,3)=='312' && closeOrder.apply_dept.substring(0,1)==4">
											<s:submit id="mdyStatus30" name="mdyStatus30" value="运营总监审核通过" action="closeOrder_check30" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
											<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
										</s:if>
										</c:if>

										<c:if test="${40==closeOrder.sd_state && closeOrder.smd_status>=40  && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK50',closeOrder.apply_dept)==true}">
											<s:submit id="mdyStatus50" name="mdyStatus50" value="业务副总审核通过" action="closeOrder_check40" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
											<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									<div class="statusInline">
										销售部审核状态:
										<s:if test="closeOrder.sd_state==0">初始状态</s:if>
										<s:if test="closeOrder.sd_state==5">
											<font class="message_error">审核退回</font>(${closeOrder.sd_user_name} ${it:formatDate(closeOrder.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.sd_state==10">
											<font class="message_warning">待审核</font>
										</s:if>
										<s:if test="closeOrder.sd_state==20">
											<font class="message_pass">办事处已审</font>(${closeOrder.sd_user_name} ${it:formatDate(closeOrder.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>

										<s:if test="closeOrder.sd_state==30">
											<font class="message_pass">业务部经理已审</font>(${closeOrder.sd_user_name} ${it:formatDate(closeOrder.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.sd_state==40">
											<font class="message_pass">总监已审</font>(${closeOrder.sd_user_name} ${it:formatDate(closeOrder.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.sd_state==50">
											<font class="message_pass">副总已审</font>(${closeOrder.sd_user_name} ${it:formatDate(closeOrder.sd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>

									</div>
								</div>
							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">销管审核:</div>
								<div class="label_rwbenx">
									<s:if test="closeOrder.state<2">
										<c:if test="${10==closeOrder.smd_status && closeOrder.sd_state>=20 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS10',closeOrder.apply_dept)==true}">
											<s:submit id="mdyCloseOrderSMDStatus10" name="mdyCloseOrderSMDStatus10" cssClass="input-green" value="销管经理-审核通过" action="mdyCloseOrderSMDStatus10" onclick="return isOp('确定执行此操作?');" />
											<s:submit id="mdyCloseOrderSMDStatus5" name="mdyCloseOrderSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseOrderSMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>

										<c:if test="${30==closeOrder.smd_status && closeOrder.sd_state==40 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS40',closeOrder.apply_dept)==true}">
											<s:submit id="mdyCloseOrderSMDStatus50" name="mdyCloseOrderSMDStatus50" cssClass="input-green" value="销管部经理-审核通过" action="mdyCloseOrderSMDStatus40" onclick="return isOp('确定执行此操作?');" />
											<s:submit id="mdyCloseOrderSMDStatus5" name="mdyCloseOrderSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseOrderSMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										<c:if test="${40==closeOrder.smd_status && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_SMDSTATUS50',closeOrder.apply_dept)==true}">
											<s:submit id="mdyCloseOrderSMDStatus40" name="mdyCloseOrderSMDStatus40" cssClass="input-green" value="销管副总-审核通过" action="mdyCloseOrderSMDStatus50" onclick="return isOp('确定执行此操作?');" />
											<s:submit id="mdyCloseOrderSMDStatus5" name="mdyCloseOrderSMDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseOrderSMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										
										<s:if test="closeOrder.apply_dept.substring(0,3)!='312' && closeOrder.apply_dept.substring(0,1)!=4">
											<c:if test="${closeOrder.sd_state==30 && closeOrder.smd_status==30 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK60',closeOrder.apply_dept)==true}">
												<s:submit id="mdyCloseOrderSDStatus50" name="mdyCloseOrderSDStatus50" cssClass="input-green" value="总经理-审核通过" action="mdyCloseOrderSMDStatus60" onclick="return isOp('确定执行此操作?');" />
												<s:submit id="mdyCloseOrderSDStatus5" name="mdyCloseOrderSDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseOrderSMDStatus5" onclick="return isOp('确定执行此操作?');" />
											</c:if>
										</s:if>
										<s:else>
											<c:if test="${closeOrder.smd_status==50 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK60',closeOrder.apply_dept)==true}">
											<s:submit id="mdyCloseOrderSDStatus50" name="mdyCloseOrderSDStatus50" cssClass="input-green" value="总经理-审核通过" action="mdyCloseOrderSMDStatus60" onclick="return isOp('确定执行此操作?');" />
											<s:submit id="mdyCloseOrderSDStatus5" name="mdyCloseOrderSDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseOrderSMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
										</s:else>
										
										<c:if test="${closeOrder.smd_status>=50  && closeOrder.smd_status<70 && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK70',closeOrder.apply_dept)==true}">
										<s:if test="closeOrder.apply_dept.substring(0,1)!=4">
										<s:submit id="mdyCloseOrderSDStatus50" name="mdyCloseOrderSDStatus50" cssClass="input-green" value="副总审核通过" action="mdyCloseOrderSMDStatus70" onclick="return isOp('确定执行此操作?');" />
										</s:if>
										<s:else>
										<s:submit id="mdyCloseOrderSDStatus50" name="mdyCloseOrderSDStatus50" cssClass="input-green" value="董事审核通过" action="mdyCloseOrderSMDStatus70" onclick="return isOp('确定执行此操作?');" />
										</s:else>
											
											<s:submit id="mdyCloseOrderSDStatus5" name="mdyCloseOrderSDStatus5" cssClass="input-red" value="审核不通过" action="mdyCloseOrderSMDStatus5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									<div class="statusInline">
										销管部审核状态:
										<s:if test="closeOrder.smd_status==0">未签收</s:if>
										<s:if test="closeOrder.smd_status==5">
											<font class="message_error">审核退回</font>(${closeOrder.smd_user_name} ${it:formatDate(closeOrder.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.smd_status==10">
											<font class="message_warning">已签收</font>
										</s:if>
										<s:if test="closeOrder.smd_status==30">
											<font class="message_pass">销管经理已审</font>(${closeOrder.smd_user_name} ${it:formatDate(closeOrder.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.smd_status==40">
											<font class="message_pass">销管部经理已审</font>(${closeOrder.smd_user_name} ${it:formatDate(closeOrder.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.smd_status==50">
											<font class="message_pass">销管副总已审</font>(${closeOrder.smd_user_name} ${it:formatDate(closeOrder.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.smd_status==60">
											<font class="message_pass">总经理已审</font>(${closeOrder.smd_user_name} ${it:formatDate(closeOrder.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.smd_status==70">
										<s:if test="closeOrder.apply_dept.substring(0,1)!=4">
										<font class="message_pass">副总已审</font>
										</s:if>
										<s:else>
										<font class="message_pass">董事已审</font>
										</s:else>
											(${closeOrder.smd_user_name} ${it:formatDate(closeOrder.smd_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									</div>
								</div>
							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">财务审核:</div>
								<div class="label_rwbenx">
									<s:if test="closeOrder.state<2">
										<c:if test="${closeOrder.smd_status>=50 && 10!=closeOrder.fd_check_state && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK40',closeOrder.apply_dept)==true}">
											<s:submit id="mdyCloseOrderFDSTATUS10" name="mdyCloseOrderFDSTATUS10" cssClass="input-green" value="财务-审核通过" action="closeOrder_checkfd10" onclick="return isOp('确定执行此操作?');" />
											<s:submit id="mdyCloseOrderFDStatus5" name="mdyCloseOrderFDStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_checkfd5" onclick="return isOp('确定执行此操作?');" />
										</c:if>
									</s:if>
									<div class="statusInline">
										财务部审核状态:
										<s:if test="closeOrder.fd_check_state==0">未确认</s:if>
										<s:if test="closeOrder.fd_check_state==5">
											<font class="message_error">审核退回</font>(${closeOrder.fd_user_name} ${it:formatDate(closeOrder.fd_check_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="closeOrder.fd_check_state==10">
											<font class="message_pass">财务已审</font>(${closeOrder.fd_user_name} ${it:formatDate(closeOrder.fd_check_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									</div>
								</div>
							</div>
						</div>

						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">数据中心:</div>
								<div class="label_rwbenx">
									<c:if test="${closeOrder.smd_status>=50 && 10!=closeOrder.nd_check_state && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_NDSTATUS0',closeOrder.apply_dept)==true}">
										<s:submit id="mdyCloseOrderFDSTATUS10" name="mdyCloseOrderFDSTATUS10" cssClass="input-green" value="数据中心-审核通过" action="closeOrder_checknd0" onclick="return isOp('确定执行此操作?');" />
										<s:submit id="mdyCloseOrderFDStatus5" name="mdyCloseOrderFDStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_checknd5" onclick="return isOp('确定执行此操作?');" />
									</c:if>
									<div class="statusInline">
										数据中心审核状态:
										<s:if test="CloseOrder.nd_check_state==0">未确认</s:if>
										<s:if test="CloseOrder.nd_check_state==5">
											<font class="message_error">审核退回</font>(${closeOrder.nd_user_name} ${it:formatDate(closeOrder.nd_check_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
										<s:if test="CloseOrder.nd_check_state==10">
											<font class="message_pass">已审</font>(${closeOrder.nd_user_name} ${it:formatDate(closeOrder.nd_check_time,'yyyy-MM-dd HH:mm:ss')})</s:if>
									</div>
								</div>
							</div>
						</div>

					</s:if>

				</div>
			</s:form>

			<div id="approveFrom" class="label_con idialog" title="审阅信息">
				<s:form name="form1" action="close_approve" cssClass="validForm" namespace="/qkjmanage" method="post" theme="simple">
					<input type="hidden" name="closeOrder.uuid" value="${closeOrder['uuid']}" />
					<input type="hidden" id="add_approve_flag" name="approve.flag" />
					<div class="label_main">
						<textarea name="approve.advice" rows="3"></textarea>
					</div>
					<div class="label_main tac" style="padding: 5px 0;">
						<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_APPROVE',null)==true}">
							<input type="submit" name="approve_pass" value="审阅通过" onclick="return addApproveCheck(10);" />
							<input type="submit" name="approve_fail" value="审阅不通过" onclick="return addApproveCheck(5);" />
						</c:if>
						<c:if test="${'true'==isApprover && it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_APPROVEDELLAST',null)==true}">
							<s:submit name="close_approveDel" value="撤销最后一次审阅" action="close_approveDel" onclick="return isOp('确定进行此操作?');" />
						</c:if>
					</div>
				</s:form>
			</div>

			<!-- 添加销售物料(公司) -->
			<div id="addPosmForm" class="label_con idialog" title="添加销售物料(公司)">
				<s:form name="form_addPosmForm" cssClass="validFormDialog" action="closePosm_add" namespace="/qkjmanage" method="post" theme="simple">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">名目:</div>
							<div class="label_rwben label_rwb">
								<s:textfield name="closePosm.title" title="名目" cssClass="validate[required,maxSize[32]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">名目说明:</div>
							<div class="label_rwben label_rwb">
								<s:textfield name="closePosm.note" title="名目说明" cssClass="validate[required,maxSize[255]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">金额:</div>
							<div class="label_rwben label_rwb nw">
								<s:textfield name="closePosm.total_price" title="名目" cssClass="validate[required,custom[number],maxSize[11]]" />
								元
							</div>
						</div>
						<div class="label_hang label_button tac">
							<s:hidden name="closePosm.closeOrder_id" value="%{closeOrder.uuid}" />
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD',null)==true}">
								<s:submit id="add" name="add" value="确定" action="closePosm_add" />
							</c:if>
						</div>
					</div>
				</s:form>
			</div>

			<div id="addMemberForm" class="label_con idialog" title="添加参与客户">
				<s:form id="addMemberFormTag" name="form_addMemberForm" cssClass="validFormDialog" action="closeOrder_saveMember" namespace="/qkjmanage" method="post" theme="simple">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">会员编号:</div>
							<div class="label_rwben label_rwb">
								<s:textfield id="order_user_id" name="closeOrder.member_id" cssClass="validate[required,maxSize[85]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">会员手机:</div>
							<div class="label_rwben label_rwb">
								<s:textfield id="order_user_mobile" name="closeOrder.member_phone" cssClass="validate[custom[mobile]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">会员名称:</div>
							<div class="label_rwben label_rwb">
								<s:textfield id="order_user_name" name="closeOrder.member_name" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">名目:</div>
							<div class="label_rwben label_rwb">
								<s:textfield id="CloseOrderMemcost_title" name="closeOrder.member_title" cssClass="validate[required]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">名目说明:</div>
							<div class="label_rwben label_rwb">
								<s:textarea id="CloseOrderMemcost_note" name="closeOrder.member_note" cssClass="validate[required]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">金额:</div>
							<div class="label_rwben label_rwb nw">
								<s:textfield id="CloseOrderMemcost_total_price" name="closeOrder.mt_price" cssClass="validate[required]" />
								元
							</div>
						</div>
						<div class="label_hang label_button tac">
							<s:hidden id="CloseOrderMemcost_CloseOrder_id" name="closeOrder.uuid" value="%{closeOrder.uuid}" />
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CLOSEORDERMEMCOST_ADD',null)==true}">
								<input id="addMe" type="button" value="确定" />
								<font id="addMemcost" color="red"></font>
							</c:if>
						</div>
					</div>
				</s:form>
			</div>

		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
</body>
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
	var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
	var c_mid = '<s:property value="outStock.member_id" />';
	$(function(){
		SimpleLoadMember(ajax_url_action, function(event, ui){
			loadAddress(ui.item.order_user_id);
		});
		if (c_mid != '') {
			loadAddress(c_mid);
		}
	});
	function loadAddress(memberid){
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url_action;
		ajax.config._success = function(data, textStatus){
			createAddreeeSelect(data);
		};
		ajax.addParameter("privilege_id", "QKJCJ_SYSEBIZ_AJAXLOAD_ADDRESS");
		ajax.addParameter("parameters", "member_id=" + memberid);
		ajax.sendAjax();
	}

	var c_data = new Array(); // 保存当前用户的所有联系人信息
	function createAddreeeSelect(p_data){
		var selectid = $("#selectAddress");
		selectid.clearAllOption();
		var sh = "";
		for (var i = 0; i < p_data.length; i++) {
			selectid.addOption(i + "-" + p_data[i].province, i);
			sh += p_data[i].province + " " + p_data[i].city + " " + p_data[i].area + " " + p_data[i].street + "  " + p_data[i].con_name + ' 收  邮编:' + p_data[i].post + ' 联系电话:' + p_data[i].mobile;
			if (p_data[i].defaultaddress == 1) {
				$(":input[name='closeOrder.member_address']").val(sh);
				selectid.setSelectedValue(i);
			}
			c_data[i] = sh;
			sh = "";
		}
		selectid.unbind().bind("change", function(){
			$(":input[name='closeOrder.member_address']").val(c_data[$(this).getSelectedValue()]);
		});
	}
</script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript">
	var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
	var add_user = '${customerRecode.add_user}';
	$(function(){
		CommonUtil.pickrow('table1');
		CommonUtil.pickrowAll('table1', 'uuidcheck');
		$("#customerRecode_recode_time").datepicker();
		$("#customerRecode_next_date").datepicker();

		if ($("#userdept_codeid").val() != '') {
			loadManagers($("#userdept_codeid").val());
		}
		createCustomerView();
	});

	var sobj02;
	var createCustomerView = function(){
		//http://localhost:8888/qkjmanage/customer_load?viewFlag=mdy&customer.uuid=3
		var w_width = $(window).width();
		var w_height = $(window).height();
		sobj02 = new DialogIFrame({ src : '',
		title : "查看促销活动信息",
		width : w_width * 0.35,
		height : w_height * 0.85 });
		sobj02.selfAction = function(val1, val2){};
		sobj02.create();
		//sobj02.open();
	};

	var openCustomerView = function(customer_uuid){
		var iframeId = sobj02.getConid() + "iframe";
		$("#" + iframeId).attr("src", "/salpro/salPromot_loadt?viewFlag=view&salstate=1&salPromot.uuid=" + customer_uuid);
		sobj02.open();
	};
</script>

<script type="text/javascript">
	var infoeditor01;
	$(function(){
		$("#addPosmForm").dialog({ autoOpen : false,
		modal : true });
		$("#addPosm").click(function(){
			$("#addPosmForm").dialog("open");
		});

	});

	$("#addMemberForm").dialog({ autoOpen : false,
	modal : true });
	$("#addMember").click(function(){
		$("#addMemberForm").dialog("open");
	});

	$("#addMe").click(function(){
		$.ajax({ type : 'POST',
		url : '/sysvip/getMember',
		data : "params=" + $("#order_user_id").val(),
		beforeSend : function(){
			$("#addMemcost").text("正在验证...");
		},
		success : function(data){
			if (data == "false") {
				alert("此客户不存在\n请到[会员管理>添加会员]处添加会员信息后再继续填写.");
			} else if ($("#CloseOrderMemcost_title").val() == '') {
				alert("【名目】不许为空!");
				$("#CloseOrderMemcost_title").focus();
			} else if ($("#CloseOrderMemcost_note").val() == '') {
				alert("【名目说明】不许为空!");
				$("#CloseOrderMemcost_note").focus();
			} else if ($("#CloseOrderMemcost_total_price").val() == '') {
				alert("【金额】不许为空!");
				$("#CloseOrderMemcost_total_price").focus();
			} else {
				$("#addMemberFormTag").submit();
			}
		},
		complete : function(){
			$("#addMemcost").text("");
		} });
	});
</script>

<script type="text/javascript">
	$(function(){
		if ($("#apply_is_fullcheck").val() == 1) {
			$("#apply_is_fullcheck_box").attr("checked", "checked");
			$("#apply_fullcheck_text").show();
		}
		$("#apply_is_fullcheck_box").bind("click", function(){
			if (!!$(this).attr("checked")) {
				//alert("checked");
				$("#apply_is_fullcheck").val(1);
				$("#apply_fullcheck_text").show();
			} else {
				//alert("unchecked");
				$("#apply_is_fullcheck").val(0);
				$("#apply_fullcheck_text").hide();
			}
		});

		$("#approveFrom").dialog({ autoOpen : false,
		modal : true });
	});

	$("#fupprice").bind("change", function(){
		$("#fbprice").val($("#fupprice").val() - $("#fprice").val());
	});

	$("#fprice").bind("change", function(){
		$("#fbprice").val($("#fupprice").val() - $("#fprice").val());
	});

	$("#upprice").bind("change", function(){
		$("#bprice").val($("#upprice").val() - $("#price").val());
	});

	$("#price").bind("change", function(){
		$("#bprice").val($("#upprice").val() - $("#price").val());
	});

	function loadMemberInfo(member_id){
		$("#view_member_uuid").text("正在加载...");
		$("#view_member_mobile").empty();
		$("#view_member_name").empty();
		$("#view_member_with_score").empty();
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url;
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

</html>