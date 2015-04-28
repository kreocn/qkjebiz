<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>添加产品--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/zTreeStyle/zTreeStyle.css" />" />
<script type="text/javascript" src="<s:url value="/js/zTreeJs/jquery.ztree.core-3.5.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/zTreeJs/product_v0.2.js" />"></script>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		<span class="opb lb op-area">
		<a href="${backUrl}${uuidKey}=${uuidValue}">返回</a>
		</span>
	</div>
	<div id="addProductForm" class="label_con idialog" title="添加产品" align="center">
	<form id="editForm" name="editForm" class="validForm"  action="${actionUrl}" method="post">
	<input type="hidden" name="${uuidKey}" value="${uuidValue}" />	
	<input type="hidden" name="${keyName}" value="${uuidValue}" />	
	<div class="label_main">
		<div class="label_hang">
		    <div class="label_ltit">类型:</div>
		    <div class="label_rwben15">
		    	<select id="selectType" name="selectType">
		    		<s:if test="onlyType==0 || onlyType==null"><option value="0">产品</option></s:if>
		    		<s:if test="onlyType==1 || onlyType==null"><option value="1">促销物料</option></s:if>
		    	</select>
		    </div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_ltit">&nbsp;</div>
		<div class="label_rwben2 cr tal">
		品鉴酒移到[促销物料]里了
		</div>
	</div>
	
	<div class="label_main">
		<div class="label_hang">
		    <div class="label_ltit">产品:</div>
		    <div class="label_rwben15">
		    	<s:textfield  id="citySel"/>
		    	<input type="hidden" name="${prodName}"  id="cityUid" />	
		    	<s:hidden id="datacase"></s:hidden>
		    </div>
		</div>
		<div class="label_hang">
		<div class="label_rwben">
		    	&nbsp;<input type="button" id="addProduct" value="选择产品" onclick="showMenu(); return false;"/>
		    	<div id="menuContent" class="menuContent">
			        <ul id="treeDemo" class="ztree"></ul>
			    </div>
		    </div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_ltit">&nbsp;</div>
		<div class="label_rwben2 cr tal">
		海拔系列产品移到[天佑德海拔系列]里了
		</div>
	</div>
	
	<div id="per_price_select_area" class="label_main">
		<div class="label_hang">
		    <div class="label_ltit">参考价:</div>
		    <div class="label_rwben15"><select id="per_price_select"></select></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
		    <div class="label_ltit">单价:</div>
		    <div class="label_rwben15"><input type="text" name="${perName}" class="validate[required,custom[number],maxSize[11]]" /></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
		    <div class="label_ltit">数量:</div>
		    <div class="label_rwbenx">
			    <input type="text" name="${numName}" class="validate[required,custom[number],maxSize[11]]" />
				<span id="ladingItemnumCase"></span>
			</div>
		</div>
	</div>
	
	<div class="label_main">
	<div class="label_hang">
		    <div class="label_ltit">合计:</div>
		    <div class="label_rwben15 nw"><input type="text" name="${totalName}" class="validate[required,custom[number],maxSize[11]]" />元</div>
		</div>
	</div>
	<div class="label_main">
	<div class="label_hang label_button tar">
			<input type="submit" value="确定" class="input-blue"/>
			<input type="button" value="返回" onclick="linkurl('${backUrl}${uuidKey}=${uuidValue}');"  class="input-gray" />
		 </div>
	</div>
	
	</form>
	</div>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var add_per_price_input = $("#editForm :input[name='${perName}']");
var add_num_input = $("#editForm :input[name='${numName}']");
var add_total_price_input = $("#editForm :input[name='${totalName}']");
var add_product_id = $("#editForm :input[name='${prodName}']");

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