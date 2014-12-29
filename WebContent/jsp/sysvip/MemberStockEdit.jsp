<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员库存--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/zTreeStyle/zTreeStyle.css" />" />
<script type="text/javascript" src="<s:url value="/js/zTreeJs/jquery.ztree.core-3.5.js" />"></script>
<script type="text/javascript" src="<s:url value="http://images01.qkjchina.com/qkjebiz01/zTree_result.js?v0=1" />"></script>
<script type="text/javascript" src="<s:url value="/js/zTreeJs/product.js" />"></script>
<body>
<div class="main">
<div class="dq_step">
	${path}
	<span class="opb lb op-area"><a href="<s:url action="memberStock_list" namespace="/sysvip"></s:url>">返回列表</a></span>
</div>
<s:form id="editForm" name="editForm" cssClass="validForm" namespace="/sysvip" method="post" theme="simple">
<div class="label_con">
	<s:if test="'mdy' == viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">编号:</div>
		<div class="label_rwben label_rwb">${memberStock.uuid}<s:hidden name="memberStock.uuid" title="会员号" /></div>
	</div>
	</div>
	</s:if>
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">经销商帐号:</div>
	    <div class="label_rwben label_rwb">
	    <s:textfield  name="memberStock.dealer" cssClass="validate[required,maxSize[85]]" />
	    </div>
	</div>
	</div>
	<div class="label_main">
	<div class="label_hang">
		    <div class="label_ltit">产品:</div>
		    <div class="label_rwben label_rwb" style="width: 140px;">
		    	<s:textfield  id="citySel"/>
		    	<s:hidden name="memberStock.product" id="cityUid"></s:hidden>
		    	<s:hidden id="datacase"></s:hidden>
		    </div>
		</div>
	<div class="label_hang">
		<div class="label_rwben">
		    	&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="addProduct" value="选择商品" onclick="showMenu();"/>
		    	<div id="menuContent" class="menuContent">
			        <ul id="treeDemo" class="ztree"></ul>
			    </div>
		    </div>
	</div>
	</div>
	
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">数量:</div>
	    <div class="label_rwben label_rwb">
	    <s:textfield name="memberStock.stock" cssClass="validate[required,maxSize[85]]" />
	    </div>
	</div>
	</div>
	
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">核对日期:</div>
		<div class="label_rwben">
	    <div class="label_rwbenx">
            	<span class="message_prompt">日期仅填写年月即可，例（2014-12）</span>
            	<s:textfield id="active_remark" name="memberStock.check_date" title="活动备注" size="40%"  cssClass="inputNote" />
            </div>
         </div>
	</div>
	</div>
	
	<s:if test="'mdy'==viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">填加人:</div>
	    <div class="label_rwben label_rwb">
	    ${memberStock.add_user_name }
	    </div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">填加时间:</div>
	    <div class="label_rwben label_rwb">
	     ${it:formatDate(memberStock.add_time,'yyyy-MM-dd hh:mm:ss')}
	    </div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">修改人:</div>
	    <div class="label_rwben label_rwb">
	    ${memberStock.lm_user_name }
	    </div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">修改时间:</div>
	    <div class="label_rwben label_rwb">
	     ${it:formatDate(memberStock.lm_time,'yyyy-MM-dd hh:mm:ss')}
	    </div>
	</div>
	</div>
	</s:if>
	
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            	<s:if test="'add' == viewFlag">
					<s:submit id="add" name="add" value="确定" action="member_add" />
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:submit id="save" name="save" value="保存" action="member_save" cssClass="input-blue" />
					<s:submit id="delete" name="delete" value="删除" action="member_del" cssClass="input-red" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="member_list" namespace="/sysvip" />');"  class="input-gray" />
        	</div>
    	</div>
	</div>
</div>
</s:form>
</div>
</body>
<script type="text/javascript">
var add_per_price_input = $("#form_addProductForm :input[name='activeProduct.per_price']");
var add_num_input = $("#form_addProductForm :input[name='activeProduct.num']");
var add_total_price_input = $("#form_addProductForm :input[name='activeProduct.total_price']");
var add_product_id = $("#form_addProductForm :input[name='activeProduct.product_id']");

$(function(){
	add_per_price_input.bind("keyup",function(){
		add_total_price_input.val($(this).val()*add_num_input.val());
		
	});
	add_num_input.bind("keyup",function(){
		add_total_price_input.val($(this).val()*add_per_price_input.val());
		setDataCase();
	});
	
	$("#per_price_select").bind("change",function(){
		add_per_price_input.val($(this).val());
		add_total_price_input.val($(this).val()*add_num_input.val());
		setDataCase();
	});
});
$("#per_price_select_area").hide();
function setDataCase() {
	var data_case =document.getElementById("datacase").value;
	var num_value = add_num_input.val();
	if(!(data_case==null || data_case=='' || num_value==null || num_value=='')) {
		var num=num_value/data_case;
		$("#ladingItemnumCase").html('瓶/'+num+'件');
	}
}
</script>
</html>