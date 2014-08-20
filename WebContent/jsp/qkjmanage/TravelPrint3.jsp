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
   	<h2 class="danz_tit">来访客户资料登记表</h2>
	<div class="danz_top">
    	<p class="danz_lsqdh">申请单号：${travel.uuid}</p>
        <p class="danz_rdate">制表日期：${it:formatDate(travel.add_time,'yyyy年MM月dd日')}</p>
        <div style="clear:both;"></div>
    </div>
    <table width="100%" align="center" cellpadding="0" cellspacing="0" border="0" class="danz_table">
        <tr>
            <td>序号</td>
            <td>日期</td>
            <td>客户姓名</td>
            <td>性别</td>
            <td>来访客户单位</td>
            <td>客户类别</td>
            <td>联系电话</td>
            <td>身份证号</td>
            <td>申请接待部门</td>
            <td>申请人</td>
            <td>申请单号*</td>
            <td>执行日期*</td>
            <td>备注</td>
        </tr>
        <s:iterator value="travelCustomers" status="sta">
        <tr>
            <td><s:property value="#sta.index" /></td>
            <td>${it:formatDate(travel.travel_date,'yyyy-MM-dd')}</td>
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
            <td>${travel.apply_dept_name}</td>
            <td>${travel.apply_user_name}</td>
            <td></td>
            <td></td>
            <td>${note}</td>
        </tr>
        </s:iterator>
    </table>
</div>
<div class="noprint" style="text-align: center;"><input type="button" value="打印本页" onclick="window.print();" /> <input type="button" value="返回" onclick="location.href='<s:url action="travel_relist" namespace="/qkjmanage" />';" /></div>
</body>
</html>