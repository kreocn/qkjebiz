<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}<span class="opb lb op-area">
		<a href="<s:url action="outStock_list" namespace="/outStock" />">出库列表</a>
		</span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="outStock_add" namespace="/outStock" method="post" theme="simple">
	<div class="label_con">
		<div class="label_main">
	        	<div class="label_hang">
		            <div class="label_ltit">单据号:</div>
		            <div class="label_rwb"><s:textfield name="outStock.ordernum" title="单据号"  rows="4"></s:textfield></div>
	       		</div>
	     </div>
	     
	     <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">出库时间:</div>
	            	<span class="label_rwb nw">
					<input class="datepicker validate[required,custom[date]]" type="text"  name="outStock.date" title="从" value="${it:formatDate(outStock.date,'yyyy-MM-dd')}" />
					</span>
	        </div>
	     </div>
	     <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">出库仓库:</div>
	            <div class="label_rwben2">
			       <span class="label_rwb">
			       <select id="membermanagerid" cssClass="selectKick" name="outStock.store_id"
								title="出库仓库">
									<s:iterator value="wares" status="sta" var="x">
										<option value="<s:property value="uuid" />"/>
										<s:property value="ware_name" />
									</s:iterator>
					</select>
	            	</span>
	            </div>
	        </div>
        </div>
        
        <div class="label_main">
	        <div class="label_hang">
	            <div class="label_ltit">状态:</div>
	            <div class="label_rwben2">
			       <span class="label_rwb">
			       <select cssClass="selectKick" id="out" name="outStock.reason" title="状态" onchange="borrow();">
									<option value="0">销售出库</option>
									<option value="3">报损</option>
									<option value="1">招待用酒</option>
									<option value="4">赠酒</option>
									<option value="5">其它</option>
					</select>
	            	</span>
	            </div>
	        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">其它说明:</div>
            <div class="label_rwbenx">
            	<s:textarea id="apply_check_note" name="outStock.note"
									title="其它说明" rows="4" cssClass="label_hang_linput validate[maxSize[128]]"></s:textarea>
            </div>
        </div>
        </div>
        
        <div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            <span id="message"><s:property value="message" /></span>
            <s:if test="null == outStock && 'new' == viewFlag">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_OUTSTOCK_ADD')">
					<s:submit id="add" name="add" value="下一步" action="outStock_add" cssClass="input-blue"/>
				</s:if>
			</s:if> 
			<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="outStock_list" namespace="/outStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
            </div>
		</div>
		</div>
		
	</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>