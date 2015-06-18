<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/v0.1/area.js" />"></script>
<style type="text/css">
.w5{float:left; width:5px; height:20px;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
<div class="dq_step">
	${path}
	<span class="opb lb op-area"><a href="<s:url action="member_list" namespace="/sysvip"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span>
</div>
<s:form id="editForm" name="editForm" cssClass="validForm" namespace="/sysvip" method="post" theme="simple">
<div class="label_con">
	<s:if test="'mdy' == viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">会员号:</div>
		<div class="label_rwben">${member.uuid}<s:hidden id="puid" name="member.uuid" title="会员号" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">登录密码:</div>
		<div class="label_rwben label_rwb"><s:password id="passwords" name="member.passwords" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">再次输入:</div>
		<div class="label_rwben label_rwb"><s:password id="passwords2" name="passwords2" cssClass="validate[equals[passwords]]" /></div>
	</div>
	</div>
	</s:if>
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">会员手机:</div>
		<div class="label_rwben2">
			<span class="label_rwb label_rwbx"><s:textfield id="memMobile" name="member.mobile" title="会员手机" cssClass="validate[required,custom[mobile]]" /></span>
			<span class="label_rwb nw"><s:radio name="member.is_mobile_check" title="手机验证"  list="#{0:'未验证',1:'已验证'}"  cssClass="regular-radio" /></span>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员名称:</div>
		<div class="label_rwben label_rwb"><s:textfield id="member_name" name="member.member_name" cssClass="validate[required,maxSize[85]]" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">联系人姓名:</div>
		<div class="label_rwben label_rwb"><span class="message_prompt">企业联系人</span><s:textfield name="member.contact" title="联系人" cssClass="inputNote" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员分组:</div>
		<div class="label_rwben">
			<div class="label_rwb"><s:select name="member.user_type" title="会员级别"  list="roles" listKey="uuid" listValue="role_name" /></div></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">会员EMAIL:</div>
		<div class="label_rwben2">
			<span class="label_rwb label_rwbx"><s:textfield name="member.email" cssClass="validate[maxSize[85]]" /></span>
			<span class="label_rwb nw"><s:radio name="member.is_email_check" title="EMAIL验证"  list="#{0:'未验证',1:'已验证'}"  cssClass="regular-radio" /></span>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">登录别名:</div>
		<div class="label_rwben label_rwb"><s:textfield name="member.title" cssClass="validate[maxSize[85]]" /></div>
	</div>
	<s:if test="'mdy'==viewFlag">
	<div class="label_hang">
		<div class="label_ltit">所属办事处:</div>
		<div class="label_rwben">${member.dept_name}</div>
	</div>
	<div class="label_hang">
	<div class="label_ltit">所属人:</div>
	<div class="label_rwben">${member.manager_name}</div>
	</div>
	</s:if>
	<s:if test="'add'==viewFlag">
	<div class="label_hang">
		<div class="label_ltit">所属办事处:</div>
		<div class="label_rwben nw">
			<div class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="member.dept_name" readonly="true" /></div>
				<s:hidden id="userdept_codeid" name="member.dept_code" />
			</div>
			<img class="imglink vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true,null,1);" />
	</div>
	<div class="label_hang">
	<div class="label_ltit">所属人:</div>
	<div class="label_rwben">
		<div class="label_rwb">
			<s:select id="membermanagerid" name="member.manager" list="#{}"	headerKey="" headerValue="--请选择--" />
		</div>
	</div>
	</div>
	<div class="label_hang">
	<div class="label_ltit">潜在客户:</div>
	<div class="label_rwben">
		<div class="label_rwb">
		<s:radio onclick="qianzai(this);"  name="member.is_customers" title="是否是潜在客户"  list="#{0:'否',1:'是'}" value="0" cssClass="regular-radio" />
		</div>
	</div>
	</div>
	</s:if>
	</div>

	<s:if test="'mdy'==viewFlag">
	<div class="label_main">
	<div class="label_hang">
		<div class="label_ltit">潜在客户:</div>
		<div class="label_rwben label_rwb">
			<s:if test="1==member.is_customers">
			<s:radio onclick="qianzai(this);"  name="member.is_customers" title="是否是潜在客户"  list="#{0:'否',1:'是'}" value="1" cssClass="regular-radio" />
			</s:if>
			<s:else><s:radio onclick="qianzai(this);"  name="member.is_customers" title="是否是潜在客户"  list="#{0:'否',1:'是'}" value="0" cssClass="regular-radio" /></s:else>
		</div>
	</div>
	<div class="是否是潜在客户">
		<div class="label_ltit">注册来源:</div>
		<div class="label_rwben label_rwb">
			<s:if test="0==member.reg_type">自行注册</s:if>
			<s:if test="1==member.reg_type">管理员添加</s:if>
			<s:if test="2==member.reg_type">批量导入</s:if>
		</div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">注册时间:</div>
		<div class="label_rwben" style="width:auto;"><s:date name="member.reg_time" format="yyyy-MM-dd HH:mm:ss" /></div>
	</div>
	<div class="label_hang">
		<div class="label_ltit">最后登录时间:</div>
		<div class="label_rwben" style="width:auto;"><s:date name="member.last_login_time" format="yyyy-MM-dd HH:mm:ss" /></div>
	</div>
	</div>
	</s:if>
	
	
	
<div id="tabs"  class="label_main">
  <ul>
    <li><a href="#tabs-1">收货地址</a></li>
    <li style="display: none;" id="qianzaikehu"><a href="#tabs-2"  >潜在客户</a></li>
    <s:if test="'mdy'==viewFlag">
    	<s:if test="1==member.is_customers">
        <li><a href="#tabs-2"  id="qianzaikehu1">潜在客户</a></li>
    </s:if>
    </s:if>
    <s:if test="'mdy'==viewFlag">
    <li><a href="#tabs-3">回访记录</a></li>
      </s:if>
        <s:if test="'mdy'==viewFlag">
        	 <c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE',null)==true}">
         <li><a href="#tabs-4">活动记录</a></li>
         </c:if>
         </s:if>
  </ul>
	 <div id="tabs-1">
    	<fieldset class="clear">
	<legend>收货地址</legend>
	<!--<span class="shaddress">--------------------收货地址--------------------</span>-->
	<s:if test="'add' == viewFlag">
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">所在地区:</div>
			<div class="label_rwbenx">
				<div class="label_rwb"><s:select id="memberAddress.province" name="memberAddress.province" title="省" list="#{}" cssClass="validate[required]" /></div>
				<div class="label_rwb"><s:select id="memberAddress.city" name="memberAddress.city" title="市" list="#{}" cssClass="validate[required]" data-prompt-position="inline" data-prompt-target="rm_x" /></div>
				<div class="label_rwb"><s:select id="memberAddress.area" name="memberAddress.area" title="县" list="#{}" /></div>
				<span id="rm_x" class="sva"></span>
			</div>
		</div>
	</div>
		<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">邮政编码:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.post" title="邮政编码" controlName="邮政编码" dataType="zipcode" /></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">街道地址:</div>
			<div class="label_rwbenx"><s:textarea name="memberAddress.street" cssClass="label_hang_linput" title="街道地址" controlName="街道地址" require="required" /></div>
		</div>
	</div>
	<div class="label_main">
		<div class="label_hang">
			<div class="label_ltit">收货人姓名:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.con_name" title="收货人姓名" controlName="收货人姓名" require="required" /></div>
		</div>
		<div class="label_hang">
			<div class="label_ltit">联系号码:</div>
			<div class="label_rwben label_rwb"><s:textfield name="memberAddress.mobile" title="联系号码" controlName="联系号码" require="required" /></div>
		</div>
		<div class="label_hang label_button tac">
			<a href="javascript:;" onclick="copyval();">复制会员姓名和手机</a>
		</div>
	</div>
	</s:if>
	<s:if test="'mdy'==viewFlag">
		 <div class="label_main">
		 	<!--
		 	<p class="lb_yjtit bn">
			<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">add</s:param><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" >添加收货地址</a>
		 	</p>
		 	-->
			<table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
			<tr>
				<th>所在地区</th>
				<th>邮编</th>
				<th>街道地址</th>
				<th>收货人姓名</th>
				<th>手机/联系电话</th>
				<th>默认地址</th>
				<th><a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">add</s:param><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" >添加收货地址</a></th>
			</tr>
			<s:iterator value="memberAddresses" status="sta">
			  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
				<td><s:property value="province" /> <s:property value="city" /> <s:property value="area" /></td>
				<td><s:property value="post" /></td>
				<td><s:property value="street" /></td>
				<td><s:property value="con_name" /></td>
				<td><s:property value="mobile" /></td>
				<td>
				<s:url id="setDefault" namespace="/sysvip" action="memberAddress_default">
					<s:param name="memberAddress.uuid" value="uuid" />
					<s:param name="memberAddress.member_id" value="member.uuid" />
					<s:param name="memberAddress.defaultaddress">1</s:param>
				</s:url>
				<s:if test="0==defaultaddress"><a href="${setDefault}"><span class="aI aI-e"></span></a></s:if>
				<s:if test="1==defaultaddress"><span class="aI aI-y"></span></s:if>
				</td>
				<td>
			    	[<a href="<s:url namespace="/sysvip" action="memberAddress_load"><s:param name="viewFlag">mdy</s:param><s:param name="memberAddress.uuid" value="uuid"></s:param></s:url>">修改</a>]
			    	[<a href="<s:url namespace="/sysvip" action="memberAddress_del"><s:param name="memberAddress.uuid" value="uuid" /><s:param name="memberAddress.member_id" value="member.uuid" /></s:url>" onclick="return isDel();">删除</a>]
			    </td>
			  </tr>
			</s:iterator>
			</table>
        </div>
		
	</s:if>
	</fieldset>
	  </div>
  <div id="tabs-2">
  <div>
  	<div class="label_con">
 			<div class="label_main">
 				<fieldset class="clear">
					<legend>基本信息</legend>
					<s:if test="'mdy' == viewFlag">
						<div class="label_hang">
				            <div class="label_ltit">客户编号:</div>
				            <div class="label_rwben">${customer.uuid}<s:hidden name="customer.uuid" title="客户编号" /></div>
						</div>
						<div class="label_hang">
				            <div class="label_ltit">添加时间:</div>
				            <div class="label_rwbenx">${it:formatDate(customer.add_time,'yyyy-MM-dd hh:mm:ss')}</div>
						</div>
					</s:if>
					<div class="label_hang">
			            <div class="label_ltit">所属阶段:</div>
			            <div class="label_rwben"><s:select name="customer.stage" title="所属阶段" list="#{0:'初步了解',1:'深度了解',2:'开始报价',3:'客户未成交',4:'客户成交'}" /></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">客户来源:</div>
			            <div class="label_rwben"><s:select name="customer.source" title="客户来源" list="#{0:'杂志、媒体、广告',1:'朋友介绍',2:'聊天工具',3:'互联网',4:'会议会展',5:'其他'}" /></div>
					</div>
					<div class="label_hang" id="failed_reason_tr" <s:if test="'add' == viewFlag || customer.stage!=3">style="display: none;"</s:if>>
						<div class="label_ltit">未成交原因:</div>
			            <div class="label_rwbenx"><s:checkboxlist name="customer.failed_reasons" list="#{'MORE':'首单量太多','HAVE':'区域内已有经销商','NOPROD':'没有合适的产品','QA':'对公司的市场支持和企业实力有疑问','OTHER':'其他原因'}" /></div>
					</div>
					<div class="label_hang" id="contract_end_tr" <s:if test="'add' == viewFlag || customer.stage!=4">style="display: none;"</s:if>>
						<div class="label_ltit">合同截止期:</div>
			            <div class="label_rwben"><input class="datepicker validate[required,custom[date]]" type="text" name="customer.contract_end" title="合同截止期" value="${it:formatDate(customer.contract_end,'yyyy-MM-dd')}" /></div>
					</div>
				</fieldset>
				<div style="height:10px;"></div>
				<fieldset class="clear">
					<legend>初步了解</legend>

					<div class="label_hang">
			            <div class="label_ltit">联系QQ:</div>
			            <div class="label_rwben"><s:textfield name="customer.qq" title="联系QQ"  cssClass="validate[custom[integer],maxSize[15]]" /></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">传真:</div>
			            <div class="label_rwben"><s:textfield name="customer.fax" title="传真"  cssClass="validate[custom[integer],maxSize[24]]" /></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">手机:</div>
			            <div class="label_rwben"><s:textfield name="customer.mobile" title="手机"  cssClass="validate[custom[integer],maxSize[15]]" /></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">经销区域:</div>
			            <div class="label_rwbenx">
			            	<div class="label_rwben"><s:select id="customer_sale_province" name="customer.sale_province" title="经销区域-省" headerKey="" headerValue="--请选择--" list="#{}" cssClass="validate[required]" /></div>
			            	<div class="w5"></div>
							<div class="label_rwben"><s:select id="customer_sale_city" name="customer.sale_city" title="经销区域-市/区" headerKey="" headerValue="--请选择--" list="#{}" /></div>
							<div class="w5"></div>
							<div class="label_rwben"><s:select id="customer_sale_area" name="customer.sale_area" title="经销区域-县" headerKey="" headerValue="--请选择--" list="#{}" /></div>
							<div class="w5"></div>
							<span class="message_prompt">(如果是市级代理,可以不选【县】)</span>
			            </div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">电子邮箱:</div>
			            <div class="label_rwben"><s:textfield name="customer.email" title="电子邮箱"  cssClass="validate[maxSize[100]]" /></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">邮递地址:</div>
			            <div class="label_rwbenx">
			            	<div class="label_rwben"><s:select id="customer_m_province" name="customer.m_province" title="邮寄地址-省" list="#{}" headerKey="" headerValue="--请选择--"/></div>
							<div class="w5"></div>
							<div class="label_rwben"><s:select id="customer_m_city" name="customer.m_city" title="邮寄地址-市/区" list="#{}" headerKey="" headerValue="--请选择--"/></div>
							<div class="w5"></div>
							<div class="label_rwben"><s:select id="customer_m_area" name="customer.m_area" title="邮寄地址-县" list="#{}" headerKey="" headerValue="--请选择--"/></div>
							
			            </div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">邮递地址邮编:</div>
			            <div class="label_rwben"><s:textfield name="customer.m_post" title="邮递地址邮编"  cssClass="validate[custom[integer],maxSize[10]]" /></div>
					</div>
					<div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">邮递街道地址:</div>
				            <div class="label_rwben"><s:textarea name="customer.m_street" title="邮递街道地址" cssClass="label_hang_linput inputNote validate[maxSize[255]]" /></div>
						</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">所属行业:</div>
			            <div class="label_rwben"><s:textfield name="customer.trade" title="所属行业"  cssClass="validate[maxSize[255]]" /></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">资金实力:</div>
			            <div class="label_rwben"><s:textfield name="customer.financial" title="资金实力"  cssClass="validate[maxSize[64]]" /></div>
					</div>
					<div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">经营思路:</div>
				            <div class="label_rwben"><s:textarea name="customer.mind" title="经营思路" cssClass="label_hang_linput inputNote validate[maxSize[255]]" /></div>
						</div>
					</div>
					<div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">客户背景概述:</div>
				            <div class="label_rwben"><s:textarea name="customer.cus_back" title="原从事行业、销售经验、社会资源状况等" cssClass="label_hang_linput inputNote" rows="4" /></div>
						</div>
					</div>
					<div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">客户现状概述:</div>
				            <div class="label_rwben"><s:textarea name="customer.cus_now"  title="目前经营项目、销售团队配置、资金状况、销售模式等" cssClass="label_hang_linput inputNote" rows="4" /></div>
						</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">仓库面积:</div>
			            <div class="label_rwben"><s:textfield name="customer.ware_square" title="仓库面积" cssStyle="width:70%;" cssClass="validate[custom[number],maxSize[6]]" />&nbsp;m²</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">仓储归属:</div>
			            <div class="label_rwben"><s:select name="customer.ware_type" title="仓储归属"  list="#{0:'租赁',1:'自有' }"/></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">配送车辆:</div>
			            <div class="label_rwben"><s:textfield name="customer.vehicle_num" title="配送车辆" cssStyle="width:70%;" cssClass="validate[custom[integer],maxSize[10]]" />&nbsp;辆</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">市场类型:</div>
			            <div class="label_rwbenx"><s:radio name="customer.sale_type" title="市场类型" list="#{0:'省会',1:'地级',2:'县级'}" /></div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">自有批发商:</div>
			            <div class="label_rwben"><s:textfield name="customer.in_wholesaler" title="自有批发商" cssStyle="width:70%;" cssClass="validate[custom[integer],maxSize[10]]" />&nbsp;个</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">自有直供店:</div>
			            <div class="label_rwben"><s:textfield name="customer.in_shop" title="自有直供店" cssStyle="width:70%;" cssClass="validate[custom[integer],maxSize[10]]" />&nbsp;个</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">二级批发商:</div>
			            <div class="label_rwben"><s:textfield name="customer.out_wholesaler" title="二级批发商" cssStyle="width:70%;" cssClass="validate[custom[integer],maxSize[10]]" />&nbsp;个</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">下级直供店:</div>
			            <div class="label_rwben"><s:textfield name="customer.out_shop" title="下级直供店" cssStyle="width:70%;" cssClass="validate[custom[integer],maxSize[10]]" />&nbsp;个</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">客户类型:</div>
			            <div class="label_rwbenx"><s:checkboxlist name="customer.distributions" list="#{'配送商':'配送商','经销商':'经销商','团购商':'团购商','试销':'试销','其他':'其他'}" /></div>
					</div>
				</fieldset>
				<div style="height:10px;"></div>
				<fieldset class="clear">
					<legend>深入了解</legend>
					<div class="label_hang">
			            <div class="label_ltit">客户重要等级:</div>
			            <div class="label_rwbenx">
			            	<input name="customer.rating" type="radio" class="star {split:2}" value="0.5" <s:if test="customer.rating==0.5"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="1.0" <s:if test="customer.rating==1.0"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="1.5" <s:if test="customer.rating==1.5"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="2.0" <s:if test="customer.rating==2.0"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="2.5" <s:if test="customer.rating==2.5"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="3.0" <s:if test="customer.rating==3.0"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="3.5" <s:if test="customer.rating==3.5"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="4.0" <s:if test="customer.rating==4.0"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="4.5" <s:if test="customer.rating==4.5"> checked="checked"</s:if> />
							<input name="customer.rating" type="radio" class="star {split:2}" value="5.0" <s:if test="customer.rating==5.0"> checked="checked"</s:if> />
			            </div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit" style="width:150px;">客户能承受的首单量:</div>
			            <div class="label_rwben"><s:textfield name="customer.first_pay" title="客户能承受的首单量" cssClass="validate[maxSize[64]]" /></div>
			        </div>
			        <div class="label_hang">
			            <div class="label_ltit" style="width:120px;">感兴趣的产品:</div>
			            <div class="label_rwben"><s:textfield name="customer.i_product" title="感兴趣的产品" cssClass="validate[maxSize[32]]" /></div>
			        </div>
			        <div class="label_hang">
			            <div class="label_ltit" style="width:120px;">客户需要的产品:</div>
			            <div class="label_rwben2"><s:textfield name="customer.n_product" title="客户需要的产品" cssClass="validate[maxSize[128]]" /></div>
			        </div>
			        <div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">客户的疑虑:</div>
				            <div class="label_rwben"><s:textarea name="customer.doubt" title="客户的疑虑" cssClass="label_hang_linput inputNote validate[maxSize[255]]" /></div>
						</div>
					</div>
					<div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">客户问题/解答:</div>
				            <div class="label_rwben"><s:textarea name="customer.qa" title="客户的问题和解答" cssClass="label_hang_linput inputNote validate[maxSize[21845]]" /></div>
						</div>
					</div>
				</fieldset>
				<div style="height:10px;"></div>
				<fieldset class="clear">
					<legend>其他</legend>
					<div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">备注:</div>
				            <div class="label_rwben"><s:textarea name="customer.remark" title="备注" cssClass="label_hang_linput inputNote validate[maxSize[21845]]" /></div>
						</div>
					</div>

					<div class="label_hline">
						<div class="label_hang">
				            <div class="label_ltit">相关操作:</div>
				            <div class="label_rwbenx">
				            	<div class="noprintarea">
									<s:if test="'add' == viewFlag">
									
								<%-- 		<s:submit id="add" name="add" value="确定" action="customer_add" cssClass="input-blue" /> --%>
									
									</s:if>
									<s:elseif test="'mdy' == viewFlag">
									<%-- 	<c:if test="${it:checkPermit('QKJ_QKJMANAGE_CUSTOMER_MDY',null)==true}">
										<s:submit id="save" name="save" value="保存" action="customer_save" cssClass="input-blue" />
										</c:if> --%>
										<%-- <c:if test="${it:checkPermit('QKJ_QKJMANAGE_CUSTOMER_DEL',null)==true}">
										<s:submit id="delete" name="delete" value="删除" action="customer_del" onclick="return isDel();" cssClass="input-red" />
										</c:if> --%>
									
									

								
											
									</s:elseif>
									<%-- <input type="button" class="input-gray" value="返回" onclick="linkurl('<s:url action="customer_relist" namespace="/qkjmanage" />');" /> --%>
									<input id="print_button" type="button" onclick="window.print();" value="打印本页">
									<s:if test="mode!=null">
									<input id="mdy_show_button" type="button" onclick="showMdyButton();" value="我要修改" class="input-blue">
									<span id="message"><s:property value="message" /></span>
									</s:if>
									</div>
				            </div>
						</div>
					</div>
				</fieldset>
				<div style="height:10px;"></div>
				
			</div>
		</div>
	</div>
  </div>
     <s:if test="'mdy'==viewFlag">
  <div id="tabs-3">
  <fieldset class="clear">
					<legend>回访记录</legend>
					<table id="table1" width="100%" class="lb_jpin">
						<tr>
							<th>回访次数</th>
							<th>回访日期</th>
							<th>回访方式</th>
							<th>受访人</th>
							<th>下次回访时间</th>
							<th>回访人</th>
						<th>操作</th> 
						</tr>
						<s:iterator value="customerRecodes" status="sta">
							<tr>
								<td>第${sta.index+1}次</td>
								<td>${it:formatDate(recode_time,'yyyy-MM-dd')}</td>
								<td data="${type}">
									<s:if test="0==type">主动电话拜访</s:if>
									<s:if test="1==type">被动电话来访</s:if>
									<s:if test="2==type">主动上门拜访</s:if>
									<s:if test="3==type">被动上门来访</s:if>
									<s:if test="4==type">会展会场来访</s:if>
									<s:if test="5==type">网络、邮件、信息形式来访</s:if>
									<s:if test="6==type">其他方式</s:if>
								</td>
								<td>${person}</td>
								<td>${it:formatDate(next_date,'yyyy-MM-dd')}</td>
								<td>${add_user_name}</td>
								<td>
										[<a style="color:#0044BB;" href="<s:url namespace="/qkjmanage" action="customerRecode_del"><s:param name="customerRecode.uuid" value="uuid" /><s:param name="customerRecode.customer_id" value="customer_id" /></s:url>" onclick="return isDel();">删除</a>]
							    
							    	[<a style="color:#0044BB;" href="javascript:;" onclick="showRecode(${uuid});">查看详情</a>] 
							    	<span id="content_${uuid}" class="tooltiptext" style="display:none"><s:property value="content" /></span>
									<span id="promise_${uuid}" class="tooltiptext" style="display:none"><s:property value="promise" /></span>
								</td>
							</tr>
						</s:iterator>
					</table>
				</fieldset>
				<input id="addRecode" type="button" value="增加回访记录" onclick="openAddRecode();" />
  </div>
  </s:if>
  
   <c:if test="${it:checkPermit('QKJ_QKJMANAGE_ACTIVE',null)==true}">
      <s:if test="'mdy'==viewFlag">
    <div id="tabs-4">

<fieldset class="clear">
					<legend>活动记录</legend>
					<table id="table1" width="100%" class="lb_jpin">
						<tr>
							<th>主题</th>
							<th>目的	</th>
							<th>活动开始时间</th>
							<th>活动结束时间 </th>
							<th>活动预期</th>
							<th>活动状态</th>
							<th>操作</th>
						</tr>
						<s:iterator value="active" status="sta1">
							<tr>
								<td>${theme }</td>
								<td>${purpose}</td>
								<td>${it:formatDate(plan_start,'yyyy-MM-dd')}</td>
								<td>${it:formatDate(plan_end,'yyyy-MM-dd')}</td>
								<td>${expect}</td>
								 
								<td data="${status}">
									<s:if test="0==status">新申请</s:if>
									<s:if test="1==status">申请审批中</s:if>
									<s:if test="2==status">申请通过</s:if>
									<s:if test="3==status">开始结案</s:if>
									<s:if test="4==status">结案审批中</s:if>
									<s:if test="5==status">结案通过</s:if>
							
								</td>
								<td><a style="color:#0044BB;" href="/qkjmanage/active_load.action?viewFlag=mdy&active.uuid=${uuid}">查看</a></td>
								</tr>
								</s:iterator>
</table>
						
				</fieldset>






</div>
  </s:if>
  </c:if>
  
  
  
  
  
  
  
  
</div>
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
            	<s:if test="'add' == viewFlag">
					
				 	<input id="svipadd" name="svipadd" type="button" value="确定" /> 
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<input id="svipsave" name="svipsave" type="button" value="保存" class="input-blue" />
					<s:submit id="svipdelete" name="svipdelete" value="删除" action="member_del" cssClass="input-red" onclick="return isDel();" />
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="member_list" namespace="/sysvip" />');"  class="input-gray" />
				<s:if test="'mdy' == viewFlag">
					<c:if test="${it:checkPermit('QKJM_SYSVIP_MEMBERSTOCK_LIST',null)==true}">
						<input type="button" value="生成会员库存盘点模板" onclick="linkurl('<s:url action="memberStock_out" namespace="/sysvip" ><s:param name="member.member_name" value="%{member.member_name}"></s:param><s:param name="member.uuid" value="%{member.uuid}"></s:param></s:url>');"  class="input-blue" />
					</c:if>
				</s:if>
				<font id="addMobile" color="red"></font>
				<span id="message"><s:property value="message" /></span>
        	</div>
    	</div>
	</div>
</div>
</s:form>
</div>
</div>








<div id="AddRecode" title="增加回访记录" style="display: none;">
<s:form name="form_customerRecode_add" cssClass="validForm" action="customerRecode_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<tr id="recode_index_tr" style="display: none;">
			<td align="right" width="20%">回访序号:</td>
			<td><span id="recode_index"></span></td>
		</tr>
		<tr>
			<td align="right" width="20%">回访方式:</td>
			<td><s:select id="customerRecode_type" name="customerRecode.type" title="回访方式"  list="#{0:'主动电话拜访',1:'被动电话来访',2:'主动上门拜访',3:'被动上门来访',4:'会展会场来访',5:'网络、邮件、信息形式来访',6:'其他方式'}" cssClass="validate[required]" /></td>
		</tr>
		<tr>
			<td align="right">回访日期:</td>
			<td><s:textfield id="customerRecode_recode_time" name="customerRecode.recode_time" title="回访日期"  value="%{getText('global.date',{customerRecode.recode_time})=='null'?'':getText('global.date',{customerRecode.recode_time})}" dataType="date" cssClass="validate[required]" /></td>
		</tr>
		<tr>
			<td align="right">受访人:</td>
			<td><s:textfield id="customerRecode_person" name="customerRecode.person" title="受访人" cssClass="validate[maxSize[21]]"  /></td>
		</tr>
		<tr>
			<td align="right">访谈内容:</td>
			<td><s:textarea id="customerRecode_content" name="customerRecode.content" title="访谈内容" cssClass="validate[required,maxSize[21845]]" cssStyle="width:71%;" /></td>
		</tr>
		<tr>
			<td align="right">给予客户承诺:</td>
			<td><s:textarea id="customerRecode_promise" name="customerRecode.promise" title="给予客户承诺" cssClass="validate[maxSize[21845]]" cssStyle="width:71%;" /></td>
		</tr>
		<tr>
			<td align="right">下次回访时间:</td>
			<td><s:textfield id="customerRecode_next_date" name="customerRecode.next_date" title="下次回访时间" value="%{getText('global.date',{customerRecode.next_date})=='null'?'':getText('global.date',{customerRecode.next_date})}" dataType="date" controlName="下次回访时间" /></td>
		</tr>
		<tr id="customerRecode_bottonarea">
			<td>&nbsp;</td>
		    <td class="buttonarea">
		    	<s:hidden name="customerRecode.customer_id" value="%{member.uuid}" />
		    
				<s:submit id="customerRecode_add" name="customerRecode_add" value="确定" action="customerRecode_add" />
		
			</td>
	    </tr>
	</table>	
	
</s:form>
</div>


<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
					var sa = new SArea($("#memberAddress\\.province") ,$("#memberAddress\\.city"),$("#memberAddress\\.area"));
					sa.ajax_url = ajax_url;
					sa.init(toHTML.un('<s:property value="memberAddress.province" />'),toHTML.un('<s:property value="memberAddress.city" />'),toHTML.un('<s:property value="memberAddress.area" />'));
				</script>
</body>
<script type="text/javascript">
$(function() {
    $( "#tabs" ).tabs();
  });
		$("#svipadd").click(function(){
			 $.ajax({
			     type:'POST',
			     url: '/sysvip/getMemberMobile',
			     data: "params="+$("#memMobile").val(),
			     beforeSend:function() {
			    	 $("#addMobile").text("正在验证...");
			     },
			     success: function(data){
			    	
			    	 if($("#memMobile").val()==''){
			    		 alert("【会员手机】不许为空!");
				 			$("#memMobile").focus();
			    	 }else if(data=="false"){
			 			alert("会员手机号重复.");
			 		} else if($("#member_name").val()=='') {
			 			alert("【会员名称】不许为空!");
			 			$("#member_name").focus();
			 		} else if($("#memberAddress\\.province").val()=='') {
			 			alert("【所在省市】不许为空!");
			 			$("#memberAddress\\.province").focus();
			 		} else if($("#memberAddress\\.city").val()=='') {
			 			alert("【所在省市】不许为空!");
			 			$("#memberAddress\\.city").focus();
			 		}else {
			 			 document.forms[0].action="/sysvip/member_add";
			 			 document.forms[0].submit();
			 		}
			    },
			    complete:function(){
			    	$("#addMobile").text("");
			    }				    
			  });
			});
		 
		$("#svipsave").click(function(){
			 $.ajax({
			     type:'POST',
			     url: '/sysvip/getMemberMobile',
			     data: "params="+$("#memMobile").val()+"&puid="+$("#puid").val(),
			     beforeSend:function() {
			    	 $("#addMobile").text("正在验证...");
			     },
			     success: function(data){
			    	 if($("#memMobile").val()==''){
			    		 alert("【会员手机】不许为空!");
				 			$("#memMobile").focus();
			    	 }else if(data=="false"){
			 			alert("会员手机号重复.");
			 		}else if($("#member_name").val()=='') {
			 			alert("【会员名称】不许为空!");
			 			$("#member_name").focus();
			 		} else if($("#memberAddress\\.province").val()=='') {
			 			alert("【所在省市】不许为空!");
			 			$("#memberAddress\\.province").focus();
			 		} else if($("#memberAddress\\.city").val()=='') {
			 			alert("【所在省市】不许为空!");
			 			$("#memberAddress\\.city").focus();
			 		}else {
			 			document.forms[0].action="/sysvip/member_save";
			 			document.forms[0].submit();
			 		}
			    },
			    complete:function(){
			    	$("#addMobile").text("");
			    }				    
			  });
			});

		</script>
<script type="text/javascript">
var curr_dept = '${member.dept_code}';
$(function(){
	if(curr_dept!='') {
		loadManagers(curr_dept,'${member.manager}');
	}
});
function copyval() {
	$(":input[name='memberAddress.con_name']").val($(":input[name='member.member_name']").val());
	$(":input[name='memberAddress.mobile']").val($(":input[name='member.mobile']").val());
}
function checkManager() {
	if($("#userdept_codeid").val()=="")
		return isOp("还没有分配部门,确定要提交吗?");
	else 
		return true;
}
</script>






















<script type="text/javascript">
									$("#print_button").show();
									function showMdyButton() {
										$("#mdy_show_button").hide();
										if($("#save").length>0)$("#save").show();
										if($("#addRecode").length>0)$("#addRecode").show();
									}
									</script>
<script type="text/javascript">
								var sa2 = new SArea($("#customer_m_province") ,$("#customer_m_city"),$("#customer_m_area"));
								sa2.ajax_url = '<s:url value="/common_ajax/json_ajax" />';
								sa2.init(toHTML.un('<s:property value="customer.m_province" />'),toHTML.un('<s:property value="customer.m_city" />'),toHTML.un('<s:property value="customer.m_area" />'));
							</script>
<script type="text/javascript">
								var sa = new SArea($("#customer_sale_province"),$("#customer_sale_city"),$("#customer_sale_area"));
								sa.ajax_url = '<s:url value="/common_ajax/json_ajax" />';
								sa.init(toHTML.un('<s:property value="customer.sale_province" />'),toHTML.un('<s:property value="customer.sale_city" />'),toHTML.un('<s:property value="customer.sale_area" />'));
							</script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var manager = '${customer.manager}';

	$("#AddRecode").dialog({
	      autoOpen: false,
	      width: 580,
	      height: 320,
	      modal: true
	});
	CommonUtil.pickrow('table_recode');
	$(".tooltip").tooltip();
 });
