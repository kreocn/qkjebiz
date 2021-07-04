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
.lb_lgsfy {
  float: left;
  border-right: 1px solid #ccc;
  width: 49%;
}
.label_hang_sign{
	width:49%;
	min-height:45px;
	height:auto;
	line-height:28px;
}
.label_rwb_sign {
  margin-top:0;
}

.label_main {
  padding-bottom: 0;
}
</style>
</head>

<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			<span id="hs" class="pt">结案提货单（${closeOrder.uuid}）</span>
			<span class="opb lb op-area noprint">
				<!-- <a href="<s:url action="closeOrder_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a> -->
				<a href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">mdy</s:param><s:param name="closeOrder.uuid" value="%{closeOrder.uuid}"></s:param></s:url>">返回修改页面</a>
				
			</span> 
			<span class="opb lb op-area noprint">
				<input type="button" onclick="prin();window.print();" value="打印本页" />&nbsp;<input type="button" onclick="tastingprint();window.print();" value="打印品鉴酒" />&nbsp;<input type="button" onclick="nottastingprint();window.print();" value="打印非品鉴酒" />&nbsp;</span> 

		</div>
		<s:form id="editForm" name="editForm" cssClass="validForm" action="apply_load" namespace="/qkjmanage" method="post" theme="simple">
			<div class="label_con">
				<div class="label_main">
						<div class='label_hang'>
							<div class='label_ltit'>申请人:</div>
							<div class='label_rwben'>${closeOrder.add_user_name}</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">单据编号:</div>
							<div class="label_rwbenx">
								${closeOrder.close_num }
							</div>
						</div>
					</div>
						
						
					
					<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">签字:</div>
						<div class="label_rwbenx label_rwb_sign">
							<s:iterator value="allsigns" status="sta">
								
									<s:if test="puser_sign!=null">
										<s:if test="puser_sign==null">	(${puser_name})</s:if>
										<s:else>
											<s:if test="%{sign==null}">
											<span class="user_sign"><img src="${puser_sign}" /></span>
											<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd')}</span>
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
								
							</s:iterator>
						</div>
					</div>
				</div>
				
				
				<div class="label_main label_main_sep"></div>
				<div class="label_main">
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">财务部:</div>
						<s:if test="sign!=null && sign.sign50!=null">
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							
								<span class="user_sign"><img src="${sign.sign50}" /></span>
								<span class="vab">${it:formatDate(sign.time50,'yyyy-MM-dd')}</span>
						</div>
						</s:if>
							<s:else>
							${closeOrder.fd_user_name}${it:formatDate(closeOrder.fd_check_time,'yyyy-MM-dd')}
							</s:else>
					</div>
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">数据中心:</div>
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							<s:if test="sign!=null && sign.sign30!=null">
								<span class="user_sign"><img src="${sign.sign30}" /></span>
								<span class="vab">${it:formatDate(sign.time30,'yyyy-MM-dd')}</span>
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
							<s:if test="sign!=null && sign.sign40!=null">
								<span class="user_sign"><img src="${sign.sign40}" /></span>
								<span class="vab">${it:formatDate(sign.time40,'yyyy-MM-dd')}</span>
							</s:if>
						</div>
					</div>
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">销管副总:</div>
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							<s:if test="sign!=null && sign.sign60!=null">
								<span class="user_sign"><img src="${sign.sign60}" /></span>
								<span class="vab">${it:formatDate(sign.time60,'yyyy-MM-dd')}</span>
							</s:if>
						</div>
					</div>
				</div>
				
				<div class="label_main label_main_sep"></div>
				<div class="label_main">
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">业务副总:</div>
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							<s:if test="sign!=null && sign.sign20!=null">
								<span class="user_sign"><img src="${sign.sign20}" /></span>
								<span class="vab">${it:formatDate(sign.time20,'yyyy-MM-dd')}</span>
							</s:if>
						</div>
					</div>
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">总经理:</div>
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							<s:if test="sign!=null && sign.sign70!=null">
								<span class="user_sign"><img src="${sign.sign70}" /></span>
								<span class="vab">${it:formatDate(sign.time70,'yyyy-MM-dd')}</span>
							</s:if>
						</div>
					</div>
				</div>
				<div class="label_main label_main_sep"></div>
				<div class="label_main">
					<div class="label_hang label_hang_sign">
						<div class="label_ltit">营销副总经理:</div>
						<div class="label_rwbenx label_rwb_sign">
							(签字/日期)
							<s:if test="sign!=null && sign.sign80!=null">
								<span class="user_sign"><img src="${sign.sign80}" /></span>
								<span class="vab">${it:formatDate(sign.time80,'yyyy-MM-dd')}</span>
							</s:if>
						</div>
					</div>
				</div>
				<div class="label_main label_main_sep"></div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">主题:</div>
							<div class="label_rwbenx">
								${ closeOrder.theme}
							</div>
						</div>
					</div>
					<div class="label_main">
					<s:if test="closeOrder.type==2">
					<div class="label_hang">
							<div class="label_ltit">收货人姓名:</div>
							<div class="label_rwbenx">
								${ closeOrder.m_name}
							</div>
						</div>
					</s:if>
					<s:else>
					<div class="label_hang">
							<div class="label_ltit">收货人姓名:</div>
							<div class="label_rwbenx">
								${ closeOrder.member_name}
							</div>
						</div>
					</s:else>
						
						<div class="label_hang">
							<div class="label_ltit">手机:</div>
							<div class="label_rwb">
								${ closeOrder.member_phone}
							</div>
						</div>
						
						<div class="label_hang">
							<div class="label_ltit">结案时间:</div>
							<div class="label_rwbenx">
								<span class="label_rwb nw"> 
								${it:formatDate(closeOrder.close_time,'yyyy-MM-dd')}
								</span>
							</div>
						</div>
						
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">配送地点:</div>
							<div class="label_rwbenx">
							${ closeOrder.member_address}
							</div>
						</div>
					</div>
					
					<s:if test="closeOrder.type==2">
						<div class="label_main">
							<fieldset class="clear">
								<legend>已参至事由</legend>
								<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
									<!-- lading.promotions -->
									<s:iterator value="applysed" status="sta">
										<tr>
											<td class="nw">${title}</td>
											<td class="nw">申请时间：${it:formatDate(apply_time,'yyyy-MM-dd')}</td>
										</tr>
									</s:iterator>
								</table>
								
							</fieldset>
						</div>
					</s:if>
					<s:elseif test="closeOrder.type==0">
					<div class="label_main">
							<fieldset class="clear">
								<legend>已参与促销活动</legend>
								<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
									<!-- lading.promotions -->
									<s:iterator value="salPromots" status="sta">
										<tr>
											<td class="nw">${sal_title}</td>
											<td class="nw">活动时间：${it:formatDate(startime,'yyyy-MM-dd')} - ${it:formatDate(endtime,'yyyy-MM-dd')}</td>
										</tr>
									</s:iterator>
								</table>
								
							</fieldset>
						</div>
					</s:elseif>
					
						
						<fieldset class="clear">
								<legend>结案单明细</legend>
									<div class="lb_lgsfy">
											<p class="lb_gstit" id="nottasting1" >公司酒品/公司物料</p>
											<table  id="nottasting2"  class="lb_jpin">
												<tr>
													<th>品名</th>
													<th>单价</th>
													<th>数量(瓶)</th>
													<th>合计</th>
												</tr>
												<s:iterator value="closeOrderPros" status="sta">
													<tr>
														<td class="nw">${product_name}</td>
														<td class="nw">￥${product_price}</td>
														<td class="nw">${product_num}</td>
														<td class="nw">￥${total_price}</td>
													</tr>
												</s:iterator>
											</table>
											<p class="lb_gstit" id="tasting1">品鉴酒</p>
											<table id="tasting2" width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
												<tr>
													<th>品名</th>
													<th>单价</th>
													<th>数量(瓶)</th>
													<th>合计</th>
												
												</tr>
												<s:iterator value="closeOrderProsTasting" status="sta">
													<tr>
														<td class="nw">${product_name}</td>
														<td class="nw">￥${product_price}</td>
														<td class="nw">${product_num}</td>
														<td class="nw">￥${total_price}</td>
													</tr>
												</s:iterator>
											</table>
											
											
											
									<p class="lb_gstit">其它物料</p>
									<table class="lb_jpin">
										<tr>
											<th>名目</th>
											<th>名目说明</th>
											<th>金额</th>
										</tr>
										<s:iterator value="closePosms" status="sta">
											<tr>
												<td>${title}</td>
												<td>${note}</td>
												<td class="nw">￥${total_price}</td>
											</tr>
										</s:iterator>
									</table>
								
									<p class="lb_gstit">费用合计</p>
									<p class="lb_jwei" id="total">￥${closeOrder.totel_price}</p>
									<p class="lb_jwei" id="tastingPrice">￥${closeOrder.totel_price-proPrice}</p>
									<p class="lb_jwei" id="nottastingPrice">￥${posmPrice+proPrice}</p>
									</div>
									
									
									<div class="lb_gsfy">
									<p class="lb_yjtit">
										参与客户&预计费用
											<input type="button" id="addMember" value="添加客户" />
									</p>
									<div class="lb_yjcon">
										<p class="lb_gstit">参与活动客户</p>
										<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
											<tr>
												<th>客户</th>
												<th>名目</th>
												<th>名目说明</th>
												<th>金额</th>
												<th>地址</th>
												<th>操作</th>
											</tr>
											<s:iterator value="CloseOrderMemcosts" status="sta">
												<tr>
													<td><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
													<td>${title}</td>
													<td>${note}</td>
													<td>￥${total_price}</td>
													<td>${address}</td>
													<td class="nw">
															<a href="<s:url action="closeOrderMemcost_del"><s:param name="closeOrderMemcost.uuid" value="%{uuid}" /><s:param name="closeOrderMemcost.close_id" value="%{closeOrder.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
														</td>
												</tr>
											</s:iterator>
										</table>

										<p class="lb_gstit">客户预计费用合计</p>
										<p class="lb_jwei">￥${closeOrder.mt_price}</p>
									</div>
								
									<div class="clear"></div>
									<p class="lb_yjbot">方案费用总计: ${closeOrder.totel_price} + ${closeOrder.mt_price} = ￥${closeOrder.totel_price+closeOrder.mt_price}</p>
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
				
				<div class="label_main noprint">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<input type="button" onclick="prin();window.print();" value="打印本页" />&nbsp;
							<!-- <input type="button" value="返回" onclick="linkurl('<s:url action="closeOrder_relist" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');" class="input-gray" />-->
							 <input type="button" value="返回修改页面" onclick="linkurl('<s:url action="closeOrder_load" namespace="/qkjmanage"><s:param name="viewFlag">mdy</s:param><s:param name="closeOrder.uuid" value="%{closeOrder.uuid}"></s:param></s:url>');" />
						</div>
					</div>
				</div>
			</div>
		</s:form>
	</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
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
	
	
	
	
	

	function  tastingprint(){
		$("#nottasting1").addClass("noprint");
		$("#nottasting2").addClass("noprint");
		$("#tasting1").removeClass("noprint");
		$("#tasting2").removeClass("noprint");
		$("#tastingPrice").addClass("noprint");
		$("#total").addClass("noprint");
		$("#nottastingPrice").removeClass("noprint");
	}
	
	function  nottastingprint(){
		
		$("#tasting1").addClass("noprint");
		$("#tasting2").addClass("noprint");
	    $("#nottasting1").removeClass("noprint");
		$("#nottasting2").removeClass("noprint");
		
		$("#tastingPrice").removeClass("noprint");
		$("#total").addClass("noprint");
		$("#nottastingPrice").addClass("noprint");
	}
	
	function  prin(){
		
		$("#tasting1").removeClass("noprint");
		$("#tasting2").removeClass("noprint");
		$("#nottasting1").removeClass("noprint");
		$("#nottasting2").removeClass("noprint");
		$("#tastingPrice").addClass("noprint");
		$("#total").removeClass("noprint");
		$("#nottastingPrice").addClass("noprint");
	}
	
</script>
</html>