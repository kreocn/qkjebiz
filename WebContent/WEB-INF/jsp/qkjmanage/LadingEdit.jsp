<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>订单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
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
	    	<s:if test='5==lading.status'><span title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cr">已退回(${lading.check_user_name})</span></s:if>
			<s:if test='10==lading.status'><span title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cy">待确认(${lading.check_user_name})</span></s:if>
			<s:if test='20==lading.status'><span title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cg">已确认(${lading.check_user_name})</span></s:if>
			<s:if test='30==lading.status'><span  title="${it:formatDate(lading.check_time,'yyyy-MM-dd HH:mm:ss')}" class="cg">已发货</span></s:if>
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
     <!-- 发货部门 -->
    <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">发货部门:</div>
            <div class="label_rwben nw">
            	<s:textfield id="userdept_nameid" name="lading.dis_dept_name" readonly="true" cssClass="validate[required]" />
				<s:hidden id="userdept_codeid" name="lading.dis_dept" />
            </div>
			<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" />
        </div>
        
		</div>
		
    <s:if test="'mdy' == viewFlag">
    <div class="label_main">
    	<fieldset class="clear">
    		<legend>订单明细</legend>
    		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_ADD') && lading.status<=5">
    		<div>
    			<s:url id="ladingAddProductsUrl" action="qkjm_addProducts" namespace="qkjmanage">
    				<s:param name="onlyType">0</s:param>
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
				<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_DEL')">
				<th>操作</th>
				</s:if>
			</tr>
			<s:iterator value="ladingItems" status="sta">
			<tr>
				<td class="nw">${product_name}</td>
				<td class="nw">￥${per_price}</td>
				<td class="nw">${num}</td>
				<td class="nw">${it:formatNum(num/case_spec,1)}</td>
				<td class="nw">￥${total_price}</td>
				<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGITEM_DEL')">
				<td><a href="<s:url action="ladingItem_del" namespace="/qkjmanage"><s:param name="ladingItem.uuid" value="%{uuid}" /><s:param name="ladingItem.lading_id" value="%{lading.uuid}" /></s:url>" onclick="return isDel();">[删除]</a></td>
				</s:if>
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
    <fieldset class="clear">
   		<legend>已参与促销活动</legend>
   		<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
		<tr>
			<th>活动名称</th>
			<th>开始时间</th>
			<th>结束时间</th>
			<th>操作</th>
		</tr>
		<!-- lading.promotions -->
		<s:iterator value="salPromotsed" status="sta">
		<tr>
			<td class="nw">${sal_title}</td>
			<td class="nw">${it:formatDate(startime,'yyyy-MM-dd')}</td>
			<td class="nw">${it:formatDate(endtime,'yyyy-MM-dd')}</td>
			<td><a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a></td>
		</tr>
		</s:iterator>
		</table>
		<script type="text/javascript">
		setCheckBox("lading.promotions", '${lading.promotions}');
		</script>
	</fieldset>
	</div>
	<s:if test="lading.status<=5">
    <div class="label_main">
    <fieldset class="clear">
   		<legend>可参与促销活动</legend>
   		<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
		<tr>
			<th>参加</th>
			<th>活动名称</th>
			<th>开始时间</th>
			<th>结束时间</th>
			<th>操作</th>
		</tr>
		<!-- lading.promotions -->
		<s:iterator value="salPromots" status="sta">
		<tr>
			<td class="nw">
				<input type="checkbox" name="lading.promotions" value="${uuid}" />
			</td>
			<td class="nw">${sal_title}</td>
			<td class="nw">${it:formatDate(startime,'yyyy-MM-dd')}</td>
			<td class="nw">${it:formatDate(endtime,'yyyy-MM-dd')}</td>
			<td><a href="javascript:;" onclick="openCustomerView(${uuid});">[查看详情]</a></td>
		</tr>
		</s:iterator>
		</table>
		<script type="text/javascript">
		setCheckBox("lading.promotions", '${lading.promotions}');
		</script>
	</fieldset>
	</div>
	</s:if>
	<s:if test="lading.promotions!=null">
	<div class="label_main">
    	<fieldset class="clear">
    		<legend>返利/搭赠明细</legend>
    		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGPRODUCTG_ADD') && lading.status<=5">
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
				<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGPRODUCTG_DEL')">
				<th>操作</th>
				</s:if>
			</tr>
			<s:iterator value="ladingProductgs" status="sta">
			<tr>
				<td class="nw">${product_name}</td>
				<td class="nw">￥${per_price}</td>
				<td class="nw">${num}</td>
				<td class="nw">${it:formatNum(num/case_spec,1)}</td>
				<td class="nw">￥${total_price}</td>
				<s:if test="lading.status<=5 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADINGPRODUCTG_DEL')">
				<td><a href="<s:url action="ladingProductg_del" namespace="/qkjmanage"><s:param name="ladingProductg.uuid" value="%{uuid}" /><s:param name="ladingProductg.lading_id" value="%{lading.uuid}" /></s:url>" onclick="return isDel();">[删除]</a></td>
				</s:if>
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
				    <div class="label_rwben">
				    <s:if test="%{lading.total_price<=0.00}">
				    0.00%
				    </s:if>
				    <s:else>
				  ${it:formatNum(lading.total_price_g*100/lading.total_price,2)}%
				    </s:else>
				    </div>
				</div>
			</div>
    	</fieldset>
    </div>
    </s:if>
    
     <div class="label_main">
    	<fieldset class="clear">
    		<legend>财务信息</legend>
    		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_FDCHECK')">
			<div class="op-area"><a id="FDCheckInfoOpener" href="javascript:;">添加/修改财务信息</a></div>
    		</s:if>
    		<div class="label_main">
				<div class="label_hang">
				    <div class="label_ltit">付款状态:</div>
				   <div class="label_rwben label_rwb">
				   		<s:if test="lading.fd_check==0"><span class="cr">未付款</span></s:if>
				   		<s:if test="lading.fd_check==1"><span class="cy">未付清</span></s:if>
				   		<s:if test="lading.fd_check==2"><span class="cg">已付款</span></s:if>
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">付款日期:</div>
				    <div class="label_rwben label_rwb">${it:formatDate(lading.fd_date,'yyyy-MM-dd')}</div>
				</div>
			</div>
			<div class="label_main">
				<div class="label_hang">
				    <div class="label_ltit">付款方式:</div>
				    <div class="label_rwbenx">
				    	<!--   cssClass="regular-checkbox" -->
				    	<s:checkboxlist name="lading.fd_typesx" list="#{0:'现金',1:'POS',2:'支票',3:'转账',4:'预付款',5:'其他'}" cssClass="regular-checkbox" />
				    </div>
				</div>
			</div>
			<div class="label_main">
				<div class="label_hang">
				    <div class="label_ltit">付款说明:</div>
				    <div class="label_rwbenx">${lading.fd_note}</div>
				</div>
			</div>
    	</fieldset>
    </div>
    </s:if>
   
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">备注:</div>
            <div class="label_rwbenx">
            	<s:textarea id="lading_content" name="lading.content" title="备注"  cssClass="label_hang_linput validate[maxSize[65535]]" />
            </div>
        </div>
    </div>
    <s:if test="lading.status>5">
    <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">审核意见:</div>
            <div class="label_rwbenx">
            	<s:textarea id="lading_note" name="lading.note" title="备注"  cssClass="label_hang_linput validate[maxSize[65535]]" />
            </div>
        </div>
    </div>
    </s:if>
    <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx op-area">
            <s:if test="null == lading && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_ADD')">
					<s:submit id="add" name="add" value="下一步&填写出货明细" action="lading_add" cssClass="input-blue"/>
					</s:if>
				</s:if>
				<s:elseif test="null != lading && 'mdy' == viewFlag">
					<s:if test="lading.status<=5">
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_MDY')">
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
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_STATUS0')&&lading.status<=5">
							<s:submit id="saveLadingStatus0" name="saveLadingStatus0" value="送审" action="saveLadingStatus0" onclick="return isOp('确定执行此操作?');" cssClass="input-yellow" />
						</s:if>
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_DEL')">
							<s:submit id="delete" name="delete" value="删除订单" action="lading_del" onclick="return isDel();" cssClass="input-red" />
						</s:if>
					</s:if>
					
					
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_STATUS10')&&lading.status==10">
						<s:submit id="saveLadingStatus10" name="saveLadingStatus10" value="财务通过" action="saveLadingStatus10" onclick="return isOp('确定执行此操作?');" cssClass="input-green" />
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_STATUS5')">
						<s:submit id="saveLadingStatus5" name="saveLadingStatus5" value="财务退回" action="saveLadingStatus5" onclick="return isOp('确定执行此操作?');" cssClass="input-red" />
						</s:if>
					</s:if>
				</s:elseif>
				<s:if test="lading.status>=10">
								<input type="button" onclick="linkurl('<s:url namespace="/qkjmanage" action="lading_view"><s:param name="lading.uuid" value="lading.uuid" /><s:param name="viewFlag">view</s:param></s:url>');" value="转到详情页面" />
				</s:if>
				<input type="button" value="返回" onclick="linkurl('<s:url action="lading_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>');"  class="input-gray" />
				<span id="message"  class="cr"></span>
				<!-- <input type="button" value="打印" onclick="window.print();" /> -->
            </div>
		</div>
	</div>
    </div>
	</s:form>