function loadManagers(dept_code) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#membermanagerid").clearAllOption();
		$("#membermanagerid").addOption("暂不分配","");
		$("#membermanageridC").clearAllOption();
		$("#membermanageridC").addOption("暂不分配","");
		$.each(data, function(i, n){
			$("#membermanagerid").addOption(n.user_name,n.uuid);
			$("#membermanageridC").addOption(n.user_name,n.uuid);
		});
		
		if(manager!='') {
			$("#membermanagerid").setSelectedValue(manager);
			$("#membermanageridC").setSelectedValue(manager);
		};
	};
	ajax.addParameter("work", "AutoComplete");
	ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
	ajax.sendAjax2();
}

function getCurrRowSpan() {
	return $(".base_info_class:visible").length;
}

function openAddRecode() {
	$("#customerRecode_bottonarea").show();
	$("#recode_index_tr").hide();
	$("#customerRecode_recode_time").datepicker();
	$("#customerRecode_next_date").datepicker();
	
	$("#recode_index").empty();
	$("#customerRecode_recode_time").val('');
	$("#customerRecode_type").val('');
	$("#customerRecode_person").val('');
	$("#customerRecode_next_date").val('');
	$("#customerRecode_content").val('');
	$("#customerRecode_promise").val('');
	
	$("#AddRecode").dialog("open");
}

var showRecode = function(r_id) {
	$("#customerRecode_bottonarea").hide();
	$("#recode_index_tr").show();
	$("#customerRecode_recode_time").datepicker("destroy");
	$("#customerRecode_next_date").datepicker("destroy");
	
	$.each($("#recode_" + r_id + " td"), function(i, n){
		if(i==0)$("#recode_index").text(n.innerText);
		if(i==1)$("#customerRecode_recode_time").val(n.innerText);
		if(i==2)$("#customerRecode_type").val(n.innerText);
		if(i==3)$("#customerRecode_person").val(n.innerText);
		if(i==4)$("#customerRecode_next_date").val(n.innerText);
	});
	$("#customerRecode_content").val($("#content_"+r_id).text());
	$("#customerRecode_promise").val($("#promise_"+r_id).text());
	
	$("#AddRecode").dialog("open");
};

var qianzai= function (obj) {
	if(getRadio("member.is_customers")==1) {	
		document.getElementById("qianzaikehu").style.display = "";
		
	} else {
		document.getElementById("qianzaikehu").style.display = "none";
		document.getElementById("qianzaikehu1").style.display = "none";
	}
}
</script>
</html>