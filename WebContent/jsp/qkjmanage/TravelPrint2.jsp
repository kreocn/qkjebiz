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
<div class="noprint" style="text-align: center;"><input type="button" value="打印本页" onclick="window.print();" /> <input type="button" value="返回" onclick="location.href='<s:url action="travel_relist" namespace="/qkjmanage" />';" /></div>
 <div class="danz_warp printmain">
   	<h2 class="danz_tit">接待(餐酒、礼品)申请单</h2>
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
            <td rowspan="4">接待标准</td>
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
            <td>餐酒标准
            <span class="nowrap">(散酒:公斤 | 瓶装酒:瓶)</span>
            </td>
            <td colspan="5" style="text-align:left;padding-left: 5px;">
              <s:if test="travelProducts==null || travelProducts.size==0">
                    <div style="line-height: 30px;">无酒品信息</div>
                </s:if>
                <s:else>
              <table cellpadding="0" cellspacing="0" border="0" class="danz_table">
                  <tr>
                    <td>产品名称</td>
                    <td>数量(瓶|公斤)</td>
                    <td>产品名称</td>
                    <td>数量(瓶|公斤)</td>
                  </tr>
                  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
                  <s:iterator value="travelProducts" status="sta">
                  <s:if test="#sta.odd == true && #sta.index > 1">
                  </tr>
                  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
                  </s:if>
                      <td><s:property value="product_name" /></td>
                      <td><s:property value="num" /></td>
                  </s:iterator>
                  </tr>
                </table>
                </s:else>
            </td>
        </tr>
        <tr>
            <td>礼品配送</td>
            <td colspan="2" style="text-align:left; padding-left:10px;">申请礼品品项： ${travel.gift }</td>
            <td colspan="2"><u> ${travel.gift_num } </u> 份</td>
        </tr>
        <tr>
            <td colspan="2">特殊情况说明</td>
            <td colspan="4" height="120" style="text-align:left; padding-left:10px;">${travel.note}</td>
        </tr>
        <tr>
            <td colspan="2">办事处经理/部门主管</td>
            <td colspan="4" height="60" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi">签字：</div>
                <div class="danz_date">日期：</div>
            </td>
        </tr>
        <tr>
            <td colspan="2">运营中心总监/部门经理</td>
            <td colspan="4" height="60" valign="top" style="padding:0; position:relative;">
                <s:if test="travel.check_status==30">
                  <div class="danz_yjian">${travel.check_note}</div>
                  <div class="danz_qzi">签字：
                  <s:if test="active.sd_user_sign==null">
                    <span class="span_label">${travel.check_user_name}</span>
                  </s:if>
                  <s:else>
                    <span class="user_sign"><img alt="" src="${travel.check_user_sign}" /></span>
                  </s:else>
                 </div>
                  <div class="danz_date">日期：${it:formatDate(travel.check_time,'yyyy-MM-dd')}</div>
                </s:if>
            </td>
        </tr>
        <tr>
            <td colspan="2">分管副总</td>
            <td colspan="4" height="60" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi">签字： </div>
                <div class="danz_date">日期：</div>
            </td>
        </tr>
        <tr>
            <td colspan="2">行政部经理</td>
            <td colspan="4" height="60" valign="top" style="padding:0; position:relative;">
                <s:if test="travel.check_status==30">
                  <div class="danz_yjian">${travel.acheck_note}</div>
                  <div class="danz_qzi">签字：
                  <s:if test="active.sd_user_sign==null">
                    <span class="span_label">${travel.acheck_user_name}</span>
                  </s:if>
                  <s:else>
                    <span class="user_sign"><img alt="" src="${travel.acheck_user_sign}" /></span>
                  </s:else>
                 </div>
                  <div class="danz_date">日期：${it:formatDate(travel.acheck_time,'yyyy-MM-dd')}</div>
                </s:if>
            </td>
        </tr>
        <tr>
            <td colspan="2">行政管理副总</td>
            <td colspan="4" height="60" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi">签字：</div>
                <div class="danz_date">日期：</div>
            </td>
        </tr>
    </table>
</div>
<div class="noprint" style="text-align: center;"><input type="button" value="打印本页" onclick="window.print();" /> <input type="button" value="返回" onclick="location.href='<s:url action="travel_relist" namespace="/qkjmanage" />';" /></div>
</body>
</html>