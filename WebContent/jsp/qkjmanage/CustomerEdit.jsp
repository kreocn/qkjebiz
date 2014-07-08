<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>客户管理管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/stylesheets/jquery.rating.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.rating.pack.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.MetaData.js" />"></script>
<style type="text/css">
.titleRowx {width: 30px;}
.firstRowx {width: 150px;}
.secRowx {}
.table_sep {height: 5px;}
.tooltiptext{display: none;}
<s:if test="mode!=null">
.viewmode {display: none;}
</s:if>
</style>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="'add' == viewFlag">增加</s:if><s:elseif test="'mdy' == viewFlag">修改</s:elseif>客户信息</span>
		<s:if test="mode==null">
		<span class="extra1 noprintarea">
			<a href="<s:url action="customer_list" namespace="/qkjmanage"><s:param name="viewFlag">relist</s:param></s:url>" >客户列表</a>
		</span>
		</s:if>
	</div>
<s:form name="form1" action="customer_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
			<tr class="base_info_class">
			<td id="base_info_td" class="titleRowx">
				基<br />本<br />信<br />息<br />
			</td>
			<td class='firstRowx'><span style="color:red;">*</span> 所属部门:</td>
			<td class='secRowx' colspan="5">
				<s:textfield id="customer_dept_code" name="customer.dept_code" title="所属部门" readonly="readonly" require="required" controlName="所属部门" />
				<s:textfield id="customer_dept_name" name="customer.dept_name" title="所属部门" readonly="readonly" />
				<span class="noprintarea"><img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept2();" /></span>
				<s:select id="membermanagerid" name="customer.manager" list="#{}" headerKey="" headerValue="--请选择--"  controlName="所属人"  />
				<span id="ajax_member_message"></span>
			</td>
			</tr>
			
			<s:if test="'mdy' == viewFlag">
		    <tr class="base_info_class">
			<td class='firstRowx'><span style="color:red;">*</span> 客户编号:</td>
			<td class='secRowx'><s:property value="customer.uuid" /><s:hidden name="customer.uuid" title="客户编号" /></td>
			<td class='firstRowx'>添加时间:</td>
			<td class='secRowx' colspan="3"><s:date name="customer.add_time" format="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			</s:if>
			<tr class="base_info_class">
			<td class='firstRowx'><span style="color:red;">*</span> 所属阶段:</td>
			<td class='secRowx'><s:select id="customer_stage" name="customer.stage" title="所属阶段" require="required" controlName="所属阶段" headerKey="" headerValue="--请选择--" list="#{0:'初步了解',1:'深度了解',2:'开始报价',3:'客户未成交',4:'客户成交'}" /></td>
			<td class='firstRowx'><span style="color:red;">*</span> 客户来源:</td>
			<td class='secRowx' colspan="3"><s:select name="customer.source" title="客户来源" require="required" controlName="客户来源" headerKey="" headerValue="--请选择--" list="#{0:'杂志、媒体、广告',1:'朋友介绍',2:'聊天工具',3:'互联网',4:'会议会展',5:'其他'}" /></td>
			</tr>
			<tr id="failed_reason_tr" class="base_info_class" <s:if test="'add' == viewFlag || customer.stage!=3">style="display: none;"</s:if>>
			<td class='firstRowx'>未成交原因:</td>
			<td class='secRowx' colspan="5">
				<s:checkboxlist name="customer.failed_reasons" 
					list="#{'MORE':'首单量太多','HAVE':'区域内已有经销商','NOPROD':'没有合适的产品','QA':'对公司的市场支持和企业实力有疑问','OTHER':'其他原因'}" />
			</td>
			</tr>
			<tr id="contract_end_tr"  class="base_info_class" <s:if test="'add' == viewFlag || customer.stage!=4">style="display: none;"</s:if>>
			<td class='firstRowx'><span style="color:red;">*</span> 合同截止期:</td>
			<td class='secRowx' colspan="5">
				<input id="customer_contract_end" name="customer.contract_end" title="合同截止期" value='${it:formatDate(customer.contract_end,"yyyy-MM-dd")}' dataType="date" controlName="合同截止期(已成交才有)" />
			</td>
			</tr>
			
			<tr class="table_sep"><td colspan="20"></td></tr>
			<!-- 初步了解 -->
			<tr>
			<td class="titleRowx" rowspan="13">
				<div style="padding: 0 8px;">
				初<br />步<br />了<br />解<br />
				</div>
			</td>
			<td class='firstRowx'><span style="color:red;">*</span> 客户名称/企业名称:</td>
			<td class='secRowx'><s:textfield name="customer.cus_name" title="客户名称/企业名称" dataLength="0,42" require="required" controlName="客户名称" /></td>
			<td class='firstRowx'><span style="color:red;">*</span> 联系人:</td>
			<td class='secRowx'><s:textfield name="customer.con_name" title="联系人" require="required" dataLength="0,10" controlName="联系人" /></td>
			<td class='firstRowx'>联系电话:</td>
			<td class='secRowx'><s:textfield name="customer.phone" title="联系电话" dataLength="0,21" controlName="联系电话" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>联系QQ:</td>
			<td class='secRowx'><s:textfield name="customer.qq" title="联系QQ" dataLength="0,15" controlName="联系QQ" /></td>
			<td class='firstRowx'>传真:</td>
			<td class='secRowx'><s:textfield name="customer.fax" title="传真" dataLength="0,24" controlName="传真" /></td>
			<td class='firstRowx'>手机:</td>
			<td class='secRowx'><s:textfield name="customer.mobile" title="手机" dataLength="0,15" controlName="手机" /></td>
			</tr>
			<tr>
			<td class='firstRowx'><span style="color:red;">*</span> 经销区域:</td>
			<td class='secRowx' colspan="3">
				<s:select id="customer_sale_province" name="customer.sale_province" title="经销区域-省" list="#{}" require="required" controlName="经销区域-省" />
				<s:select id="customer_sale_city" name="customer.sale_city" title="经销区域-市/区" list="#{}" />
				<s:select id="customer_sale_area" name="customer.sale_area" title="经销区域-县" list="#{}" />
				<script type="text/javascript">
					var sa = new SArea($("#customer_sale_province") ,$("#customer_sale_city"),$("#customer_sale_area"));
					sa.ajax_url = '<s:url value="/common_ajax/json_ajax" />';
					sa.init(toHTML.un('<s:property value="customer.sale_province" />'),toHTML.un('<s:property value="customer.sale_city" />'),toHTML.un('<s:property value="customer.sale_area" />'));
				</script>
				<span class="message_prompt">(如果是市级代理,可以不选【县】)</span>
			</td>
			<td class='firstRowx'>电子邮箱:</td>
			<td class='secRowx'><s:textfield name="customer.email" title="电子邮箱" dataLength="0,100" controlName="电子邮箱" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>邮寄地址-省/直辖市:</td>
			<td class='secRowx' colspan="3">
				<s:select id="customer_m_province" name="customer.m_province" title="邮寄地址-省" list="#{}" />
				<s:select id="customer_m_city" name="customer.m_city" title="邮寄地址-市/区" list="#{}" />
				<s:select id="customer_m_area" name="customer.m_area" title="邮寄地址-县" list="#{}" />
				<script type="text/javascript">
					var sa2 = new SArea($("#customer_m_province") ,$("#customer_m_city"),$("#customer_m_area"));
					sa2.ajax_url = '<s:url value="/common_ajax/json_ajax" />';
					sa2.init(toHTML.un('<s:property value="customer.m_province" />'),toHTML.un('<s:property value="customer.m_city" />'),toHTML.un('<s:property value="customer.m_area" />'));
				</script>
			</td>
			<td class='firstRowx'>邮寄地址-邮编:</td>
			<td class='secRowx'><s:textfield name="customer.m_post" title="邮寄地址-邮编" dataLength="0,10" controlName="邮寄地址-邮编" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>邮寄地址-街道地址:</td>
			<td class='secRowx' colspan="5"><s:textarea name="customer.m_street" title="邮寄地址-街道地址" dataLength="0,255" controlName="邮寄地址-街道地址" cssStyle="width:80%" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>所属行业:</td>
			<td class='secRowx'><s:textfield name="customer.trade" title="所属行业" dataLength="0,255" controlName="所属行业" /></td>
			<td class='firstRowx'>资金实力:</td>
			<td class='secRowx' colspan="3"><s:textfield name="customer.financial" title="资金实力" dataLength="0,64" controlName="资金实力" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>经营思路:</td>
			<td class='secRowx' colspan="5"><s:textarea name="customer.mind" rows="3" title="经营思路" dataLength="0,255" controlName="经营思路" cssStyle="width:80%" /></td>
			</tr>
			
			<tr>
			<td class='firstRowx'>客户背景概述:</td>
			<td class='secRowx' colspan="5"><s:textarea name="customer.cus_back" rows="6" title="原从事行业、销售经验、社会资源状况等" controlName="客户背景概述" cssClass="tooltip" cssStyle="width:80%" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>客户现状概述:</td>
			<td class='secRowx' colspan="5"><s:textarea name="customer.cus_now" rows="6" title="目前经营项目、销售团队配置、资金状况、销售模式等" controlName="客户现状概述" cssClass="tooltip" cssStyle="width:80%" /></td>
			</tr>
			
			<tr>
			<td class='firstRowx'>仓库面积:</td>
			<td class='secRowx'><s:textfield name="customer.ware_square" title="仓库面积" dataLength="0,6" dataType="number" controlName="仓库面积" cssStyle="width:60px;" /> M<span style="vertical-align:super;">2</span></td>
			<td class='firstRowx'>仓储归属:</td>
			<td class='secRowx' style=""><s:select name="customer.ware_type" title="仓储归属" list="#{0:'租赁',1:'自有' }" /></td>
			<td class='firstRowx'>配送车辆:</td>
			<td class='secRowx'><s:textfield name="customer.vehicle_num" title="配送车辆" dataLength="0,10" dataType="integer" controlName="配送车辆" cssStyle="width:30px;" /> 辆</td>
			</tr>
			
			<tr>
			<td class='firstRowx' rowspan="2">市场类型:</td>
			<td class='secRowx' rowspan="2">
				<s:radio name="customer.sale_type" title="市场类型"  list="#{0:'省会',1:'地级',2:'县级'}" />
			</td>
			<td class='firstRowx'>自有批发商:</td>
			<td class='secRowx'><s:textfield name="customer.in_wholesaler" title="自有批发商" dataLength="0,10" dataType="integer" controlName="自有批发商" cssStyle="width:30px;" /> 个</td>
			<td class='firstRowx'>自有直供店:</td>
			<td class='secRowx'><s:textfield name="customer.in_shop" title="自有直供店" dataLength="0,10" dataType="integer" controlName="自有直供店" cssStyle="width:30px;" /> 个</td>
			</tr>
			
			<tr>
			<td class='firstRowx'>二级批发商:</td>
			<td class='secRowx'><s:textfield name="customer.out_wholesaler" title="二级批发商" dataLength="0,10" dataType="integer" controlName="二级批发商" cssStyle="width:30px;" /> 个</td>
			<td class='firstRowx'>下级直供店:</td>
			<td class='secRowx'><s:textfield name="customer.out_shop" title="下级直供店" dataLength="0,10" dataType="integer" controlName="下级直供店" cssStyle="width:30px;" /> 个</td>
			</tr>
			
			<tr>
			<td class='firstRowx'>客户类型:</td>
			<td class='secRowx' colspan="5">
				<s:checkboxlist name="customer.distributions" list="#{'配送商':'配送商','经销商':'经销商','团购商':'团购商','试销':'试销','其他':'其他'}" />
			</td>
			</tr>
			
			<tbody id="customer_stage_1" <s:if test="'add' == viewFlag || customer.stage==0">style="display: none;"</s:if>>
			<tr class="table_sep"><td colspan="20"></td></tr>
			<tr>
			<td class="titleRowx" rowspan="4">
				深<br />入<br />了<br />解<br />
			</td>
			<td class='firstRowx'>客户重要等级:</td>
			<td class='secRowx'>
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
			</td>
			<td class='firstRowx'>客户能承受的首单量:</td>
			<td class='secRowx' colspan="3"><s:textfield name="customer.first_pay" title="客户能承受的首单量" dataLength="0,64" controlName="客户能承受的首单量" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>感兴趣的产品:</td>
			<td class='secRowx'><s:textfield name="customer.i_product" title="感兴趣的产品" dataLength="0,32" controlName="感兴趣的产品" /></td>
			<td class='firstRowx' >客户需要的产品:</td>
			<td class='secRowx' colspan="3"><s:textfield name="customer.n_product" title="客户需要的产品" dataLength="0,128" controlName="客户需要的产品" cssStyle="width:80%;" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>客户的疑虑:</td>
			<td class='secRowx' colspan="5">
				<s:textarea name="customer.doubt" title="客户的疑虑" dataLength="0,255" controlName="客户的疑虑" cssStyle="width:80%;" />
			</td>
			</tr>
			<tr>
			<td class='firstRowx'>客户的问题和解答:</td>
			<td class='secRowx' colspan="5">
				<s:textarea name="customer.qa" title="客户的问题和解答" dataLength="0,21845" controlName="客户的问题和解答" cssStyle="width:80%;" />
			</td>
			</tr>
			</tbody>
			
			<tr class="table_sep"><td colspan="20"></td></tr>
			<tr>
			<td class="titleRowx" rowspan="2">其<br />他</td>
			<td class='firstRowx'>备注:</td>
			<td class='secRowx' colspan="5"><s:textarea name="customer.remark" title="备注" dataLength="0,21845" controlName="备注" cssStyle="width:80%;" /></td>
			</tr>
			<tr>
			<td class='firstRowx'>相关操作:</td>
			<td class='secRowx' colspan="5">
				<div class="noprintarea">
				<s:if test="'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_ADD')">
					<s:submit id="add" name="add" value="确定" action="customer_add" />
					</s:if>
				</s:if>
				<s:elseif test="'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_MDY')">
					<s:submit id="save" name="save" value="保存" action="customer_save" cssClass="viewmode" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMER_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="customer_del" onclick="return isDel();" cssClass="viewmode" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMERRECODE_ADD')">
					<input id="addRecode" type="button" value="增加回访记录" onclick="openAddRecode();" class="viewmode" />
					</s:if>
				</s:elseif>
				<input type="button" class="viewmode" value="返回" onclick="linkurl('<s:url action="customer_relist" namespace="/qkjmanage" />');" />
				<input id="print_button" type="button" onclick="window.print();" value="打印本页">
				<s:if test="mode!=null">
				<input id="mdy_show_button" type="button" onclick="showMdyButton();" value="我要修改">
				<script type="text/javascript">
				$("#print_button").show();
				function showMdyButton() {
					$("#mdy_show_button").hide();
					if($("#save").length>0)$("#save").show();
					if($("#addRecode").length>0)$("#addRecode").show();
				}
				</script>
				<span id="message"><s:property value="message" /></span>
				</s:if>
				</div>
			</td>
			</tr>
			
			<tr class="table_sep"><td colspan="20"></td></tr>
			<tr>
			<td class="titleRowx">回<br />访<br />记<br />录</td>
			<td class='secRowx' colspan="6" valign="top">
	<table class="ilisttable" id="table_recode" width="100%">
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
	  <tr id="recode_${uuid}" class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
		<td align="center">第${sta.index+1}次</td>
		<td align="center"><s:date name="recode_time" format="yyyy-MM-dd" /></td>
		<td  align="center" data="${type}">
			<s:if test="0==type">主动电话拜访</s:if>
			<s:if test="1==type">被动电话来访</s:if>
			<s:if test="2==type">主动上门拜访</s:if>
			<s:if test="3==type">被动上门来访</s:if>
			<s:if test="4==type">会展会场来访</s:if>
			<s:if test="5==type">网络、邮件、信息形式来访</s:if>
			<s:if test="6==type">其他方式</s:if>
		</td>
		<td><s:property value="person" /></td>
		<td align="center"><s:date name="next_date" format="yyyy-MM-dd" /></td>
		<td align="center"><s:property value="add_user_name" /></td>
		<td align="center">
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMERRECODE_DEL')">
	    	[<a href="<s:url namespace="/qkjmanage" action="customerRecode_del"><s:param name="customerRecode.uuid" value="uuid" /><s:param name="customerRecode.customer_id" value="customer_id" /></s:url>" onclick="return isDel();">删除</a>]
	    	</s:if>
	    	[<a href="javascript:;" onclick="showRecode(${uuid});">查看详情</a>]
	    	<span id="content_${uuid}" class="tooltiptext"><s:property value="content" /></span>
			<span id="promise_${uuid}" class="tooltiptext"><s:property value="promise" /></span>
	    </td>
	  </tr>
