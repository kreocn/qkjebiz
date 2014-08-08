<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == travel && 'add' == viewFlag">增加</s:if><s:elseif test="null != travel && 'mdy' == viewFlag">修改</s:elseif>工业旅游申请</span>
		<span class="extra1">
			<a href="<s:url action="travel_list" namespace="/qkjmanage" />" >工业旅游申请列表</a>
		</span>	
	</div>
<s:form name="form1" action="travel_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		<s:if test="null != travel">
		  <tr>
<td class='firstRow'><span style="color:red;">*</span> 主键自增:</td>
<td class='secRow'><s:property value="travel.uuid" /><s:hidden name="travel.uuid" title="主键自增" /></td>
</tr>

		</s:if>
		  <tr>
<td class='firstRow'>申请部门:</td>
<td class='secRow'><s:textfield name="travel.apply_dept" title="申请部门" dataLength="0,24" controlName="申请部门" /></td>
</tr>
<tr>
<td class='firstRow'>申请人:</td>
<td class='secRow'><s:textfield name="travel.apply_user" title="申请人" dataLength="0,48" controlName="申请人" /></td>
</tr>
<tr>
<td class='firstRow'>申请项目:</td>
<td class='secRow'><s:textfield name="travel.apply_item" title="申请项目" dataLength="0,48" controlName="申请项目" /></td>
</tr>
<tr>
<td class='firstRow'>客户人数:</td>
<td class='secRow'><s:textfield name="travel.travel_num" title="客户人数" dataLength="0,10" dataType="integer" controlName="客户人数" /></td>
</tr>
<tr>
<td class='firstRow'>陪同人数:</td>
<td class='secRow'><s:textfield name="travel.accompany_num" title="陪同人数" dataLength="0,10" dataType="integer" controlName="陪同人数" /></td>
</tr>
<tr>
<td class='firstRow'>执行日期:</td>
<td class='secRow'><s:textfield name="travel.travel_date" title="执行日期" value="%{getText('global.date',{travel.travel_date})=='null'?'':getText('global.date',{travel.travel_date})}" dataType="date" controlName="执行日期" /></td>
</tr>
<tr>
<td class='firstRow'>客户家数:</td>
<td class='secRow'><s:textfield name="travel.member_num" title="客户家数" dataLength="0,10" dataType="integer" controlName="客户家数" /></td>
</tr>
<tr>
<td class='firstRow'>午餐标准/桌:</td>
<td class='secRow'><s:textfield name="travel.lunch_price" title="午餐标准/桌" dataLength="0,10" dataType="number" controlName="午餐标准/桌" /></td>
</tr>
<tr>
<td class='firstRow'>午餐次数:</td>
<td class='secRow'><s:textfield name="travel.lunch_num" title="午餐次数" dataLength="0,10" dataType="integer" controlName="午餐次数" /></td>
</tr>
<tr>
<td class='firstRow'>午餐桌数:</td>
<td class='secRow'><s:textfield name="travel.lunch_desk" title="午餐桌数" dataLength="0,10" dataType="integer" controlName="午餐桌数" /></td>
</tr>
<tr>
<td class='firstRow'>晚餐标准/桌:</td>
<td class='secRow'><s:textfield name="travel.dinner_price" title="晚餐标准/桌" dataLength="0,10" dataType="number" controlName="晚餐标准/桌" /></td>
</tr>
<tr>
<td class='firstRow'>晚餐次数:</td>
<td class='secRow'><s:textfield name="travel.dinner_num" title="晚餐次数" dataLength="0,10" dataType="integer" controlName="晚餐次数" /></td>
</tr>
<tr>
<td class='firstRow'>晚餐桌数:</td>
<td class='secRow'><s:textfield name="travel.dinner_desk" title="晚餐桌数" dataLength="0,10" dataType="integer" controlName="晚餐桌数" /></td>
</tr>
<tr>
<td class='firstRow'>是否使用香烟0否 1是:</td>
<td class='secRow'><s:textfield name="travel.cigarette" title="是否使用香烟0否 1是" dataLength="0,10" dataType="integer" controlName="是否使用香烟0否 1是" /></td>
</tr>
<tr>
<td class='firstRow'>准备香烟包数:</td>
<td class='secRow'><s:textfield name="travel.cigarette_num" title="准备香烟包数" dataLength="0,10" dataType="integer" controlName="准备香烟包数" /></td>
</tr>
<tr>
<td class='firstRow'>是否准备水果0否 1是:</td>
<td class='secRow'><s:textfield name="travel.fruit" title="是否准备水果0否 1是" dataLength="0,10" dataType="integer" controlName="是否准备水果0否 1是" /></td>
</tr>
<tr>
<td class='firstRow'>是否安排住宿0否 1是:</td>
<td class='secRow'><s:textfield name="travel.hotel" title="是否安排住宿0否 1是" dataLength="0,10" dataType="integer" controlName="是否安排住宿0否 1是" /></td>
</tr>
<tr>
<td class='firstRow'>开始住宿时间:</td>
<td class='secRow'><s:textfield name="travel.hotel_start" title="开始住宿时间" value="%{getText('global.date',{travel.hotel_start})=='null'?'':getText('global.date',{travel.hotel_start})}" dataType="date" controlName="开始住宿时间" /></td>
</tr>
<tr>
<td class='firstRow'>结束住宿时间:</td>
<td class='secRow'><s:textfield name="travel.hotel_end" title="结束住宿时间" value="%{getText('global.date',{travel.hotel_end})=='null'?'':getText('global.date',{travel.hotel_end})}" dataType="date" controlName="结束住宿时间" /></td>
</tr>
<tr>
<td class='firstRow'>总共住宿天数:</td>
<td class='secRow'><s:textfield name="travel.hotel_total" title="总共住宿天数" dataLength="0,10" dataType="integer" controlName="总共住宿天数" /></td>
</tr>
<tr>
<td class='firstRow'>标间间数:</td>
<td class='secRow'><s:textfield name="travel.hotel_twinroom" title="标间间数" dataLength="0,10" dataType="integer" controlName="标间间数" /></td>
</tr>
<tr>
<td class='firstRow'>别墅规格(几人一套):</td>
<td class='secRow'><s:textfield name="travel.hotel_house" title="别墅规格(几人一套)" dataLength="0,10" dataType="integer" controlName="别墅规格(几人一套)" /></td>
</tr>
<tr>
<td class='firstRow'>别墅套数:</td>
<td class='secRow'><s:textfield name="travel.hotel_house_num" title="别墅套数" dataLength="0,10" dataType="integer" controlName="别墅套数" /></td>
</tr>
<tr>
<td class='firstRow'>车辆标准:</td>
<td class='secRow'><s:textfield name="travel.car" title="车辆标准" dataLength="0,48" controlName="车辆标准" /></td>
</tr>
<tr>
<td class='firstRow'>是否联系旅行社0否 1是:</td>
<td class='secRow'><s:textfield name="travel.travel_agency" title="是否联系旅行社0否 1是" dataLength="0,10" dataType="integer" controlName="是否联系旅行社0否 1是" /></td>
</tr>
<tr>
<td class='firstRow'>具体行程安排:</td>
<td class='secRow'><s:textfield name="travel.trip" title="具体行程安排" dataLength="0,65535" controlName="具体行程安排" /></td>
</tr>
<tr>
<td class='firstRow'>礼品品相:</td>
<td class='secRow'><s:textfield name="travel.gift" title="礼品品相" dataLength="0,108" controlName="礼品品相" /></td>
</tr>
<tr>
<td class='firstRow'>礼品份数:</td>
<td class='secRow'><s:textfield name="travel.gift_num" title="礼品份数" dataLength="0,10" dataType="integer" controlName="礼品份数" /></td>
</tr>
<tr>
<td class='firstRow'>其他情况说明:</td>
<td class='secRow'><s:textfield name="travel.note" title="其他情况说明" dataLength="0,65535" controlName="其他情况说明" /></td>
</tr>
<tr>
<td class='firstRow'>业务审核状态:</td>
<td class='secRow'><s:textfield name="travel.check_status" title="业务审核状态" dataLength="0,10" dataType="integer" controlName="业务审核状态" /></td>
</tr>
<tr>
<td class='firstRow'>业务审核人:</td>
<td class='secRow'><s:textfield name="travel.check_user" title="业务审核人" dataLength="0,38" controlName="业务审核人" /></td>
</tr>
<tr>
<td class='firstRow'>业务审核时间:</td>
<td class='secRow'><s:textfield name="travel.check_time" title="业务审核时间" value="%{getText('global.date',{travel.check_time})=='null'?'':getText('global.date',{travel.check_time})}" dataType="date" controlName="业务审核时间" /></td>
</tr>
<tr>
<td class='firstRow'>业务审核意见:</td>
<td class='secRow'><s:textfield name="travel.check_note" title="业务审核意见" dataLength="0,255" controlName="业务审核意见" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核状态:</td>
<td class='secRow'><s:textfield name="travel.acheck_status" title="行政审核状态" dataLength="0,10" dataType="integer" controlName="行政审核状态" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核人:</td>
<td class='secRow'><s:textfield name="travel.acheck_user" title="行政审核人" dataLength="0,38" controlName="行政审核人" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核时间:</td>
<td class='secRow'><s:textfield name="travel.acheck_time" title="行政审核时间" value="%{getText('global.date',{travel.acheck_time})=='null'?'':getText('global.date',{travel.acheck_time})}" dataType="date" controlName="行政审核时间" /></td>
</tr>
<tr>
<td class='firstRow'>行政审核意见:</td>
<td class='secRow'><s:textfield name="travel.acheck_note" title="行政审核意见" dataLength="0,255" controlName="行政审核意见" /></td>
</tr>
<tr>
<td class='firstRow'>添加人:</td>
<td class='secRow'><s:textfield name="travel.add_user" title="添加人" dataLength="0,48" controlName="添加人" /></td>
</tr>
<tr>
<td class='firstRow'>添加时间:</td>
<td class='secRow'><s:textfield name="travel.add_time" title="添加时间" value="%{getText('global.date',{travel.add_time})=='null'?'':getText('global.date',{travel.add_time})}" dataType="date" controlName="添加时间" /></td>
</tr>
<tr>
<td class='firstRow'>最后修改人:</td>
<td class='secRow'><s:textfield name="travel.lm_user" title="最后修改人" dataLength="0,48" controlName="最后修改人" /></td>
</tr>
<tr>
<td class='firstRow'>最后修改时间:</td>
<td class='secRow'><s:textfield name="travel.lm_time" title="最后修改时间" value="%{getText('global.date',{travel.lm_time})=='null'?'':getText('global.date',{travel.lm_time})}" dataType="date" controlName="最后修改时间" /></td>
</tr>

		<tr>
		    <td colspan="20" class="buttonarea">
		    	
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == travel && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ADD')">
					<s:submit id="add" name="add" value="确定" action="travel_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != travel && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_MDY')">
					<s:submit id="save" name="save" value="保存" action="travel_save" />
					</s:if>
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_DEL')">
					<s:submit id="delete" name="delete" value="删除" action="travel_del" onclick="return isDel();" />
					</s:if>
				</s:elseif>
				<input type="button" value="返回" onclick="linkurl('<s:url action="travel_relist" namespace="/qkjmanage" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>