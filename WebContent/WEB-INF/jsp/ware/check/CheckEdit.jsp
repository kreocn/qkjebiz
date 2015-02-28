<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>盘点管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
		<a href="<s:url action="check_list" namespace="/check" />" >盘点列表</a>
		</span>
	</div>
	<!-- 页面修改 -->
	<s:form id="editForm" name="editForm" cssClass="validForm" action="check_add" namespace="/check" method="post" theme="simple">
	<s:if test="null != check && check.stock_id!=null">
	<div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">编号:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:property value="check.uuid" /><s:hidden name="check.uuid" title="编号" /></div>
		            </div>
	       		</div>
	 </div>
	 <div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">商品名称:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:property value="check.product_name" /></div>
		            </div>
	       		</div>
	 </div>
	 <div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">所在仓库:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:property value="check.ware_name" /></div>
		            </div>
	       		</div>
	 </div>
	 <div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">库存数量:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:property value="check.quantity" /></div>
		            </div>
	       		</div>
	 </div>
	 <div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">相差数量:</div>
		            <div class="label_rwben2">
		            <div class="label_rwb"><s:textfield name="check.num"></s:textfield></div>
		            </div>
	       		</div>
	 </div>
	</s:if>
	<!-- 填加 -->
	<s:else>
		<div class="tab_warp">
	 		<table>
	 		<tr id="coltr">
			<th class="td1">商品名称</th>
		    <th class="td3">所在仓库</th>
			<th class="td1">库存</th>
			<th class="td2">招待用酒</th>
			<th class="td3">赠酒</th>
			<th class="td3">报损</th>
			<th class="td2">借酒</th>
			<th class="td2">其它</th>
			<th class="td1">变动数量</th>
			<th class="td0">查看</th>
			 
		  	</tr>
		  	<s:iterator value="stocks" status="sta">
		  		<s:hidden name="pageStocks[%{#sta.index}].uuid" value="%{uuid}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].product_id" value="%{product_id}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].store_id" value="%{store_id}" />
		    	<s:hidden name="pageStocks[%{#sta.index}].quantity" value="%{quantity}" />
		    	
		    	<s:hidden name="pageStocks[%{#sta.index}].zdnum" value="%{zdnum}"/>
				<s:hidden name="pageStocks[%{#sta.index}].znum" value="%{znum}"/>
				<s:hidden name="pageStocks[%{#sta.index}].snum" value="%{snum}"/>
				<s:hidden name="pageStocks[%{#sta.index}].jnum" value="%{jnum}"/>
				<s:hidden name="pageStocks[%{#sta.index}].qnum" value="%{qnum}"/>
		  		<tr id="showtr${uuid}">
		  			<td class="td1 nw"><s:property value="product_name" /></td>
		  			<td class="td3 nw"><s:property value="store_name" /></td>
				    <td class="td1 nw"><s:property value="quantity" /></td>
				    <td class="td2 nw">
						<s:if test="zdnum==null">0</s:if>
						<s:else>
						<s:property value="zdnum"></s:property></s:else></td>
						<td class="td3 nw">
						<s:if test="zdnum==null">0</s:if>
						<s:else>
						<s:property value="znum"></s:property></s:else></td>
						<td class="td3 nw">
						<s:if test="zdnum==null">0</s:if>
						<s:else>
						<s:property value="snum"></s:property></s:else></td>
						<td class="td2 nw">
						<s:if test="zdnum==null">0</s:if>
						<s:else>
						<s:property value="jnum"></s:property></s:else></td>
						<td class="td2 nw">
						<s:if test="zdnum==null">0</s:if>
						<s:else>
						<s:property value="qnum"></s:property></s:else></td>
						<td class="td1 nw">
						<s:textfield name="pageStocks[%{#sta.index}].cnum" value="0"></s:textfield></td>
						<td class="td0 op-area"><div class="printhide"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></div></td>
		  		</tr>
		  	</s:iterator>
	 		</table>
	 	</div>
	</s:else>
	<div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_ADD')">
					<s:submit id="add" name="add" value="确定" cssClass="input-blue" action="check_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_MDY')">
					<s:submit id="save" name="save" value="保存" cssClass="input-blue"  action="check_save"  />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_CHECK_DEL')">
					<s:submit id="delete" name="delete" value="删除" cssClass="input-red" action="check_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="check_relist" namespace="/check" />');" />
            </div>
		</div>
		</div>
	</s:form>
</div>
</div>
<div class="hidden_area">
	<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />

</body>
</html>