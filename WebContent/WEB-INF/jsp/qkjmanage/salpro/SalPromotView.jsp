<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>促销活动管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>

	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
		<s:if test="salstate!=1">
			${path} 
			<span class="opb lb op-area"> <s:if test="'view' != viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SALPRO_SALPROMOT')"><a
				href="<s:url action="salPromot_list" namespace="/salpro"></s:url>">促销活动列表</a></s:if>
			</span>
			</s:if>
		</div>
		<!-- 页面修改 -->
		<s:form id="editForm" name="editForm" cssClass="validForm"
			action="salPromot_add" namespace="/salpro" method="post" theme="simple">
			<div class="label_con">
				<s:if test="null != salPromot">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">编号:</div>
							<div class="label_rwb">
								${salPromot.uuid }								
							</div>
						</div>
						<s:if test="salstate!=1">
						<div class="label_hang">
							<div class="label_ltit">活动状态:</div>
							<div class="label_rwb">
								<s:if test="%{salPromot.status==0}">新申请</s:if>	
								<s:if test="%{salPromot.status==1}">审核中</s:if>	
								<s:if test="%{salPromot.status==2}">审核通过</s:if>								
							</div>
						</div>
						
						<div class="label_hang">
							<div class="label_ltit">审核状态:</div>
							<div class="label_rwbenx">
								<div class="zhuangtai">
									<s:if test="salPromot.smd_status==0 && salPromot.sd_status==0">待审核</s:if>
								<s:if test="salPromot.smd_status==5">
								<span class="message_error" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">销管已退回(${salPromot.smd_name })
								</span>
								</s:if>
								<s:if test="salPromot.smd_status==20">
								<span class="message_pass" title="${it:formatDate(salPromot.smd_time,'yyyy-MM-dd HH:mm:ss')}">经理/大区已审(${salPromot.smd_name })</span>
								</s:if>
								<s:if test="salPromot.sd_status==5">
								<span class="message_error" title="${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已退回(${salPromot.sd_name })</span>
								</s:if>
								<s:if test="salPromot.sd_status==30">
								<span class="message_pass" title="${it:formatDate(salPromot.sd_time,'yyyy-MM-dd HH:mm:ss')}">运营总监已审(${salPromot.sd_name })</span>
								</s:if>	
								</div>
															
							</div>
						</div>
						</s:if>
					</div>
				</s:if>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">主题:</div>
						<div class="label_rwben">
						${salPromot.sal_title }	
						</div>
					</div>
					<s:if test="salstate!=1">
					<div class="label_hang">
			            <div class="label_ltit">活动时间:</div>
			            <div class="label_rwbenx">
			            	${it:formatDate(salPromot.startime,'yyyy-MM-dd')}&nbsp;至&nbsp;${it:formatDate(salPromot.endtime,'yyyy-MM-dd')}
			            </div>
			        </div>
			        </s:if>
			        <div class="label_hang">
						<div class="label_ltit">返利系数:</div>
						<div class="label_rwben">
						${salPromot.rebate }	
						</div>
					</div>
					
					<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">范围:</div>
						${salPromot.sal_scopDept_name }
					</div>
				</div>
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">范围说明:</div>
						<div class="label_rwben">
						${salPromot.sal_scop }
						</div>
					</div>
				</div>
				
				<div class="label_hang">
							<div class="label_ltit">许可范围:</div>
							<div class="label_rwben label_rwb">
								<span class="label_rwb">
								 <s:select id="sal_scopUs" name="salPromot.sal_scopUs" cssClass="selectKick" list="#{1:'公有',2:'私有'}" headerKey="" headerValue="--请选择--"  onchange="pub();"/>
								</span>
							</div>
				</div>
				
				</div>
				<s:if test="salstate!=1">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">申请人:</div>
						<div class="label_rwben">
						${salPromot.add_user_name }	
						</div>
					</div>
					<div class="label_hang">
			            <div class="label_ltit">申请时间:</div>
			            <div class="label_rwbenx">
			            	${it:formatDate(salPromot.add_time,'yyyy-MM-dd hh:mm:ss')}
			            </div>
			        </div>
					
				</div>
				</s:if>
				<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">促销方案:</div>
		            <div class="label_rwbenx">
		            </div>
		        </div>
		        </div>
		        <div class="label_main">
		        	<div class="note_area">
						${salPromot.sal_plan}
						<div class="clear"></div>
		        	</div>
		        </div>
				<s:if test="salstate!=1">
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<span id="message"><s:property value="message" /></span>
							<span class="opb lb op-area noprint"><input type="button" onclick="window.print();" value="打印本页"/>&nbsp;</span>
							<input type="button" class="input-gray" value="返回"
								onclick="linkurl('<s:url action="salPromot_list" namespace="/salpro"></s:url>');" />
						</div>
					</div>
				</div>
				</s:if>
			</div>
		</s:form>
	</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
<script type="text/javascript">
$("#sendee").click(function() {
	sendeeForm();
});
$("#delsend").click(function() {
	var ru=$("#r_uuid").val();
	var a = ru.substring(0,ru.lastIndexOf(";"));
	var b=a.substring(0,a.lastIndexOf(";"))+";";
	if(b==";"){
		$("#r_uuid").val(null);
	}else{
		$("#r_uuid").val(b);
	}
	
	
});

function sendeeForm() {
	//接收人
	var ruid=$("#r_uuid").val();
	//接收人的下拉
	var  rl=$("#membermanagerid").val();
	var type = document.getElementById("membermanagerid");
	var rlname=type[type.selectedIndex].text;
	var  depat=$("#userdept_codeid").val();
	var depname=$("#userdept_nameid").val();
	if(rl==null||rl==""){
		$("#r_uuid").val(ruid+depname+" "+depat+";");
	}else{
		$("#r_uuid").val(ruid+rlname+" "+rl+";");
	}
	
}
</script>
</html>