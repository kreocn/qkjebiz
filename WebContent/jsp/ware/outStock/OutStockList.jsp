<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>

<body>
<div class="main">
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
			<span class="opb lb op-area">
			<a href="<s:url namespace="/outStock" action="outStock_load"><s:param name="viewFlag">new</s:param></s:url>" >添加出库单</a>
			</span>
		</s:if>
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="outStock_list"  method="get" namespace="/outStock"  theme="simple">
		<div class="label_con">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">编号:</div>
            <div class="label_rwben"><s:textfield name="outStock.uuid" title="编号" /></div>
       		</div>
        	<div class="label_hang">
            <div class="label_ltit">单据号:</div>
            <div class="label_rwben"><s:textfield name="outStock.ordernum" title="单据号" /></div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">出库时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="datepicker iI iI-f" type="text" name="outStock.date_start" title="从" value="${it:formatDate(outStock.date_start,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="datepicker iI iI-t" type="text" name="outStock.date_end" title="到" value="${it:formatDate(outStock.date_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">出库仓库:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="outStock.store_id" title="出库仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">单据性质:</div>
            <div class="label_rwben label_rwb">
            	<select id="membermanagerid" cssClass="selectKick" name="outStock.reason" title="状态">
							<option value="-1">---请选择---</option>
							<option value="0"
							<s:if test="%{outStock.reason==0}">
							 selected="selected"
							</s:if>
							>销售出库</option>
							<option value="1"
							 <s:if test="%{outStock.reason==1}">
							 selected="selected"
							</s:if>
							>招待用酒</option>
							
							<option value="3" 
							<s:if test="%{outStock.reason==3 }">
							selected="selected"
							</s:if>
							>报损</option>
							<option value="4" 
							<s:if test="%{outStock.reason==4 }">
							selected="selected"
							</s:if>
							>赠酒</option>
							<option value="5" 
							<s:if test="%{outStock.reason==5 }">
							selected="selected"
							</s:if>
							>其它</option>
				</select>
            </div>
        	</div>
        	<div class="label_hang">
            <div class="label_ltit">状态:</div>
            <div class="label_rwben label_rwb">
            	<select id="membermanagerid" cssClass="selectKick" name="outStock.send" title="状态">
					<option value="-1">---请选择---</option>
					<option value="-2">正常订单</option>
					<option value="5">取消订单</option>
				</select>
            </div>
        	</div>
        	
        	<div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        	</div>
        
		</div>
		</div>
	</s:form>
	
	<!-- 列表 -->
	<div class="tab_warp">
 		<table>
 		<tr id="coltr">
		<th class="td1">编号</th>
		<th class="td3">经办人</th>
		<th class="td2">单号</th>
		<th class="td1">出库仓库</th>
		<th class="td3">状态</th>
		<th class="td1">单据性质</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="outStocks" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw"><s:property value="uuid" /></td>
				<td class="td3 nw"><s:property value="manager_check_user_name" /></td>
				<td class="td2 nw"><s:property value="ordernum" /></td>
				<td class="td1 nw"><s:property value="ware_name" /></td>
				<td class="td3 nw"><s:if test='0==send'>借出未还</s:if>
						<s:if test='1==send'>借出已还</s:if>
						<s:if test='2==send'>新单</s:if>
						<s:if test='3==send'>待审核</s:if>
						<s:if test='4==send'>结案<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
						<s:if test='5==send'>已取消订单</s:if>
				</td>
				<td class="td1 nw">
					<s:if test="%{reason==0}">销售出库
					</s:if>
					 <s:if test="%{reason==1}">招待用酒
					</s:if>
					
					<s:if test="%{reason==3 }">报损
					</s:if>
					<s:if test="%{reason==4 }">赠酒
					</s:if>
					<s:if test="%{reason==5 }">其它
					</s:if>
				</td>
				<td class="td4 op-area">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_MDY') && @com.qkj.ware.action.warepower@checkPermit(store_id,'del')">
			    	<a class="input-blue" href="<s:url namespace="/outStock" action="outStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="outStock.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:if>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_DEL') && @com.qkj.ware.action.warepower@checkPermit(store_id,'del') && (send!=4 && send!=5)">
			    	<a class="input-red" href="<s:url namespace="/outStock" action="outStock_del"><s:param name="outStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>	 
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_PRINT')  && (send==4 || send==5) ">
			    	<a class="input-gray" href="<s:url namespace="/outStock" action="outStock_view"><s:param name="viewFlag">view</s:param><s:param name="outStock.uuid" value="uuid"></s:param></s:url>">打印</a>
			    	</s:if>	  
		    	</td>
		    	<td class="td0 op-area"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
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
	
	<div class="hidden_area">
	<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
	</div>
</div>
</body>
</html>