</div>
</div>
<!-- HIDDEN AREA BEGIN -->
<div class="dn">
<!-- 添加财务信息 -->
<div id="addFDCheckInfo" class="label_con idialog" title="添加财务信息">
<s:form id="form_addFDCheckInfo" name="form_addFDCheckInfo" cssClass="validFormDialog" action="mdyLadingFDCheck" namespace="/qkjmanage" method="post" theme="simple">
<div class="label_main">
	<div class="label_hang">
	    <div class="label_ltit">付款状态:</div>
	   <div class="label_rwben label_rwb">
		    	<s:select name="lading.fd_check" list="#{0:'未付款',2:'未付清',3:'已付款' }" />
	    </div>
	</div>
	<div class="label_hang">
	    <div class="label_ltit">付款方式:</div>
	    <div class="label_rwben"></div>
	</div>
	<div class="label_hang">
	  <s:checkboxlist name="lading.fd_typesx" list="#{0:'现金',1:'POS',2:'支票',3:'转账',4:'预付款',5:'其他'}" />
	</div>
	<div class="label_hang">
	    <div class="label_ltit">付款日期:</div>
	    <div class="label_rwben label_rwb">
	    	<input  name="lading.fd_date" class="datepicker validate[custom[date]]" value="${it:formatDate(lading.fd_date,'yyyy-MM-dd')}" />
	    </div>
	</div>
	<div class="label_hang">
	    <div class="label_ltit">付款说明:</div>
	    <div class="label_rwben nw"><s:textarea name="lading.fd_note" /></div>
	</div>
	 <div class="label_hang label_button tac">
	 	<s:hidden name="lading.uuid" />
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_LADING_FDCHECK')">
		<s:submit id="mdyLadingFDCheck" name="mdyLadingFDCheck" value="确定" action="mdyLadingFDCheck" />
		</s:if>
	 </div>
