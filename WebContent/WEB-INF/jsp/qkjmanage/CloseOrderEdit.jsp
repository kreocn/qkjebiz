<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>结案提货单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
#win{  
    /*窗口的高度和宽度*/  
    width : 300px;  
    height: 200px;  
    /*窗口的位置*/  
    position : absolute;  
    top : 100px;  
    left: 350px;  
    /*开始时窗口不可见*/  
    display : none;  
}  
/*控制背景色的样式*/  
#title{  
    /*控制标题栏的左内边距*/  
    padding-left: 3px;  
}  
#cotent{  
    padding-left : 3px;  
    padding-top :  5px;  
}  
/*控制关闭按钮的位置*/  
#close{  
    margin-left: 188px;  
    /*当鼠标移动到X上时，出现小手的效果*/  
    cursor: pointer;  
} s
</style>
</head>

<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">${path}
			<span class="opb lb op-area"><a href="<s:url action="closeOrder_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span> <span class="opb lb op-area"><s:if test="closeOrder.check_state>=1">
					<a class="input-gray" href="<s:url namespace="/qkjmanage" action="closeOrder_view"><s:param name="closeOrder.uuid" value="closeOrder.uuid" /></s:url>">转到打印页面</a>
				</s:if> </span>
		</div>
		<s:form id="editForm" name="editForm" cssClass="validForm" action="apply_load" namespace="/qkjmanage" method="post" theme="simple">
			<div class="label_con">
				<div class="label_main">
					<s:if test="'mdy' == viewFlag">
						<div class='label_hang'>
							<div class='label_ltit'>主键:</div>
							<div class='label_rwben'>${closeOrder.uuid}<s:hidden name="closeOrder.uuid" />
							</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>申请人:</div>
							<div class='label_rwben'>${closeOrder.add_user_name}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">审核状态:</div>
							<div class="label_rwbenx">
								<div class="zhuangtai" <s:if test="%{closeOrder.check_state!=0}">title="${it:formatDate(closeOrder.check_time,'yyyy-MM-dd HH:mm:ss')}"</s:if>>
									单据审核状态:
									<s:if test="closeOrder.check_state==0">新单</s:if>
									<s:if test="closeOrder.check_state==5">
										<font class="message_error">审核退回</font>(${closeOrder.check_user_name})</s:if>
									<s:if test="closeOrder.check_state==1">
										<font class="message_warning">待审核</font>
									</s:if>
									<s:if test="closeOrder.check_state==10">
										<font class="message_pass">主管已审</font>(${closeOrder.check_user_name})</s:if>
									<s:if test="closeOrder.check_state==20">
										<font class="message_pass">主管/办事处经理已审</font>(${closeOrder.check_user_name})</s:if>
									<s:if test="closeOrder.check_state==30">
										<font class="message_pass">经理/大区已审</font>(${closeOrder.check_user_name})</s:if>
									<s:if test="closeOrder.check_state==40">
										<font class="message_pass">总监已审</font>(${closeOrder.check_user_name})</s:if>
									<s:if test="closeOrder.check_state==50">
										<font class="message_pass">财务已审</font>(${closeOrder.check_user_name})</s:if>
									<s:if test="closeOrder.check_state==60">
										<font class="message_pass">业务副总已审</font>(${closeOrder.check_user_name})</s:if>
									<s:if test="closeOrder.check_state==70">
										<font class="message_pass">总经理已审</font>(${closeOrder.check_user_name})</s:if>
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
					</s:if>
					
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">单据编号:</div>
							<div class="label_rwb">
								<s:textfield name="closeOrder.close_num" title="单据编号"/>
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
					<s:if test="'mdy'==viewFlag">
						<div class="label_main">
							<fieldset class="clear">
								<legend>已参与的促销活动</legend>
								<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
									<tr>
										<th>活动名称</th>
										<th>开始时间</th>
										<th>结束时间</th>
										<th>操作</th>
									</tr>
									<!-- lading.promotions -->
									<s:iterator value="salPromotsed" status="sta">
										<tr>
											<td class="nw">${sal_title}</td>
											<td class="nw">${it:formatDate(startime,'yyyy-MM-dd')}</td>
											<td class="nw">${it:formatDate(endtime,'yyyy-MM-dd')}</td>
											<td>
											<a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a>
											</td>
										</tr>
									</s:iterator>
								</table>
								<script type="text/javascript">
									setCheckBox("closeOrder.salPro_id", '${closeOrder.salPro_id}');
								</script>
							</fieldset>
						</div>
						<s:if test="closeOrder.check_state==0 || closeOrder.check_state==5">
						<div class="label_main">
							<fieldset class="clear">
								<legend>可参与促销活动</legend>
								<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
									<tr>
										<th>参加</th>
										<th>活动名称</th>
										<th>开始时间</th>
										<th>结束时间</th>
										<th>操作</th>
									</tr>
									<!-- lading.promotions -->
									<s:iterator value="salPromots" status="sta">
										<tr>
											<td class="nw"><input type="checkbox" name="closeOrder.salPro_id" value="${uuid}" /></td>
											<td class="nw">${sal_title}</td>
											<td class="nw">${it:formatDate(startime,'yyyy-MM-dd')}</td>
											<td class="nw">${it:formatDate(endtime,'yyyy-MM-dd')}</td>
											<td>
											<a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a>
											</td>
										</tr>
									</s:iterator>
								</table>
								<script type="text/javascript">
									setCheckBox("closeOrder.salPro_id", '${closeOrder.salPro_id}');
								</script>
							</fieldset>
						</div>
						</s:if>
					</s:if>
					<s:if test="'mdy' == viewFlag && closeOrder.salPro_id!=null">
						<fieldset class="clear">
								<legend>结案单明细</legend>
								<div class="label_main">
									<s:if test="(closeOrder.check_state==0 || closeOrder.check_state==5) && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD')">
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
									<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
										<tr>
											<th>品名</th>
											<th>单价</th>
											<th>数量(瓶)</th>
											<th>合计</th>
											<s:if test="(closeOrder.check_state==0 || closeOrder.check_state==5) && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL')">
												<th>操作</th>
											</s:if>
										</tr>
										<s:iterator value="closeOrderPros" status="sta">
											<tr>
												<td class="nw">${product_name}</td>
												<td class="nw">￥${product_price}</td>
												<td class="nw">${product_num}</td>
												<td class="nw">￥${total_price}</td>
												<td><s:if test="(closeOrder.check_state==0 || closeOrder.check_state==5) && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL')">
														<a href="<s:url action="closeOrderPro_del"><s:param name="closeOrderPro.uuid" value="%{uuid}" /><s:param name="closeOrderPro.order_id" value="%{closeOrder.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
													</s:if></td>
											</tr>
										</s:iterator>
									</table>
									<p class="lb_gstit">费用合计</p>
									<p class="lb_jwei">￥${closeOrder.totel_price}</p>
								</div>
						</fieldset>
						<div style="height:10px;"></div>
					</s:if>

					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">说明:</div>
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
							<s:if test="'add' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD')">
									<s:submit id="add" name="add" value="下一步&填写费用明细" action="closeOrder_add" cssClass="input-blue" />
								</s:if>
							</s:if>
							<s:elseif test="(closeOrder.check_state==0 || closeOrder.check_state==5) && 'mdy' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_MDY')">
									<s:submit id="save" name="save" value="保存" action="closeOrder_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK0')">
									<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="closeOrder_check0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL')">
									<s:submit id="delete" name="delete" value="删除" action="closeOrder_del" onclick="return isDel();" cssClass="input-red" />
								</s:if>
							</s:elseif>
							<s:elseif test="closeOrder.check_state>0 && 'mdy' == viewFlag">
								<s:if test="closeOrder.check_state>=1 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_APPROVE')">
								<input type="button" value="审阅" onclick="openApprove();" class="input-yellow" />
								</s:if>
								<s:if test="closeOrder.check_state==1 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK10')">
									<s:submit id="mdyStatus10" name="mdyStatus10" value="主管/办事处经理审核通过" action="closeOrder_check10" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==20 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK20')">
									<s:submit id="mdyStatus20" name="mdyStatus20" value="经理/大区审核通过" action="closeOrder_check20" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==30 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK30')">
									<s:submit id="mdyStatus30" name="mdyStatus30" value="运营总监审核通过" action="closeOrder_check30" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==40 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK40')">
									<s:submit id="mdyStatus40" name="mdyStatus40" value="财务审核通过" action="closeOrder_check40" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==50 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK50')">
									<s:submit id="mdyStatus50" name="mdyStatus50" value="业务副总审核通过" action="closeOrder_check50" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>
								<s:if test="closeOrder.check_state==60 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_CHECK60')">
									<s:submit id="mdyStatus60" name="mdyStatus60" value="总经理审核通过" action="closeOrder_check60" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyStatus5" name="mdyStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_check5" onclick="return isOp('确定执行此操作?');" />
								</s:if>

								<s:if test="closeOrder.check_state>=40 && closeOrder.nd_check_state<=5  && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_NDSTATUS0')">
									<s:submit id="mdyndStatus0" name="mdyndStatus0" value="数据中心审核通过" action="closeOrder_checknd0" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
									<s:submit id="mdyndStatus5" name="mdyndStatus5" cssClass="input-red" value="审核不通过" action="closeOrder_checknd5" onclick="return isOp('确定执行此操作?');" />
								</s:if>

							</s:elseif>
							<s:if test="closeOrder.check_state>=1">
								<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="closeOrder_view"><s:param name="closeOrder.uuid" value="closeOrder.uuid" /></s:url>');" value="转到打印页面" />
							</s:if>
							<input type="button" value="返回" onclick="linkurl('<s:url action="closeOrder_relist" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" class="input-gray" />
						</div>
					</div>
				</div>
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
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_APPROVE')">
						<input type="submit" name="approve_pass" value="审阅通过" onclick="return addApproveCheck(10);" />
						<input type="submit" name="approve_fail" value="审阅不通过" onclick="return addApproveCheck(5);" />
					</s:if>
					<s:if test="'true'==isApprover && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_APPROVEDELLAST')">
						<s:submit name="active_approveDel" value="撤销最后一次审阅" action="close_approveDel" onclick="return isOp('确定进行此操作?');" />
					</s:if>
				</div>
			</s:form>
		</div>
	</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
	<script type="text/javascript">
									setCheckBox("closeOrder.salPro_id", '${closeOrder.salPro_id}');
								</script>
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
		title:"查看促销活动信息",
		width:w_width*0.35,
		height:w_height*0.85
	});
	sobj02.selfAction = function(val1,val2) {};
	sobj02.create();
	//sobj02.open();
};

var openCustomerView = function(customer_uuid) {
	var iframeId = sobj02.getConid() + "iframe";
	$("#"+iframeId).attr("src","/salpro/salPromot_loadt?viewFlag=view&salstate=1&salPromot.uuid=" + customer_uuid);
	sobj02.open();
};

</script>

</html>