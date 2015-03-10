<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/singlejs/order.js" />"></script>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/sysebiz" action="order_list"><s:param name="viewFlag">relist</s:param></s:url>">订单列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="order_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<fieldset class="clear">
					<legend>订单基本信息</legend>
					<s:if test="null != order">
						<div class="label_hang">
					       <div class="label_ltit">订单号:</div>
					       <div class="label_rwben">${order.uuid}<s:hidden name="order.uuid"  title="订单号"/></div>
						</div>
						<div class="label_hang">
					       <div class="label_ltit">订单状态:</div>
					       <div class="label_rwbenx">
					       		<s:if test="0==order.status">作废订单</s:if>
								<s:if test="10==order.status">新订单</s:if>
								<s:if test="15==order.status">已退回</s:if>
								<s:if test="20==order.status">已受理</s:if>		
								<s:if test="30==order.status">已审核</s:if>
								<s:if test="40==order.status">已配货</s:if>
								<s:if test="50==order.status">已送达</s:if>
								<s:if test="60==order.status">交易不成功</s:if>
								<s:if test="70==order.status">交易成功</s:if>
								<s:if test="80==order.status"> 已评价</s:if>
								<s:hidden name="order.status" />		
								<s:if test="0==order.pay_status">未付款</s:if>
								<s:if test="1==order.pay_status"><span class="message_pass">已付款</span> (确认时间:<s:date name="order.pay_time" format="yyyy-MM-dd HH:mm:ss" />)</s:if>
								<s:hidden name="order.pay_status" />		
								<s:if test="0==order.invoice_status">未开票</s:if>
								<s:if test="1==order.invoice_status">已开票</s:if>
								<s:hidden name="order.invoice_status" />
					       </div>
						</div>
					</s:if>
					<div class="label_hang">
					       <div class="label_ltit">会员号:</div>
					       <div class="label_rwben"><s:textfield name="order.user_id" id="order_user_id" title="会员号" cssClass="validate[required]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">会员手机:</div>
					       <div class="label_rwben"><s:textfield name="order.user_mobile" id="order_user_mobile" title="会员手机" cssClass="validate[required,custom[integer]]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">会员姓名:</div>
					       <div class="label_rwben"><s:textfield name="order.user_name" id="order_user_name" title="会员姓名" cssClass="validate[required]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">支付方式:</div>
					       <div class="label_rwben">
					       		<s:select name="order.pay_type" list="#{0:'余额支付',1:'网上银行支付',2:'货到付款',3:'银行打款',4:'当面收取',5:'积分付款'}" />
					       </div>
					</div>
					<s:if test="null != order">
							<div class="label_hang">
							       <div class="label_ltit">下单时间:</div>
							       <div class="label_rwbenx">${it:formatDate(order.add_time,'yyyy-MM-dd  HH:mm:ss')}</div>
							</div>
							<div class="label_hang">
							       <div class="label_ltit">订单来源:</div>
							       <div class="label_rwbenx">
							       		<s:if test="0==order.order_source">本站</s:if>
										<s:if test="1==order.order_source">代客下单 (下单人:<s:property value="order.add_user_name" />)</s:if>
										<s:if test="2==order.order_source">淘宝 (淘宝帐号:<s:property value="order.add_user" />)</s:if>
							       </div>
							</div>
					</s:if>
				</fieldset>
				<div style="height:10px;"></div>
				<fieldset class="clear">
					<legend>订单附加信息</legend>
					<div class="label_hang">
					       <div class="label_ltit">订单备注:</div>
					       <div class="label_rwbenx"><s:textarea name="order.note" title="订单备注" cssClass="label_hang_linput inputNote validate[maxSize[400]]" /></div>
					</div>
				</fieldset>
				<div style="height:10px;"></div>
				<fieldset class="clear">
					<legend>收货人信息[<a id="moreaddresstext" href="javascript:;" onclick="showMoreAddress();">显示更多地址</a>]</legend>
					<div id="orderconsigneid_p" style="display: none;">
						<div  id="orderconsigneid"></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">收货人姓名:</div>
					       <div class="label_rwbenx"><s:textfield name="order.con_name" title="收货人姓名" cssClass="validate[required,maxSize[85]]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">联系电话:</div>
					       <div class="label_rwben"><s:textfield name="order.con_mobile" title="联系电话" cssClass="validate[required,custom[number],maxSize[85]]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">收货地区:</div>
					       <div class="label_rwbenx">
					       		<div class="label_rwben" style="margin-right:5px;"><s:select name="order.con_province" id="con_provinceid" title="省" list="#{}" cssClass="validate[required]"></s:select></div>
								<div class="label_rwben" style="margin-right:5px;"><s:select name="order.con_city" id="con_cityid" title="市" list="#{}"></s:select></div>
								<div class="label_rwben"><s:select name="order.con_area" id="con_areaid" title="县" list="#{}"></s:select></div>
					       </div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">邮编:</div>
					       <div class="label_rwben"><s:textfield name="order.con_post" title="邮编" cssClass="validate[custom[number],maxSize[85]]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">街道地址:</div>
					       <div class="label_rwbenx"><s:textarea name="order.con_street" title="街道地址" cssClass="label_hang_linput inputNote validate[required,maxSize[21845]]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">收货人备注:</div>
					       <div class="label_rwbenx"><s:textarea name="order.con_note" title="收货人备注" cssClass="label_hang_linput inputNote validate[maxSize[21845]]" /></div>
					</div>
				</fieldset>
				<div style="height:10px;"></div>
				<fieldset class="clear">
					<legend>商品信息
						<s:if test="(order.status>=10 && order.status<=36) && viewFlag=='mdy'">
							<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDERGOODS_ADD')">
							[<a id="addGoods" href="javascript:;">添加商品</a>]
							</s:if>
						</s:if>
						<s:if test="30==order.status">
				    		[<a href="<s:url namespace="/sysebiz" action="orderCellar_list"><s:param name="memberCellar.order_id" value="order.uuid" /><s:param name="memberCellar.member_id" value="order.user_id" /></s:url>">藏酒配货</a>]
				    	</s:if>
				    	<s:if test="30<order.status">
				    		[<a href="<s:url namespace="/sysebiz" action="orderCellar_list"><s:param name="memberCellar.order_id" value="order.uuid" /><s:param name="memberCellar.member_id" value="order.user_id" /><s:param name="viewFlag">view</s:param></s:url>">藏酒查看</a>]
				    	</s:if>
					</legend>
					<s:if test="viewFlag=='add'">
						<div id="table_goods_firstadd">
							<div class="label_hang">
							       <div class="label_ltit">商品:</div>
							       <div class="label_rwbenx">
							       		<select name="orderGoods.goods_id"  title="商品" class="validate[required]">
							       				<option>--请选择--</option>
												<s:iterator value="goodss" status="sta">
												<option data='<s:property value="goods_price" />#<s:property value="stock_num" />#<s:property value="froze_num" />#<s:property value="goods_unit" />' value='<s:property value="uuid" />'><s:property value="goods_name" /></option>
												</s:iterator>
							       		</select>
							       </div>
							</div>
							<div class="label_hang">
							       <div class="label_ltit">单价:</div>
							       <div class="label_rwben"><s:textfield name="orderGoods.per_price" title="单价" cssClass="validate[required,custom[number]]"/></div>
							</div>
							<div class="label_hang" style="height:28px;">
							       <div class="label_ltit">订单数量:</div>
							       <div class="label_rwbenx">
							       		<s:textfield name="orderGoods.order_num" title="订单数量" style="width:100px;" cssClass="validate[required,custom[integer]]"/>
							       		<p class="dd_nums"><span id="goods_unit_02"></span><span id="goods_num_02" class="goods_num_show"></span></p>
							       </div>
							</div>
							<div class="label_hang">
							       <div class="label_ltit">保管费:</div>
							       <div class="label_rwben"><s:textfield name="orderGoods.storage_fees" title="保管费" cssClass="validate[required,custom[number]]"/></div>
							</div>
							<div class="label_hang">
							       <div class="label_ltit">保管截止时间:</div>
							       <div class="label_rwben"><input class="datepicker validate[required,custom[date]]" type="text" name="orderGoods.storage_date" title="保管截止时间" value="${it:formatDate(orderGoods.storage_date,'yyyy-MM-dd')}" class="validate[required]"/></div>
							</div>
							<div class="label_hang">
							       <div class="label_ltit">小计:</div>
							       <div class="label_rwben"><s:textfield name="orderGoods.total_price" title="小计" cssClass="validate[required,custom[number]]"/></div>
							</div>
						</div>
						<script type="text/javascript">
						$(function(){
							var firstadd_goods_id_input = $("#table_goods_firstadd :input[name='orderGoods.goods_id']");
							var firstadd_per_price_input = $("#table_goods_firstadd :input[name='orderGoods.per_price']");
							var firstadd_order_num_input = $("#table_goods_firstadd :input[name='orderGoods.order_num']");
							var firstadd_order_storage_input = $("#table_goods_firstadd :input[name='orderGoods.storage_fees']");
							var firstadd_total_price_input = $("#table_goods_firstadd :input[name='orderGoods.total_price']");
							
							firstadd_goods_id_input.change(function(){
								var ps = $(this).getSelectedAttr("data").split("#");
								firstadd_per_price_input.val(ps[0]);
								$("#goods_num_02").text("(可用库存:"+(ps[1]-ps[2])+" 已冻结:"+ps[2] + ")");
								//结合验证框架来防止超出库存的情况
								firstadd_order_num_input.attr("dataBetween","1,"+(ps[1]-ps[2]));
								$("#goods_unit_02").text(ps[3]);
							});
							
							firstadd_per_price_input.bind('keyup', function() {
								firstadd_total_price_input.val(Number($(this).val()*firstadd_order_num_input.val())+Number(firstadd_order_storage_input.val()));
							});
							
							firstadd_order_num_input.bind('keyup', function() {
								firstadd_total_price_input.val(Number($(this).val()*firstadd_per_price_input.val())+Number(firstadd_order_storage_input.val()));
							});
							
							firstadd_order_storage_input.bind('keyup', function() {
								firstadd_total_price_input.val(Number(firstadd_order_num_input.val()*firstadd_per_price_input.val())+Number($(this).val()));
							});
						});
						</script>
					</s:if>
					<s:elseif test="orderGoodss.size > 0 && viewFlag=='mdy'">
						<table class="lb_jpin" id="table_goods_list" width="100%">
							<tr>
								<th>编号</th>
								<th>商品名称</th>
								<th>单价</th>
								<th>订单数量</th>
								<th>保管费</th>
								<th>保管截至时间</th>
								<th>小计</th>
								<th>操作</th>
							</tr>
							<s:iterator value="orderGoodss" status="sta">
								<tr>
									<td>${uuid}</td>
									<td>${goods_name}</td>
									<td>￥${per_price}</td>
									<td>${order_num} ${goods_unit}</td>
									<td>${storage_fees}</td>
									<td>${it:formatDate(storage_date,'yyyy-MM-dd')}</td>
									<td>￥${total_price}</td>
									<td>
										<s:if test="40>=order.status && 'mdy' == viewFlag">
								    	[<a href="<s:url namespace="/sysebiz" action="orderGoods_del"><s:param name="orderGoods.uuid" value="uuid" /><s:param name="orderGoods.order_id" value="%{order.uuid}"></s:param></s:url>" onclick="return isDel();">删除</a>]
								    	</s:if>
									</td>
								</tr>
							</s:iterator>
							<tr>
								<td colspan="8">
									<div class="label_rwben" style="float:right;"><s:textfield name="order.total_price" title="订单总价" cssClass="validate[required,custom[number]"/></div>
									<p class="dd_zjia">订单总价：￥</p>
								</td>
							</tr>
						 </table>
						</s:elseif>
					</fieldset>
				<div style="height: 10px;"></div>
				<fieldset class="clear">
					<legend>订单操作信息</legend>
					<div class="label_hang">
					       <div class="label_ltit">操作备注:</div>
					       <div class="label_rwbenx"><s:textarea name="op_message" title="操作备注" cssClass="label_hang_linput inputNote validate[maxSize[21845]]"/></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">当前可操作:</div>
					       <div class="label_rwbenx">
					       		<s:if test="null == order && 'add' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_ADD')">
									<s:submit id="order_add" cssClass="input-blue"  name="order_add" value="新增订单" action="order_add" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_ADDCHECK')">
									<s:submit id="order_add_check" name="order_add_check" value="新增&送交审核" action="order_add_check" onclick="return isOp('是否直接送交审核?\n送审后将不能更改!');" />
									</s:if>
								</s:if>				
								<s:if test="10==order.status && 'mdy' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_MDY')">
									<s:submit id="save" name="save" cssClass="input-blue"  value="保存订单" action="order_save" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK10')">
									<s:submit id="order_check10" cssClass="input-yellow"  name="order_check10" value="送交审核" action="order_check10" onclick="return isOp('是否送交审核?\n送审后将不能更改!');" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK0')">
									<s:submit id="order_check0" cssClass="input-red" name="order_check0" value="订单作废" action="order_check0" onclick="return isOp('是否作废订单?\n作废操作不能取消!');" />
									</s:if>
								</s:if>
								<s:if test="15==order.status && 'mdy' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_MDY')">
									<s:submit id="save" name="save" cssClass="input-blue"  value="保存订单" action="order_save" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK15')">
									<s:submit id="order_check15" cssClass="input-yellow"  name="order_check15" value="重新送审" action="order_check15" onclick="return isOp('是否重新送审?\n送审后将不能更改!');" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK0')">
									<s:submit id="order_check0" name="order_check0"  cssClass="input-red"  value="订单作废" action="order_check0" onclick="return isOp('是否作废订单?\n作废操作不能取消!');" />
									</s:if>
								</s:if>
								<s:if test="20==order.status && 'mdy' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK19')">
									<s:submit id="order_check19" name="order_check19" cssClass="input-red"  value="不通过" action="order_check19" onclick="return isOp('确定退回订单(审核不通过)?\n退回操作不能取消!');" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK20')">
									<s:submit id="order_check20" name="order_check20" cssClass="input-green"  value="审核通过" action="order_check20" onclick="return isOp('确定通过?\n通过后将直接进行商品配货!');" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK0')">
									<s:submit id="order_check0" name="order_check0" cssClass="input-red"  value="订单作废" action="order_check0" onclick="return isOp('是否作废订单?\n作废操作不能取消!');" />
									</s:if>
								</s:if>				
								<s:if test="30==order.status && 'mdy' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK30')">
									<s:submit id="order_check30" name="order_check30" cssClass="input-blue"  value="配货完成" action="order_check30" onclick="return isOp('确定配货完成?\n配货完成操作不能取消!');" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK0')">
									<s:submit id="order_check0" name="order_check0"  cssClass="input-red"  value="订单作废" action="order_check0" onclick="return isOp('是否作废订单?\n作废操作不能取消!');" />
									</s:if>
								</s:if>
								<s:if test="40==order.status && 'mdy' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK39')">
									<s:submit id="order_check39" name="order_check39" cssClass="input-blue"  value="重新配货" action="order_check39" onclick="return isOp('确定重新配货吗?\n重新配货操作不能取消!');" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK41')">
									<s:submit id="order_check41" name="order_check41" cssClass="input-green"  value="交易完成" action="order_check41" onclick="return isOp('确定交易完成?\n交易完成操作不能取消!\n交易完成之后,订单将不能进行任何操作!');" />
									</s:if>
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHECK0')">
									<s:submit id="order_check0" name="order_check0" cssClass="input-red" value="订单作废" action="order_check0" onclick="return isOp('是否作废订单?\n作废操作不能取消!');" />
									</s:if>
								</s:if>
								<s:if test="0==order.pay_status && 'mdy' == viewFlag">
									<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_ORDER_CHANGEPAYSTATUS')">
									<s:submit id="order_pay_status" name="order_pay_status" cssClass="input-green"  value="确认付款" action="order_pay_status" onclick="return isOp('是否确定钱已到账?\n此操作不能取消!');" />
									</s:if>
								</s:if>
								<span id="message"><s:property value="message" /></span>
					       </div>
					</div>
				</fieldset>
				<s:if test="'mdy' == viewFlag">
					<table class="lb_jpin" id="table_orderActns" width="100%">
						 <tr>
						  	<th>操作人</th>
							<th>操作时间</th>
						    <th>操作类型</th>
						    <th>新值</th>
							<th>备注</th>
						 </tr>
						<s:iterator value="orderActns" status="sta">
							  <tr>
							  	<td>${add_user_name}</td>
								<td>${it:formatDate(add_time,'yyyy-MM-dd  HH:mm:ss')}</td>
							    <td>${action_type}</td>
							    <td>
							    	<s:if test="'CHANGE_STATUS'==action_type">
							    		把订单状态改为:
							    		<s:if test="0==new_value">【作废订单】</s:if>
										<s:if test="10==new_value">【新订单】</s:if>
										<s:if test="15==new_value">【已退回】</s:if>
										<s:if test="20==new_value">【已受理】</s:if>		
										<s:if test="30==new_value">【已审核】</s:if>
										<s:if test="40==new_value">【已配货】</s:if>
										<s:if test="70==new_value">【交易成功】</s:if>
							    	</s:if>
							    	<s:elseif  test="'CHANGE_PAYSTATUS'==action_type">
							    		把付款状态改为:<s:if test="1==new_value">【已付款】</s:if>
							    	</s:elseif>
							    	<s:else>
							    		${new_value}
							    	</s:else>
							    </td>
								<td>${note}</td>
							  </tr>
						</s:iterator>
					</table>
				</s:if>
			</div>
		</div>
	</s:form>
