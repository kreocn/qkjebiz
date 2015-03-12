<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动申请单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />

</head>
<style type="text/css">
.ship_info {
cursor: pointer;
}
</style>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<!--right列表-->
<div class="tab_right">
<div class="tab_warp main" >
 	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_ADD')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="active_load"><s:param name="viewFlag">add</s:param></s:url>">添加申请单</a></span>
		</s:if>
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_REINFORCE')">
			<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="active_reinforce"></s:url>">补充数据</a></span>
		</s:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="active_list"  method="get" namespace="/qkjmanage" theme="simple">
 	<div class="label_con">
 	<div class="label_main">
 		<div class="label_hang">
            <div class="label_ltit">快速查询:</div>
           <div class="label_rwben2" style="size: 30%">
            	<s:select id="sselect" onchange="kselect();" name="sselect"  cssClass="selectKick" headerKey="" headerValue="-----请选择-----" list="#{0:'(申)大区经理待审',1:'(申)销管经理待审',
            	2:'(申)运营总监待审',12:'(申)青藏-运营总监待审',13:'(申)新疆-运营总监待审',14:'(申)西北-运营总监待审',
            	3:'(申)西北-销管部经理待审',4:'(申)西北-业务副总待审',5:'(申)西北-销管副总待审',
            	8:'(申)总经理待审',9:'(申)西北-财务待审',10:'(申)省外-财务待审',11:'(申)北京-财务待审',15:'(申)西藏-财务待审',
            	21:'(结)大区经理待审',22:'(结)销管经理待审',23:'(结)运营总监待审',33:'(结)青藏-运营总监待审',34:'(结)新疆-运营总监待审',35:'(结)西北-运营总监待审',
            	24:'(结)西北-销管部经理待审',25:'(结)西北-业务副总待审',26:'(结)西北-销管副总待审',
            	29:'(结)总经理待审',30:'(结)西北-财务待审',31:'(结)省外-财务待审',32:'(结)北京-财务待审',36:'(结)西藏-财务待审'
            	}" />
            </div>
        </div>
        
 		<div class="label_hang">
            <div class="label_ltit">数字编号:</div>
            <div class="label_rwben"><s:textfield name="active.uuid" title="数字编号" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">主题(%):</div>
            <div class="label_rwben"><s:textfield name="active.theme" title="主题" /></div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">客户名称:</div>
            <div class="label_rwben"><s:textfield id="order_user_id" name="active.member_id"/></div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben2">
            	<span class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="active.apply_dept_name" readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="active.apply_dept" readonly="true" />
				</span>
				<span class="lb nw">
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
				<s:checkbox id="apply_is_sub_dept" name="active.is_sub_dept" cssClass="regular-checkbox" />
				<label for="apply_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
				</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="active.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
            </div>
		</div>
		<div class="label_hang">
            <div class="label_ltit">活动状态:</div>
            <div class="label_rwben label_rwb"><s:select id="status" name="active.status" cssClass="selectKick" headerKey="" headerValue="-活动状态-" list="#{0:'新申请',1:'申请审批中',2:'申请通过',3:'开始结案',4:'结案审批中',5:'结案通过'}" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(申)销售状态:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="sd_status" name="active.sd_status" cssClass="selectKick" list="#{0:'新单',5:'退回',10:'待审核',30:'大区已审',40:'总监已审',50:'副总已审',60:'总经理已审'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(申)销管状态:</div>
            <div class="label_rwben label_rwb"><s:select id="smd_sta" name="active.smd_status" cssClass="selectKick"
				 list="#{0:'新单/未签收',5:'退回',10:'已签收',30:'销管经理已审',40:'销管部经理已审',50:'销管副总已审'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(申)财务状态:</div>
            <div class="label_rwben label_rwb"><s:select id="fdsta" name="active.fd_status" cssClass="selectKick"
				 list="#{0:'未确认',5:'退回',10:'已通过'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(结)销售状态:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="clsdsta" name="active.close_sd_status" cssClass="selectKick"
				 list="#{0:'新单',5:'退回',10:'待审核',30:'大区已审',40:'总监已审',50:'副总已审',60:'总经理已审'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(结)销管状态:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="clsmdsta" name="active.close_smd_status" cssClass="selectKick"
				 list="#{0:'新单/未签收',5:'退回',10:'已签收',30:'销管经理已审',40:'销管部经理已审',50:'销管副总已审'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(结)财务状态:</div>
            <div class="label_rwben label_rwb"><s:select id="clfd" name="active.close_fd_status" cssClass="selectKick"
				 list="#{0:'未确认',5:'退回',10:'已通过'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">(结)数据中心:</div>
            <div class="label_rwben label_rwb"><s:select name="active.close_nd_status" cssClass="selectKick"
				 list="#{0:'未确认',5:'退回',10:'已通过'}"
				 headerKey="" headerValue="--请选择--" />
            </div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben label_rwb">
            	<s:select name="active.ship_status"  cssClass="selectKick" headerKey="" headerValue="-发货状态-" list="#{0:'未发货',10:'已发货',99:'其他' }" />
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请通过时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="datepicker iI iI-f" type="text" name="active.pass_time_start" title="从" value="${it:formatDate(active.pass_time_start,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="datepicker iI iI-t" type="text" name="active.pass_time_end" title="到" value="${it:formatDate(active.pass_time_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">结案通过时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="datepicker iI iI-f" type="text" name="active.close_pass_time_start" title="从" value="${it:formatDate(active.close_pass_time_start,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="datepicker iI iI-t" type="text" name="active.close_pass_time_end" title="到" value="${it:formatDate(active.close_pass_time_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">计划开始时间:</div>
            <div class="label_rwben2">
            	<span class="label_rwb nw">
				<input  class="datepicker iI iI-f" type="text" name="active.plan_start_begin" title="从" value="${it:formatDate(active.plan_start_begin,'yyyy-MM-dd')}" />
				</span>
				<span class="label_rwb nw">
				<input  class="datepicker iI iI-t" type="text" name="active.plan_start_end" title="到" value="${it:formatDate(active.plan_start_end,'yyyy-MM-dd')}" />
            	</span>
            </div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">sp:</div>
            <div class="label_rwben label_rwb">
            	<s:select name="flag"  cssClass="selectKick" headerKey="" headerValue="--请选择--" list="#{0:'有',10:'无'}" />
            </div>
        </div>
        
        <div class="label_hang label_button tac">
        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
			<label for="search_mcondition"></label>更多条件
            <s:submit value="搜索" /> <s:reset value="重置" />
        </div>
    </div>
 	</div>
 	</s:form>
 	<div class="tab_warp">
 		<table>
 		<tr id="coltr">
	    <th class="td1">编号</th>
		<th class="td2">申请部门</th>
		<th class="td1">申请人</th>
		<th class="td5">主题</th>
		<th class="td2">费用合计</th>
		<th class="td5">活动地点</th>
		<th class="td1">活动状态</th>
		<th class="td3">销售状态</th>
		<th class="td3">销管状态</th>
		<th class="td5">FA</th>
		<th class="td5">FC</th>
		<th class="td3">SP</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="actives" status="sta">
	  	<tr id="showtr${uuid}">
		    <td class="td1 nw">${uuid}</td>
			<td class="td2 nw">${apply_dept_name}</td>
			<td class="td1 nw">${apply_user_name}</td>
			<td class="td5 longnote" title="${theme}">${it:subString(theme,18)}</td>
			<td class="td2 nw">(申)${it_price+mt_price}
			<s:if test="status > 2">
			(结)${close_it_price+close_mt_price}
			</s:if>
			</td>
			<td class="td5 nw" title="${address}">${it:subString(address,6)}</td>
			<td  class="td1">
				<s:if test="status==-1"><font class="message_error">已作废</font></s:if>
				<s:if test="status==0">新申请</s:if>
				<s:if test="status==1"><font class="message_warning">申请审批中</font></s:if>
				<s:if test="status==2"><font class="message_pass" title="${it:formatDate(pass_time,'yyyy-MM-dd HH:mm:ss')}">申请通过</font></s:if>
				<s:if test="status==3">开始结案</s:if>
				<s:if test="status==4"><font class="message_warning">结案审批中</font></s:if>
				<s:if test="status==5"><font class="message_pass" title="${it:formatDate(close_pass_time,'yyyy-MM-dd HH:mm:ss')}">结案通过</font></s:if>
				<s:if test="status==5">
				<span class="op-area">
				<s:if test="ship_status==0"><a class="ship_info input-nostyle"  data="${uuid}">未发货</a></s:if>
				<s:if test="ship_status==10"><a class="ship_info input-nostyle"  data="${uuid}"><span class="message_pass">已发货</span></a></s:if>
				</span>
				<span class="ship_hidden_info" style="display:none;">
					<span id="ship_no_${uuid}">${ship_no}</span>
					<span id="ship_type_${uuid}">${ship_type}</span>
					<span id="ship_date_${uuid}">${it:formatDate(ship_date,"yyyy-MM-dd")}</span>
					<span id="ship_phone_${uuid}">${ship_phone}</span>
					<span id="ship_status_${uuid}">${ship_status}</span>
					<span id="active_remark_${uuid}">${remark}</span>
				</span>
				</s:if>
			</td>
			<td  class="td3">
				<s:if test="status<=2">
					<s:if test="sd_status==0">新单</s:if>
					<s:if test="sd_status==5"><font class="message_error" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
					<s:if test="sd_status==10"><font class="message_warning">待审核</font></s:if>
					<s:if test="sd_status==30"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">大区已审</font></s:if>
					<s:if test="sd_status==40"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">总监已审</font></s:if>
					<s:if test="sd_status==50"><font class="message_pass" title="${sd_user_name} ${it:formatDate(sd_time,'yyyy-MM-dd HH:mm:ss')}">副总已审</font></s:if>
					
				</s:if>
				<s:if test="status>2">
				<s:if test="close_sd_status==0">新单</s:if>
				<s:if test="close_sd_status==5"><font class="message_error" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
				<s:if test="close_sd_status==10"><font class="message_warning">待审核</font></s:if>
				<s:if test="close_sd_status==30"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">大区已审</font></s:if>
				<s:if test="close_sd_status==40"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">总监已审</font></s:if>
				<s:if test="close_sd_status==50"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">副总已审</font></s:if>
				<s:if test="close_sd_status==60"><font class="message_pass" title="${close_sd_user_name} ${it:formatDate(close_sd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审</font></s:if>
				</s:if>
			</td>
			<td  class="td3">
				<s:if test="status<=2">
					<s:if test="smd_status==0">未签收</s:if>
					<s:if test="smd_status==5"><font class="message_error" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
					<s:if test="smd_status==10"><font class="message_warning">已签收</font></s:if>
					<s:if test="smd_status==30"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审</font></s:if>
					<s:if test="smd_status==40"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">销管部经理已审</font></s:if>
					<s:if test="smd_status==50"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审</font></s:if>
					<s:if test="smd_status==60"><font class="message_pass" title="${smd_user_name} ${it:formatDate(smd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审</font></s:if>
				</s:if>
				<s:if test="status>2">
				<span class="span_label">
					<s:if test="close_smd_status==0">新单</s:if>
					<s:if test="close_smd_status==5"><font class="message_error" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">审核退回</font></s:if>
					<s:if test="close_smd_status==10"><font class="message_warning">已签收</font></s:if>
					<s:if test="close_smd_status==30"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">销管经理已审</font></s:if>
					<s:if test="close_smd_status==40"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">销管部经理已审</font></s:if>
					<s:if test="close_smd_status==50"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">销管副总已审</font></s:if>
					<s:if test="close_smd_status==60"><font class="message_pass" title="${close_smd_user_name} ${it:formatDate(close_smd_time,'yyyy-MM-dd HH:mm:ss')}">总经理已审</font></s:if>
				</span>
				</s:if>
			</td>
			<td class="td5">
			<s:if test="%{fd_status==10}"><!-- 已审 -->
			<a href="javascript:;"  data="${uuid}" class="success"></a>
			<span id="leave_cause${uuid}" style="display:none;" class="leave_cause_shows">
				操作人:${fd_user_name}<br/> 操作时间：${it:formatDate(fd_time,'yyyy-MM-dd hh:mm:ss')}
			</span>
			
			</s:if>
			<s:elseif test="%{fd_status==5}"><a href="javascript:;"  data="${uuid}"  class="nosuc"></a>
			<span id="leave_cause${uuid}" style="display:none;" class="leave_cause_shows">
				操作人:${fd_user_name}<br/> 操作时间：${it:formatDate(fd_time,'yyyy-MM-dd hh:mm:ss')}
			</span>
			</s:elseif>
			<s:else>
			<a  class="daisuc"></a>
			</s:else>
			</td>
			<td class="td3">
			<s:if test="%{close_fd_status==10}"><!-- 已审 -->
			<a href="javascript:;"  data="${uuid}" class="success"></a>
			<span id="leave_cause${uuid}" style="display:none;" class="leave_cause_shows">
				操作人:${close_fd_name}<br/> 操作时间：${it:formatDate(close_fd_time,'yyyy-MM-dd hh:mm:ss')}
			</span>
			</s:if>
			<s:elseif test="%{close_fd_status==5}"><a  class="nosuc"></a></s:elseif>
			<s:else>
			<a href="javascript:;"  data="${uuid}" class="daisuc"></a>
			<span id="leave_cause${uuid}" style="display:none;" class="leave_cause_shows">
				操作人:${close_fd_name}<br/> 操作时间：${it:formatDate(close_fd_time,'yyyy-MM-dd hh:mm:ss')}
			</span>
			</s:else>
			</td>
			
			<td class="td5">
			<s:if test="%{spe_remark!=null && spe_remark!=''}">
			<a  class="nonull"></a>
			</s:if>
			<s:else>
			<a  class="yesnull"></a>
			</s:else>
			</td>
			<td class="td4 op-area nw">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_APPLY')">
		    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="active_load"><s:param name="viewFlag">mdy</s:param><s:param name="active.uuid" value="uuid"></s:param></s:url>">申请修改</a>
		    	</s:if>
		    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVECLOSE')">
		    	<s:if test="status == 2">
		    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="uuid"></s:param></s:url>">开始结案</a>
		    	</s:if>
		    	<s:if test="status > 2">
		    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="active_closeLoad"><s:param name="active.uuid" value="uuid"></s:param></s:url>">结案修改</a>
		    	</s:if>
		    	</s:if>
		    	<s:if test="status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_DEL')">
		    	<a class="input-red" href="<s:url namespace="/qkjmanage" action="active_del"><s:param name="active.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
		    	</s:if>	   
		    </td>
		    <td class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	  	</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div id="listpage" class="pagination"></div>
</div>
</div>
 <!-- HIDDEN AREA BEGIN -->
 <div id="mdyActiveShipInfoForm" class="label_con idialog" title="修改发货信息">
<s:form name="form_mdyActiveShipInfoForm" action="mdyActiveShipInfo" namespace="/qkjmanage" method="post" theme="simple">
	<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">发货状态:</div>
            <div class="label_rwben"><s:select id="e_active_ship_status" name="active.ship_status" list="#{0:'未发货',10:'已发货',99:'其他' }" /></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">出库日期:</div>
            <div class="label_rwben"><input id="e_active_ship_date" class="datepicker validate[custom[date]]" type="text" name="active.ship_date" title="出库日期" value="${it:formatDate(active.ship_date,'yyyy-MM-dd')}" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">运单号:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_no" cssClass="validate[maxSize[48]]" name="active.ship_no" title="运单号码" /></div>
        </div>
		<div class="label_hang">
            <div class="label_ltit">物流名称:</div>
            <div class="label_rwben"><s:textfield id="e_active_ship_type" name="active.ship_type" cssClass="validate[maxSize[32]]" title="物流类型/名称" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">物流电话:</div>
            <div class="label_rwben"><s:textfield id="e_ship_phone" name="active.ship_phone"  cssClass="validate[maxSize[48]]" title="物流电话" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">备注:</div>
            <div class="label_rwben"><s:textarea id="e_active_remark" name="active.remark" cssClass="validate[maxSize[65535]]" title="备注" cols="3" rows="4" /></div>
        </div>
        <div class="label_hang label_button tac">
           	<s:hidden id="e_active_uuid" name="active.uuid" value="%{active.uuid}" />
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVE_MDYSHIPINFO')">
			<s:submit id="mdyActiveShipInfo" name="mdyActiveShipInfo" value="确定" action="mdyActiveShipInfo" />
			</s:if>
        </div>
    </div>
</s:form>
</div>
<!-- HIDDEN AREA END -->
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript" src="<s:url value="/js/jqueryPlugins/select3/jquery.cityselect.js" />"></script>
<script type="text/javascript">
$(function(){
	$("#mmtype").citySelect({
		url:'<s:url value="/js/jqueryPlugins/select3/mm.js" />',
		prov:"${assets.typea}",
		city:"${assets.typeb}",
		dist:" ${assets.typec}",
		nodata:"none",
		required:false
	});
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
 });
$(".success").tooltip({
	items: "[data]",
	content: function() {
		return "<div class='show_dialog'>" + $("#leave_cause" + $(this).attr("data")).html() + "</div>";
  }
});
$(".nosuc").tooltip({
	items: "[data]",
	content: function() {
		return "<div class='show_dialog'>" + $("#leave_cause" + $(this).attr("data")).html() + "</div>";
  }
});
//var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_apply_dept = '${active.apply_dept}';
//var curr_apply_user = '${active.apply_user}';
$(function(){
	if(curr_apply_dept!='') {
		loadManagers(curr_apply_dept,'${active.apply_user}');
	}
	if($(".ship_info").length>0) {
		$(".ship_info").bind("click",function(){
			setShipVal($(this).attr("data"));
			$("#mdyActiveShipInfoForm").dialog("open");
		});
	}
	$("#mdyActiveShipInfoForm").dialog({
	      autoOpen: false,
	      modal: true
	});
 });
 
function setShipVal(p_uuid) {
	$("#e_active_uuid").val(p_uuid);
	$("#e_active_ship_phone").val($("#ship_phone_"+p_uuid).text());
	$("#e_active_ship_type").val($("#ship_type_"+p_uuid).text());
	$("#e_active_ship_no").val($("#ship_no_"+p_uuid).text());
	$("#e_active_ship_date").val($("#ship_date_"+p_uuid).text());
	$("#e_active_ship_status").val($("#ship_status_"+p_uuid).text());
	$("#e_active_remark").text($("#active_remark_"+p_uuid).text());
}

function jnull(){
	document.getElementById("clsmdsta").options[0].selected = true; 
	document.getElementById("clsdsta").options[0].selected = true;
	document.getElementById("clfd").options[0].selected = true;
	document.getElementById("membermanagerid").options[0].selected = true;
	$("#userdept_codeid").val("");
	$("#userdept_nameid").val("");
	document.getElementById("apply_is_sub_dept").checked=false;
	document.getElementById("status").options[2].selected = true;
}
function snull(){
	document.getElementById("sd_status").options[0].selected = true; 
	document.getElementById("smd_sta").options[0].selected = true;
	document.getElementById("fdsta").options[0].selected = true;
	document.getElementById("membermanagerid").options[0].selected = true;
	$("#userdept_codeid").val("");
	$("#userdept_nameid").val("");
	document.getElementById("apply_is_sub_dept").checked=false;
	document.getElementById("status").options[5].selected = true;
}
function kselect(){
	var num=$("#sselect").val();
	if(parseInt(num)==0){//(申)大区经理待审
		jnull();
		document.getElementById("sd_status").options[3].selected = true; 
		document.getElementById("smd_sta").options[0].selected = true;
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==1){//(申)销管经理待审
		jnull();
		document.getElementById("smd_sta").options[3].selected = true; 
		document.getElementById("sd_status").options[4].selected = true;
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==2){//总监
		jnull();
		document.getElementById("sd_status").options[4].selected = true; 
		document.getElementById("smd_sta").options[4].selected = true;
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==3){//销管部经理待审西北
		jnull();
		document.getElementById("smd_sta").options[4].selected = true; 
		document.getElementById("sd_status").options[5].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
		
	}
	if(parseInt(num)==4){//西北业务副总
		jnull();
		document.getElementById("sd_status").options[5].selected = true; 
		document.getElementById("smd_sta").options[0].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==5){//西北销管副总
		jnull();
		document.getElementById("smd_sta").options[5].selected = true; 
		document.getElementById("sd_status").options[0].selected = true; 
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	
	if(parseInt(num)==8){//总经理
		jnull();
		document.getElementById("sd_status").options[0].selected = true; 
		document.getElementById("smd_sta").options[6].selected = true; 
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==9){//西北财
		jnull();
		document.getElementById("sd_status").options[0].selected = true; 
		document.getElementById("smd_sta").options[6].selected = true; 
		document.getElementById("fdsta").options[1].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==10){//省外财
		jnull();
		document.getElementById("sd_status").options[5].selected = true; 
		document.getElementById("smd_sta").options[0].selected = true; 
		document.getElementById("fdsta").options[1].selected = true;
		$("#userdept_codeid").val("211");
		$("#userdept_nameid").val("省外运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==11){//北京财
		jnull();
		document.getElementById("sd_status").options[5].selected = true; 
		document.getElementById("smd_sta").options[0].selected = true; 
		document.getElementById("fdsta").options[1].selected = true; 
		$("#userdept_codeid").val("210");
		$("#userdept_nameid").val("北京销售公司");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==15){//西藏财务(申)
		jnull();
		document.getElementById("sd_status").options[0].selected = true; 
		document.getElementById("smd_sta").options[6].selected = true; 
		document.getElementById("fdsta").options[1].selected = true;
		$("#userdept_codeid").val("230");
		$("#userdept_nameid").val("青藏运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==12){//青藏总监
		jnull();
		document.getElementById("sd_status").options[4].selected = true; 
		document.getElementById("smd_sta").options[4].selected = true;
		$("#userdept_codeid").val("2302");
		$("#userdept_nameid").val("西藏大区");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	
	if(parseInt(num)==13){//新疆总监
		jnull();
		document.getElementById("sd_status").options[4].selected = true; 
		document.getElementById("smd_sta").options[4].selected = true;
		$("#userdept_codeid").val("22030");
		$("#userdept_nameid").val("新疆办事处");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==14){//西北总监
		jnull();
		document.getElementById("sd_status").options[4].selected = true; 
		document.getElementById("smd_sta").options[4].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==21){//(结)大区经理待审
		snull();
		document.getElementById("clsdsta").options[3].selected = true; 
		document.getElementById("clsmdsta").options[0].selected = true;
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==22){//(申)销管经理待审
		snull();
		document.getElementById("clsmdsta").options[3].selected = true; 
		document.getElementById("clsdsta").options[4].selected = true;
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==23){//
		snull();
		document.getElementById("clsdsta").options[4].selected = true; 
		document.getElementById("clsmdsta").options[4].selected = true;
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==24){//销管部经理待审西北
		snull();
		document.getElementById("clsmdsta").options[4].selected = true; 
		document.getElementById("clsdsta").options[5].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
		
	}
	if(parseInt(num)==25){//西北业务副总
		snull();
		document.getElementById("clsdsta").options[5].selected = true; 
		document.getElementById("clsmdsta").options[0].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==26){//西北销管副总
		snull();
		document.getElementById("clsmdsta").options[5].selected = true; 
		document.getElementById("clsdsta").options[0].selected = true; 
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	
	if(parseInt(num)==29){//总经理
		snull();
		document.getElementById("clsdsta").options[0].selected = true; 
		document.getElementById("clsmdsta").options[6].selected = true; 
		$("#userdept_codeid").val("");
		$("#userdept_nameid").val("");
		document.getElementById("apply_is_sub_dept").checked=false;
	}
	if(parseInt(num)==30){//西北财
		snull();
		document.getElementById("clsdsta").options[0].selected = true; 
		document.getElementById("clsmdsta").options[6].selected = true; 
		document.getElementById("clfd").options[1].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==31){//省外财
		snull();
		document.getElementById("clsdsta").options[5].selected = true; 
		document.getElementById("clsmdsta").options[0].selected = true; 
		document.getElementById("clfd").options[1].selected = true;
		$("#userdept_codeid").val("211");
		$("#userdept_nameid").val("省外运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==32){//北京财
		snull();
		document.getElementById("clsdsta").options[5].selected = true; 
		document.getElementById("clsmdsta").options[0].selected = true; 
		document.getElementById("clfd").options[1].selected = true; 
		$("#userdept_codeid").val("210");
		$("#userdept_nameid").val("北京销售公司");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==33){//
		snull();
		document.getElementById("clsdsta").options[4].selected = true; 
		document.getElementById("clsmdsta").options[4].selected = true;
		$("#userdept_codeid").val("2302");
		$("#userdept_nameid").val("西藏大区");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==34){//
		snull();
		document.getElementById("clsdsta").options[4].selected = true; 
		document.getElementById("clsmdsta").options[4].selected = true;
		$("#userdept_codeid").val("22030");
		$("#userdept_nameid").val("新疆办事处");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==35){//
		snull();
		document.getElementById("clsdsta").options[4].selected = true; 
		document.getElementById("clsmdsta").options[4].selected = true;
		$("#userdept_codeid").val("220");
		$("#userdept_nameid").val("西北运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	if(parseInt(num)==36){//西藏 财务待审
		snull();
		document.getElementById("clsdsta").options[0].selected = true; 
		document.getElementById("clsmdsta").options[6].selected = true; 
		document.getElementById("clfd").options[1].selected = true;
		$("#userdept_codeid").val("230");
		$("#userdept_nameid").val("青藏运营中心");
		document.getElementById("apply_is_sub_dept").checked=true;
	}
	
	 document.getElementById("serachForm").action="/qkjmanage/active_list";
	 document.getElementById("serachForm").submit();
}
$(function() {
	SimpleLoadMember(ajax_url,function(event, ui) {loadAddress(ui.item.order_user_id);});
	CommonUtil.pickrow('fd_list_table');
});
function loadAddress(memberid) {
	var ajax = new Common_Ajax();
	ajax.config.action_url = ajax_url;
	ajax.sendAjax();
}
</script>
</body>
</html>