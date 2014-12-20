<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>

<body>
	<div class="main">
		<div class="dq_step">
			${path} <span class="opb lb op-area"> <s:if test="'view' != viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_LIST')"><a
				href="<s:url action="schedule_leftList" namespace="/sche"><s:param name="sche.type" value="%{sche.type}"></s:param></s:url>">公告列表</a></s:if>
			</span>
		</div>
		<!-- 页面修改 -->
		<s:form id="editForm" name="editForm" cssClass="validForm"
			action="sche_add" namespace="/sche" method="post" theme="simple">
			<div class="label_con">
			<s:hidden id="sche.type" name="sche.type" value="%{sche.type}"/>
			<div class="label_main">
				<div class="label_hang">
					<div class="label_ltit">编号:</div>
						<div class="label_rwb">
							<s:property value="sche.uuid" />
							<s:hidden id="sche.uuid" name="sche.uuid" value="%{sche.uuid}"/>
								
						</div>
				</div>
				<div class="label_hang">
					<div class="label_ltit">类别:</div>
						<div class="label_rwb">
							<div class="label_rwben2">
			       				<span class="label_rwb">
				            	 <s:if test="sche.type==0">部门手册</s:if>
								<s:if test="sche.type==1">公司制度和章程</s:if>
								<s:if test="sche.type==2">公司文件</s:if>
								<s:if test="sche.type==3">更新公告</s:if>
				            	</span>
				            </div>
						</div>
				</div>
				<div class="label_hang">
							<div class="label_ltit">发布日期:</div>
							<div class="label_rwb">
								<s:property value="sche.sdate" />
							</div>
				</div>
				<div class="label_hang">
							<div class="label_ltit">发布人:</div>
							<div class="label_rwb">
								<s:property value="sche.p_name" />
							</div>
				</div>
				
			</div>
					
				<s:if test="'view' == viewFlag">
			      <div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">主题:</div>
						<div class="label_rwben">
							<s:property value="sche.title" />
						</div>
					</div>
				</div>
			    </s:if>
				
				<s:if test="null != sche && null !=sche.user_name">
					<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">已阅人:</div>
						<div class="label_rwben">
						<s:property value="sche.user_name" />
						</div>
					</div>
				</div>
				</s:if>

			    <div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">公告内容:</div>
						<div class="label_rwbenx"></div>
					</div>
				</div>
				<div class="label_main">
					<div class="note_area">
					${sche.content }
					</div>
				</div>
				
			</div>
		</s:form>
	</div>
</body>
</html>