</s:iterator>
	</table>
			</td>
			</tr>
		</table>	
</s:form>
	</div>
</div>
</div>

<div id="AddRecode" title="增加回访记录" style="display: none;">
<s:form name="form_customerRecode_add" action="customerRecode_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<tr id="recode_index_tr" style="display: none;">
		<td class='firstRow'>回访序号:</td>
		<td class='secRow'><span id="recode_index"></span></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 回访方式:</td>
		<td class='secRow'><s:select id="customerRecode_type" name="customerRecode.type" title="回访方式"  list="#{0:'主动电话拜访',1:'被动电话来访',2:'主动上门拜访',3:'被动上门来访',4:'会展会场来访',5:'网络、邮件、信息形式来访',6:'其他方式'}" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 回访日期:</td>
		<td class='secRow'><s:textfield id="customerRecode_recode_time" name="customerRecode.recode_time" title="回访日期" require="required" value="%{getText('global.date',{customerRecode.recode_time})=='null'?'':getText('global.date',{customerRecode.recode_time})}" dataType="date" controlName="回访日期" /></td>
		</tr>
		<tr>
		<td class='firstRow'>受访人:</td>
		<td class='secRow'><s:textfield id="customerRecode_person" name="customerRecode.person" title="受访人" dataLength="0,21" controlName="受访人" /></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 访谈内容:</td>
		<td class='secRow'><s:textarea id="customerRecode_content" name="customerRecode.content" title="访谈内容" require="required" dataLength="0,21845" controlName="访谈内容" cssStyle="width:80%;" /></td>
		</tr>
		<tr>
		<td class='firstRow'>给予客户承诺:</td>
		<td class='secRow'><s:textarea id="customerRecode_promise" name="customerRecode.promise" title="给予客户承诺" dataLength="0,21845" controlName="给予客户承诺" cssStyle="width:80%;" /></td>
		</tr>
		<tr>
		<td class='firstRow'>下次回访时间:</td>
		<td class='secRow'><s:textfield id="customerRecode_next_date" name="customerRecode.next_date" title="下次回访时间" value="%{getText('global.date',{customerRecode.next_date})=='null'?'':getText('global.date',{customerRecode.next_date})}" dataType="date" controlName="下次回访时间" /></td>
		</tr>

		<tr id="customerRecode_bottonarea">
		    <td colspan="20" class="buttonarea">
		    	<s:hidden name="customerRecode.customer_id" value="%{customer.uuid}" />
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CUSTOMERRECODE_ADD')">
				<s:submit id="customerRecode_add" name="customerRecode_add" value="确定" action="customerRecode_add" />
				</s:if>
				<span id="message"><s:property value="message" /></span>
			</td>
	    </tr>
	</table>	
