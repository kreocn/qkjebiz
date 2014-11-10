<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>活动申请单管理--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref" namespace="/manager" executeResult="true" />
<style type="text/css">
.active_icost {padding: 3px 5px;}
.active_icost_left {}
.active_icost_right {}
.active_p_title {
border-bottom: #666 dashed 1px;
text-indent: 2px;
font-weight: bold;
padding-bottom: 5px;
margin-bottom: 5px;
}
.active_p_title_second {
margin-top: 6px;
}
.active_p_list ul {
padding: 0;margin: 0 0 0 5px;list-style: none;
}
.active_p_list li {
line-height: 25px;height: 25px;clear: both;
}
.active_p_list li:hover {
color: #AA0000;
}
.active_p_list span {
display: block;float: left;
}
.active_p_list .p_n {width: 150px;}
.active_p_list .p_p {width: 80px;text-align: center;}
.active_p_list .p_m {width: 80px;text-align: center;}
.active_p_list .p_t {width: 100px;text-align: center;}
.active_p_list .p_x {width: 180px;text-align: left;}
.active_p_list .p_a {float: right;}
.active_p_list .p_x2 {width: 200px;text-align: left;}
.ui-autocomplete {z-index: 200;}
.p_tm {text-indent: 70%;}
#active_remark,#active_remark textarea {
font-size: 14px;
}
.approve_list {}
.approve_ad_time, .approve_check_user, .approve_flag,.approve_advice {
font-weight: bold;
}
.approve_flag_fail {
color: #FF0000;
}
.approve_flag_pass {
color: #008000;
}

