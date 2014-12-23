<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户回访记录列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
<div class="main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_PRODUCT_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="customerRecode_load"><s:param name="viewFlag">add</s:param></s:url>" >添加客户回访记录</a></span>
		</s:if>
	</div>
	<s:form name="form_serach" action="customerRecode_list"  method="get" namespace="/qkjmanage" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">回访客户名称:</div>
				       <div class="label_rwben"><s:textfield name="customerRecode.cus_name" title="回访客户名称"/></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">回访客户ID:</div>
				       <div class="label_rwben"><s:textfield name="customerRecode.customer_id" title="回访客户编号"  /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">回访方式:</div>
				       <div class="label_rwben">
				       			<s:select name="customerRecode.type" title="回访方式" headerKey="" headerValue="--请选择--" list="#{0:'主动电话拜访',1:'被动电话来访',2:'主动上门拜访',3:'被动上门来访',4:'会展会场来访',5:'网络、邮件、信息形式来访',6:'其他方式'}" />
				       </div>
				</div>
				<div class="label_hang">
		            	<div class="label_ltit">拜访日期:</div>
		            	<div class="label_rwben"><input type="text" name="customerRecode_recode_time" class="datepicker" value="${it:formatDate(leave.serach_date,'yyyy-MM-dd')}" /></div>
		        </div>
		        <div class="label_hang">
		            	<div class="label_ltit">下次拜访时间:</div>
		            	<div class="label_rwben"><input type="text" name="customerRecode_next_date" class="datepicker" value="${it:formatDate(leave.serach_date,'yyyy-MM-dd')}" /></div>
		        </div>
		        <div class="label_hang">
		        		<div class="label_ltit">拜访部门:</div>
		        		<div class="label_rwben2">
			            	<span class="label_rwb">
							<s:textfield title="部门名称" id="userdept_nameid" name="active.apply_dept_name" readonly="true" />
							<s:hidden title="部门代码" id="userdept_codeid" name="active.apply_dept" readonly="true" />
							</span>
							<span class="lb nw">
							<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" />
							<s:checkbox id="apply_is_sub_dept" name="active.is_sub_dept" cssClass="regular-checkbox" />
							<label for="apply_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
							</span>
			            </div>
		        </div>
		        <div class="label_hang">
		            <div class="label_ltit">拜访人员:</div>
		            <div class="label_rwben label_rwb">
		            	<s:select id="membermanagerid" cssClass="selectKick" name="active.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
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
</div>
</body>
</html>