</s:form>
</div>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var manager = '${customer.manager}';
$(function(){
	if($("#customer_dept_code").val()!='') {
		loadManagers($("#customer_dept_code").val());
	}
	$("#customer_stage").bind("change",function(){
		if($(this).val()==0) {
			$("#customer_stage_1").hide();
		} else {
			$("#customer_stage_1").show();
		}
		if($(this).val()==3) {
			$("#failed_reason_tr").show();
		} else {
			$("#failed_reason_tr").hide();
		}
		if($(this).val()==4) {
			$("#contract_end_tr").show();
			$("#customer_contract_end").attr("require","required");
		} else {
			$("#contract_end_tr").hide();
			$("#customer_contract_end").removeAttr("require");
		}
		$("#base_info_td").attr("rowspan",$(".base_info_class:visible").length);
	});
	$("#AddRecode").dialog({
	      autoOpen: false,
	      width: 580,
	      height: 275,
	      modal: true
	});
	$("#base_info_td").attr("rowspan",$(".base_info_class:visible").length);
	
	$("#customer_contract_end").datepicker();
	if(CommonUtil.isVisible($("#customer_contract_end"))) {
		$("#customer_contract_end").attr("require","required");
	} else {
		$("#customer_contract_end").removeAttr("require");
	}
	
	CommonUtil.pickrow('table_recode');
	
	$(".tooltip").tooltip();
 });
 
var sobj01;
var selectDept2 = function() {
	sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
	sobj01.selfAction = function(val1,val2) {
		$("#customer_dept_code").val(val1);
		$("#customer_dept_name").val(val2);
		 loadManagers(val1);
	};
	sobj01.create();
	sobj01.open();
};

function loadManagers(dept_code) {
	var ajax = new Common_Ajax('ajax_member_message');
	ajax.config.action_url = ajax_url_action;
	ajax.config._success = function(data, textStatus) {
		$("#membermanagerid").clearAllOption();
		$("#membermanagerid").addOption("暂不分配","");
		$.each(data, function(i, n){
			$("#membermanagerid").addOption(n.user_name,n.uuid);
		});
		
		if(manager!='') {
			$("#membermanagerid").setSelectedValue(manager);
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
</script>
</body>
</html>