</style>
<body>
<div class="main">
	<div class="dq_step">
		<span class="pt">活动申请单</span>
		<span class="opb lb op-area noprint"><a href="<s:url namespace="/qkjmanage" action="active_list"><s:param name="viewFlag">relist</s:param></s:url>">返回列表</a></span>
		<span class="opb lb op-area noprint"><input type="button" onclick="window.print();" value="打印本页"/></span>
	</div>
	<s:form id="editForm" name="editForm" cssClass="validForm" action="apply_list"  method="get" namespace="/qkjmanage" theme="simple">
	<div class="label_con">
		<div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">申请编号:</div>
            <div class="label_rwben">${active.uuid}<s:hidden name="active.uuid" /></div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">原编号:</div>
            <div class="label_rwben">${active.uid }</div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwbenx">${active.apply_dept_name}</div>
        </div>
        <div class="label_hang">
            <div class="label_ltit">申请人员:</div>
            <div class="label_rwben">${active.apply_user_name}</div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">状态:</div>
            <div class="label_rwbenx">
                <div class="zhuangtai">
					申请单状态:
					<s:if test="active.status==-1"><font class="message_error">已作废</font></s:if>
					<s:if test="active.status==0">新申请</s:if>
					<s:if test="active.status==1"><font class="message_warning">申请审批中</font></s:if>
					<s:if test="active.status==2"><font class="message_pass">申请通过-可以执行</font></s:if>
					<s:if test="active.status==3">开始结案</s:if>
					<s:if test="active.status==4"><font class="message_warning">结案审批中</font></s:if>
					<s:if test="active.status==5"><font class="message_pass">结案通过</font></s:if>
				</div>
				<div class="zhuangtai" title="${it:formatDate(active.sd_time,'yyyy-MM-dd HH:mm:ss')}">
					销售部审核:
					<s:if test="active.sd_status==0">新单</s:if>
					<s:if test="active.sd_status==5"><font class="message_error">审核退回</font>(${active.sd_user_name})</s:if>
					<s:if test="active.sd_status==10"><font class="message_warning">待审核</font></s:if>
					<s:if test="active.sd_status==30"><font class="message_pass">经理/大区已审</font>(${active.sd_user_name})</s:if>
					<s:if test="active.sd_status==40">	<font class="message_pass">运营总监已审</font>(${active.sd_user_name})</s:if>
					<s:if test="active.sd_status==50"><font class="message_pass">业务副总已审</font>(${active.sd_user_name})</s:if>
					<s:if test="active.sd_status==60"><font class="message_pass">总经理已审</font>(${active.sd_user_name})</s:if>
				</div>
				<div class="zhuangtai" title="${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')}">
					销管部审核:
					<s:if test="active.smd_status==0">未签收</s:if>
					<s:if test="active.smd_status==5"><font class="message_error">审核退回</font>(${active.smd_user_name})</s:if>
					<s:if test="active.smd_status==10"><font class="message_warning">已签收</font></s:if>
					<s:if test="active.smd_status==30"><font class="message_pass">销管经理已审</font>(${active.smd_user_name})</s:if>
					<s:if test="active.smd_status==40"><font class="message_pass">销管部经理已审</font>(${active.smd_user_name})</s:if>
					<s:if test="active.smd_status==50"><font class="message_pass">销管副总已审</font>(${active.smd_user_name})</s:if>
				</div>
				<s:hidden name="active.status" /><s:hidden name="active.sd_status" /><s:hidden name="active.smd_status" />
            </div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">签字:</div>
            <div class="label_rwbenx">
            <s:iterator value="activeSing" status="sta">
            	<div class="zhuangtai bgcw">
					<s:if test="puser_sign!=null">
						<s:if test="puser_sign==null">	(${puser_name})</s:if>
						<s:else><span class="user_sign"><img src="${puser_sign}" /></span></s:else>
						<span class="vab">${it:formatDate(biz_time,'yyyy-MM-dd HH:mm:ss')}</span>
					</s:if>
				</div>
			</s:iterator>
				
				<%-- <div class="zhuangtai bgcw">
					<s:if test="active.smd_status==30">
						<s:if test="active.smd_user_sign==null">(${active.smd_user_name})</s:if>
						<s:else><span class="user_sign"><img src="${active.smd_user_sign}" /></span></s:else>
						<span class="vab">${it:formatDate(active.smd_time,'yyyy-MM-dd HH:mm:ss')}</span>
					</s:if>
				</div> --%>
            </div>
		</div>
		</div>
		
		<div class="label_main label_main_sep"></div>
		 <div class="label_main">
		 <div class="label_hang label_hang_sign">
		     <div class="label_ltit">财务部:</div>
		     <div class="label_rwbenx label_rwb_sign">(签字/日期)</div>
		 </div>
		 </div>
		
		 <div class="label_main label_main_sep"></div>
		 <div class="label_main">
		 <div class="label_hang label_hang_sign">
		     <div class="label_ltit">销管部经理:</div>
		     <div class="label_rwbenx label_rwb_sign">(签字/日期)
		     <s:if test="guanActive!=null">
		     <span class="user_sign"><img src="${guanActive.puser_sign}" /></span>
		     
		     </s:if>
		     </div>
		 </div>
		 </div>
		
		
		 
		 <div class="label_main label_main_sep"></div>
		 <div class="label_main">
		 <div class="label_hang label_hang_sign">
		     <div class="label_ltit">销管副总:</div>
		     <div class="label_rwbenx label_rwb_sign">(签字/日期)
		     <s:if test="fuActive!=null">
		     <span class="user_sign"><img src="${fuActive.puser_sign}" /></span>
		     </s:if>
		     </div>
		 </div>
		 </div>
		
       <div class="label_main label_main_sep"></div>
		 <div class="label_main">
		 <div class="label_hang label_hang_sign">
		     <div class="label_ltit">总经理:</div>
		     <div class="label_rwbenx label_rwb_sign">(签字/日期)
		     <s:if test="zongActive!=null">
		     <span class="user_sign"><img src="${zongActive.puser_sign}" /></span>
		     </s:if>
		     </div>
		 </div>
		 </div>
        
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">主题:</div>
            <div class="label_rwbenx">${active.theme}</div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">目的:</div>
            <div class="label_rwbenx">${active.purpose}</div>
        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">活动时间:</div>
            <div class="label_rwben2 nw">${it:formatDate(active.plan_start,'yyyy-MM-dd')} - ${it:formatDate(active.plan_end,'yyyy-MM-dd')}</div>
        </div>
         <div class="label_hang">
         	<div class="label_ltit">活动地点:</div>
         	<div class="label_rwben">${active.address}</div>
         </div>
         <div class="label_hang">
         	<div class="label_ltit">执行人:</div>
         	<div class="label_rwben">${active.person}</div>
         </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">活动预期:</div>
            <div class="label_rwbenx">${active.expect}</div>
        </div>
        </div>
        <div class="label_main">
        	<div class="lb_xxsm">
	        	<p class="lb_yjtit fy_hide">预计活动费用</p>
	            <div class="lb_lgsfy">
	            	<p class="lb_yjtit">
	            		公司预计费用
	            		<s:if test="active.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPRODUCT_ADD')">
						<input type="button" id="addProduct" value="添加酒品" />
						</s:if>
						<s:if test="active.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEPOSM_ADD')">
						<input type="button" id="addPosm" value="添加物料" />
						</s:if>
	            	</p>
	                <div class="lb_yjcon">
	                	<p class="lb_gstit">公司提供酒品</p>
	                    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
	                    	<tr>
	                        	<th>品名</th>
	                            <th>单价</th>
	                            <th>数量(瓶)</th>
	                            <th>合计</th>
	                        </tr>
	                        <s:iterator value="activeProducts" status="sta">
							<tr>
							<td class="nw">${product_name}</td>
							<td class="nw">￥${per_price}</td>
							<td class="nw">${num}</td>
							<td class="nw">￥${total_price}</td>
							</tr>
							</s:iterator>
	                    </table>
	                    <p class="lb_gstit">公司销售物料(除酒品之外的其他费用,全部算物料)</p>
	                    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
	                    	<tr>
							<th>名目</th>
							<th>名目说明</th>
							<th>金额</th>
							</tr>
							<s:iterator value="activePosms" status="sta">
							<tr>
							<td>${title}</td>
							<td>${note}</td>
							<td class="nw">￥${total_price}</td>
							</tr>
							</s:iterator>
	                    </table>
	                	<p class="lb_gstit">公司预计费用合计</p>
	                    <p class="lb_jwei">￥${active.it_price}</p>
	                </div>
	            </div>
	            <div class="lb_gsfy">
	            	<p class="lb_yjtit">
	            	参与客户&预计费用
	            	<s:if test="active.status==0 && @org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_ACTIVEMEMCOST_ADD')">
					<input type="button" id="addMember" value="添加客户" />
					</s:if>
	            	</p>
	                <div class="lb_yjcon">
	                	<p class="lb_gstit">参与活动客户</p>
	                    <table width="100%" cellpadding="0" cellspacing="0" border="0" class="lb_jpin">
	                    	<tr>
							<th>客户</th>
							<th>名目</th>
							<th>名目说明</th>
							<th>金额</th>
							</tr>
							<s:iterator value="activeMemcosts" status="sta">
							<tr>
							<td><a href="javascript:;" onclick="loadMemberInfo('${member_id}');">${member_name}</a></td>
							<td>${title}</td>
							<td>${note}</td>
							<td class="nw">￥${total_price}</td>
							</tr>
							</s:iterator>
	                    </table>
	                	<p class="lb_gstit">客户预计费用合计</p>
	                    <p class="lb_jwei">￥${active.mt_price}</p>
	                </div>
	            </div>
	            <div class="clear"></div>
	            <p class="lb_yjbot">方案预计费用总计: ${active.it_price} + ${active.mt_price} = ￥${active.it_price+active.mt_price}</p>
	        </div>
        </div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">方案说明:</div>
            <div class="label_rwbenx">
            </div>
        </div>
        </div>
        <div class="label_main">${active.note}</div>
        <div class="label_main">
        <div class="label_hang">
            <div class="label_ltit">备注:</div>
            <div class="label_rwbenx textBreak label_hang_linput">${active.remark}</div>
        </div>
        </div>
		<div class="label_main noprint">
        <div class="label_hang">
            <div class="label_ltit">相关操作:</div>
            <div class="label_rwbenx">
				<input type="button" onclick="window.print();" value="打印本页"/>
            </div>
        </div>
        </div>
	</div>
	</s:form>
</div>
</body>
</html>