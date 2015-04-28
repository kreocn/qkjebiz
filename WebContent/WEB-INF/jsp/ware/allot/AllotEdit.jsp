<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调库管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url action="allot_list" namespace="/allot" />" >调库列表</a>
		</span>
	</div>
	<!-- 页面修改 -->
	<s:form id="editForm" name="editForm" cssClass="validForm" action="allot_add" namespace="/allot" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="label_con">
	<!-- 修改 -->
		<s:if test="null != allot">
			<s:hidden name="allot.uuid" title="编号" />
			<s:hidden name="allot.date" title="入库时间" />
			<div class="label_main">
				<div class="label_hang">
		            <div class="label_ltit">调货编号:</div>
		            <div class="label_rwb">${allot.uuid }
		             <s:if test="%{allot.state==0}"><font color="red">(未发货)</font></s:if>
				    <s:if test="%{allot.state==1}"><font color="red">(已发货)</font></s:if>
				    <s:if test="%{allot.state==2}"><font color="red">(取消发货)</font></s:if>
				    <s:if test="%{allot.state==3}"><font color="red">(已收货)</font></s:if>
				     <s:if test="%{allot.state==4}"><font color="red">(经手人确认)</font></s:if>
		            </div>
	       		</div>
				<div class="label_hang">
		            <div class="label_ltit">单据号:</div>
		            <div class="label_rwben2" style="width:auto;">
		            <div class="label_rwb"><s:textfield name="allot.ordernum" title="单据号" rows="4"></s:textfield></div>
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">调库日期:</div>
		            <div class="label_rwben">
		           <s:date name="allot.date" format="yyyy-MM-dd" />
		            </div>
	       		</div>
			</div>
        	<div class="label_main">
	       		<div class="label_hang">
		            <div class="label_ltit">单据性质:</div>
		            <div class="label_rwben">
		            <span class="label_rwb">
		            <select id="allot.reason" name="allot.reason" title="单据性质" >
					<option value="0" 
					<s:if test="allot.reason==0">selected="selected"</s:if>
					>调库</option>
					<option value="1"
					<s:if test="allot.reason==1">selected="selected"</s:if>
					>借货</option>
					<option value="2" 
					<s:if test="allot.reason==2">selected="selected"</s:if>
					>还货</option>
				</select>
				</span>
		            </div>
	       		</div>
	       		
		        <div class="label_hang">
		            <div class="label_ltit">调入仓库:</div>
		            <div class="label_rwben2" style="width:auto;">
				       <span class="label_rwb">
					       <select id="membermanagerid" name="allot.goldid" title="调入仓库" >
								<s:iterator value="wares" status="sta" var="x">
								<option value="<s:property value="uuid" />" 
								<s:if test="#x.uuid==allot.goldid">
								selected="selected"
								</s:if>
								/><s:property value="ware_name" />
								</s:iterator>
							</select>
		            	</span>
		            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">调出仓库:</div>
		            <div class="label_rwben2" style="width:auto;">
				       <span class="label_rwb">
					       <select id="membermanagerid" name="allot.sourceid" title="调出仓库" >
								<s:iterator value="warepowers" status="sta" var="x">
								<option value="<s:property value="uuid" />" 
								<s:if test="#x.uuid==allot.sourceid">
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
		            <s:property value="allot.add_user_name" />
		            </div>
	       		</div>
	       		
	       		<div class="label_hang">
				<div class="label_ltit">添加时间:</div>
				<div class="label_rwbenx"><s:date name="allot.add_timer" format="yyyy-MM-dd HH:mm:ss" /></div>
				</div>
	       		<div class="label_hang">
		            <div class="label_ltit">最后修改人:</div>
		            <div class="label_rwben">
		            <s:property value="allot.lm_user_name" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">最后修改时间:</div>
		            <div class="label_rwbenx">
		            <s:date name="allot.lm_timer" format="yyyy-MM-dd HH:mm:ss" />
		            </div>
	       		</div>
	       		<s:if test="allot.sureUser!=null">
	       		<div class="label_hang">
		            <div class="label_ltit">确认人/经手人:</div>
		            <div class="label_rwben">
		            <s:property value="allot.sureUser_name" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">确认时间:</div>
		            <div class="label_rwbenx">
		            <s:date name="allot.sureDate" format="yyyy-MM-dd HH:mm:ss" />
		            </div>
	       		</div>
	       		</s:if>
			</div>
			
        </s:if>
        <!-- 填加 -->
        <s:else>
        <div class="label_main">
        	<div class="label_hang">
		            <div class="label_ltit">单据号:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="allot.ordernum" title="单据号" rows="4"></s:textfield></div>
		            </div>
	       		</div>
		</div>
        <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">调库日期:</div>
	            <div class="label_rwben2">
	            	<span class="label_rwb nw">
					<input class="datepicker validate[required,custom[date]]" type="text"  name="allot.date" value="${it:formatDate(allot.date,'yyyy-MM-dd')}" />
					</span>
	            </div>
	        </div>
	     </div>
	    <div class="label_main">
	        <div class="label_hang">
		            <div class="label_ltit">单据性质:</div>
		            <div class="label_rwben">
		            <select id="allot.reason" name="allot.reason" title="单据性质" >
				
					<option value="0" 
					<s:if test="allot.reason==0">selected="selected"</s:if>
					>调库</option>
					<option value="1"
					<s:if test="allot.reason==1">selected="selected"</s:if>
					>借货</option>
					<option value="2" 
					<s:if test="allot.reason==2">selected="selected"</s:if>
					>还货</option>
				</select>
		            </div>
	       		</div>
	     </div>
	     <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">调入仓库:</div>
	            <div class="label_rwben2">
			       <span class="label_rwb">
				       <select id="membermanagerid" name="allot.goldid" title="调入仓库" >
							<s:iterator value="wares" status="sta" var="x">
							<option value="<s:property value="uuid" />" 
							<s:if test="#x.uuid==allot.goldid">
							selected="selected"
							</s:if>
							/><s:property value="ware_name" />
							</s:iterator>
						</select>
	            	</span>
	            </div>
	        </div>
        </div>
        <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">调出仓库:</div>
	            <div class="label_rwben2">
			       <span class="label_rwb">
				       <select id="membermanagerid" name="allot.sourceid" title="调出仓库" >
							<s:iterator value="warepowers" status="sta" var="x">
							<option value="<s:property value="uuid" />" 
							<s:if test="#x.uuid==allot.sourceid">
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
            <div class="label_ltit">其它说明:</div>
            <div class="label_rwbenx">
            	<s:textarea id="apply_check_note" name="allot.note" title="其它说明" rows="4" cssClass="label_hang_linput validate[maxSize[128]]"></s:textarea>
            </div>
        </div>
        </div>
        
        <!-- 明细 -->
        <s:if test="null != allot">
	        <fieldset>
			<legend>调库明细</legend>
			 <div class="label_main">
					<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
					<tr>
						<th>编号</th>
						<th>产品名称</th>
						<th>调库数量</th>
						<s:if test="allot.reason!=0"><th>已还数量</th></s:if>
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_ADD') && allot.state==0 && @com.qkj.ware.action.warepower@checkPermit(allot.sourceid,'edit')">
						<th>
						<a id="addItem" onclick="commain();">添加调库明细</a>
						</th>
						</s:if>
						
					</tr>
					<s:iterator value="allotDetails" status="sta">
									<tr>
									<td class="nw"><s:property value="uuid" /></td>
									<td class="nw"><s:property value="product_name" /></td>
									<td class="nw">
										<s:property value="num" />(<s:property value="%{(num/(case_spec*1.0)).toString().substring(0,3)}" />件)
									</td>
									<s:if test="allot.reason!=0">
									<td class="nw">
									<s:property value="bnum" />(<s:property value="%{(bnum/(case_spec*1.0)).toString().substring(0,3)}" />件)
									</td>
									</s:if>
									<s:if test="%{allot.state==0||allot.state==2}">
									<td>
								   	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_DEL')">
								   	[<a href="<s:url namespace="/allot" action="allotDetail_del"><s:param name="allotDetail.uuid" value="uuid" /><s:param name="allotDetail.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
								   	</s:if>	   
								    </td>
								    </s:if>
									</tr>
					</s:iterator>
					</table>
		        </div>
			</fieldset>
        </s:if>
        
       <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            	<s:if test="null == allot && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="allot_add" cssClass="input-blue" onclick="return xt();"/>
					</s:if>
				</s:if>
				<s:elseif test="null != allot && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkPermit(allot.sourceid,'edit')">
					<s:if test="allot.state!=2">
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_MDY')">
					<s:if test="%{allot.state==0||allot.state==2}">
					<s:submit id="save" name="save" value="保存" action="allot_save" cssClass="input-blue" onclick="return xt();"/>
					<s:if test="%{allotDetails.size>0}">
					<s:submit id="freeze" name="freeze" value="发货" action="allot_freeze"  cssClass="input-green" onclick="return isOp('是否确认发货?\n发货后将不能更改!');"></s:submit>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_DEL') && (allot.state==0||allot.state==2)">
					<s:submit id="delete" name="delete" value="删除" action="allot_del"  cssClass="input-red" onclick="return isDel();" />
					</s:if>
					</s:if>
					</s:if>
					</s:if>
					<s:if test="allot.state==1 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_CENCLE')">
					<s:submit id="freeze" name="freeze" value="取消发货" action="allot_cancel"  cssClass="input-red" onclick="return isOp('确认取消发货?');"></s:submit>
					</s:if>
				</s:elseif>
				
				<s:if test="null != allot && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkPermit(allot.goldid,'edit')">
					
					<s:if test="allot.state==4 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_DELI') ">
					<s:submit id="freeze" name="freeze" value="确认收货" onclick="return isOp('确认收货?');" action="allot_delivery"></s:submit>
					</s:if>
					
					<s:if test="allot.state==1 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_SURE') ">
					<s:submit id="freeze" name="freeze" value="经手人确认" onclick="return isOp('确认发货?');" cssClass="input-yellow" action="allot_sure"></s:submit>
					</s:if>
					
				</s:if>
				
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_CENCLE') && @com.qkj.ware.action.warepower@checkPermit(inStock.store_id,'add')  && inStock.confirm!=null && inStock.send!=1">
					<s:submit cssClass="input-red" id="cencle" name="cencle" value="取消订单" action="inStock_cencle" onclick="return isOp('确认取消?');" />
					</s:if>
				<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="allot_relist" namespace="/allot" />');" />&nbsp;
            </div>
		</div>
		</div>
	</div>
	</s:form>
</div>
</div>
<!--盘点仓库 -->
<div id="addItemForm" title="添加明细">
<s:form id="form_addItem" name="form_addItem" action="inDetail_add" namespace="/inDetail" onsubmit="return validator(this);" method="post" theme="simple">
	<table>
		  <tr>
		   	<td>
		   	<div class="label_main input-a">
				<div id="addItemForm" class="label_con" title="请选择调库商品">	
					<div class="label_hang">
			            <div class="label_ltit">商品:</div>
			            <div class="label_rwben2">
			            	<span class="label_rwb">
			            	<select id="membermanagerid" name="allotDetail.stock_id" title="产品">
								<option>--请选择--</option>
								<s:iterator value="stocks" status="sta">
								<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />' value='<s:property value="uuid" />'><s:property value="product_name" /></option>
								</s:iterator>
							</select>
							</span>
			            </div>
			        </div>																		
					
	       		<div class="label_hang">
		            <div class="label_ltit">数量:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb">
						<s:textfield name="allotDetail.num" title="数量" dataType="integer" controlName="数量" require="required" />
						<span id="ladingItemnumCase"></span>
					</div>
		            </div>
	       		</div>	
			        <div class="label_hang label_button tac">																				
			         <s:hidden name="allotDetail.lading_id" title="调货单ID" value="%{allot.uuid}" />
					<s:hidden name="allot.goldid" title="调入仓库" value="%{allot.goldid}"></s:hidden>
					<s:hidden name="allot.reason" value="%{allot.reason}"/>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_ALLOT_ADD')">
					<s:submit id="add" name="add" value="确定" action="allotDetail_add" />
					</s:if>
					<input type="button" value="关闭" onclick="closeAddForm();" class="input-gray" />
			        </div>
			       </div>																				
				</div>
			</td>
		 	</tr>
	</table>	
	<s:hidden name="viewFlag" value="add" />
</s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var c_mid = '<s:property value="outStock.member_id" />';
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id);});
	if(c_mid!='') {
		loadAddress(c_mid);
	}
	$("#addItemForm").dialog({
	      autoOpen: false,
	      height: 300,
	      width: 600,
	      modal: true
	});
	$("#addItem").click(function() {
		openAddForm();
	});
	// 此段代码可以方式回车提交
	jQuery(function($){
	    $("form").keypress(function(e){
	        if(e.keyCode == 13) {
	            e.preventDefault();
	        }
	    });  
	});
	
	CommonUtil.pickrow('fd_list_table');
});
function openAddForm() {
	$("#addItemForm").dialog("open");
}

