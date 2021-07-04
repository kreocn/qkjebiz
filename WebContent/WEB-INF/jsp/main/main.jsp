<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>商务管理中心--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<!--right列表-->
<div class="tab_right">
	<div class="tab_warp">
	<p class="dq_step"><a href="">首页</a>&nbsp;&gt;&nbsp;工时申请单列表
		<span class="opb lb op-area"><a href="">添加申请单</a></span>
		<span class="opb lb op-area"><a href="javascript:;" onclick="showCookie(wCo);" style="float: right;">测试dialog</a></span>
	</p>
    <form id="serachForm" name="serachForm" action="/adm/leave_list" method="get">
        <div class="label_main">
            <div class="label_hang">
                <div class="label_ltit">编号:</div>
                <div class="label_rwben"><input type="text" name="leave.uuid" value="" id="serachForm_leave_uuid"/></div>
            </div>
            <div class="label_hang">
                <div class="label_ltit">类型:</div>
                <div class="label_rwben">
                    <select name="leave.leave_type" id="searchLeaveType" title="类型">
                        <option value="">--请选择--</option>
                        <option value="0">出差</option>
                        <option value="1">请假</option>
                        <option value="2">加班</option>
                        <option value="3">换休</option>
                        <option value="4">补签</option>    
                    </select>    
                </div>
            </div>
            <div class="label_hang">
                <div class="label_ltit">查询日期:</div>
                <div class="label_rwben"><input type="text" name="leave.serach_date" class="datepicker" value="" /></div>
            </div>
            <div class="label_hang">
                <div class="label_ltit">申请部门:</div>
                <div class="label_rwben">
                	<input type="text" name="leave.leave_dept_name" value="" readonly="readonly" id="userdept_nameid" title="部门名称"/>
                </div>
            </div>
            <div class="label_hang">
                <div class="label_ltit">申请人:</div>
                <div class="label_rwben">
                    <select name="leave.leave_user" id="membermanagerid" class="selectKick">
                    	<option value="">--请选择--</option>  
    				</select>    
                </div>
            </div>
            <div class="label_hang">
                <div class="label_ltit">补贴状态:</div>
                <div class="label_rwben label_rwb">
                    <select name="leave.allowance_status" id="serachForm_leave_allowance_status">
                        <option value="">--请选择--</option>
                        <option value="0">未补贴</option>
                        <option value="1">已补贴</option>
                        <option value="2">其他</option>
                    </select>
                </div>
            </div>
            <div class="label_hang">
                <div class="label_ltit">业务审核状态:</div>
                <div class="label_rwben label_rwb">
                	<select name="leave.check_status" id="serachForm_leave_check_status">
                        <option value="">--请选择--</option>
                        <option value="0">新申请</option>
                        <option value="5">已退回</option>
                        <option value="10">待审核</option>
                        <option value="20">经理/大区已审</option>
                        <option value="30">运营总监已审</option>
                        <option value="40">业务副总已审</option>
                    </select>
                </div>
            </div>
            <div class="label_hang">
                <div class="label_ltit">人事审核状态:</div>
                <div class="label_rwben label_rwb">
                	<select name="leave.acheck_status" id="serachForm_leave_acheck_status">
                        <option value="">--请选择--</option>
                        <option value="0">未审核/已退回</option>
                        <option value="10">人事经理已审</option>
                        <option value="20">行政副总已审</option>
                        <option value="30">总经理已审</option>
                    </select>
                </div>
            </div>
            <div class="label_hang label_button tac">
                <input type="hidden" id="__checkbox_search_mcondition" name="__checkbox_search_mcondition" value="true" />
    			<input type="checkbox" name="search_mcondition" value="true" checked="checked" id="search_mcondition" class="regular-checkbox"/>
                <label for="search_mcondition"></label>更多条件
                <input type="submit" id="serachForm_0" value="&#25628;&#32034;"/>
     			<input type="reset" value="&#37325;&#32622;"/>    
            </div>
        </div>
    </form>
    <table style="width: 100%;border-collapse:collapse;border-spacing:0;">
        <tr>
            <th><input type="checkbox" /></th>
            <th>编号</th>
            <th class="td1">类型</th>
            <th class="td2">申请部门</th>
            <th class="td2">申请人</th>
            <th class="td3">开始时间</th>
            <th class="td3">结束时间</th>
            <th class="td4">共计(天)</th>
            <th class="td4">事由</th>
            <th class="td5">业务部门意见</th>
            <th class="td5">人事部门意见</th>
            <th>操作</th>
            <th class="td0" style="padding:0;">查看</th>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>1</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-09</td>
            <td class="td4">2.0</td>
            <td class="td4">事假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>2</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
       <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr><tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr><tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" target="_blank">[修改]</a>&nbsp;<a href="#">[打印]</a></td>
            <td class="td0"><a class="detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
        <tr>
            <td><input type="checkbox" name="uuid" /></td>
            <td>3</td>
            <td class="td1">请假</td>
            <td class="td2">特殊部门</td>
            <td class="td2">系统测试员</td>
            <td class="td3">2014-08-07</td>
            <td class="td3">2014-08-08</td>
            <td class="td4">1.0</td>
            <td class="td4">病假</td>
            <td class="td5">业务副总已审</td>
            <td class="td5">人事经理已审</td>
            <td><a href="detail.html" class="btn_css" target="_blank">修改</a>&nbsp;&nbsp;<a href="" class="btn_css">打印</a></td>
            <td class="td0"><a class="btn_css detail" onClick="pubMsgbox('查看详情','90','100','infoDetail');">查看详情</a></td>
        </tr>
    </table>
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>