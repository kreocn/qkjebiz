<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>
	<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
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
				<s:if test="null != sche && sche.uuid!=null">
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">编号:</div>
							<div class="label_rwb">
								<s:property value="sche.uuid" />
								<s:hidden id="sche.uuid" name="sche.uuid" value="%{sche.uuid}"/>
								
							</div>
						</div>
					</div>
					<div class="label_main">
					<div class="label_hang">
			            <div class="label_ltit">发送给:</div>
			            <div class="label_rwbenx">
			            	<%-- <span class="message_prompt">不填写，则对所有人公开！</span> --%>
			            	<s:if test="'view' == viewFlag">
			            	<s:property value="sche.r_uuid" />
			            	</s:if>
			            	<s:else>
							<s:textfield id="r_uuid" name="sche.r_uuid" title="接收人" cssClass="label_hang_linput inputNote validate[required,maxSize[255]]" />
							</s:else>
			            </div>
			        </div>
					</div>
					<s:if test="null != sche && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkSche(sche.uuid)">
					<div class="label_main">
						<div class="label_hang">
			            <div class="label_ltit">部门:</div>
			            <div class="label_rwben nw">
			            	<span class="label_rwb">
			            	<s:textfield title="部门名称" id="userdept_nameid"   readonly="true" />
							<s:hidden title="部门代码" id="userdept_codeid"  readonly="true" />
							</span>
							<img class="detail vam" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
				            </div>
					        </div>
					        <div class="label_hang">
				            <div class="label_ltit">接收人:</div>
				            <div class="label_rwbenx">
				            	<s:select id="membermanagerid" cssClass="selectKick"  list="#{}" headerKey="" headerValue="--请选择--"  controlName="申请人"/>
				            </div>
						 </div>
						 <div class="label_hang" style="padding-left:10px;">
				            	<input id="sendee" type="button" value="确认接收人">
				            	<input id="delsend" type="button" value="删除接收人">
						 </div>
				     </div>
				     </s:if>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">日期:</div>
							<div class="label_rwb">
								<s:property value="sche.sdate" />
								<s:hidden id="sche.uuid" name="sche.sdate" />
							</div>
						</div>
					</div>
				</s:if>

				<s:else>
					<div class="label_main">
						<div class="label_hang">
				            <div class="label_ltit">发送给:</div>
				            <div class="label_rwbenx">
				            	<%-- <span class="message_prompt">不填写，则对所有人公开！</span> --%>
								<s:textfield id="r_uuid" name="sche.r_uuid" title="接收人" cssClass="label_hang_linput inputNote validate[required,maxSize[255]]" readonly="true"/>
				            </div>
				        </div>
			        </div>
			        <div class="label_main">
						<div class="label_hang">
			            <div class="label_ltit">部门:</div>
			            <div class="label_rwben nw">
			            	<span class="label_rwb">
			            	<s:textfield title="部门名称" id="userdept_nameid"   readonly="true" />
							<s:hidden title="部门代码" id="userdept_codeid"  readonly="true" />
							</span>
							<img class="detail vam" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
				            </div>
					        </div>
					        <div class="label_hang">
				            <div class="label_ltit">接收人:</div>
				            <div class="label_rwbenx">
				            	<s:select id="membermanagerid" cssClass="selectKick"  list="#{}" headerKey="" headerValue="--请选择--"  controlName="申请人"/>
				            </div>
						 </div>
						 <div class="label_hang" style="padding-left:10px;">
				            	<input id="sendee" type="button" value="确认接收人">&nbsp;
				            	<input id="delsend" type="button" value="删除接收人">&nbsp;
						 </div>
				     </div>
					<div class="label_main">
						<div class="label_hang">
							<div class="label_ltit">日期:</div>
							<div class="label_rwben2">
								<span class="label_rwb nw"> <input
									class="datepicker iI-t validate[required,custom[date]]"
									type="text" name="sche.sdate"
									value="${it:formatDate(inStock.date,'yyyy-MM-dd')}" />
								</span>
							</div>
						</div>
					</div>
					
				</s:else>
					<div class="label_main">
				        <div class="label_hang">
				            <div class="label_ltit">公告类別:</div>
				             <div class="label_rwbenx">
			       				<span class="label_rwb">
				            	 <s:if test="sche.type==0">部门手册</s:if>
								<s:if test="sche.type==1">公司制度和章程</s:if>
								<s:if test="sche.type==2">公司文件</s:if>
								<s:if test="sche.type==3">更新公告</s:if>
				            	</span>
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
			    <s:else>
			    <div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">主题:</div>
						<div class="label_rwben">
							<s:textfield name="sche.title" title="主题"
								cssClass="label_hang_linput validate[required,maxSize[255]]" />
						</div>
					</div>
				</div>
			    </s:else>
				
				
				<s:if test="null != sche && null !=sche.user_name">
					<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">已阅人:</div>
						<div class="label_rwben">
						<s:textfield name="sche.user_name" 
								cssClass="label_hang_linput validate[required,maxSize[255]]" />
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
						<s:textarea name="sche.content" title="公告内容"
							cssClass="xheditorArea validate[maxSize[65535]]" />
					</div>
				</div>
				
				<div class="label_main">
					<div class="label_hang">
						<div class="label_ltit">相关操作:</div>
						<div class="label_rwbenx">
							<span id="message"><s:property value="message" /></span>
							<s:if test="sche.type==0">
							<s:if test="(null == sche || sche.uuid==null) && 'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_MANU_ADD')">
							
								<s:submit id="add" name="add" value="确定" action="schedule_add"
									cssClass="input-blue" />
							</s:if>
							<s:elseif test="null != sche && sche.uuid!=null && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkSche(sche.uuid)">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_MANU_SAVE')">
								<s:submit id="save" name="save" value="保存"
									action="schedule_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_MANU_DEL')">
								<s:submit id="delete" name="delete" value="删除" action="schedule_del"
									cssClass="input-red" onclick="return isDel();" />
								</s:if>
							</s:elseif>
							</s:if>
							
							<s:if test="sche.type==1">
							<s:if test="(null == sche || sche.uuid==null) && 'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_COMP_ADD')">
							
								<s:submit id="add" name="add" value="确定" action="schedule_add"
									cssClass="input-blue" />
							</s:if>
							<s:elseif test="null != sche && sche.uuid!=null && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkSche(sche.uuid)">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_COMP_SAVE')">
								<s:submit id="save" name="save" value="保存"
									action="schedule_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_COMP_DEL')">
								<s:submit id="delete" name="delete" value="删除" action="schedule_del"
									cssClass="input-red" onclick="return isDel();" />
								</s:if>
							</s:elseif>
							</s:if>
							
							<s:if test="sche.type==2">
							<s:if test="(null == sche || sche.uuid==null) && 'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_FILE_ADD')">
							
								<s:submit id="add" name="add" value="确定" action="schedule_add"
									cssClass="input-blue" />
							</s:if>
							<s:elseif test="null != sche && sche.uuid!=null && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkSche(sche.uuid)">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_FILE_SAVE')">
								<s:submit id="save" name="save" value="保存"
									action="schedule_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_FILE_DEL')">
								<s:submit id="delete" name="delete" value="删除" action="schedule_del"
									cssClass="input-red" onclick="return isDel();" />
								</s:if>
							</s:elseif>
							</s:if>
							<s:if test="sche.type==3">
							<s:if test="(null == sche || sche.uuid==null) && 'add' == viewFlag && @org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_UPSC_ADD')">
							
								<s:submit id="add" name="add" value="确定" action="schedule_add"
									cssClass="input-blue" />
							</s:if>
							<s:elseif test="null != sche && sche.uuid!=null && 'mdy' == viewFlag && @com.qkj.ware.action.warepower@checkSche(sche.uuid)">
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_UPSC_SAVE')">
								<s:submit id="save" name="save" value="保存"
									action="schedule_save" cssClass="input-blue" />
								</s:if>
								<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_UPSC_DEL')">
								<s:submit id="delete" name="delete" value="删除" action="schedule_del"
									cssClass="input-red" onclick="return isDel();" />
								</s:if>
							</s:elseif>
							</s:if>
							<s:if test="'view' != viewFlag">
							<input type="button" class="input-gray" value="返回"
								onclick="linkurl('<s:url action="schedule_leftList" namespace="/sche"><s:param name="sche.type" value="%{sche.type}"></s:param></s:url>');" />
							</s:if>
						</div>
					</div>
				</div>
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