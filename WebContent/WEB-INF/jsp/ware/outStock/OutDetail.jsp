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
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
			<a href="<s:url action="outStock_list" namespace="/outStock" />" >出库列表</a>
		</span>
	</div>
	<!-- 页面修改 -->
	<s:form id="editForm" name="editForm" cssClass="validForm" action="outStock_add" namespace="/outStock"  method="post" theme="simple">
	<div class="label_con">
		<!-- 主表显示 -->
		<s:if test="null != outStock">
		<s:hidden name="outDetail.lading_id"  title="出库单号" />
		<s:hidden name="outStock.uuid"/>
		<s:hidden name="outStock.send"/>
		<s:hidden name="outStock.date" value="%{outStock.date}" />
		<s:hidden name="outStock.reason" value="%{outStock.reason}"/>
        	<div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">单据号:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="outStock.ordernum" title="单据号"  rows="4"/></div>
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
			       <span class="label_rwb">
	            	<s:if test='0==outStock.send'>借出未还</s:if>
					<s:if test='1==outStock.send'>借出已还</s:if>
					<s:if test='2==outStock.send'>新单</s:if>
					<s:if test='3==outStock.send'>待审核</s:if>
					<s:if test='4==outStock.send'>结案<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
					<s:if test='5==outStock.send'>已取消订单</s:if>
					<s:if test='6==outStock.send'><span class="message_error">未返利</span></s:if><s:if test='1==lading.rebates_flag'><span class="message_pass">返利中</span></s:if><s:if test='2==lading.rebates_flag'>已返利</s:if>
				
	            	</span>
	            </div>
	            
	            <div class="label_hang">
	            <div class="label_ltit">出库仓库:</div>
	            <div class="label_rwben2">
			       <span class="label_rwb">
			       <select id="membermanagerid" cssClass="selectKick" name="outStock.store_id" title="出库仓库" >
							
							<s:iterator value="wares" status="sta" var="x">
							<option value="<s:property value="uuid" />" 
							<s:if test="#x.uuid==outStock.store_id">
							selected="selected"
							</s:if>
							/><s:property value="ware_name" />
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
				<div class="label_rwben" style="width:auto;"><s:date name="outStock.add_timer" format="yyyy-MM-dd HH:mm:ss" /></div>
				</div>
	       		<div class="label_hang">
		            <div class="label_ltit">最后修改人:</div>
		            <div class="label_rwben">
		            <s:property value="outStock.lm_user_name" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">最后修改时间:</div>
		            <div class="label_rwben" style="width:auto;">
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
		            <s:date name="outStock.manager_check_time" format="yyyy-MM-dd HH:mm:ss" />
		            </div>
	       		</div>
	       		</s:if>
			</div>
			
        </s:if>
        
        <s:else>
        <div class="label_main">
        	<div class="label_hang">
		            <div class="label_ltit">出库单号:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="outStock.ordernum" title="单据号" /></div>
		            </div>
	       		</div>
		</div>
		<div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">单据性质:</div>
	            <div class="label_rwben label_rwb">
	            	<select id="membermanagerid" cssClass="selectKick" name="outStock.reason" title="状态">
							<option value="0"
							<s:if test="%{outStock.reason==0}">
							 selected="selected"
							</s:if>
							>销售出库</option>
							<option value="1"
							 <s:if test="%{outStock.reason==1}">
							 selected="selected"
							</s:if>
							>招待用酒</option>
							
							<option value="3" 
							<s:if test="%{outStock.reason==3 }">
							selected="selected"
							</s:if>
							>报损</option>
							<option value="4" 
							<s:if test="%{outStock.reason==4 }">
							selected="selected"
							</s:if>
							>赠酒</option>
							<option value="5" 
							<s:if test="%{outStock.reason==5 }">
							selected="selected"
							</s:if>
							>其它</option>
					</select>
	            </div>
	        </div>
	     </div>
	     <div class="label_main">
	     	<div class="label_hang">
	            <div class="label_ltit">出库仓库:</div>
	            <div class="label_rwben2">
			       <span class="label_rwb">
			       <select id="membermanagerid" cssClass="selectKick" name="outStock.store_id" title="出库仓库" >
							
							<s:iterator value="wares" status="sta" var="x">
							<option value="<s:property value="uuid" />" 
							<s:if test="#x.uuid==outStock.store_id">
							selected="selected"
							</s:if>
							/><s:property value="ware_name" />
							</s:iterator>
					</select>
	            	</span>
	            </div>
	        </div>
	     </div>
        </s:else>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">其它说明:<br/><s:submit value="修改说明" action="outStock_note"/></div>
            <div class="label_rwbenx">
            	<s:textarea id="apply_check_note" name="outStock.note" title="其它说明" rows="4" cssClass="label_hang_linput validate[maxSize[128]]"></s:textarea>
            </div>
        </div>
        </div>
        
	        <s:if test="%{outStock.reason==3}"><!-- 报损出库，不审核，自动入库到报损库 -->
	        	<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">报损原因:</div>
		            <div class="label_rwbenx">
		            	<s:textarea id="bsreason" name="outStock.bsreason" title="入库原因" rows="4" cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
		            </div>
		        </div>
		        </div>
	</s:if>
	<s:else><!-- 其它出库，不审核，但要 填写目的地，收货人，联系方式，基本费用-->
	 <div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">出库信息:</div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">收货人:</div>
		            <div class="label_rwb">
		            <s:textfield name="outStock.member_name" title="姓名" cssClass="validate[required,maxSize[85]]"/>
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">联系方式:</div>
		            <div class="label_rwb">
		            <s:textfield name="outStock.member_mebile" title="手机"/>
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">基本费用:</div>
		            <div class="label_rwb">
		            <s:textfield name="outStock.member_price" title="基本费用"/>
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
	</s:else>
        <!-- 明细 -->
       <s:if test="null != outStock">
	        <fieldset>
			<legend>出库明细</legend>
		
			 <div class="label_main">
					<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
					<tr>
						<th>编号</th>
						<th>产品名称</th>
						<th>单价</th>
						<th>订单数量</th>
						<th>实际价格</th>
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD') && 2==outStock.send && @com.qkj.ware.action.warepower@checkPermit(outStock.store_id,'del')">
						<th>
						<s:url id="ladingAddProductsUrl" action="qkjm_addProducts" namespace="/qkjmanage">
												<s:param name="uuidKey">outStock.uuid</s:param>
												<s:param name="uuidValue" value="outStock.uuid" />
												<s:param name="backUrl">/outStock/outStock_load?viewFlag=mdy&</s:param>
												<s:param name="actionUrl">/outStock/outDetail_add</s:param>
												<s:param name="keyName">outDetail.lading_id</s:param>
												<s:param name="prodName">outDetail.product_id</s:param>
												<s:param name="perName">outDetail.price</s:param>
												<s:param name="numName">outDetail.num</s:param>
												<s:param name="totalName">outDetail.totel</s:param>
							</s:url>
											<input type="button" id="product" onclick="window.location.href='${ladingAddProductsUrl}';" value="添加酒品" />
						<!-- <a id="addItem" onclick="commain();" >添加出库明细</a> -->
						</th>
						</s:if>
					</tr>
					<s:iterator value="outDetails" status="sta">
									<tr>
									<td class="nw"><s:property value="uuid" /></td>
									<td class="nw"><s:property value="product_name" /></td>
									<td class="nw"><s:property value="price" /></td>
									<td class="nw">
										<s:property value="num" />(<s:property value="%{(num/(case_spec*1.0)).toString().substring(0,3)}" />件)
									</td>
									<td class="nw"><s:property value="totel" /></td>
									<td>
								   	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_DEL') && 2==outStock.send && @com.qkj.ware.action.warepower@checkPermit(outStock.store_id,'del')">
								   	[<a href="<s:url namespace="/outStock" action="outDetail_del"><s:param name="outDetail.uuid" value="uuid" /><s:param name="outDetail.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
								   	</s:if>	   
								    </td>
									</tr>
					</s:iterator>
					</table>
					<p class="lb_gstit">合计</p>
	                <p class="lb_jwei"><s:property value="outStock.total_price" />
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
            <span id="message"><s:property value="message" /></span>
            	<s:if test="null == outStock && 'add' == viewFlag && @com.qkj.ware.action.warepower@checkPermit(outStock.store_id,'del')">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="outStock_add" cssClass="input-blue"/>
					</s:if>
				</s:if>
				<s:elseif test="null != outStock && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_MDY') && 2==outStock.send">
					<s:submit id="save" name="save" value="保存" action="outStock_save" cssClass="input-blue"/>
					</s:if>
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_SURE') && 2==outStock.send">
					<s:if test="%{outDetails.size>0}">
					<s:submit value="经手人确认" action="outStock_sure" onclick="return isOp('是否确认?\n确认后将不能更改!');" cssClass="input-yellow"></s:submit>
					</s:if>
					</s:if>
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_DEL') && 2==outStock.send">
					<s:submit id="delete" name="delete" value="删除" action="outStock_del" onclick="return isDel();" cssClass="input-red"/>
					</s:if>
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_CENCLE') && 4==outStock.send && @com.qkj.ware.action.warepower@checkPermit(outStock.store_id,'edit')">
					<s:submit id="cencle" name="cencle" value="取消订单" action="outStock_cencle" onclick="return isOp('确认取消?');" cssClass="input-red"/>
					</s:if>
				</s:elseif>
				<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="outStock_list" namespace="/outStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
            </div>
		</div>
		</div>
	</div>
	</s:form>
</div>
</div>

<!--出库祥表 -->
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
//当前日期
function wol() {
	var date = new Date();
	var dateString = date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
			+ date.getDate();
		document.getElementById("indate").value=dateString;
}
</script>
</html>