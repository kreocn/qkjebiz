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
							<div class='label_rwben'>${uuid}<s:hidden name="closeOrder.uuid" />
							</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>结案时间:</div>
							<div class='label_rwben'>${it:formatDate(close_time,'yyyy-MM-dd HH:mm:ss')}<s:hidden name="closeOrder.close_time" />
							</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>填加人:</div>
							<div class='label_rwben'>${add_user}</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>填加时间:</div>
							<div class='label_rwben'>${it:formatDate(add_time,'yyyy-MM-dd HH:mm:ss')}</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>审核人:</div>
							<div class='label_rwben'>${check_user}</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>数据中心审核状态:</div>
							<div class='label_rwben'>${nd_check_state}</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>最后修改时间:</div>
							<div class='label_rwben'>${it:formatDate(lm_time,'yyyy-MM-dd HH:mm:ss')}</div>
						</div>
						<div class='label_hang'>
							<div class='label_ltit'>最后修改人:</div>
							<div class='label_rwben'>${lm_user}</div>
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
								<span class="label_rwb nw"> <input class="datepicker validate[required,custom[date]]" type="text" name="closeOrder.close_time" value="${it:formatDate(active.plan_end,'yyyy-MM-dd')}" />
								</span>
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">促销方案:</div>
							<div class="label_rwben label_rwb">
								<div class="iselect">
									<select name="closeOrder.salPro_id" title="产品">
										<s:iterator value="products" status="sta">
											<option value='<s:property value="uuid" />'>
												<s:property value="title" />
											</option>
										</s:iterator>
									</select>
								</div>
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

							<s:if test="'add' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD')">
									<s:submit id="add" name="add" value="确定" action="closeOrder_add" />
								</s:if>
							</s:if>
							<s:elseif test="'mdy' == viewFlag">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_MDY')">
									<s:submit id="save" name="save" value="保存" action="closeOrder_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_STATUS0')">
									<s:submit id="mdyStatus0" name="mdyStatus0" value="报审" action="mdyStatus0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL')">
									<s:submit id="delete" name="delete" value="删除" action="closeOrder_del" onclick="return isDel();" cssClass="input-red" />
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