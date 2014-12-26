<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var c_mid = '<s:property value="lading.member_id" />';
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id);});
	if(c_mid!='') {
		loadAddress(c_mid);
	}
	$("#addItemForm").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addItem").click(function() {
		openAddForm();
	});
	
	$("#addLadingPay").dialog({
	      autoOpen: false,
	      height: 200,
	      width: 600,
	      modal: true
	});
	$("#addLadingPayOpen").click(function() {
		$("#addLadingPay").dialog("open");
	});
	
	//lading_fd_date
	if($("#lading_fd_date").length>0) {
		$("#lading_fd_date").datepicker();
	}
	CommonUtil.pickrow('fd_list_table');
});

//此段代码可以防止回车提交
jQuery(function($){
    $("form").keypress(function(e){
        if(e.keyCode == 13 && "TEXTAREA"!=e.target.tagName.toUpperCase()) {
            e.preventDefault();
        }
    });  
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
	selectid.addOption("--请选择--",0);
	for ( var i = 0; i < p_data.length; i++) {
		selectid.addOption(i+"-"+ p_data[i].province,i+1);
		sh += p_data[i].province + " " + p_data[i].city + " " + p_data[i].area + " " + p_data[i].street + "  " 
			+ p_data[i].con_name + ' 收  邮编:' + p_data[i].post + ' 联系电话:' + p_data[i].mobile;
		if (p_data[i].defaultaddress == 1) {
			//<s:if test="'add' == viewFlag">
			$(":input[name='lading.address']").val(sh);//</s:if>
			selectid.setSelectedValue(i);
		}
		c_data[i+1] = sh;
		sh="";
	}
	selectid.unbind().bind("change",function(){
		$(":input[name='lading.address']").val(c_data[$(this).getSelectedValue()]);
	});
}

function openAddForm() {
	$("#addItemForm").dialog("open");
}

function closeAddForm() {
	$("#addItemForm").dialog("close");
}
</script>
<body>
<div class="main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="lading_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="lading_load" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_con">
	<s:if test="'mdy' == viewFlag">
	<div class="label_main">
	<div class="label_hang">
	    <div class="label_ltit">申请编号:</div>
	    <div class="label_rwben"><s:property value="lading.uuid" /><s:hidden name="lading.uuid" /></div>
	</div>
	<div class="label_hang">
	    <div class="label_ltit">订单状态:</div>
	    <div class="label_rwben">
	    	<s:if test='0==lading.status'>新单</s:if>
			<s:if test='1==lading.status'>待审核</s:if>
			<s:if test='2==lading.status'>结案-<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
			<s:if test='0==lading.out_flag'><span class="message_error">未出货</span></s:if><s:if test='1==lading.out_flag'>已出货</s:if>
	    </div>
	</div>
	<div class="label_hang">
	    <div class="label_ltit">订单提交时间:</div>
	    <div class="label_rwbenx">${it:formatDate(lading.apply_time,'yyyy-MM-dd HH:mm:ss')}</div>
	</div>
	</div>
	</s:if>
	<s:if test="'add' == viewFlag">
	<div class="label_main">
		<div class="label_hang">
		    <div class="label_ltit">会员编号:</div>
		    <div class="label_rwben label_rwb"><s:textfield id="order_user_id" name="lading.member_id" cssClass="validate[required,maxSize[85]]" /></div>
		</div>
		<div class="label_hang">
		    <div class="label_ltit">会员手机:</div>
		    <div class="label_rwben label_rwb"><s:textfield id="order_user_mobile" name="lading.member_mobile" cssClass="validate[custom[mobile]]"/></div>
		</div>
		<div class="label_hang">
		    <div class="label_ltit">会员名称:</div>
		    <div class="label_rwben label_rwb"><s:textfield id="order_user_name" name="lading.member_name" /></div>
		</div>
	</div>
	</s:if>
	<s:elseif test="'mdy' == viewFlag">
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
	</s:elseif>
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">配送地址:</div>
            <div class="label_rwbenx">
            	<s:textarea id="lading_address" name="lading.address" title="配送地点"  cssClass="label_hang_linput"></s:textarea>
				<br />
				<span class="label_rwb nw">选择预设地址:<select id="selectAddress"></select></span>
			</div>
        </div>
    </div>
    <s:if test="'mdy' == viewFlag">
    <div class="label_main">
    	<fieldset class="clear">
    		<legend>订单明细</legend>
    		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_ADD')">
    		<div>
    			<s:url id="ladingAddProductsUrl" action="qkjm_addProducts" namespace="qkjmanage">
        			<s:param name="uuidKey">lading.uuid</s:param>
        			<s:param name="uuidValue" value="lading.uuid" />
        			<s:param name="backUrl">/qkjmanage/lading_load?viewFlag=mdy&</s:param>
        			<s:param name="actionUrl">/qkjmanage/ladingItem_add</s:param>
        			<s:param name="keyName">ladingItem.lading_id</s:param>
        			<s:param name="prodName">ladingItem.product_id</s:param>
        			<s:param name="perName">ladingItem.per_price</s:param>
        			<s:param name="numName">ladingItem.num</s:param>
        			<s:param name="totalName">ladingItem.total_price</s:param>
        		</s:url>
				<input type="button" id="product" onclick="window.location.href='${ladingAddProductsUrl}';" value="添加酒品" />
    		</div>
    		</s:if>
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
			<tr>
				<th>品名</th>
				<th>单价</th>
				<th>数量(瓶)</th>
				<th>数量(件)</th>
				<th>合计</th>
				<th>操作</th>
			</tr>
			<s:iterator value="ladingItems" status="sta">
			<tr>
				<td class="nw">${product_name}</td>
				<td class="nw">￥${per_price}</td>
				<td class="nw">${num}</td>
				<td class="nw">${it:formatNum(num/case_spec,1)}</td>
				<td class="nw">￥${total_price}</td>
				<td>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_DEL')">
				<a href="<s:url action="ladingItem_del" namespace="/qkjmanage"><s:param name="ladingItem.uuid" value="%{uuid}" /><s:param name="ladingItem.lading_id" value="%{lading.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
				</s:if>
				</td>
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
				    <div class="label_rwben"><s:textfield name="lading.curr_price" cssClass="validate[required,custom[number],maxSize[11]]" /></div>
				</div>
			</div>
    	</fieldset>
    </div>
    <div class="label_main">
	    <div class="label_hang">
		    <div class="label_ltit">?促销活动:</div>
		    <div class="label_rwben2">
		    	<s:select name="lading.promotion_id" list="#{0:'不参加活动',1:'新春搭增活动' }"></s:select>
		    </div>
		</div>
	</div>
	<s:if test="lading.promotion_id!=0">
	<div class="label_main">
    	<fieldset class="clear">
    		<legend>返利/搭赠明细</legend>
    		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGPRODUCTG_ADD')">
    		<div>
    			<s:url id="ladingAddProductgsUrl" action="qkjm_addProducts" namespace="qkjmanage">
        			<s:param name="uuidKey">lading.uuid</s:param>
        			<s:param name="uuidValue" value="lading.uuid" />
        			<s:param name="backUrl">/qkjmanage/lading_load?viewFlag=mdy&</s:param>
        			<s:param name="actionUrl">/qkjmanage/ladingProductg_add</s:param>
        			<s:param name="keyName">ladingProductg.lading_id</s:param>
        			<s:param name="prodName">ladingProductg.product_id</s:param>
        			<s:param name="perName">ladingProductg.per_price</s:param>
        			<s:param name="numName">ladingProductg.num</s:param>
        			<s:param name="totalName">ladingProductg.total_price</s:param>
        		</s:url>
				<input type="button" id="product" onclick="window.location.href='${ladingAddProductgsUrl}';" value="添加酒品" />
    		</div>
    		</s:if>
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
			<tr>
				<th>品名</th>
				<th>单价</th>
				<th>数量(瓶)</th>
				<th>数量(件)</th>
				<th>合计</th>
				<th>操作</th>
			</tr>
			<s:iterator value="ladingProductgs" status="sta">
			<tr>
				<td class="nw">${product_name}</td>
				<td class="nw">￥${per_price}</td>
				<td class="nw">${num}</td>
				<td class="nw">${it:formatNum(num/case_spec,1)}</td>
				<td class="nw">￥${total_price}</td>
				<td>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGPRODUCTG_DEL')">
				<a href="<s:url action="ladingProductg_del" namespace="/qkjmanage"><s:param name="ladingProductg.uuid" value="%{uuid}" /><s:param name="ladingProductg.lading_id" value="%{lading.uuid}" /></s:url>" onclick="return isDel();">[删除]</a>
				</s:if>
				</td>
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
    </s:if>
    </s:if>
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">备注:</div>
            <div class="label_rwbenx">
            	<s:textarea id="lading_note" name="lading.note" title="备注"  cssClass="label_hang_linput validate[maxSize[65535]]" />
            </div>
        </div>
    </div>
    <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            
            <s:if test="null == lading && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_ADD')">
					<s:submit id="add" name="add" value="下一步&填写出货明细" action="lading_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != lading && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_MDY')&&(lading.status==0||lading.status==1)">
					<s:submit id="save" name="save" value="保存" action="lading_save"  cssClass="input-blue" />
					<script type="text/javascript">
					$(function(){
						$("#editForm :input").change(function(){
							if($("#saveLadingStatus0").length>0)
								$("#saveLadingStatus0").attr("disabled","disabled");
							if($("#saveLadingStatus1").length>0)
								$("#saveLadingStatus1").attr("disabled","disabled");
							$("#message").text("请先保存后才能进行其他相关操作");
						});
					});
					</script>
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_STATUS0')&&lading.status==0">
					<s:submit id="saveLadingStatus0" name="saveLadingStatus0" value="送审" action="saveLadingStatus0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_STATUS1')&&lading.status==1">
					<s:submit id="saveLadingStatus1" name="saveLadingStatus1" value="结案&发货" action="saveLadingStatus1" onclick="return isOp('确定执行此操作?');" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_DEL')">
						<s:submit id="delete" name="delete" value="删除订单" action="lading_del" onclick="return isDel();" cssClass="input-red" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="lading_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');"  class="input-gray" />
				<span id="message"  class="cr"></span>
				<input type="button" value="打印" onclick="window.print();" />
            </div>
		</div>
	</div>
    </div>
	</s:form>
</div>
</body>
</html>