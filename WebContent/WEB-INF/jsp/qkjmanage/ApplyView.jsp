<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>至事由申请管理--<s:text name="APP_NAME" /></title>
</head>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="stylesheet" href="<s:url value="/css/print.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<style type="text/css">
.apply_print .apply_print * {
	letter-spacing: 1px;
}

.apply_print {
	border-top: #000 solid 1px; padding-top: 8px;
}

.apply_t {
	font-size: 18px; margin: 8px 5px; /*font-weight: bold;*/
}

.apply_hr {
	margin: 15px 5px; height: 3px; background-color: #000;
}

.apply_h {
	padding-bottom: 50px;
}

.apply_n {
	font-size: 16px; margin: 8px 5px; text-indent: 28px; line-height: 30px;
}

.apply_n * {
	font-size: 16px;
}

.check_note {
	margin: 8px 5px; border: #666 solid 1px; clear: both;
}

.check_user {
	text-align: right; margin: 8px; border-top: #000 dashed 1px; padding: 10px 30px; font-size: 16px;
}

.check_user .uname {
	font-size: 24px; font-weight: bold;
}
</style>
<body>

	<s:action name="nav" namespace="/manage" executeResult="true" />
	<div class="tab_right">
	
	<div class="tab_warp main noprint" >
 	<div class="dq_step">
		<a href="<s:url namespace="/qkjmanage" action="apply_list"></s:url>">返回列表</a>
		<a href="<s:url namespace="/qkjmanage" action="apply_load"><s:param name="viewFlag">mdy</s:param><s:param name="apply.uuid" value="%{apply.uuid}"></s:param></s:url>">返回修改页面</a>
	</div>
	</div>
		<div class="tab_warp main printarea">
			<div id="result">
				<div class="itablemdy">
					<div class="noprint tac">
						<input type="button" onclick="window.print();" value="打印本页" />
					</div>
					<div class="apply_print">
						<div style="float: right;">编号：${apply.uuid }</div>
						<div class="apply_t apply_z">至：${apply.touser}</div>
						<div class="apply_t apply_s">事：${apply.title} ${it:formatDate(apply.apply_time,'yyyy-MM-dd')}</div>
						<s:if test="apply.is_fullcheck==1">
							<div class="apply_t apply_h">会审：${apply.fullcheck_text}</div>
						</s:if>
						<div class="apply_t apply_y">由：${apply.apply_dept_name } ${apply.apply_user_name}</div>
						<div class="apply_hr"></div>
						
						<%-- <div class="label_main">
							<div class="label_hang">
								<div class="label_ltit">签字:</div>
								<div class="label_rwbenx label_rwb_sign">
									<s:iterator value="applyUserSign" status="sta">
											<!--<s:if test="user_sign==null">
												<span class="uname">${sign_user_name}</span>
											</s:if>-->
											<s:if test="user_sign!=null">
													<s:if test="%{sign==null}">
													<span class="user_sign"><img src="${user_sign}" /></span>
													<span class="vab">${it:formatDate(sign_biz_time,'yyyy-MM-dd')}</span>
													</s:if>
													<s:else>
													<s:if test="sign.sign60!=user_sign && sign.sign70!=user_sign && sign.sign80!=user_sign">
													<span class="user_sign"><img src="${user_sign}" /></span>
													<span class="vab">${it:formatDate(sign_biz_time,'yyyy-MM-dd')}</span>
													</s:if>
													<!-- <s:elseif test="sign.sign70!=user_sign">
													<span class="user_sign"><img src="${user_sign}" /></span>
													<span class="vab">${it:formatDate(sign_biz_time,'yyyy-MM-dd')}</span>
													</s:elseif>
													<s:elseif test="sign.sign80!=user_sign">
													<span class="user_sign"><img src="${user_sign}" /></span>
													<span class="vab">${it:formatDate(sign_biz_time,'yyyy-MM-dd')}</span>
													</s:elseif> -->
													<s:else>
													<span class="user_sign"><img src="${user_sign}" /></span>
													<span class="vab">${it:formatDate(sign_biz_time,'yyyy-MM-dd')}</span>
													</s:else>
													</s:else>
											</s:if>
										
									</s:iterator>
								</div>
							</div>
						</div> --%>
						
						
						<div class="apply_t">说明:</div>
						<div id="apply_note_text" class="apply_n oneditor">${apply.note}</div>
						<div class="check_note">
							<div class="apply_t">审核意见:</div>
							<div id="apply_check_note_text" class="apply_n"></div>
							<div class="check_user">
								<s:iterator value="applyUserSign" status="sta">
									<s:if test="user_sign==null">
										<span class="uname">${sign_user_name}</span>
									</s:if>
									<s:else>
										<span class="user_sign"> <img alt="" src="${user_sign}" />
										</span>
									</s:else>
									<s:if test="user_sign!=null || sign_user_name!=null">
									<span class="nowrap" title="${it:formatDate(sign_biz_time,'yyyy-MM-dd HH:mm:ss')}">${it:formatDate(sign_biz_time,'yyyy-MM-dd')}</span>
									</s:if>
								</s:iterator>
							</div>
						</div>
					</div>
					<div id="apply_check_note" style="display: none;">${apply.check_note}</div>
					<script type="text/javascript">
						$("#apply_check_note_text").html(CommonUtil.rtextarea("apply_check_note", "div"));
					</script>
					<div class="noprint tac">
						<input type="button" onclick="window.print();" value="打印本页" />&nbsp;
						<s:form name="form1" action="apply_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
							<c:if test="${it:checkPermit('QKJ_QKJMANAGE_APPLY_CHECK_1',null)==true}">
								<s:hidden name="apply.uuid" />
								<s:hidden name="apply.status" />
								<s:hidden name="apply.sp_check_status" />
								<s:submit id="apply_check_1" name="apply_check_1" value="作废" action="apply_check_1" onclick="return isOp('确定进行此操作?');" />
							</c:if>
						</s:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<s:action name="ref_foot" namespace="/manager" executeResult="true" />
</body>
</html>