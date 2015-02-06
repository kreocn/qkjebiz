<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


<title>活动申请单管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/zTreeStyle/zTreeStyle.css" />" />
<script type="text/javascript" src="<s:url value="/js/zTreeJs/jquery.ztree.core-3.5.js" />"></script>
<script type="text/javascript" src="<s:url value="http://images01.qkjchina.com/qkjebiz01/zTree_result.js?v0=1" />"></script>
<script type="text/javascript" src="<s:url value="/js/zTreeJs/product.js" />"></script>
</head>
<body>
<div class="main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<s:if test="%{state==1}">
		<a href="<s:url namespace="/qkjmanage" action="active_load"><s:param name="viewFlag">mdy</s:param><s:param name="active.uuid" value="%{active.uuid}"></s:param></s:url>">返回申请修改页面</a>
		</s:if>
		<s:if test="%{state==2}">
		<a href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="uuid"></s:param></s:url>">返回结案修改页面</a>
		</s:if>
		</span>
	</div>
	<div id="addProductForm" class="label_con idialog" title="添加酒品" align="center">
	<s:form id="form_addProductForm" name="form_addProductForm" cssClass="validFormDialog" action="activeProduct_add" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_main">
		<s:hidden name="active.uuid" value="%{active.uuid}"></s:hidden>
		<div class="label_hang">
		    <div class="label_ltit">产品:</div>
		   <%-- <div class="label_rwben label_rwb">
		    	<select name="activeProduct.product_id" title="产品">
			    	<s:iterator value="products" status="sta">
						<option data='<s:property value="market_price" />#<s:property value="group_price" />#<s:property value="dealer_price" />#<s:property value="agree_price_1" />#<s:property value="agree_price_2" />#<s:property value="agree_price_3" />' data_case='<s:property value="case_spec" />' value='<s:property value="uuid" />'>
						<s:property value="title" />
						</option>
					</s:iterator>
				</select>
		    </div> --%>
		    <div class="label_rwben label_rwb" style="width: 140px;">
		    	<s:textfield  id="citySel"/>
		    	<s:hidden name="activeProduct.product_id" id="cityUid"></s:hidden>
		    	<s:hidden id="datacase"></s:hidden>
		    </div>
		</div>
		<div class="label_hang">
		<div class="label_rwben">
		    	&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="addProduct" value="选择商品" onclick="showMenu(); return false;"/>
		    	<div id="menuContent" class="menuContent">
			        <ul id="treeDemo" class="ztree"></ul>
			    </div>
		    </div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
		    <div class="label_ltit">单价:</div>
		    <div class="label_rwben">
		    	<span class="label_rwb" style="width: 140px;"><s:textfield name="activeProduct.per_price" cssClass="validate[required,custom[number],maxSize[11]]" /></span>
		    	<div id="per_price_select_area" class="label_rwben"><select id="per_price_select"></select></div>
		    </div>
		</div>
		
	</div>
	
	<div class="label_main">
	<div class="label_hang">
		    <div class="label_ltit">数量:</div>
		    <div class="label_rwben" style="width: 140px;">
	    		<div class="nw"><s:textfield name="activeProduct.num" cssClass="validate[required,custom[integer],maxSize[11]]" /></div>
		    </div>
		</div>
		<div class="label_hang">
		    <div class="label_rwben">
	    		<span id="ladingItemnumCase"></span>
		    </div>
		</div>
	</div>
	
	<div class="label_main">
	<div class="label_hang">
		    <div class="label_ltit">合计:</div>
		    <div class="label_rwben nw" style="width: 140px;"><s:textfield name="activeProduct.total_price" title="合计" cssClass="validate[required,custom[number],maxSize[11]]" />元</div>
		</div>
	</div>
	<s:if test="%{state==1}">
	<div class="label_main">
	<div class="label_hang label_button tac">
		 	<s:hidden name="activeProduct.active_id" value="%{active.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD')">
			<s:submit id="activeProduct_add" name="activeProduct_add" value="确定" action="activeProduct_add" />
			</s:if>
		 </div>
	</div>
	</s:if>
	<s:if test="%{state==2}">
	<div class="label_main">
	<div class="label_hang label_button tac">
	 	<s:hidden name="activeProduct.active_id" value="%{active.uuid}" />
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCTCLOSE_ADD')">
		<s:submit id="activeProduct_add" name="activeProduct_add" value="确定" action="activeProductClose_add" />
		</s:if>
	 </div>
	</div>
	</s:if>
	</s:form>
	</div>
</div>
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
</body>
</html>