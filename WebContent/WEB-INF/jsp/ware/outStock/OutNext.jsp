<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>出库--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<style>
body{font-size:14px;}
</style>
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
	<s:form id="editForm" name="editForm" cssClass="validForm" action="outStock_add" namespace="/outStock" method="post" theme="simple">
	<div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">单据号:</div>
		            <div class="label_rwb"><s:property value="outStock.ordernum" /><s:hidden name="outStock.uuid"></s:hidden></div>
	       		</div>
	 </div>
	 <div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">出库时间:</div>
		            <div class="label_rwb"><s:date name="outStock.date" format="yyyy-MM-dd" /><s:hidden name="outStock.date" title="出库时间" /></div>
	       		</div>
	       		<div class="label_hang">
		            <div class="label_ltit">状态:</div>
		            <div class="label_rwb">
		            <s:if test='0==outStock.send'>借出未还</s:if>
					<s:if test='1==outStock.send'>借出已还</s:if>
					<s:if test='2==outStock.send'>新单</s:if>
					<s:if test='3==outStock.send'>待审核</s:if>
					<s:if test='4==outStock.send'>结案-<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
					</div>
	       		</div>
	 </div>
	 <s:if test="%{outStock.reason==0}"><!-- 销售出库，填加会员信息，要审核 -->
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
	 
	 </s:if>
	 <s:elseif test="%{outStock.reason==3}"><!-- 报损出库，不审核，自动入库到报损库 -->
	 	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">报损原因:</div>
            <div class="label_rwbenx">
            	<s:textarea id="note" name="outStock.bsreason" title="报损原因" rows="4" cssClass="label_hang_linput validate[required,maxSize[128]]"></s:textarea>
            </div>
        </div>
     </div>
	 </s:elseif>
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
	 
	 <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            	<s:if test="null == outStock && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
					<s:submit id="add" name="add" value="保存&填写明细" action="outStock_add" cssClass="input-blue"/>
					</s:if>
				</s:if>
				<s:elseif test="null != outStock && 'mdy' == viewFlag">
					<s:hidden name="outStock.reason"/>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_MDY')">
					<s:submit id="save" name="save" value="下一步" action="outStock_sale" cssClass="input-blue"/>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_DEL')">
					<s:submit id="delete" name="delete" value="删除" cssClass="input-red" action="outStock_del" onclick="return isDel();" />
					</s:if>
					</s:if>
					
				</s:elseif>
				<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="outStock_list" namespace="/outStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
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
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id);});
	if(c_mid!='') {
		loadAddress(c_mid);
	}
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
			$(":input[name='outStock.member_adress']").val(sh);
			selectid.setSelectedValue(i);
		}
		c_data[i] = sh;
		sh="";
	}
	selectid.unbind().bind("change",function(){
		$(":input[name='outStock.address']").val(c_data[$(this).getSelectedValue()]);
	});
}

</script>
</html>