<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员库存--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/zTreeStyle/zTreeStyle.css" />" />
<script type="text/javascript" src="<s:url value="/js/zTreeJs/jquery.ztree.core-3.5.js" />"></script>
<script type="text/javascript" src="<s:url value="http://images01.qkjchina.com/qkjebiz01/zTree_result.js?v0=1" />"></script>
<script type="text/javascript" src="<s:url value="/js/zTreeJs/product.js" />"></script>
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<!--right列表-->
<div class="tab_right">
	<div class="tab_warp main">
<div class="dq_step">
${path}
<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_ADD')">
	<span class="opb lb op-area"><a href="<s:url namespace="/sysvip" action="memberStock_load"><s:param name="viewFlag">add</s:param></s:url>">添加库存信息</a></span>
	<span class="opb lb op-area">
	<s:hidden id="marketimgid"></s:hidden>
	</span>

</s:if>
</div>
	<s:form id="serachForm" name="serachForm"  method="get" namespace="/sysvip" theme="simple">
<div class="label_con">
<div class="label_main">
      <div class="label_hang">
          <div class="label_ltit">会员编号:</div>
          <div class="label_rwben"><s:textfield id="order_user_id" name="memberStock.dealer"/></div>
      </div>
      <div class="label_hang">
          <div class="label_ltit">会员名称:</div>
          <div class="label_rwben"><s:textfield name="memberStock.member_name"/></div>
      </div>
      <div class="label_hang">
		    <div class="label_ltit">产品:</div>
		    <div class="label_rwben label_rwb" style="width: 140px;">
		    <s:textfield  id="citySel" name="memberStock.product_name" onclick="showMenu(); return false;"/>
		    	<s:hidden name="memberStock.product" id="cityUid"></s:hidden>
		    	<s:hidden id="datacase"></s:hidden>
		    	<div id="menuContent" class="menuContent">
			        <ul id="treeDemo" class="ztree"></ul>
			    </div>
		    </div>
		</div>
		
		<div class="label_hang">
		<div class="label_ltit">核对日期:</div>
	    <div class="label_rwben">
            	<input  class="datepicker validate[required,custom[date]]" type="text" name="memberStock.check_date" value="${it:formatDate(memberStock.check_date,'yyyy-MM-dd')}" />
         </div>
		</div>
		
	  <div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" onclick="checkstock();" /> <s:reset value="重置" />
        </div>
        <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_DEL')">
          		<div style="clear:both;"><input type="button" class="input-red" value="批量删除" onclick="javascript:deletestock('是否真的要批量删除记录?');"></div>
        </s:if>
</div>
</div>
</s:form>
<div class="tab_warp">
<table>
<tr id="coltr">
	<th class="td1"><input id="uuidcheck" name="uuidcheck" type="checkbox" onclick="checkAll();" /></th>
	<th class="td1">编号</th>
	<th class="td1">会员帐号</th>
	<th class="td3">会员姓名</th>
	<th class="td1">产品</th>
	<th class="td2">库存数量（瓶）</th>
	<th class="td2">核对日期</th>
	<th class="td4">操作</th>
	<th class="td0">查看</th>
</tr>
<s:iterator value="memberStocks" status="sta">
	  <tr id="showtr${uuid}">
	  	<td class="td1"><input id="memberStock.uuid" name="memberStock.uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
	  	<td class="td1">${uuid}</td>
	    <td class="td1">${dealer}</td>
	    <td class="td3">${member_name}</td>
		<td class="td1">${product}(${product_name})</td>
		<td class="td2">
		${stock}&nbsp;瓶
				(${case_spec }件)
		</td>
		<td class="td2">${it:formatDate(check_date,'yyyy-MM-dd')}</td>
		<td class="td4 op-area">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_MDY')">
	    	<a class="input-blue" href="<s:url namespace="/sysvip" action="memberStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="memberStock.uuid" value="uuid"></s:param></s:url>">修改</a>
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_DEL')">
	    	<a class="input-red" href="<s:url namespace="/sysvip" action="memberStock_del"><s:param name="memberStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	    	</s:if>
		</td>
	    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
	  </tr>
</s:iterator>
</table>
</div>
<div id="listpage" class="pagination"></div>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"${assets.typea}",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none",
		required:false
	});
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
 });
</script>
<script type="text/javascript">
function checkstock(){
	if ($("#citySel").val() == '') {
		$("#cityUid").val(null);
}
}

function refurbish(){
	window.location.href="/sysvip/memberStock_list";
}

$(function(){
	$.fn.xhuploadinit("MemberStock",refurbish);
	$("#marketimgid").xhupload();
});

$(document).ready(function(){
	$("#filebtn").removeClass("filearea"); //添加样式marketimgid_filebutton
	$("#marketimgid_filebutton").val("选择导入文件");
});

function deletestock(msg){
	var checked = false;
	var qx=document.getElementsByName("memberStock.uuid"); //获取复选框对象 
    for(var j = 0; j < qx.length; j ++) {      
    	if (qx[j].checked) {    //如果只要有一个复选框被选中，就可以把checked设为true                
    		checked = true;        
    	}          
    }
	if (!checked) {//如果没有一个复选框被选中
		alert('请至少选择一条要删除信息!');
		return;
	}
	if (confirm(msg)) {//如果有选中的，询问消息
		var s = null;
        for(var i = 0; i < qx.length; i ++){   //遍历复选框选中，可以拼接别选中的id      
  		  if(qx[i].type == "checkbox"){              
			 	if (qx[i].checked){                
		 		if (s != null){
					s = s + qx[i].value + ",";
				} else {//第一次
					s = qx[i].value + ",";
				}     
		 		}             
		  }          
		}
		location.href="/sysvip/memberStock_delCheck?checkuuid="+s;
	}
}

</script>
</body>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function() {
	SimpleLoadMember(ajax_url_action,function(event, ui) {loadAddress(ui.item.order_user_id);});
	CommonUtil.pickrow('fd_list_table');
});

function loadAddress(memberid) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url_action;
	ajax.sendAjax();
}
function checkAll(){
	var check=document.getElementsByName("memberStock.uuid");
	var a=check.length;
	if(document.getElementById("uuidcheck").checked){
		for(var i=0;i<a;i++){
			check[i].checked=true;
		}
	}else{
		for(var i=0;i<a;i++){
			check[i].checked=false;
		}
	}
}
</script>
</html>