<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>入库管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
#active_remark,#active_remark textarea {
font-size: 14px;
}
</style>
</head>

<body>

<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url action="inStock_list" namespace="/inStock" />" >返回列表</a>
		</span>
	</div>
	<!-- 页面修改 -->
	<s:form id="editForm" name="editForm" cssClass="validForm" action="inStock_add" namespace="/inStock" method="post" theme="simple">
	<div class="label_con">
		<s:if test="null != inStock">
			<s:hidden name="inStock.uuid" title="编号" />
			<s:hidden name="inStock.take_id"></s:hidden>
			<s:hidden name="inStock.operator_id"></s:hidden>
			<s:hidden name="inStock.date" title="入库时间" />
			<s:hidden name="inStock.reason" value="%{inStock.reason}" />
        	<div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">入库单号:</div>
		            <div class="label_rwben2" style="width:auto;">
		            <div class="label_rwb"><s:textfield name="inStock.ordernum" title="单据号" ></s:textfield></div>
		            </div>
	       		</div>
	        	<div class="label_hang">
		            <div class="label_ltit">入库时间:</div>
		            <div class="label_rwben">
		            <s:date name="inStock.date" format="yyyy-MM-dd" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">单据性质:</div>
		            <div class="label_rwben">
		            <s:if test="%{inStock.reason==0}">正常入库</s:if>
					<s:if test="%{inStock.reason==1}">正常退货</s:if>
					<s:if test="%{inStock.reason==2 }">损坏退货</s:if>
					<s:if test="%{inStock.reason==3 }">其它</s:if>
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">添加人:</div>
		            <div class="label_rwben">
		            <s:property value="inStock.add_user_name" />
		            </div>
	       		</div>
	       		
	       		<div class="label_hang">
				<div class="label_ltit">添加时间:</div>
				<div class="label_rwbenx"><s:date name="inStock.add_timer" format="yyyy-MM-dd HH:mm:ss" /></div>
				</div>
	       		<div class="label_hang">
		            <div class="label_ltit">最后修改人:</div>
		            <div class="label_rwben">
		            <s:property value="inStock.lm_user_name" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">最后修改时间:</div>
		            <div class="label_rwbenx"><s:date name="inStock.lm_timer" format="yyyy-MM-dd HH:mm:ss" /></div>
	       		</div>
	       		<s:if test="%{inStock.conname!=null}">
	       		<div class="label_hang">
		            <div class="label_ltit">确认人:</div>
		            <div class="label_rwben">
		            <s:property value="inStock.conname_u" />
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">确认时间:</div>
		            <div class="label_rwbenx">
		            <s:date name="inStock.contime" format="yyyy-MM-dd HH:mm:ss" />
		            </div>
	       		</div>
	       		</s:if>
			</div>
			
        </s:if>
        
        <s:else>
        <div class="label_main">
        	<div class="label_hang">
		            <div class="label_ltit">入库单号:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="inStock.ordernum" title="单据号" ></s:textfield></div>
		            </div>
	       		</div>
		</div>
        <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">入库时间:</div>
	            <div class="label_rwben2">
	            	<span class="label_rwb nw">
					<input class="datepicker validate[required,custom[date]]" type="text"  name="inStock.date" title="从" value="${it:formatDate(inStock.date,'yyyy-MM-dd')}" />
					</span>
	            </div>
	        </div>
	     </div>
	    <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">单据性质:</div>
	            <div class="label_rwben label_rwb">
	            	<select id="membermanagerid" cssClass="selectKick" name="inStock.reason" title="状态">
								<option value="0"
								<s:if test="%{inStock.reason==0}">
								 selected="selected"
								</s:if>
								>正常入库</option>
								<option value="1"
								 <s:if test="%{inStock.reason==1}">
								 selected="selected"
								</s:if>
								>正常退货</option>
								<option value="2" 
								<s:if test="%{inStock.reason==2 }">
								selected="selected"
								</s:if>
								>损坏退货</option>
								<option value="3" 
								<s:if test="%{inStock.reason==3 }">
								selected="selected"
								</s:if>
								>其它</option>
						</select>
	            </div>
	        </div>
	     </div>
	     
        </s:else>
        <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">入库仓库:</div>
	            <div class="label_rwben2">
			       <span class="label_rwb">
	            	<select id="membermanagerid" cssClass="selectKick" name="inStock.store_id" title="入库仓库" >
						<s:iterator value="wares" status="sta" var="x">
						<option value="<s:property value="uuid" />" 
						<s:if test="#x.uuid==inStock.store_id">
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
            <div class="label_ltit">入库原因:</div>
            <div class="label_rwbenx">
            	<s:textarea id="apply_check_note" name="inStock.note" title="入库原因" rows="4" cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
            </div>
        </div>
        </div>
        
        <!-- 入库明细 -->
        <s:if test="null != inStock">
	        <fieldset>
			<legend>入库明细</legend>
		
			 <div class="label_main">
					<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
					<tr>
						<th>编号</th>
						<th>产品名称</th>
						<th>单价</th>
						<th>订单数量</th>
						<th>实际价格</th>
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_ADD') && null==inStock.confirm && @com.qkj.ware.action.warepower@checkPermit(inStock.store_id,'add')">
						<th>
						<s:url id="ladingAddProductsUrl" action="qkjm_addProducts" namespace="/qkjmanage">
												<s:param name="uuidKey">inStock.uuid</s:param>
												<s:param name="uuidValue" value="inStock.uuid" />
												<s:param name="backUrl">/inStock/inStock_load?viewFlag=mdy&</s:param>
												<s:param name="actionUrl">/inStock/inDetail_add</s:param>
												<s:param name="keyName">inDetail.lading_id</s:param>
												<s:param name="prodName">inDetail.product_id</s:param>
												<s:param name="perName">inDetail.price</s:param>
												<s:param name="numName">inDetail.num</s:param>
												<s:param name="totalName">inDetail.total</s:param>
							</s:url>
											<input type="button" id="product" onclick="window.location.href='${ladingAddProductsUrl}';" value="添加酒品" />
						<!-- <a id="addItem" onclick="commain();" >添加入库明细</a> -->
						</th>
						</s:if>
					</tr>
					<s:iterator value="inDetails" status="sta">
									<tr>
									<td class="nw"><s:property value="uuid" /></td>
						  			<td class="nw"><s:property value="product_name" /></td>
									<td class="nw"><s:property value="price" /></td>
									<td class="nw">
										<s:property value="num" />
										(<s:property value="%{(num/(case_spec*1.0)).toString().substring(0,3)}" />件)
									</td>
									<td class="nw"><s:property value="total" /></td>
									<td>
								   	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_INDETAIL_INDETAIL_DEL') && @com.qkj.ware.action.warepower@checkPermit(inStock.store_id,'add')  && null==inStock.confirm">
								   	[<a href="<s:url namespace="/inStock" action="inDetail_del"><s:param name="inDetail.uuid" value="uuid" /><s:param name="inDetail.lading_id" value="lading_id" /></s:url>" onclick="return isDel();">删除</a>]
								   	</s:if>	   
								    </td>
									</tr>
					</s:iterator>
					</table>
					<p class="lb_gstit">合计</p>
	                <p class="lb_jwei"><s:property value="inStock.total_price" /></p>
		        </div>
			</fieldset>
        </s:if>
        
       <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            	<s:if test="null == inStock && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="inStock_add" cssClass="input-blue"/>
					</s:if>
				</s:if>
				<s:elseif test="null != inStock && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkPermit(inStock.store_id,'add')">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_MDY') && null==inStock.confirm">
					<s:submit id="save" name="save" value="保存" action="inStock_save" cssClass="input-blue"/>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_SURE') && inDetails.size()>0">
					<s:submit value="确认" action="inStock_sure" onclick="return isOp('是否确认?\n确认后将不能更改!');" cssClass="input-yellow"></s:submit>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_DEL')  && null==inStock.confirm && inStock.confirm==null">
				
					<s:submit id="delete" name="delete" value="删除" action="inStock_del"  cssClass="input-red"/>
					</s:if>
					</s:if>
				</s:elseif>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_CENCLE') && @com.qkj.ware.action.warepower@checkPermit(inStock.store_id,'add')  && inStock.confirm!=null && inStock.send!=1">
					<s:submit cssClass="input-red" id="cencle" name="cencle" value="取消订单" action="inStock_cencle" onclick="return isOp('确认取消?');" />
					</s:if>
				<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="inStock_list" namespace="/inStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
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
				<div id="addItemForm" class="label_con" title="请选择入库商品">	
					<div class="label_hang">
			            <div class="label_ltit">商品:</div>
			            <div class="label_rwben2">
			            	<span class="label_rwb">
			            	<select id="membermanagerid" name="inDetail.product_id" title="产品">
								<option>--请选择--</option>
								<s:iterator value="products" status="sta">
								<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />' value='<s:property value="uuid" />'><s:property value="title" /></option>
								</s:iterator>
							</select>	
							</span>
			            </div>
			        </div>																		
					
			        <div class="label_hang">
		            <div class="label_ltit">单价:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="inDetail.price" title="单价" dataType="number"  /></div>
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">数量:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb">
						<s:textfield id="num" name="inDetail.num" title="数量" dataType="integer" cssClass="validate[required]" />
						<span id="ladingItemnumCase"></span>
					</div>
		            </div>
	       		</div>	
	       		<div class="label_hang">
		            <div class="label_ltit">合计:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="inDetail.total" title="合计" dataType="number" /></div>
		            </div>
	       		</div>																				
			        <div class="label_hang label_button tac">																				
			         <s:hidden name="inDetail.lading_id" title="提货单ID" value="%{inStock.uuid}" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_INSTOCK_ADD')">
					<s:submit id="add" name="add" value="确定" action="inDetail_add" onclick="return flag();" />
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
function flag(){
	var num=$("#num").val();
	if(num==null||num==""){
		alert("数量不能为空！");
		return false;
	}
}
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
var add_per_price_input = $("#form_addItem :input[name='inDetail.price']");
var add_num_input = $("#form_addItem :input[name='inDetail.num']");
var add_total_price_input = $("#form_addItem :input[name='inDetail.total']");
var add_product_id = $("#form_addItem :input[name='inDetail.product_id']");

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