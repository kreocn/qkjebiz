<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>出库管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			${path} <span class="opb lb op-area">
					<a href="<s:url action="outStock_list" namespace="/outStock" />">出库列表</a>
			</span>
		</div>
		<!-- 页面修改 -->
		<s:form id="editForm" name="editForm" cssClass="validForm"
			action="outStock_add" namespace="/outStock" method="post"
			theme="simple">
			<div class="label_con">
				<!-- 主表显示 -->
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">单据号:</div>
						<div class="label_rwben">
							<div class="label_rwb">
								<s:property value="outStock.ordernum" />
							</div>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">出库时间:</div>
						<div class="label_rwben">
							<s:date name="outStock.date" format="yyyy-MM-dd" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">单据性质:</div>
						<div class="label_rwben">
							<s:if test="%{outStock.reason==0}">销售出库
					</s:if>
							<s:if test="%{outStock.reason==1}">招待用酒
					</s:if>

							<s:if test="%{outStock.reason==3 }">报损
					</s:if>
							<s:if test="%{outStock.reason==4 }">赠酒
					</s:if>
							<s:if test="%{outStock.reason==5 }">其它
					</s:if>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">状态:</div>
						<div class="label_rwben">
							<span class="label_rwb"> <s:if
									test='0==outStock.send'>借出未还</s:if> <s:if
									test='1==outStock.send'>借出已还</s:if> <s:if
									test='2==outStock.send'>新单</s:if> <s:if test='3==outStock.send'>待审核</s:if>
								<s:if test='4==outStock.send'>结案<s:date
										name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" />
								</s:if> <s:if test='5==outStock.send'>已取消订单</s:if> <s:if
									test='6==outStock.send'>
									<span class="message_error">未返利</span>
								</s:if>
								<s:if test='1==lading.rebates_flag'>
									<span class="message_pass">返利中</span>
								</s:if>
								<s:if test='2==lading.rebates_flag'>已返利</s:if>

							</span>
						</div>
					</div>

					<div class="label_hang">
						<div class="label_ltit">出库仓库:</div>
						<div class="label_rwben2" style="width:auto;">
							<span class="label_rwb"> <select
								id="membermanagerid" cssClass="selectKick"
								name="outStock.store_id" title="出库仓库">

									<s:iterator value="wares" status="sta" var="x">
										<option value="<s:property value="uuid" />"
											<s:if test="#x.uuid==outStock.store_id">
							selected="selected"
							</s:if> />
										<s:property value="ware_name" />
									</s:iterator>
							</select>
							</span>
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">添加人:</div>
						<div class="label_rwben">
							<s:property value="outStock.add_user_name" />
						</div>
					</div>

					<div class="label_hang">
						<div class="label_ltit">添加时间:</div>
						<div class="label_rwbenx">
							<s:date name="outStock.add_timer" format="yyyy-MM-dd HH:mm:ss" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">最后修改人:</div>
						<div class="label_rwben">
							<s:property value="outStock.lm_user_name" />
						</div>
					</div>
					<div class="label_hang">
						<div class="label_ltit">最后修改时间:</div>
						<div class="label_rwbenx">
							<s:date name="outStock.lm_timer" format="yyyy-MM-dd HH:mm:ss" />
						</div>
					</div>
					<s:if test="%{outStock.manager_check!=null}">
						<div class="label_hang">
							<div class="label_ltit">确认人/经手人:</div>
							<div class="label_rwben">
								<s:property value="outStock.manager_check_user_name" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">确认时间:</div>
							<div class="label_rwbenx">
								<s:date name="outStock.manager_check_time"
									format="yyyy-MM-dd HH:mm:ss" />
							</div>
						</div>
					</s:if>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">
							其它说明:<br />
							<s:submit value="修改说明" action="outStock_note" />
						</div>
						<div class="label_rwbenx">
							<s:textarea id="apply_check_note" name="outStock.note"
								title="其它说明" rows="4"
								cssClass="label_hang_linput validate[maxSize[128]]"></s:textarea>
						</div>
					</div>
				</div>

				<s:if test="%{outStock.reason==3}">
					<!-- 报损出库，不审核，自动入库到报损库 -->
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">报损原因:</div>
							<div class="label_rwbenx">
								<s:textarea id="bsreason" name="outStock.bsreason" title="入库原因"
									rows="4"
									cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
							</div>
						</div>
					</div>
				</s:if>
				<s:elseif test="%{outStock.reason==0}"><!-- 销售出库 -->
					<div class="label_main">
		        		<div class="label_hang">
			       		<div class="label_ltit">客户信息:</div>
			       		</div>
			       		<div class="label_hang">
				            <div class="label_ltit">会员号:</div>
				            <div class="label_rwb">
				            <s:textfield id="order_user_id" name="outStock.member_id" title="会员号" cssClass="validate[required]" />
				            </div>
			       		</div>
			       		<div class="label_hang">
				            <div class="label_ltit">手机:</div>
				            <div class="label_rwb">
				            <s:textfield id="order_user_mobile" name="outStock.member_mebile"  title="手机" controlName="手机" />
				            </div>
			       		</div>
			       		<div class="label_hang">
				            <div class="label_ltit">姓名:</div>
				            <div class="label_rwb">
				            <s:textfield id="order_user_name" name="outStock.member_name" title="姓名" controlName="姓名" cssClass="validate[required,maxSize[85]]"/>
				            </div>
			       		</div>
			 </div>
			 <div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">配送地点:</div>
		            <div class="label_rwbenx">
		            	<s:textarea id="address" name="outStock.member_adress" title="配送地点" rows="4" cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
		            </div>
		        </div>
		     </div>
				</s:elseif>
				<s:else>
					<!-- 其它出库，不审核，但要 填写目的地，收货人，联系方式，基本费用-->
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">出库信息:</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">收货人:</div>
							<div class="label_rwb">
								<s:textfield name="outStock.member_name" title="姓名"
									cssClass="validate[required,maxSize[85]]" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">联系方式:</div>
							<div class="label_rwb">
								<s:textfield name="outStock.member_mebile" title="手机" />
							</div>
						</div>
						<div class="label_hang">
							<div class="label_ltit">基本费用:</div>
							<div class="label_rwb">
								<s:textfield name="outStock.member_price" title="基本费用" />
							</div>
						</div>
					</div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">配送地点:</div>
							<div class="label_rwbenx">
								<s:textarea id="address" name="outStock.member_adress"
									title="配送地点" rows="4"
									cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
							</div>
						</div>
					</div>
				</s:else>
				<!-- 明细 -->
				<s:if test="null != outStock">
					<fieldset>
						<legend>出库明细</legend>

						<div class="label_main">
							<table width="100%" cellpadding="0" cellspacing="0" border="0"
								class="lb_jpin">
								<tr>
									<th>编号</th>
									<th>产品名称</th>
									<th>单价</th>
									<th>订单数量</th>
									<th>实际价格</th>
								</tr>
								<s:iterator value="outDetails" status="sta">
									<tr>
										<td class="nw"><s:property value="uuid" /></td>
										<td class="nw"><s:property value="product_name" /></td>
										<td class="nw"><s:property value="price" /></td>
										<td class="nw"><s:property value="num" />(<s:property
												value="%{(num/(case_spec*1.0)).toString().substring(0,3)}" />件)
										</td>
										<td class="nw"><s:property value="totel" /></td>
									</tr>
								</s:iterator>
							</table>
							<p class="lb_gstit">合计</p>
							<p class="lb_jwei">
								<s:property value="outStock.total_price" />
								<s:if test="%{message!=null&&message==1}">
									<font color="red">库存不足！</font>
								</s:if>
							</p>
						</div>
					</fieldset>
				</s:if>

				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<input type="button" onclick="window.print();" value="打印本页"/>&nbsp;
						</div>
					</div>
				</div>
			</div>
		</s:form>
	</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>

</html>