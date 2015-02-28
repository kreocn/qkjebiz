<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员库存--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/zTreeStyle/zTreeStyle.css" />" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
<div class="dq_step">
	${path}
	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_LIST')">
	<span class="opb lb op-area"><a href="<s:url action="memberStock_list" namespace="/sysvip"></s:url>">返回列表</a></span>
	</s:if>
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
		<div class="label_ltit">会员帐号:</div>
	    <div class="label_rwb">
		     <s:textfield id="order_user_id" name="memberStock.dealer" title="会员号" cssClass="validate[required]" />
		 </div>
	</div>
	
	<div class="label_hang">
		<div class="label_ltit">会员名称:</div>
		<div class="label_rwben label_rwb"><s:textfield id="order_user_name"  name="memberStock.member_name" cssClass="validate[required,maxSize[85]]" /></div>
	</div>
	</div>
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
	<div class="label_hang">
		    <div class="label_ltit">产品:</div>
		    <div class="label_rwben label_rwb" style="width: 140px;">
		    <s:if test="%{memberStock.product!=null}">
		    	<s:textfield  id="citySel" cssClass="validate[required]" value="%{memberStock.product_name}"/>
		    	<s:hidden name="memberStock.product" id="cityUid" value="%{memberStock.product}"></s:hidden>
		    	<s:hidden id="datacase"></s:hidden>
		    </s:if>
		    <s:else>
		    <s:textfield  id="citySel" cssClass="validate[required]"/>
		    	<s:hidden name="memberStock.product" id="cityUid"></s:hidden>
		    	<s:hidden id="datacase"></s:hidden>
		    </s:else>
		    	
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
		    <div class="label_ltit">数量:</div>
		    <div class="label_rwben" style="width: 140px;">
	    		<div class="nw"><s:textfield id="stockId" onblur="num();" name="memberStock.stock" cssClass="validate[required,custom[integer],maxSize[11]]" /></div>
		    </div>
		</div>
		<div class="label_hang">
		    <div class="label_rwben">
	    		<span id="ladingItemnumCase">
	    		<s:if test="%{memberStock.case_spec!=null}">瓶/${memberStock.case_spec }件</s:if>
	    		</span>
		    </div>
		</div>
	</div>
	
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">核对日期:</div>
		<div class="label_rwben">
	    <div class="label_rwbenx">
            	<input  class="datepicker iI-f validate[required,custom[date]]" type="text" name="memberStock.check_date" value="${it:formatDate(memberStock.check_date,'yyyy-MM-dd')}" />
            </div>
         </div>
	</div>
	</div>
	
	<s:if test="'mdy'==viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">添加人:</div>
	    <div class="label_rwben label_rwb">
	    ${memberStock.add_user_name }
	    </div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">添加时间:</div>
	    <div class="label_rwbenx">
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
	    <div class="label_rwbenx">
	     ${it:formatDate(memberStock.lm_time,'yyyy-MM-dd hh:mm:ss')}
	    </div>
	</div>
	</div>
	</s:if>
	
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            	<s:if test="'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_ADD')">
					<s:submit id="add" name="add" value="确定" action="memberStock_add" />
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_MDY')">
					<s:submit id="save" name="save" value="保存" action="memberStock_save" cssClass="input-blue" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="memberStock_del" cssClass="input-red" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="memberStock_list" namespace="/sysvip" />');"  class="input-gray" />
        	</div>
    	</div>
	</div>
</div>
</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/zTreeJs/jquery.ztree.core-3.5.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/zTreeJs/product_v0.2.js" />"></script>
</body>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var c_mid = '<s:property value="outStock.member_id" />';
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id);});
	CommonUtil.pickrow('fd_list_table');
});

function loadAddress(memberid) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.sendAjax();
}


function num(){
	 setDataCase();
}
function setDataCase() {
	var data_case =document.getElementById("datacase").value;
	var num_value = document.getElementById("stockId").value;
	if(!(data_case==null || data_case=='' || num_value==null || num_value=='')) {
		var num=(num_value/data_case).toFixed(4);
		$("#ladingItemnumCase").html('瓶/'+num+'件');
	}
}

</script>
</html>