</div>
</div>
<div id="addGoodsForm"  title="添加商品">
<s:form name="form_addGoods" action="orderGoods_add"  cssClass="validForm" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span>商品:</td>
<td class='secRow'>
	<select name="orderGoods.goods_id" title="商品" class="validate[required]">
		<option>--请选择--</option>
		<s:iterator value="goodss" status="sta">
		<option data='<s:property value="goods_price" />#<s:property value="stock_num" />#<s:property value="froze_num" />#<s:property value="goods_unit" />' value='<s:property value="uuid" />'><s:property value="goods_name" /></option>
		</s:iterator>
	</select>
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>单价:</td>
<td class='secRow'><s:textfield name="orderGoods.per_price" title="单价" cssClass="validate[required,custom[number]]"/></td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>订单数量:</td>
<td class='secRow'>
<s:textfield name="orderGoods.order_num" title="订单数量" cssClass="validate[required,custom[integer]]" />
<span id="goods_unit_01"></span>
<span id="goods_num_01" class="goods_num_show"></span>
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>保管费:</td>
<td class='secRow'>
<s:textfield name="orderGoods.storage_fees" title="保管费" cssClass="validate[required,custom[number]]" />
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>保管截至时间:</td>
<td class='secRow'>
<s:textfield id="orderGoods_storage_date" name="orderGoods.storage_date" value="%{getText('global.date',{orderGoods.storage_date})=='null'?'':getText('global.date',{orderGoods.storage_date})}" title="保管截至时间" cssClass="datepicker validate[required,custom[date]]" />
</td>
</tr>
<tr>
<td class='firstRow'><span style="color:red;">*</span>小计:</td>
<td class='secRow'><s:textfield name="orderGoods.total_price" title="小计" cssClass="validate[required,custom[number]]" /></td>
</tr>
		<tr>
			<td>&nbsp;</td>
		    <td class="buttonarea">
				<s:hidden name="orderGoods.order_id" value="%{order.uuid}"  />
				<s:submit id="add" name="add" value="确定" action="orderGoods_add" />
				<s:reset value="重置" />
			</td>
	    </tr>
	</table>
