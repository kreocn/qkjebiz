<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/print.css" />" />
<body>
<div class="noprint input-a" style="text-align: center;">
  <input type="button" value="打印本页" onclick="window.print();" />
  <input type="button" value="返回" class="input-gray" onclick="location.href='<s:url action="travel_relist" namespace="/qkjmanage" />';" />
</div>
 <div class="danz_warp printmain">
  	<h2 class="danz_tit">接待(餐饮、住宿)申请单</h2>
	<div class="danz_top">
    	<p class="danz_lsqdh">申请单号：${travel.uuid}</p>
        <p class="danz_rdate">制表日期：${it:formatDate(travel.add_time,'yyyy年MM月dd日')}</p>
        <div style="clear:both;"></div>
    </div>
    <table width="100%" align="center" cellpadding="0" cellspacing="0" border="0" class="danz_table">
        <tr>
            <td width="14%">申请人</td>
            <td width="13%">${travel.apply_user_name}</td>
            <td width="14%">所属部门</td>
            <td width="13%">${travel.apply_dept_name}</td>
            <td width="14%">申请事项</td>
            <td width="32%" style="text-align:left; padding-left:12px;">
              <s:checkboxlist  name="travel.apply_items" list="#{'ITEM01':'厂区工艺流程','ITEM02':'新厂区','ITEM03':'高尔夫练习场打球体验','ITEM04':'参观中华土族园','ITEM99':'其他' }" />
           </td>
        </tr>
        <tr>
            <td>客户人数</td>
            <td>${travel.travel_num}</td>
            <td>陪同人数</td>
            <td>${travel.accompany_num}</td>
            <td>执行日期</td>
            <td>${it:formatDate(travel.travel_date,'yyyy-MM-dd')} - ${it:formatDate(travel.travel_date_end,'yyyy-MM-dd')}</td>
        </tr>
        <tr>
            <td colspan="2">来访客户单位</td>
            <td colspan="4">[详见附件]</td>
        </tr>
        <tr>
            <td rowspan="8">接待标准</td>
            <td rowspan="2">用餐标准</td>
            <td><u> ${travel.lunch_price} </u> 元/桌</td>
            <td>中餐</td>
            <td colspan="2"><u> ${travel.lunch_num} </u> 次 <u> ${travel.lunch_desk} </u> 桌</td>
        </tr>
        <tr>
            <td><u> ${travel.dinner_price} </u> 元/桌</td>
            <td>晚餐</td>
            <td colspan="2"><u> ${travel.dinner_num} </u> 次 <u> ${travel.dinner_desk} </u> 桌</td>
        </tr>
        <tr>
            <td>是否配备香烟</td>
            <td colspan="2"><s:checkboxlist name="travel.cigarette" list="#{0:'否',1:'是' }" /></td>
            <td colspan="2"><u> ${travel.cigarette_num} </u> 包</td>
        </tr>
        <tr>
            <td>是否配备水果</td>
            <td colspan="4"><s:checkboxlist name="travel.fruit" list="#{0:'否',1:'是' }" /></td>
        </tr>
        <tr>
            <td rowspan="2">是否安排住宿</td>
            <td colspan="2"><s:checkboxlist name="travel.hotel" list="#{0:'否',1:'是' }" /></td>
            <td colspan="2">住宿时间：${it:formatDate(travel.hotel_start,'MM月dd日')}&nbsp;至&nbsp;${it:formatDate(travel.hotel_end,'MM月dd日')}&nbsp;共 ${travel.hotel_total} 晚</td>
        </tr>
        <tr>
            <td colspan="2">标准（ ${travel.hotel_twinroom} ）间</td>
            <td colspan="2">别墅 <u>${travel.hotel_house}</u>  人间（ ${travel.hotel_house_num} ）套</td>
        </tr>
        <tr>
            <td>车辆派送</td>
            <td colspan="4"><s:checkboxlist name="travel.cars" list="#{'大巴':'大巴','中巴':'中巴','商务':'商务','轿车':'轿车'}" /></td>
        </tr>
        <tr>
            <td colspan="2">是否需要联系旅行社</td>
            <td colspan="3"><s:checkboxlist name="travel.travel_agency" list="#{0:'否',1:'是' }" /></td>
        </tr>
        <tr>
            <td colspan="2">具体行程安排</td>
            <td colspan="4" height="115" valign="top">
            	<div style="width:100%; padding:0 3px; text-align:left;">
                    ${travel.trip}
                </div>
            </td>
        </tr>
        <tr>
            <td colspan="2">办事处经理/部门主管</td>
            <td colspan="4" height="78" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi" style="width: 180px;">签字：</div>
                <div class="danz_date" style="width: 110px;">日期：</div>
            </td>
        </tr>
        <tr>
            <td colspan="2">运营中心总监/部门经理</td>
            <td colspan="4" height="78" valign="top" style="padding:0; position:relative;">
                <s:if test="travel.check_status==30">
                  <div class="danz_yjian">${travel.check_note}</div>
                  <div class="danz_qzi" style="width: 180px;">签字：
                  <s:if test="active.sd_user_sign==null">
                    <span class="span_label">${travel.check_user_name}</span>
                  </s:if>
                  <s:else>
                    <span class="user_sign"><img alt="" src="${travel.check_user_sign}" /></span>
                  </s:else>
                 </div>
                  <div class="danz_date" style="width: 110px;">日期：${it:formatDate(travel.check_time,'yyyy-MM-dd')}</div>
                </s:if>
            </td>
        </tr>
        <tr>
            <td colspan="2">分管副总</td>
            <td colspan="4" height="78" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi" style="width: 180px;">签字： </div>
                <div class="danz_date" style="width: 110px;">日期：</div>
            </td>
        </tr>
        <tr>
            <td colspan="2">行政部经理</td>
            <td colspan="4" height="78" valign="top" style="padding:0; position:relative;">
                <s:if test="travel.check_status==30">
                  <div class="danz_yjian">${travel.acheck_note}</div>
                  <div class="danz_qzi" style="width: 180px;">签字：
                  <s:if test="active.sd_user_sign==null">
                    <span class="span_label">${travel.acheck_user_name}</span>
                  </s:if>
                  <s:else>
                    <span class="user_sign"><img alt="" src="${travel.acheck_user_sign}" /></span>
                  </s:else>
                 </div>
                  <div class="danz_date" style="width: 110px;">日期：${it:formatDate(travel.acheck_time,'yyyy-MM-dd')}</div>
                </s:if>
            </td>
        </tr>
        <tr>
            <td colspan="2">行政管理副总</td>
            <td colspan="4" height="78" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi" style="width: 180px;">签字：</div>
                <div class="danz_date" style="width: 110px;">日期：</div>
            </td>
        </tr>
    </table>
</div>
<div class="noprint input-a" style="text-align: center;">
	<input type="button" value="打印本页" onclick="window.print();" />
	<input type="button" value="返回" class="input-gray" onclick="location.href='<s:url action="travel_relist" namespace="/qkjmanage" />';" />
</div>
</body>
</html>