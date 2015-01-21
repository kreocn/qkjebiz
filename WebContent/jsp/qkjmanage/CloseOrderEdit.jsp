<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>结案提货单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>

<body>
	<div class="main">
		<div class="dq_step">${path}
			<span class="opb lb op-area"><a href="<s:url action="closeOrder_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span>
		</div>
		<s:form id="editForm" name="editForm" cssClass="validForm" action="apply_load" namespace="/qkjmanage" method="post" theme="simple">
			<div class="label_con">
				<div class="label_main">
					<s:if test="'mdy' == viewFlag">
						<div class='label_hang'>
							<div class='label_ltit'>主键自增:</div>
							<div class='label_rwben'>${closeOrder.uuid}<s:hidden name="closeOrder.uuid" />
							</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>制表人:</div>
							<div class='label_rwben'>${closeOrder.add_user_name}</div>
						</div>
						<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">审核状态:</div>
							<div class="label_rwbenx">
								<s:textfield name="closeOrder.theme" title="主题" cssClass="label_hang_linput validate[required,maxSize[255]]" />
							</div>
						</div>
					</div>
					</s:if>

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

						<div class="label_hang">
							<div class="label_ltit">促销方案:</div>
							<div class="label_rwben label_rwb">
								<span class="label_rwb"> <s:select name="closeOrder.salPro_id" list="salPromots" listKey="uuid" listValue="sal_title" cssClass="validate[required]" headerKey="" headerValue="--请选择--" />
								</span>
							</div>
						</div>

						<!--<div class="label_hang">
							<div class="label_ltit">促销方案:</div>
							<div class="label_rwben label_rwb">
								<div class="iselect">
									<s:select name="closeOrder.salPro_id" list="salPromots" listKey="uuid" listValue="sal_title" cssClass="validate[required]"  headerKey="" headerValue="--请选择--"  />
									
									<select name="closeOrder.salPro_id" title="产品">
										<s:iterator value="salPromots" status="sta">
											<option value='<s:property value="uuid" />'>
												<s:property value="sal_title" />
											</option>
										</s:iterator>
									</select>
								</div>
							</div>
						</div>-->
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">会员号:</div>
							<div class="label_rwb">
								<s:textfield id="order_user_id" name="closeOrder.member_id" title="会员号" cssClass="validate[required]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">手机:</div>
							<div class="label_rwb">
								<s:textfield id="order_user_mobile" name="closeOrder.member_phone" title="手机" controlName="手机" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">收货人姓名:</div>
							<div class="label_rwb">
								<s:textfield id="order_user_name" name="closeOrder.member_name" title="姓名" controlName="姓名" cssClass="validate[required,maxSize[85]]" />
							</div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">配送地点:</div>
							<div class="label_rwbenx">
								<s:textarea id="address" name="closeOrder.member_address" title="配送地点" rows="4" cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
								<br /> 选择预设地址:<select id="selectAddress"></select>
							</div>
						</div>
					</div>
					<s:if test="'mdy' == viewFlag">
						<div class="label_main">
							<div class="lb_xxsm">
								<p class="lb_yjtit fy_hide">
									<s:if test="(closeOrder.check_state==0 || closeOrder.check_state==5) && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD')">
										<div>
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
											<input type="button" id="product" onclick="window.location.href='${ladingAddProductsUrl}';" value="添加酒品" />
										</div>
									</s:if>
								</p>
								<div class="lb_yjcon">
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>品名</th>
											<th>单价</th>
											<th>数量(瓶)</th>
											<th>合计</th>
											<s:if test="(closeOrder.check_state==0 || closeOrder.check_state==5) && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL')">
												<th>操作</th>
											</s:if>
										</tr>
										<s:iterator value="closeOrderPros" status="sta">
											<tr>
												<td class="nw">${product_name}${product_name}</td>
												<td class="nw">￥${product_price}</td>
												<td class="nw">${product_num}</td>
												<td class="nw">￥${total_price}</td>
												<td><s:if test="(closeOrder.check_state==0 || closeOrder.check_state==5) && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_DEL')">
														<a href="<s:url action="closeOrderPro_del"><s:param name="closeOrderPro.uuid" value="%{uuid}" /><s:param name="closeOrderPro.order_id" value="%{closeOrder.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</s:if></td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">费用合计</p>
									<p class="lb_jwei">￥${closeOrder.totel_price}</p>
								</div>
							</div>
						</div>
					</s:if>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">说明:</div>
							<div class="label_rwbenx"></div>
						</div>
					</div>
					<div class="label_main">
						<div class="note_area">
							<s:textarea name="closeOrder.content" title="详细说明" cssClass="xheditorArea validate[maxSize[65535]]" />
							<div class="clear"></div>
						</div>
					</div>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
						<font color="red"><span id="messages"></span></font>
							<s:if test="'add' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD')">
									<s:submit id="add" name="add" value="下一步&填写费用明细" action="closeOrder_add" cssClass="input-blue" />
								</s:if>
							</s:if>
							<s:elseif test="(closeOrder.check_state==0 || closeOrder.check_state==5) && 'mdy' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_MDY')">
									<s:submit id="save" name="save" value="保存" action="closeOrder_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS0')">
									<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="closeOrder_check0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
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
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL')">
									<s:submit id="delete" name="delete" value="删除" action="closeOrder_del" onclick="return isDel();" cssClass="input-red" />
								</s:if>
							</s:elseif>
							<s:elseif test="closeOrder.check_state>0 && 'mdy' == viewFlag">
								<s:if test="closeOrder.check_state==1  && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS1')">
									<s:submit id="mdyStatus1" name="mdyStatus1" value="主管审核通过" action="closeOrder_check1" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==10 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS10')">
									<s:submit id="mdyStatus10" name="mdyStatus10" value="招商经理审核通过" action="closeOrder_check10" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS20')">
									<s:submit id="mdyStatus20" name="mdyStatus20" value="大区经理审核通过" action="closeOrder_check20" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==30 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS30')">
									<s:submit id="mdyStatus30" name="mdyStatus30" value="财务审核通过" action="closeOrder_check30" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==40 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS40')">
									<s:submit id="mdyStatus40" name="mdyStatus40" value="运营总监审核通过" action="closeOrder_check40" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==50 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS50')">
									<s:submit id="mdyStatus50" name="mdyStatus50" value="业务副总审核通过" action="closeOrder_check50" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==60 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS60')">
									<s:submit id="mdyStatus60" name="mdyStatus60" value="总经理审核通过" action="closeOrder_check60" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
							</s:elseif>
							<input type="button" value="返回" onclick="linkurl('<s:url action="closeOrder_relist" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" class="input-gray" />
						</div>
					</div>
				</div>
			</div>
		</s:form>
	</div>
</body>
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
</html>