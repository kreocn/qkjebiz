<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
 <div class="main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="travel_list"><s:param name="viewFlag">relist</s:param></s:url>">工业旅游申请列表</a></span>
	</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="travel_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
 				<s:if test="'mdy' == viewFlag">
					<div class="label_hang">
					       <div class="label_ltit">申请单编号:</div>
					       <div class="label_rwben">${travel.uuid}<s:hidden name="travel.uuid" /><s:hidden name="travel.check_status" /><s:hidden name="travel.acheck_status" /></div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">业务审核状态:</div>
					       <div class="label_rwbenx">
					       		<s:if test="travel.check_status==0">新申请</s:if>
			                    <s:if test="travel.check_status==5"><span class="message_error">已退回</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
			                    <s:if test="travel.check_status==10"><span class="message_warning">待审核</span></s:if>
			                    <s:if test="travel.check_status==20"><span class="message_pass">经理/大区已审</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
			                    <s:if test="travel.check_status==30"><span class="message_pass">总监已审</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd')})</span></s:if>
			                    <s:if test="travel.check_status==40"><span class="message_pass">业务副总已审</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd')})</span></s:if>
					       </div>
					</div>
					<div class="label_hang">
					       <div class="label_ltit">行政审核状态:</div>
					       <div class="label_rwbenx">
					       		<s:if test="travel.acheck_status==0">新申请</s:if>
			                 	<s:if test="travel.acheck_status==5"><span class="message_error">已退回</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
			                    <s:if test="travel.acheck_status==10"><span class="message_warning">待审核</span></s:if>
			                    <s:if test="travel.acheck_status==20"><span class="message_pass">行政经理已审</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
			                    <s:if test="travel.acheck_status==30"><span class="message_pass">行政副总已审</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
			                    <s:if test="travel.acheck_status==40"><span class="message_pass">总经理已审</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
					       </div>
					</div>
				</s:if>
				<div class="label_hang">
				    <div class="label_ltit">申请部门/人:</div>
				    <div class="label_rwbenx">${travel.apply_dept_name}&nbsp;${travel.apply_user_name}<s:hidden name="travel.apply_dept" /><s:hidden name="travel.apply_user" /></div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">申请项目:</div>
				    <div class="label_rwbenx"><s:checkboxlist  name="travel.apply_items" list="#{'ITEM01':'厂区工艺流程','ITEM02':'新厂区','ITEM03':'高尔夫练习场打球体验','ITEM04':'参观中华土族园','ITEM99':'其他' }" /></div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">执行日期:</div>
				    <div class="label_rwben2">
				    	<span class="label_rwb nw">
						<input  class="datepicker iI iI-f validate[required,custom[date]]" type="text" name="travel.travel_date" title="从" value="${it:formatDate(travel.travel_date,'yyyy-MM-dd')}" />
						</span>
						<span class="label_rwb nw">
						<input  class="datepicker iI iI-t validate[required,custom[date]]" type="text" name="travel.travel_date_end" title="到" value="${it:formatDate(travel.travel_date_end,'yyyy-MM-dd')}" />
		            	</span>
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">客户人数:</div>
				    <div class="label_rwben"><s:textfield name="travel.travel_num" title="客户人数" style="width:80%;" cssClass="validate[required,custom[integer],maxSize[10]]" /> 人</div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">陪同:</div>
				    <div class="label_rwben"><s:textfield name="travel.accompany_num" title="陪同人数" style="width:80%;" cssClass="validate[required,custom[integer],maxSize[10]]" /> 人</div>
				</div>
			</div>
			<div class="label_main">
				<div class="label_hang">
				    <div class="label_ltit">客户单位:</div>
				    <div class="label_rwbenx">
				    	<s:textfield id="travel_members_names" cssClass="label_hang_linput" name="travel.members_names" title="客户单位"/><br/>
                		<span class="message_prompt">单位名称之间请用半角逗号,或者空格隔开</span>
				    </div>
				</div>
			</div>
			<s:if test="'mdy' == viewFlag">
				<fieldset class="clear">
					<legend>客户详情/来访客户资料
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
			            	<input type="button" id="AddCustomer" value="添加客户资料" />
			            </s:if>
					</legend>
					<s:if test="travelCustomers==null || travelCustomers.size==0">
                        <div style="text-align: center;line-height: 30px;">暂无客户信息</div>
	                </s:if>
	                <s:else>
	                	<table id="table1" width="100%" class="lb_jpin">
			                  <tr>
			                    <th>资料编号</th>
			                    <th>客户姓名</th>
			                    <th>性别</th>
			                    <th>单位名称</th>
			                    <th>客户类别</th>
			                    <th>联系电话</th>
			                    <th>身份证号</th>
			                    <th>操作</th>
			                  </tr>
			                  <s:iterator value="travelCustomers" status="sta">
				                  <tr>
			                    	  <td>${uuid}</td>
				                      <td>${cus_name}</td>
				                      <td>
				                        <s:if test="cus_sex==0">男</s:if>
				                        <s:elseif test="cus_sex==1">女</s:elseif>
				                      </td>
				                      <td>${cus_company}</td>
				                      <td>
				                        <s:if test="cus_type==1">政府</s:if>
				                        <s:elseif test="cus_type==2">企业</s:elseif>
				                        <s:elseif test="cus_type==3">经销商</s:elseif>
				                        <s:elseif test="cus_type==4">潜在客户</s:elseif>
				                        <s:elseif test="cus_type==5">终端零售</s:elseif>
				                        <s:elseif test="cus_type==6">专卖店消费者</s:elseif>
				                        <s:elseif test="cus_type==7">其他</s:elseif>
				                      </td>
				                      <td>${cus_phone}</td>
				                      <td>${cus_idcard}</td>
					                  <td align="center">
					                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_DEL') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
					                      [<a href="<s:url namespace="/qkjmanage" action="travelCustomer_del"><s:param name="travelCustomer.uuid" value="uuid" /><s:param name="travelCustomer.travel_id" value="travel_id" /></s:url>" onclick="return isDel();">删除</a>]
					                      </s:if>    
					                  </td>
				                  </tr>
				              </s:iterator>
                  		</table>
	                </s:else>
				</fieldset>				
				<div style="height:10px;"></div>
			</s:if>
			<fieldset class="clear">
				<legend>接待标准</legend>
				<div class="label_hang">
				    <div class="label_ltit">午餐用餐标准:</div>
				    <div class="label_rwben2">
				    	￥<s:textfield name="travel.lunch_price" style="width:80px;" title="午餐标准/桌" cssClass="validate[custom[number],maxSize[10]]"/> 元/桌
		                      共<s:textfield name="travel.lunch_num"  style="width:40px;" title="午餐次数" cssClass="validate[custom[integer],maxSize[10]]" /> 次
		                      每次<s:textfield name="travel.lunch_desk"  style="width:40px;" title="午餐桌数" cssClass="validate[custom[integer],maxSize[10]]" /> 桌
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">是否使用香烟:</div>
				    <div class="label_rwbenx">
				    	<s:radio name="travel.cigarette" list="#{0:'否',1:'是' }" />
                		<s:textfield name="travel.cigarette_num" title="准备香烟包数" style="width:40px;" cssClass="validate[custom[integer],maxSize[10]]" /> 包
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">晚餐用餐标准:</div>
				    <div class="label_rwbenx">
				    	￥<s:textfield name="travel.dinner_price" style="width:80px;" title="晚餐标准/桌" cssClass="validate[custom[number],maxSize[10]]"/> 元/桌
		                      共<s:textfield name="travel.dinner_num"  style="width:40px;" title="晚餐次数" cssClass="validate[custom[integer],maxSize[10]]" /> 次
		                      每次<s:textfield name="travel.dinner_desk"  style="width:40px;" title="晚餐桌数" cssClass="validate[custom[integer],maxSize[10]]" /> 桌
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">是否使用香烟:</div>
				    <div class="label_rwbenx">
						<s:radio name="travel.fruit" list="#{0:'否',1:'是' }" />
				    </div>
				</div>
				<s:if test="'mdy' == viewFlag">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">餐酒标准:</div>
							<div class="label_rwbenx">
								
							</div>
						</div>
					</div>
				</s:if>
			</fieldset>
		</div>
	</s:form>					
</div>
</body>
</html>