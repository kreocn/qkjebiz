<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>资产物品列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
<div class="main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/adm" action="assetItem_load"><s:param name="viewFlag">add</s:param></s:url>" >添加资产物品</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="assetItem_list"  method="get" namespace="/adm" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">编号:</div>
				       <div class="label_rwben">${assetItem.uuid}<s:hidden name="assetItem.uuid" title="编号" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">所属资产:</div>
				       <div class="label_rwben">${assetItem.asset_id}<s:hidden name="assetItem.asset_id" title="所属资产" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">型号:</div>
				       <div class="label_rwben"><s:textfield name="assetItem.model" title="型号" cssClass="validate[maxSize[96]]"/></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">规格:</div>
			       <div class="label_rwben"><s:textfield name="assetItem.spec" title="规格" cssClass="validate[maxSize[96]]"/></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">所属人:</div>
			       <div class="label_rwben"><s:textfield name="assetItem.own_user" title="所属人" cssClass="validate[maxSize[32]]"/></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">执行时间:</div>
			       <div class="label_rwben"><input  class="datepicker validate[custom[date]]" type="text" name="assetItem.op_time" title="执行时间" value="${it:formatDate(assetItem.op_time,'yyyy-MM-dd')}" /></div>
				</div>
				<div class="label_hang">
			       <div class="label_ltit">修改人:</div>
			       <div class="label_rwben">${assetItem.lm_user}</div>
				</div>
				<div class="label_hang label_button tac">
		        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
					<label for="search_mcondition"></label>更多条件
		            <s:submit value="搜索" /> <s:reset value="重置" />
		        </div>
			</div>
		</div>
	</s:form>
	<div class="tab_warp">
	 		<table id="table1">
	 			<tr id="coltr">
	              <th  class="td1">编号</th>
	              <th  class="td2">型号</th>
	              <th  class="td3">规格</th>
	              <th  class="td1">所在位置</th>
	              <th  class="td2">是否已领用</th>
	              <th  class="td3">所属人</th>
	              <th  class="td4">领用时间</th>
	              <th  class="td4">执行人</th>
	              <th  class="td4">执行时间</th>
	              <th  class="td5">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="assetItems" status="sta">
	            	<tr id="showtr${uuid}">
	            		<td  class="td1">${uuid}</td>
	            		<td  class="td2">${model}</td>
	            		<td  class="td3">${spec}</td>
	            		<td  class="td1">${position}</td>
	            		<td  class="td2"><s:if test="0==is_use">未领用</s:if><s:if test="1==is_use">已领用</s:if></td>
	            		<td  class="td3">${own_user_name}</td>
	            		<td  class="td4">${it:formatDate(user_time,'yyyy-MM-dd HH:mm:ss')}</td>
	            		<td  class="td4">${op_user_name}</td>
	            		<td  class="td4">${it:formatDate(op_time,'yyyy-MM-dd HH:mm:ss')}</td>
	            		<td  class="td5 op-area">
	            			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_MDY')">
					    	<a class="input-blue" href="<s:url namespace="/adm" action="assetItem_load"><s:param name="viewFlag">mdy</s:param><s:param name="assetItem.uuid" value="uuid"></s:param></s:url>">修改</a>
					    	</s:if>
					    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_ADM_ASSETITEM_DEL')">
					    	<a class="input-red"  href="<s:url namespace="/adm" action="assetItem_del"><s:param name="assetItem.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
					    	</s:if>	 
	            		</td>
	            		<td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	            	</tr>
	            </s:iterator>
	         </table>
	   </div>
	   <div class="pagination">
			<script type="text/javascript">
			var spage = new ShowPage(${currPage});
			spage.show2(${recCount},${pageSize},2);
			</script>
		</div>
</div>
</body>
</html>