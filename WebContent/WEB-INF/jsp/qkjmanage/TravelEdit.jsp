<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.lb_jiup th,.lb_jiup td{border:1px solid #ccc; text-align:center; line-height:22px; font-size:12px;}
.lb_jiup th{background: #f1f1f1;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
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
						<input  class="datepicker iI iI-f validate[custom[date]]" type="text" name="travel.travel_date" title="从" value="${it:formatDate(travel.travel_date,'yyyy-MM-dd')}" />
						</span>
						<span class="label_rwb nw">
						<input  class="datepicker iI iI-t validate[custom[date]]" type="text" name="travel.travel_date_end" title="到" value="${it:formatDate(travel.travel_date_end,'yyyy-MM-dd')}" />
		            	</span>
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">客户人数:</div>
				    <div class="label_rwben"><s:textfield name="travel.travel_num" title="客户人数" style="width:80%;" cssClass="validate[custom[integer],maxSize[10]]" /> 人</div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">陪同:</div>
				    <div class="label_rwben"><s:textfield name="travel.accompany_num" title="陪同人数" style="width:80%;" cssClass="validate[custom[integer],maxSize[10]]" /> 人</div>
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
				    <div class="label_ltit">是否使用水果:</div>
				    <div class="label_rwbenx">
						<s:radio name="travel.fruit" list="#{0:'否',1:'是' }" />
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">是否安排住宿:</div>
				    <div class="label_rwbenx">
						<s:radio name="travel.hotel" list="#{0:'否',1:'是' }" />
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">别墅规格:</div>
				    <div class="label_rwbenx">
						<s:textfield name="travel.hotel_house"  style="width:40px;" title="别墅规格(几人一套)" cssClass="validate[custom[integer],maxSize[10]]" /> 人间
		                <s:textfield name="travel.hotel_house_num"  style="width:40px;" title="别墅套数" cssClass="validate[custom[integer],maxSize[10]]" /> 套
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">住宿时间:</div>
				    <div class="label_rwbenx">
						<input style="width:90px;" class="datepicker validate[custom[date]]" type="text" name="travel.hotel_start" title="开始住宿时间" value="${it:formatDate(travel.hotel_start,'yyyy-MM-dd')}" />
						&nbsp;-&nbsp;
						<input style="width:90px;" class="datepicker validate[custom[date]]" type="text" name="travel.hotel_end" title="结束住宿时间" value="${it:formatDate(travel.hotel_end,'yyyy-MM-dd')}" />
						共 <s:textfield name="travel.hotel_total" style="width:40px;"  title="总共住宿天数" cssClass="validate[custom[integer],maxSize[10]]" /> 天
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">标间:</div>
				    <div class="label_rwbenx">
						<s:textfield name="travel.hotel_twinroom"  style="width:40px;" title="标间间数" cssClass="validate[custom[integer],maxSize[10]]" /> 间
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">车辆派送:</div>
				    <div class="label_rwbenx">
						<s:checkboxlist name="travel.cars" list="#{'大巴':'大巴','中巴':'中巴','商务':'商务','轿车':'轿车'}" />&nbsp;&nbsp;&nbsp;
				    </div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">是否联系旅行社:</div>
				    <div class="label_rwbenx">
						&nbsp;&nbsp;<s:radio name="travel.travel_agency" list="#{0:'否',1:'是' }" />
				    </div>
				</div>
				<s:if test="'mdy' == viewFlag">
					<div class="label_hang clear">
						<div class="label_ltit">餐酒标准:<br />
               			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELPRODUCT_ADD') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
               			<input type="button" id="AddProduct" value="添加酒品" /></s:if></div>
						<div class="label_rwbenx">
							<s:if test="travelProducts==null || travelProducts.size==0">
			                    <div style="line-height: 30px;">暂无酒品信息</div>
			                </s:if>
			                <s:else>
			                	<table class="lb_jiup" width="300" id="table1">
					                  <tr>
					                    <th>产品名称</th>
					                    <th>数量(瓶|公斤)</th>
					                    <th>操作</th>
					                  </tr>
					                  <s:iterator value="travelProducts" status="sta">
					                    <tr>
					                      <td>${product_name}</td>
					                      <td>${num}</td>
					                      <td>
						                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELPRODUCT_DEL') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
						                      [<a href="<s:url namespace="/qkjmanage" action="travelProduct_del"><s:param name="travelProduct.uuid" value="uuid" /><s:param name="travelProduct.travel_id" value="travel_id" /></s:url>" onclick="return isDel();">删除</a>]
						                      </s:if>
						                    </td>
					                    </tr>
					                  </s:iterator>
				                  </table>
				                  <span class="message_prompt">散酒的单位是:公斤 | 瓶装酒单位是:瓶</span>
			                </s:else>
						</div>
					</div>
				</s:if>
			</fieldset>
			<div class="label_hang clear">
			    <div class="label_ltit">具体行程安排:</div>
			    <div class="label_rwbenx">&nbsp;<span class="message_prompt">请尽量不要超过8行</span></div>
			</div>
			<div class="label_main">
				<div class="note_area">
					<s:if test="travel.check_status<=5 ||  travel.acheck_status<=5">
						<s:textarea name="travel.trip" title="具体行程安排" cssClass="xheditorArea validate[maxSize[65535]]" />
					</s:if>
					<s:else>${travel.trip}</s:else>					
					<div class="clear"></div>
	        	</div>
			</div>
			<fieldset class="clear">
				<legend>礼品标准</legend>
				<div class="label_hang">
				    <div class="label_ltit">礼品品相:</div>
				    <div class="label_rwben"><s:textfield name="travel.gift" title="礼品品相" cssClass="validate[maxSize[108]]" /></div>
				</div>
				<div class="label_hang">
				    <div class="label_ltit">礼品份数:</div>
				    <div class="label_rwben"><s:textfield name="travel.gift_num" title="礼品份数" cssClass="validate[custom[integer],maxSize[10]]" /></div>
				</div>
			</fieldset>
			<div style="height:5px;"></div>
			<div class="label_main">
				<div class="label_hang">
				    <div class="label_ltit">其他情况说明:</div>
				    <div class="label_rwbenx">
				    	<s:if test="travel.check_status<=5 ||  travel.acheck_status<=5">
		                <s:textarea name="travel.note" title="其他情况说明" cssClass="label_hang_linput inputNote validate[maxSize[65535]]" />
		                </s:if>
		                <s:else>${travel.note}</s:else>
				   	</div>
				</div>
			</div>
			<div class="label_main">
				<div class="label_hang">
				    <div class="label_ltit">相关操作:</div>
				    <div class="label_rwbenx">
				    	<s:if test="'add' == viewFlag">
		                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ADD')">
		                    <s:submit id="add" cssClass="input-blue"  name="add" value="下一步-添加客户信息和招待酒品信息" action="travel_add" />
		                  </s:if>
		                </s:if>
		                <s:elseif test="'mdy' == viewFlag">
		                <s:if test="travel.check_status<=5 ||  travel.acheck_status<=5">
		                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_MDY')">
		                    <s:submit id="save" name="save" cssClass="input-blue"  value="保存" action="travel_save" />
		                  </s:if>
		                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK')">
		                    <s:submit id="travel_mdyCheck" cssClass="input-yellow" name="travel_mdyCheck" value="报审" action="travel_mdyCheck" onclick="return isOp('确定要执行此操作?');" />
		                  </s:if>
		                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_DEL')">
		                    <s:submit id="delete" name="delete" cssClass="input-red" value="删除" action="travel_del" onclick="return isDel();" />
		                  </s:if>
		                </s:if>
		                <s:else>
		                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK10') && travel.check_status==10">
		                    <s:submit id="travel_mdyCheckStatus10" cssClass="input-green"  name="travel_mdyCheckStatus10" value="经理/大区审核通过" action="travel_mdyCheckStatus10" onclick="return isOp('确定要执行此操作?');" />
		                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
		                    <s:submit id="travel_mdyCheckStatus5" cssClass="input-red" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" onclick="return isOp('确定要执行此操作?');" />
		                    </s:if>
		                  </s:if>
		                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK20') && travel.check_status==20">
		                    <s:submit id="travel_mdyCheckStatus20" cssClass="input-green"  name="travel_mdyCheckStatus20" value="总监审核通过" action="travel_mdyCheckStatus20" onclick="return isOp('确定要执行此操作?');" />
		                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
		                    <s:submit id="travel_mdyCheckStatus5" cssClass="input-red" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" onclick="return isOp('确定要执行此操作?');" />
		                    </s:if>
		                  </s:if>
		                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK30') && travel.check_status==30">
		                    <s:submit id="travel_mdyCheckStatus30" cssClass="input-green"  name="travel_mdyCheckStatus30" value="业务副总审核通过" action="travel_mdyCheckStatus30" onclick="return isOp('确定要执行此操作?');" />
		                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
		                    <s:submit id="travel_mdyCheckStatus5" cssClass="input-red" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" onclick="return isOp('确定要执行此操作?');" />
		                    </s:if>
		                  </s:if>
		                  <s:if test="travel.check_status>=30">
		                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK10') && travel.acheck_status==10">
		                      <s:submit id="travel_mdyACheckStatus10" cssClass="input-green" name="travel_mdyACheckStatus10" value="行政经理审核通过" action="travel_mdyACheckStatus10" onclick="return isOp('确定要执行此操作?');" />
		                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
		                      <s:submit id="travel_mdyACheckStatus5" cssClass="input-red" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" onclick="return isOp('确定要执行此操作?');" />
		                      </s:if>
		                    </s:if>
		                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK20') && travel.acheck_status==20">
		                      <s:submit id="travel_mdyACheckStatus20" cssClass="input-green"  name="travel_mdyACheckStatus20" value="行政副总审核通过" action="travel_mdyACheckStatus20" onclick="return isOp('确定要执行此操作?');" />
		                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
		                      <s:submit id="travel_mdyACheckStatus5" cssClass="input-red" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" onclick="return isOp('确定要执行此操作?');" />
		                      </s:if>
		                    </s:if>
		                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK30') && travel.acheck_status==30">
		                      <s:submit id="travel_mdyACheckStatus30" cssClass="input-green"  name="travel_mdyACheckStatus30" value="总经理审核通过" action="travel_mdyACheckStatus30" onclick="return isOp('确定要执行此操作?');" />
		                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
		                      <s:submit id="travel_mdyACheckStatus5" cssClass="input-red" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" onclick="return isOp('确定要执行此操作?');" />
		                      </s:if>
		                    </s:if>
		                  </s:if>
		                </s:else>
		              </s:elseif> 
		                <input type="button" class="input-gray" value="返回" onclick="location.href='<s:url action="travel_relist" namespace="/qkjmanage" />';" />
		                <span id="message"><s:property value="message" /></span> 
					</div>
				</div>
			</div>
		</div>
	</s:form>					
</div>
</div>
<s:if test="'mdy' == viewFlag">
  <div id="AddCustomerForm" title="添加客户资料">
	  <s:form name="form1" cssClass="validForm" action="travelCustomer_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	  <input type="hidden" name="travelCustomer.travel_id" value="${travel.uuid }" />
	  <table width="100%" class="ilisttable">
	      <tr>
		      <td align="right" width="25%">客户姓名:</td>
		      <td width="75%"><s:textfield name="travelCustomer.cus_name" title="客户姓名" cssClass="validate[required,maxSize[32]]"/></td>
	      </tr> 
	      <tr>
		      <td align="right">性别:</td>
		      <td><s:radio name="travelCustomer.cus_sex" list="#{0:'男',1:'女'}" /></td>
	      </tr>
	      <tr>
		      <td align="right"valign="top" style="line-height:26px;">单位名称:</td>
		      <td>
		        <s:textfield id="travelCustomer_cus_company" name="travelCustomer.cus_company" title="单位名称" cssClass="validate[maxSize[255]]"/>
		        <br/><select id="cus_select"><option>--请选择--</option></select>
		      </td>
	      </tr>
	      <tr>
		      <td align="right">客户类别:</td>
		      <td>
		        <s:select name="travelCustomer.cus_type" title="客户类别" list="#{1:'政府',2:'企业',3:'经销商',4:'潜在客户',5:'终端零售',6:'专卖店消费者',7:'其他'}" />
		      </td>
	      </tr>
	      <tr>
		      <td align="right">联系电话:</td>
		      <td><s:textfield name="travelCustomer.cus_phone" title="联系电话" cssClass="validate[custom[integer],maxSize[55]]"/></td>
	      </tr>
	      <tr>
		      <td align="right">身份证号:</td>
		      <td><s:textfield name="travelCustomer.cus_idcard" title="身份证号" cssClass="validate[custom[integer],maxSize[32]]" /></td>
	      </tr>
	      <tr>
		      <td align="right">备注:</td>
		      <td><s:textfield name="travelCustomer.note" title="备注" cssClass="validate[maxSize[255]]" /></td>
	      </tr>
	   	  <tr>
	   	  		<td>&nbsp;</td>
				<td class="buttonarea">
				  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
				  <s:submit id="add" name="add" value="确定" action="travelCustomer_add" />
				  </s:if>
				</td>
	      </tr>
	  </table>  
	</s:form>
  </div>
  <div id="AddProductForm" title="添加酒品">
    <s:form name="form1" cssClass="validForm" action="travelProduct_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
      <div class="ifromoperate"><input type="hidden" name="travelProduct.travel_id"  value="${travel.uuid }" /></div>
      <table class="ilisttable" width="100%">
        <tr>
          <td align="right" width="25%">产品:</td>
          <td>
            <s:select name="travelProduct.product_id" list="products" listKey="uuid" listValue="title" cssClass="validate[required]"  headerKey="" headerValue="--请选择--"  />
          </td>
        </tr>
        <tr>
          <td align="right" valign="top" style="line-height:26px;">数量:</td>
          <td>
            <s:textfield name="travelProduct.num" title="数量" cssClass="validate[required,custom[integer],maxSize[10]]"/>
            <br/><span class="message_prompt">散酒(公斤) | 瓶装酒(瓶)</span>
         </td>
        </tr>
        <tr>
        	<td>&nbsp;</td>
            <td class="buttonarea">
              <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELPRODUCT_ADD')">
                <s:submit id="add" name="add" value="确定" action="travelProduct_add" />
              </s:if>
           </td>
        </tr>
      </table>
    </s:form>
  </div>
</s:if>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
var infoeditor01;
var mns = '${travel.members_names}';
$(function(){
  if($("#travel_trip").length>0) {
    infoeditor01 = new widget_textarea();
    infoeditor01.init("travel_trip");
  }
  $('#travel_hotel_start').datepicker();
  $('#travel_hotel_end').datepicker();
  $('#travel_travel_date').datepicker();
  $('#travel_travel_date_end').datepicker();
  //<s:if test="'mdy' == viewFlag">
  $("#AddCustomerForm").dialog({
      autoOpen: false,
      height: 330,
      width: 420,
      modal: true
  });
  $("#AddCustomer").click(function(){
	  if(mns!=null || mns!='') {
		  $("#cus_select").clearAllOption();
		  $("#cus_select").addOption("--请选择--","");
		  var ts = mns.replace(/\s+/g," ").split(/[,| ]/);
		  for(i=0;i<ts.length;i++) {
			  $("#cus_select").addOption(ts[i],ts[i]);
		  }
	  }
	  $("#AddCustomerForm").dialog("open");
  });
  $("#cus_select").change(function(){
	  $("#travelCustomer_cus_company").val($(this).val());
  });
  $("#AddProductForm").dialog({
      autoOpen: false,
      height: 190,
      width: 420,
      modal: true
  });
  $("#AddProduct").click(function(){
	  $("#AddProductForm").dialog("open");
  });
  //</s:if>
});
</script>
</body>
</html>