</div>
</s:form>
</div>
</div>
<!-- HIDDEN AREA END -->
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var c_mid = '<s:property value="lading.member_id" />';
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id);});
	if(c_mid!='') {
		loadAddress(c_mid);
	}
	
	$("#addFDCheckInfo").dialog({
	      autoOpen: false,
	      //height: 200,
	      //width: 600,
	      modal: true
	});
	$("#FDCheckInfoOpener").click(function() {
		$("#addFDCheckInfo").dialog("open");
	});
	
	//CommonUtil.pickrow('fd_list_table');
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
</script>

<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var add_user='${customerRecode.add_user}';
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
	$("#customerRecode_recode_time").datepicker();
	$("#customerRecode_next_date").datepicker();
	
	if($("#userdept_codeid").val()!='') {
		loadManagers($("#userdept_codeid").val());
	}
	createCustomerView();
 });

var sobj01;
var selectDept = function(dcode_id, dname_id, isLoad, p_m,b_m){
	sobj01 = new DialogIFrame({ src : '/sys/dept_permit_select?objname=sobj01&check_code=1',
	title : "选择部门",
	width : 200,
	height : 400 });
	sobj01.selfAction = function(val1, val2){
		$("#" + dcode_id).val(val1);
		$("#" + dname_id).val(val2);
		if (isLoad) {
			if(b_m==1){
				loadManagers(val1, p_m,'1');
			}else{
				loadManagers(val1, p_m);
			}
			
		}
	};
	sobj01.create();
	sobj01.open();
};

var sobj02;
var createCustomerView = function() {
	//http://localhost:8888/qkjmanage/customer_load?viewFlag=mdy&customer.uuid=3
	var w_width = $(window).width();
	var w_height = $(window).height();
	sobj02 = new DialogIFrame({
		src:'',
		title:"查看促销活动信息",
		width:w_width*0.35,
		height:w_height*0.85
	});
	sobj02.selfAction = function(val1,val2) {};
	sobj02.create();
	//sobj02.open();
};

var openCustomerView = function(customer_uuid) {
	var iframeId = sobj02.getConid() + "iframe";
	$("#"+iframeId).attr("src","/salpro/salPromot_loadt?viewFlag=view&salstate=1&salPromot.uuid=" + customer_uuid);
	sobj02.open();
};

</script>
</body>
</html>