function closeAddForm() {
	$("#addItemForm").dialog("close");
}
</script>
<script type="text/javascript">
function xt(){
	var source = $("#editForm :input[name='allot.sourceid']");
	var gold = $("#editForm :input[name='allot.goldid']");
	if(source==gold){
		alert("调入仓库调出仓库不能一致！");
		return false;
	}
}
var add_per_price_input = $("#form_addItem :input[name='allotDetail.price']");
var add_num_input = $("#form_addItem :input[name='allotDetail.num']");
var add_total_price_input = $("#form_addItem :input[name='allotDetail.total']");
var add_product_id = $("#form_addItem :input[name='allotDetail.stock_id']");

$(function(){
	add_per_price_input.bind("keyup",function(){
		add_total_price_input.val($(this).val()*add_num_input.val());
		
	});
	add_num_input.bind("keyup",function(){
		add_total_price_input.val($(this).val()*add_per_price_input.val());
		setDataCase();
	});
	
	$("#per_price_select_area").hide();
	add_product_id.bind("change",function(){
		add_per_price_input.val("");
		$("#per_price_select").clearAllOption();
		if($(this).getSelectedAttr("data")==null || $(this).getSelectedAttr("data")=='') {
			$("#per_price_select_area").hide();
		} else {
			var ps = $(this).getSelectedAttr("data").split("#");
			if(ps.length>=3) {
				$("#per_price_select").addOption("自定义","");
				$("#per_price_select").addOption("市场价("+ps[0]+")",ps[0]);
				$("#per_price_select").addOption("团购价("+ps[1]+")",ps[1]);
				$("#per_price_select").addOption("出厂价("+ps[2]+")",ps[2]);
				if(ps[3]!='')$("#per_price_select").addOption("协议价1("+ps[3]+")",ps[3]);
				if(ps[4]!='')$("#per_price_select").addOption("协议价2("+ps[4]+")",ps[4]);
				if(ps[5]!='')$("#per_price_select").addOption("协议价3("+ps[5]+")",ps[5]);
				$("#per_price_select_area").fadeIn(1000);
			}
		}
	});
	
	$("#per_price_select").bind("change",function(){
		add_per_price_input.val($(this).val());
		add_total_price_input.val($(this).val()*add_num_input.val());
		setDataCase();
	});
});

function setDataCase() {
	var data_case = add_product_id.getSelectedAttr("data_case");
	var num_value = add_num_input.val();
	if(!(data_case==null || data_case=='' || num_value==null || num_value=='')) {
		$("#ladingItemnumCase").text((num_value/data_case)+'件');
	}
}
</script>
</html>