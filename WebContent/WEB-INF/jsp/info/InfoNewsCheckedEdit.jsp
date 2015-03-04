<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<%@ page import="org.iweb.sys.ContextHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>信息内容--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<style type="text/css">
.label_ltit{width:130px;}
</style>
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step"><a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;审核信息</div>
	<s:form id="formEdit" name="form1" cssClass="validForm" action="news_save" namespace="/info" onsubmit="return validator(this);" method="post" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
			       <div class="label_ltit">信息类别:</div>
			       <div class="label_rwbenx">
			       		<s:hidden name="news.class_id" /><s:hidden name="news.uuid" />${news.class_name}
			       </div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">标题:</div>
			       <div class="label_rwbenx">${news.title}</div>
				</div>
				<div class="label_hang clear">
			       <div class="label_ltit">跳转链接:</div>
			       <div class="label_rwbenx">${news.redirect_url}</div>
			    </div>
			    <div class="label_hang clear">
			       <div class="label_ltit">是否为图片信息:</div>
			       <div class="label_rwbenx"><s:radio title="是否为图片信息" onclick="showImgInput(this);" name="news.isimgnews" list="#{0:'否',1:'是'}"></s:radio></div>
			    </div>
			    <div class="label_hang clear" id="checkimgnews" <s:if test="null == news || null == news.isimgnews || 0 == news.isimgnews">style="display: none;"</s:if>>
						<div class="label_ltit">小图链接:</div>
						<div class="label_rwbenx">${news.smallimg}</div>
						<div class="label_ltit">大图链接:</div>
						<div class="label_rwbenx">${news.bigimg}</div>
				</div>
				<div class="label_hang  clear">
					<div class="label_ltit">信息内容:</div>
					<div class="label_rwbenx">${news.content}</div>
				</div>
				<div class="label_hang  clear">
			       <div class="label_ltit">关键字(多个用,隔开):</div>
			       <div class="label_rwbenx">${news.keywords}</div>
			    </div>
				<div class="label_hang  clear">
			       <div class="label_ltit">简短描述:</div>
			       <div class="label_rwbenx">${news.shortcontent}</div>
			    </div>
				<div class="label_hang  clear">
			       <div class="label_ltit">信息来源:</div>
			       <div class="label_rwbenx">${news.new_source}</div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">是否置顶:</div>
			       <div class="label_rwbenx"><s:if test="0 == news.istop">否</s:if> <s:elseif test="1 == news.istop">是</s:elseif></div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">创建人:</div>
			       <div class="label_rwbenx">${news.add_user_name}</div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">创建时间:</div>
			       <div class="label_rwbenx"><s:date name="news.add_time" format="yyyy-MM-dd HH:mm:ss" /></div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">修改人:</div>
			       <div class="label_rwbenx">${news.lm_user_name}</div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">修改时间:</div>
			       <div class="label_rwbenx"><s:date name="news.lm_time" format="yyyy-MM-dd HH:mm:ss" /></div>
			    </div>
			    <div class="label_hang clear">
			       <div class="label_ltit">审核信息:</div>
			       <div class="label_rwbenx"><s:hidden name="news.ischecked" /></div>
			    </div>
			    <div class="label_hang">
			       <div class="label_ltit">当前状态:</div>
			       <div class="label_rwbenx">
			       		<s:if test="news.ischecked==0">
							<span style="color: red; font-weight: bold;">待初审</span>
						</s:if>
						<s:elseif test="news.ischecked==1">
							<span style="color: yellow;">初审退回</span>
						</s:elseif>
						<s:elseif test="news.ischecked==2">
							<span style="color: green;">初审通过</span>
						</s:elseif>
						<s:elseif test="news.ischecked==3">
							<span style="color: orange;">终审退回</span>
						</s:elseif>
						<s:elseif test="news.ischecked==4">
							<span style="color: gray;">终审通过</span>
						</s:elseif>
						<s:else>
							<span style="color: red; font-weight: bold;">状态异常,请通知管理员</span>
						</s:else>
			       </div>
			    </div>
			    <s:if test="news.ischecked==0 || news.ischecked==1">
			    <div class="label_hang clear">
			       <div class="label_ltit">初审意见:</div>
			       <div class="label_rwbenx"><s:textarea title="初审意见" name="news.first_check_note" cssClass="label_hang_linput" /></div>
			    </div> 
			    <div class="label_hang clear">
			       <div class="label_ltit">操作:</div>
			       <div class="label_rwbenx">
			       		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FIRSTPASS')">
							<s:submit id="firstpass" name="firstpass" value="初审通过" action="news_saveFirstPass" cssClass="input-green" />
						</s:if> <s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FIRSTFAIL')">
							<s:submit id="firstfail" name="firstfail" value="初审退回" action="news_saveFirstFail" cssClass="input-red"/>
						</s:if>
			       </div>
			    </div> 
			    </s:if>
			    <s:if test="news.ischecked>1">
			    <div class="label_hang clear">
			       <div class="label_ltit">初审意见:</div>
			       <div class="label_rwbenx">${news.first_check_note}</div>
			    </div> 
			    </s:if>
			    <s:if test="news.ischecked>1 && news.ischecked<4">
			    <div class="label_hang clear">
			       <div class="label_ltit">终审意见:</div>
			       <div class="label_rwbenx"><s:textarea title="终审意见" name="news.final_check_note" cssClass="label_hang_linput" /></div>
			    </div> 
			    <div class="label_hang clear">
			       <div class="label_ltit">操作:</div>
			       <div class="label_rwbenx">
			       		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FINALPASS')">
							<s:submit id="firstpass" name="firstpass" value="终审通过" action="news_saveFinalPass" cssClass="input-green"/>
						</s:if> <s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FINALFAIL')">
							<s:submit id="firstfail" name="firstfail" value="终审退回" action="news_saveFinalFail" cssClass="input-red"/>
						</s:if>
			       </div>
			    </div> 
			    </s:if>
			    <s:if test="news.ischecked==4">
			    <div class="label_hang clear">
			       <div class="label_ltit">终审意见:</div>
			       <div class="label_rwbenx">${news.final_check_note}</div>
			    </div>
			    </s:if>
			    <div class="label_hang clear">
			    	<div class="label_ltit">相关操作:</div>
			    	<div class="label_rwbenx">
				    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FIRSTPASS')">
							<input type="button" value="返回"  class="input-gray" onclick="linkurl('<s:url action="news_firstCheckedList" namespace="/info" />');" />
						</s:if>
						<s:elseif test="@org.iweb.sys.ContextHelper@checkPermit('INFO_MANAGER_NEWS_FINALPASS')">
							<input type="button" value="返回" class="input-gray" onclick="linkurl('<s:url action="news_finalCheckedList" namespace="/info" />');" />
						</s:elseif>&nbsp;
				    	<span id="message"><s:property value="message" /></span>
					</div>
			    </div>
			</div>
		</div>
	</s:form>
</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
function showImgInput(obj) {
	//alert(getRadio("news.isimgnews"));
	if(getRadio("news.isimgnews")==1) {	
		document.getElementById("checkimgnews").style.display = "";
	} else {
		document.getElementById("checkimgnews").style.display = "none";
	}
}
function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('#message').html(str);
}
</script>
</body>
</html>