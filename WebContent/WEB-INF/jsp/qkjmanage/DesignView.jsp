<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>门头设计--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/print.css" />" />
<body>
<div class="noprint input-a" style="text-align: center;">
  <input type="button" value="打印本页" onclick="window.print();" />
  <input type="button" value="返回" class="input-gray" onclick="location.href='<s:url action="design_list" namespace="/qkjmanage" />';" />
</div>
 <div class="danz_warp printmain">
  	<h2 class="danz_tit">设计制作申请表</h2>
	<div class="danz_top">
    	<p class="danz_lsqdh">申请单号：${active.uuid}</p>
        <p class="danz_rdate">制表日期：${it:formatDate(active.add_time,'yyyy年MM月dd日')}</p>
        <div style="clear:both;"></div>
    </div>
    <table width="100%" align="center" cellpadding="0" cellspacing="0" border="0" class="danz_table">
        <tr>
        	<td width="14%" style="font-weight: bold;">门店名称</td>
        	<td width="50%" colspan="2">${active.design_name}</td>
        	<td width="14%" style="font-weight: bold;">数量</td>
        	<td width="13%"colspan="2">${active.design_num}</td>
        </tr>
        
        <tr>
        	<td width="14%" style="font-weight: bold;">类型</td>
        	<td width="25%">${active.design_type}</td>
        	<td width="14%" style="font-weight: bold;">单价/m²（元）</td>
        	<td width="13%">${active.design_price}</td>
        	<td width="14%" style="font-weight: bold;">合计（元）</td>
        	<td width="13%">${active.design_total}</td>
            
        </tr>
        <tr>
        	<td width="14%" style="font-weight: bold;">申请人</td>
            <td width="25%">${active.apply_user_name}</td>
            <td width="14%" style="font-weight: bold;">所属部门</td>
            <td width="13%">${active.apply_dept_name}</td>
            <td width="14%" style="font-weight: bold;">使用日期</td>
            <td width="13%">${it:formatDate(active.plan_start,'yyyy-MM-dd')}- ${it:formatDate(active.plan_end,'yyyy-MM-dd')}</td>
        </tr>
        <tr>
            <td rowspan="4" style="font-weight: bold;">门头印刷品说明</td>
            <td style="font-weight: bold;">尺寸</td>
            <td colspan="4"><u> ${active.store_size} </u> </td>
        </tr>
        <tr>
            <td style="font-weight: bold;">照片/说明</td>
            <td colspan="4">
					<div class="note_area">
							${active.note}
							<div class="clear"></div>
					</div>
			</td>
        </tr>
        <tr>
            <td style="font-weight: bold;">制作材料</td>
            <td colspan="4">${active.store_material }</td>
        </tr>
        <tr>
            <td style="font-weight: bold;">费用承担</td>
            <td colspan="4">${active.assumed }</td>
        </tr>
        
        <tr>
            <td style="font-weight: bold;">办事处经理</td>
            <td colspan="5" height="78" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi" style="width: 180px;">签字：</div>
                <div class="danz_date" style="width: 110px;">日期：</div>
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold;">运营中心总监</td>
            <td colspan="5" height="78" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi" style="width: 180px;">签字:
            	<s:if test="zongjianActive!=null">
								<span class="user_sign"><img src="${zongjianActive.puser_sign}" /></span>
							</s:if>
            	</div>
                <div class="danz_date" style="width: 110px;">日期：${it:formatDate(zongjianActive.biz_time,'yyyy-MM-dd')}</div>
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold;">副总</td>
            <td colspan="5" height="78" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi" style="width: 180px;">签字:
            	<s:if test="fuActive!=null">
								<span class="user_sign"><img src="${fuActive.puser_sign}" /></span>
							</s:if>
            	</div>
                <div class="danz_date" style="width: 110px;">日期：${it:formatDate(fuActive.biz_time,'yyyy-MM-dd')}</div>
            </td>
        </tr>
        <tr>
            <td style="font-weight: bold;">总经理</td>
            <td colspan="5" height="78" valign="top" style="padding:0; position:relative;">
            	<div class="danz_yjian"></div>
            	<div class="danz_qzi" style="width: 180px;">签字： 
            	<s:if test="zongActive!=null">
								<span class="user_sign"><img src="${zongActive.puser_sign}" /></span>
							</s:if>
            	</div>
                <div class="danz_date" style="width: 110px;">日期：${it:formatDate(zongActive.biz_time,'yyyy-MM-dd')}</div>
            </td>
        </tr>
    </table>
</div>
<div class="noprint input-a" style="text-align: center;">
	<input type="button" value="打印本页" onclick="window.print();" />
	<input type="button" value="返回" class="input-gray" onclick="location.href='<s:url action="design_list" namespace="/qkjmanage" />';" />
</div>
</body>
</html>