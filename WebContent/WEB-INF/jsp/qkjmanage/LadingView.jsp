<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			${path} <span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="lading_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span> <span class="opb lb op-area"><a
				href="<s:url namespace="/qkjmanage" action="lading_load"><s:param name="viewFlag">mdy</s:param><s:param name="lading.uuid" value="lading.uuid"></s:param></s:url>">修改页面</a></span>
		</div>
		<s:form id="editForm" name="editForm" cssClass="validForm" action="lading_load" namespace="/qkjmanage" method="post" theme="simple">
			<div class="label_con">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">申请编号:</div>
						<div class="label_rwben">
							<s:property value="lading.uuid" />
							<s:hidden name="lading.uuid" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">订单状态:</div>
						<div class="label_rwben">
							<s:if test='0==lading.status'>新单</s:if>
							<s:if test='5==lading.status'>
								<span title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cr">已退回(${lading.check_user_name})</span>
							</s:if>
							<s:if test='10==lading.status'>
								<span title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cy">待确认(${lading.check_user_name})</span>
							</s:if>
							<s:if test='20==lading.status'>
								<span title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cg">已确认(${lading.check_user_name})</span>
							</s:if>
							<s:if test='30==lading.status'>
								<span title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cg">已发货</span>
							</s:if>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">订单提交时间:</div>
						<div class="label_rwbenx">${it:formatDate(lading.apply_time,'yyyy-MM-dd HH:mm:ss')}</div>
					</div>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">会员编号:</div>
						<div class="label_rwben label_rwb">${lading.member_id}</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">会员手机:</div>
						<div class="label_rwben label_rwb">${lading.member_mobile}</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">会员名称:</div>
						<div class="label_rwben label_rwb">${lading.member_name}</div>
					</div>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">配送地址:</div>
						<div class="label_rwbenx">
							<s:textarea id="lading_address" name="lading.address" title="配送地点" cssClass="label_hang_linput"></s:textarea>
							<br /> <span class="label_rwb nw">选择预设地址:<select id="selectAddress"></select></span>
						</div>
					</div>
				</div>
				<div class="label_main">
					<fieldset class="clear">
						<legend>订单明细</legend>

						<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
							<tr>
								<th>品名</th>
								<th>单价</th>
								<th>数量(瓶)</th>
								<th>数量(件)</th>
								<th>合计</th>
								<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_DEL')">
									<th>操作</th>
								</s:if>
							</tr>
							<s:iterator value="ladingItems" status="sta">
								<tr>
									<td class="nw">${product_name}</td>
									<td class="nw">￥${per_price}</td>
									<td class="nw">${num}</td>
									<td class="nw">${it:formatNum(num/case_spec,1)}</td>
									<td class="nw">￥${total_price}</td>
									<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_DEL')">
										<td><a href="<s:url action="ladingItem_del" namespace="/qkjmanage"><s:param name="ladingItem.uuid" value="%{uuid}" /><s:param name="ladingItem.lading_id" value="%{lading.uuid}" /></s:url>" onclick="return isDel();">[删除]</a></td>
									</s:if>
								</tr>
							</s:iterator>
						</table>
						<p class="lb_gstit"></p>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">金额合计:</div>
								<div class="label_rwben">￥${lading.total_price}</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">实际到账金额:</div>
								<div class="label_rwben">
									<s:textfield name="lading.curr_price" cssClass="validate[required,custom[number],maxSize[11]]" />
								</div>
							</div>
						</div>
					</fieldset>
				</div>
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
									<td class="nw"><input type="checkbox" name="lading.promotions" value="${uuid}" /></td>
									<td class="nw">${sal_title}</td>
									<td class="nw">${it:formatDate(startime,'yyyy-MM-dd')}</td>
									<td class="nw">${it:formatDate(endtime,'yyyy-MM-dd')}</td>
									<td><a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a></td>
								</tr>
							</s:iterator>
						</table>
						<script type="text/javascript">
						setCheckBox("lading.promotions", '${lading.promotions}');
						</script>
					</fieldset>
				</div>

				<div class="label_main">
					<fieldset class="clear">
						<legend>返利/搭赠明细</legend>
						<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
							<tr>
								<th>品名</th>
								<th>单价</th>
								<th>数量(瓶)</th>
								<th>数量(件)</th>
								<th>合计</th>
								<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGPRODUCTG_DEL')">
									<th>操作</th>
								</s:if>
							</tr>
							<s:iterator value="ladingProductgs" status="sta">
								<tr>
									<td class="nw">${product_name}</td>
									<td class="nw">￥${per_price}</td>
									<td class="nw">${num}</td>
									<td class="nw">${it:formatNum(num/case_spec,1)}</td>
									<td class="nw">￥${total_price}</td>
									<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGPRODUCTG_DEL')">
										<td><a href="<s:url action="ladingProductg_del" namespace="/qkjmanage"><s:param name="ladingProductg.uuid" value="%{uuid}" /><s:param name="ladingProductg.lading_id" value="%{lading.uuid}" /></s:url>" onclick="return isDel();">[删除]</a></td>
									</s:if>
								</tr>
							</s:iterator>
						</table>
						<p class="lb_gstit"></p>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">金额合计:</div>
								<div class="label_rwben">￥${lading.total_price_g}</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">返利比例:</div>
								<div class="label_rwben">${it:formatNum(lading.total_price_g*100/lading.total_price,2)}%</div>
							</div>
						</div>
					</fieldset>
				</div>

				<div class="label_main">
					<fieldset class="clear">
						<legend>财务信息</legend>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">付款状态:</div>
								<div class="label_rwben label_rwb">
									<s:if test="lading.fd_check==0">
										<span class="cr">未付款</span>
									</s:if>
									<s:if test="lading.fd_check==1">
										<span class="cy">未付清</span>
									</s:if>
									<s:if test="lading.fd_check==2">
										<span class="cg">已付款</span>
									</s:if>
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">付款日期:</div>
								<div class="label_rwben label_rwb">${it:formatDate(lading.fd_date,'yyyy-MM-dd')}</div>
							</div>
						</div>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">付款方式:</div>
								<div class="label_rwbenx">
									<!--   cssClass="regular-checkbox" -->
									<s:checkboxlist name="lading.fd_typesx" list="#{0:'现金',1:'POS',2:'支票',3:'转账',4:'预付款',5:'其他'}" cssClass="regular-checkbox" />
								</div>
							</div>
						</div>
						<div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">付款说明:</div>
								<div class="label_rwbenx">${lading.fd_note}</div>
							</div>
						</div>
					</fieldset>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">备注:</div>
						<div class="label_rwbenx">
							<s:textarea id="lading_content" name="lading.content" title="备注" cssClass="label_hang_linput validate[maxSize[65535]]" />
						</div>
					</div>
				</div>
				<s:if test="lading.status>5">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">审核意见:</div>
							<div class="label_rwbenx">
								<s:textarea id="lading_note" name="lading.note" title="备注" cssClass="label_hang_linput validate[maxSize[65535]]" />
							</div>
						</div>
					</div>
				</s:if>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<input type="button" value="返回" onclick="linkurl('<s:url action="lading_load" namespace="/qkjmanage"><s:param name="viewFlag">mdy</s:param><s:param name="lading.uuid" value="lading.uuid"></s:param></s:url>');" class="input-gray" /> <span id="message" class="cr"></span> <input type="button" value="打印本页"
								onclick="window.print();" />
						</div>
					</div>
				</div>
			</div>
		</s:form>
	</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>

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