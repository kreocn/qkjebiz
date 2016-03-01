<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}<span class="opb lb op-area">
		<a href="<s:url action="outStock_list" namespace="/outStock" />">出库列表</a>
		</span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="outStock_add" namespace="/outStock" method="post" theme="simple">
	<s:hidden name="outStock.uuid" value="%{outStock.uuid}"></s:hidden>
	<s:hidden name="outStock.send" value="%{outStock.send}"></s:hidden>
	<div class="label_con">
		<div class="label_main">
	       		<div class="label_hang">
		            <div class="label_ltit">单据号:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="outStock.ordernum" title="单据号" ></s:textfield></div>
		            </div>
	       		</div>
	     </div>
	     
	     <div class="label_main">
	        <div class="label_hang">
		            <div class="label_ltit">出库时间:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><input class="datepicker validate[required,custom[date]]" type="text"  name="outStock.date" title="从" value="${it:formatDate(outStock.date,'yyyy-MM-dd')}" /></div>
		            </div>
	       		</div>
	     </div>
	     <div class="label_main">
	        <div class="label_hang">
				       <div class="label_ltit">出库仓库:</div>
				       <div class="label_rwben2">
					       <span class="label_rwb">
					       <s:select id="membermanagerid" cssClass="validate[required]" name="outStock.store_id" title="出库仓库"   list="wares" listKey="uuid" listValue="ware_name" />
					       </span>
				       </div>
			</div>
			
			<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_MDYREMAEK',null)==true && 'mdy' == viewFlag && outStock.send!=4}">
	        <div class="label_hang">
		            <div class="label_ltit">转库:</div>
		            <div class="label_rwben2">
		            	<span class="label_rwb">
						<s:textfield title="仓库名称" id="userdept_nameid" name="outStock.ware_name" readonly="true"  cssClass="validate[required,maxSize[85]]"/>
						<s:hidden title="仓库编码" id="userdept_codeid" name="outStock.store_idR" readonly="true" />
						</span>
						<span class="lb nw">
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectWarevar('userdept_codeid','userdept_nameid',null);" />
						</span>
		            </div>
		        </div>
		        
		        <div class="label_hang">
			            <div class="label_rwben">
								<s:submit  value="确定转库" action="mdyRemark"/>
			            </div>
			        </div>
			       </c:if>
				
        </div>
        
        <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">状态:</div>
	            <div class="label_rwbenx">
		            <span class="label_rwbx">
		            	<s:if test="%{outStock.reason==8}">还货 <s:hidden id="out" value="8"/></s:if>
		            	<s:else>
		            		<s:select id="out" onchange="checkState();" name="outStock.reason" cssClass="selectKick" list="#{0:'销售出库',3:'报损',1:'招待用酒',2:'白条',4:'赠酒',6:'调货出库',7:'借货',8:'还货',5:'其它'}" />
		            	</s:else>
		            
					</span>
	            </div>
	        </div>
	        <div class="label_hang">
	            <div class="label_rwbenx">
		            <span class="label_rwbx">
		            	<s:if test="outStock.split==1">拆分自编号${outStock.splitUuid }</s:if>
		            	来源：
		            	<s:if test="%{outStock.goreason==0 }">
					(手动填加)
					</s:if>
		            	<s:if test="%{outStock.goreason==1 }">
					(调货入库${goldUuid })
					</s:if>
					<s:if test="%{outStock.goreason==2 }">
					(销售订单${goldUuid })
					</s:if>
					<s:if test="%{outStock.goreason==3 }">
					<a href="<s:url namespace="/qkjmanage" action="apply_list"><s:param name="apply.uuid">${outStock.goldUuid }</s:param></s:url>">(至事由${outStock.goldUuid })</a>
					</s:if>
					<s:if test="%{outStock.goreason==4 }">
					(提货结案单${goldUuid })
					</s:if>
					<s:if test="%{outStock.goreason==5 }">
					(门店管理${goldUuid })
					</s:if>
					</span>
	            </div>
	        </div>
        </div>
        
        <div id="state0" style="display: none;"><!-- 销售出库，填加会员信息，要审核 -->
        	<div class="label_main">
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
		            	<br />
						选择预设地址:<select id="selectAddress"></select>
		            </div>
		        </div>
		     </div>
        </div>
        
        <div id="state3" style="display: none;"><!-- 报损 -->
        	<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">报损原因:</div>
		            <div class="label_rwbenx">
		            	<s:textarea id="note" name="outStock.bsreason" title="报损原因" rows="4" cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
		            </div>
		        </div>
		     </div>
        </div>
        
        <div id="state6" style="display: none;"><!-- 报损 -->
        	<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">调入仓库:</div>
		            <div class="label_rwben2">
		            	<span class="label_rwb">
						<s:textfield title="仓库名称" id="userdept_nameid" name="outStock.borrowStore_name" readonly="true"  cssClass="validate[required,maxSize[85]]"/>
						<s:hidden title="仓库编码" id="userdept_codeid" name="outStock.borrowStore_id" readonly="true" />
						</span>
						<span class="lb nw">
						<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectWarevar('userdept_codeid','userdept_nameid',null);" />
						</span>
		            </div>
		        </div>
		     </div>
        </div>
        
        <div id="state145" style="display: none;"><!-- 其它出库，不审核，但要 填写目的地，收货人，联系方式，基本费用-->
        	<div class="label_main">
	       		<div class="label_hang">
		            <div class="label_ltit">收货人:</div>
		            <div class="label_rwb">
		            <s:textfield id="mname" name="outStock.member_name" title="姓名" cssClass="validate[required,maxSize[85]]"/>
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">联系方式:</div>
		            <div class="label_rwb">
		            <s:textfield id="mebile" name="outStock.member_mebile" title="手机"/>
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
		            	<s:textarea id="address2" name="outStock.member_adress" title="配送地点" rows="4" cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
		            </div>
		        </div>
		     </div>
        </div>
        
        <s:if test="outStock.goreason!=5">
        	<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">运单号:</div>
		            <div class="label_rwbenx">
		            	<s:textfield id="form_apply_ship_no" name="outStock.ship_no" title="运单号码" cssClass="validate[maxSize[48]]" />
		            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">物流名称:</div>
		            <div class="label_rwbenx">
		            	<s:textfield name="outStock.ship_type" title="物流名称" cssClass="validate[maxSize[48]]"/>
		            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">物流电话:</div>
		            <div class="label_rwbenx">
		            	<s:textfield id="form_apply_ship_phone" name="outStock.ship_phone" title="物流电话"  cssClass="validate[maxSize[48]]" />
		            </div>
		        </div>
		     </div>
        </s:if>
        
        <s:if test="'mdy'==viewFlag">
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
						<c:if test="${it:checkWarePermit(null,'out')==true &&  it:checkPermit('QKJ_WARE_OUTSTOCK_ADD',null)==true && outStock.send!=4}">
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
						</c:if>
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
									<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_DEL',null)==true && outStock.send!=4}">
									<td>
										[<a href="<s:url namespace="/outStock" action="outDetail_del"><s:param name="outDetail.uuid" value="uuid" /><s:param name="outDetail.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
								    </td>
								    </c:if>
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
            <div class="label_ltit">其它说明:</div>
            <div class="label_rwbenx">
            	<s:textarea id="apply_check_note" name="outStock.note"
									title="其它说明" rows="4" cssClass="label_hang_linput validate[maxSize[128]]"></s:textarea>
            </div>
        </div>
        </div>
        
        <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            <s:if test="null == outStock && 'add' == viewFlag">
				<c:if test="${it:checkPermit('QKJ_WARE_INSTOCK_MDY',null)==true && it:checkWarePermit(outStock.store_id,'in')==true}">
					<s:submit id="add" name="add" value="保存&填写明细" action="outStock_add" cssClass="input-blue"/>
				</c:if>
			</s:if> 
			<s:if test="'mdy'==viewFlag">
				<c:if test="${it:checkWarePermit(null,'out')==true}">
					<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_MDY',null)==true && outStock.send!=4&& outStock.send!=5}">
						<s:submit id="save" name="save" value="保存" action="outStock_save" cssClass="input-blue"/>
					</c:if>
					<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_SPILT',null)==true && outStock.send!=4 && outStock.send!=5 }">
							<input type="button" id="addPosm" value="拆分" />
						</c:if>
					<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_SURE',null)==true && outStock.send==2}">
						<s:if test="%{outDetails.size>0}">
						<s:submit value="经手人确认" action="outStock_sure" onclick="return isOp('是否确认?\n确认后将不能更改!');" cssClass="input-yellow"></s:submit>
						</s:if>
					</c:if>
					<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_CENCLE',null)==true && 4==outStock.send}">
						<s:submit id="cencle" name="cencle" value="取消订单" action="outStock_cencle" onclick="return isOp('确认取消?');" cssClass="input-red"/>
					</c:if>
					<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_DEL',null)==true && outStock.send!=4}">
						<s:submit id="delete" name="delete" value="删除" cssClass="input-red" action="outStock_del" onclick="return isDel();" />
					</c:if>
				</c:if>
			</s:if>
			<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="outStock_list" namespace="/outStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
			<s:if test="outStock.boflag==3"><font color="red">对方取消全部货物的入库</font></s:if>
			<s:if test="outStock.boflag==4"><font color="red">对方取消部分货物的入库</font></s:if>
			<s:if test="outStock.boflag==5"><font color="red">对方全部货物已入库</font></s:if>
			<s:if test="outStock.boflag==6"><font color="red">对方部分货物已入库</font></s:if>
            </div>
		</div>
		</div>
		
	</div>
	</s:form>
	
	<!-- 添加拆分 -->
	<s:if test="'mdy'==viewFlag">
		<div id="addPosmForm" class="label_con idialog" title="拆分" style="display: none;">
			<s:form name="form_addPosmForm" cssClass="validFormDialog" action="outStock_spilt" namespace="/outStock" method="post" theme="simple">
			<s:hidden name="outStock.uuid" title="编号" value="%{outStock.uuid}" />
				<div class="label_main">
					<div class="label_hang">
			            <div class="label_ltit">拆分商品:</div>
			            <div class="label_rwbenx">
							       <span class="label_rwb">
							       <s:select id="membermanagerid" cssClass="validate[required]" name="outDetail.uuid" title="出库仓库"   list="outDetails" listKey="uuid" listValue="product_name" />
							       </span>
						       </div>
			        </div>
			        
			        <div class="label_hang">
			            <div class="label_ltit">出库仓库:</div>
			            <div class="label_rwbenx">
							       <span class="label_rwb">
							       <s:select id="membermanagerid" cssClass="validate[required]" name="outStock.store_id" title="出库仓库"   list="wares" listKey="uuid" listValue="ware_name" />
							       </span>
						       </div>
			        </div>
					<div class="label_hang">
						<div class="label_ltit">拆分数量:</div>
						<div class="label_rwben label_rwb nw">
							<s:textfield name="outStock.splitNum" title="数量" cssClass="validate[required,custom[number],maxSize[11]]" />
						</div>
					</div>
					<div class="label_hang label_button tac">
						<s:hidden name="activePosm.active_id" value="%{active.uuid}" />
						<c:if test="${it:checkPermit('QKJ_WARE_OUTSTOCK_SPILT',null)==true}">
							<s:submit id="add" name="add" value="确定" action="outStock_spilt" />
						</c:if>
					</div>
				</div>
			</s:form>
		</div>
	</s:if>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
$("#addPosm").click(function(){
	$("#addPosmForm").dialog("open");
});
$("#addPosmForm").dialog({ autoOpen : false,
	modal : true }); 
	
$(function(){
	checkState();
	addDe();
 });
 

function checkState(){
	var state= $("#out").val();
	if(state==0){
		$("#state0").show();//
		$("#state3").hide();
		$("#state145").hide();
		$("#state6").hide();
		orderDis();
	}else if(state==3){
		$("#state3").show();//
		$("#state0").hide();
		$("#state145").hide();
		$("#state6").hide();orderDis2();
	}else if(state==6 || state==7 || state==8){//调出仓库
		$("#state3").hide();//
		$("#state0").hide();
		$("#state145").hide();
		$("#state6").show();//
		orderDis2();
	}else if(state==2){//调出仓库
		$("#state3").hide();//
		$("#state0").hide();
		$("#state145").hide();
		$("#state6").hide();//
		orderDis2();
	}else{
		$("#state145").show();//
		$("#state0").hide();
		$("#state3").hide();
		$("#state6").hide();
		orderDis2();
	}
}

function addDe(){
	 var me=${detailS};
	 if(me==2){
		 if(confirm("库存不足，是否继续？")){
			 location.href="/outStock/outDetail_add?ans=1";
		}
	 }
}

function orderDis(){
	 document.getElementById("order_user_mobile").disabled=false;
	document.getElementById("order_user_name").disabled=false;
	document.getElementById("address").disabled=false;
	document.getElementById("mname").disabled=true;
	document.getElementById("mebile").disabled=true;
	document.getElementById("address2").disabled=true;
}
function orderDis2(){
	 document.getElementById("mname").disabled=false;
		document.getElementById("mebile").disabled=false;
		document.getElementById("address2").disabled=false;
		document.getElementById("order_user_mobile").disabled=true;
		document.getElementById("order_user_name").disabled=true;
		document.getElementById("address").disabled=true;
}


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
				$(":input[name='outStock.member_adress']").val(sh);
				selectid.setSelectedValue(i);
			}
			c_data[i] = sh;
			sh = "";
		}
		selectid.unbind().bind("change", function(){
			$(":input[name='outStock.member_adress']").val(c_data[$(this).getSelectedValue()]);
		});
	}
</script>
</body>
</html>