</s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
$(function(){
	var add_goods_id_input = $("#addGoodsForm :input[name='orderGoods.goods_id']");
	var add_per_price_input = $("#addGoodsForm :input[name='orderGoods.per_price']");
	var add_order_num_input = $("#addGoodsForm :input[name='orderGoods.order_num']");
	var add_order_storage_input = $("#addGoodsForm :input[name='orderGoods.storage_fees']");
	var add_total_price_input = $("#addGoodsForm :input[name='orderGoods.total_price']");
	
	add_goods_id_input.change(function(){
		var ps = $(this).getSelectedAttr("data").split("#");
		add_per_price_input.val(ps[0]);
		$("#goods_num_01").text("可用库存:"+(ps[1]-ps[2])+" 已冻结:"+ps[2]);
		//结合验证框架来防止超出库存的情况
		add_order_num_input.attr("dataBetween","1,"+(ps[1]-ps[2]));
		
		$("#goods_unit_01").text(ps[3]);
	});
	add_per_price_input.bind('keyup', function() {
		add_total_price_input.val(Number($(this).val()*add_order_num_input.val())+Number(add_order_storage_input.val()));
	});
	add_order_num_input.bind('keyup', function() {
		add_total_price_input.val(Number($(this).val()*add_per_price_input.val())+Number(add_order_storage_input.val()));
	});
	add_order_storage_input.bind('keyup', function() {
		add_total_price_input.val(Number(add_order_num_input.val()*add_per_price_input.val())+Number($(this).val()));
	});
});
</script>

<script type="text/javascript">
var sa;
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id, true);});
	sa = new SArea($("#con_provinceid"), $("#con_cityid"), $("#con_areaid"));
	sa.ajax_url = ajax_url_action;
	sa.init(toHTML.un('<s:property value="order.con_province" />'), toHTML.un('<s:property value="order.con_city" />'),
			toHTML.un('<s:property value="order.con_area" />'));
	var usr = '<s:property value="order.user_id" />';
	if (usr != '') {
		loadAddress(usr, false);
	}
	$("#addGoodsForm").dialog({
	      autoOpen: false,
	      width: 480,
	      height: 290,
	      modal: true
	});
	$("#addGoods").click(function() {
		$("#addGoodsForm").dialog("open");
	});
	// 此段代码可以方式回车提交
	jQuery(function($){
	    $("form").keypress(function(e){
	        if(e.keyCode == 13) {
	            e.preventDefault();
	        }
	    });  
	});
});
</script>

</body>
</html>