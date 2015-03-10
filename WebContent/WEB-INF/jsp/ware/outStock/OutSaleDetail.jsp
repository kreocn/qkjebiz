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
		            <div class="label_rwben2" style="width:auto;">
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
	            <div class="label_rwben">
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
	            </div>
	            
	            <div class="label_hang">
	            <div class="label_ltit">出库仓库:</div>
	            <div class="label_rwben2" style="width:auto;">
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
				<div class="label_rwbenx"><s:date name="outStock.add_timer" format="yyyy-MM-dd HH:mm:ss" /></div>
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
		            <div class="label_rwben">
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
            	<br />
				选择预设地址:<select id="selectAddress"></select>
            </div>
        </div>
     </div>
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
												<s:param name="actionUrl">/outDetail/outDetail_add</s:param>
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
<div id="addItemForm" title="添加明细">
<s:form id="form_addItem" name="form_addItem" action="outDetail_add" namespace="/outDetail" onsubmit="return validator(this);" method="post" theme="simple">
	<table>
		  <tr>
		   	<td>
		   	<div class="label_main input-a">
				<div id="addItemForm" class="label_con" title="请选择出库商品">	
					<div class="label_hang">
					<s:hidden id="member_id" name="mid"></s:hidden>
					<s:hidden id="member_mebile" name="mmebile"></s:hidden>
					<s:hidden id="member_name" name="mname"></s:hidden>
					<s:hidden id="member_adress" name="madress"></s:hidden>
					<s:hidden id="member_price" name="mprice"></s:hidden>
			            <div class="label_ltit">商品:</div>
			            <div class="label_rwben2">
			            	<span class="label_rwb">
			            	<select id="membermanagerid" name="outDetail.product_id" title="产品">
								<option>--请选择--</option>
								<s:iterator value="stocks" status="sta">
								<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />' value='<s:property value="uuid" />'><s:property value="product_name" /></option>
								</s:iterator>
							</select>
							</span>
			            </div>
			        </div>																		
					
			        <div class="label_hang">
		            <div class="label_ltit">单价:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb">
		            <s:textfield id="pri" name="outDetail.price" title="单价" dataType="number" cssClass="validate[required]" />
					<span id="per_price_select_area"><select id="per_price_select"></select></span>
					</div>
		            </div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">数量:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb">
			            <s:textfield id="num" name="outDetail.num" title="数量" dataType="integer" cssClass="validate[required]" />
						<span id="ladingItemnumCase"></span>
					</div>
		            </div>
	       		</div>	
	       		<div class="label_hang">
		            <div class="label_ltit">合计:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="outDetail.totel" title="合计"/></div>
		            </div>
	       		</div>																				
			        <div class="label_hang label_button tac">
			        <s:hidden name="outDetail.lading_id" title="提货单ID" value="%{outStock.uuid}" />
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
					<s:submit id="add" name="add" value="确定" action="outDetail_add" onclick="return flag();"/>
					</s:if>
					<input type="button" value="关闭" onclick="closeAddForm();" class="input-gray" />	
			        </div>
			       </div>																				
				</div>
			</td>
		 	</tr>
	</table>	
</s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
function flag(){
	var num=$("#num").val();
	var pri=$("#pri").val();
	if(num==null||num==""){
		alert("数量不能为空！");
		return false;
	}
	if(pri==null||pri==""){
		alert("单价不能为空！");
		return false;
	}
}
function commain(){
	var id=$("#order_user_id").val();
	var mebile=$("#order_user_mobile").val();
	var name=$("#order_user_name").val();
	var address=$("#address").val();
	var price=$("#order_price").val();
	
	$("#member_id").val(id);
	$("#member_mebile").val(mebile);
	$("#member_name").val(name);
	$("#member_adress").val(address);
	$("#member_price").val(price);
	
}
var add_per_price_input = $("#form_addItem :input[name='outDetail.price']");
var add_num_input = $("#form_addItem :input[name='outDetail.num']");
var add_total_price_input = $("#form_addItem :input[name='outDetail.totel']");
var add_product_id = $("#form_addItem :input[name='outDetail.product_id']");

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
	
	$("#addoutStockPay").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addoutStockPayOpen").click(function() {
		$("#addoutStockPay").dialog("open");
	});
	
	//outStock_fd_date
	if($("#outStock_fd_date").length>0) {
		$("#outStock_fd_date").datepicker();
	}
	
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

function loadAddress(memberid) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		createAddreeeSelect(data);
	};
	ajax.addParameter("privilege_id", "QKJCJ_SYSEBIZ_AJAXLOAD_ADDRESS");
	ajax.addParameter("parameters", "member_id=" + memberid);
	ajax.sendAjax();
}

var c_data=new Array(); // 保存当前用户的所有联系人信息
function createAddreeeSelect(p_data) {
	var selectid = $("#selectAddress");
	selectid.clearAllOption();
	var sh = "";
	for ( var i = 0; i < p_data.length; i++) {
		selectid.addOption(i+"-"+ p_data[i].province,i);
		sh += p_data[i].province + " " + p_data[i].city + " " + p_data[i].area + " " + p_data[i].street + "  " 
			+ p_data[i].con_name + ' 收  邮编:' + p_data[i].post + ' 联系电话:' + p_data[i].mobile;
		if (p_data[i].defaultaddress == 1) {
			$(":input[name='outStock.address']").val(sh);
			selectid.setSelectedValue(i);
		}
		c_data[i] = sh;
		sh="";
	}
	selectid.unbind().bind("change",function(){
		$(":input[name='outStock.address']").val(c_data[$(this).getSelectedValue()]);
	});
}

function openAddForm() {
	$("#addItemForm").dialog("open");
}

function closeAddForm() {
	$("#addItemForm").dialog("close");
}

//当前日期
function wol() {
	var date = new Date();
	var dateString = date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
			+ date.getDate();
		document.getElementById("indate").value=dateString;
}
</script>

</html>