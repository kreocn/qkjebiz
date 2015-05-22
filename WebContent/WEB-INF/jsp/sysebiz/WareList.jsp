<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
<link rel="StyleSheet" href="<s:url value="/include/dtree/dtree.css" />" />
<script type="text/javascript" src="<s:url value="/include/dtree/dtree.js" />"></script>
<style type="text/css">
.label_main{font-size:14px;}
.label_ltit{width:130px;}
.label_hang_linput {
	width: 760px !important;
}
@media screen and (max-width:1180px) {
	.label_hang_linput {
		width: 500px !important;
	}
}
@media screen and (max-width:820px) {
	.label_hang_linput {
		width: 300px !important;
	}
}
@media screen and (max-width:620px) {
	.label_hang_linput {
		width: 150px !important;
	}
}
</style>
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="main">
		<div class="dq_step">
		${path}
		</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="200" style="background-color: #F0F0F0;" valign="top">
					<div id="dtree">
						<!--<p><a href="javascript: d.openAll();">open all</a> | <a href="javascript: d.closeAll();">close all</a></p>-->
					</div>
				</td>
				<td width="10"></td>
				<td valign="top">
					<s:form name="form1" cssClass="validForm" action="ware_list" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
						<div class="label_main">
							<input type="button" value="新增权限" onClick="setControl('add','1');" />
						</div>						
						<div class="label_main">
							<s:hidden id="ware.uuid" name="ware.uuid" value="ware.uuid" />
							<div class="label_hang">
								<div class="label_ltit">仓库类型:</div>
								<div class="label_rwbenx">
								<s:hidden id="ware_class"></s:hidden>
								<s:radio id="ware.ware_class" name="ware.ware_class" list="#{0:'普通库',1:'藏酒库',2:'区域'}" value="0" />
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">父仓库:</div>
								<div class="label_rwbenx">
									<s:select title="父权限" id="ware.parent_ware" name="ware.parent_ware" list="wares" listKey="uuid" listValue="ware_name"  headerKey="0"  headerValue="根节点" cssClass="validate[required]" />
								</div>
							</div>
							<div class="label_hang">
								<div class="label_ltit">仓库名称:</div>
								<div class="label_rwbenx"><s:textfield id="ware.ware_name" name="ware.ware_name" cssClass="validate[required]" title="仓库名称"/></div>
							</div>
							
							<div class="label_hang">
						         <div class="label_ltit">仓库地点:</div>
						         <div class="label_rwben2">
						         <div class="label_rwb"><s:textfield id="ware.address" name="ware.address" title="仓库地点" cssClass="label_hang_linput validate[maxSize[255]]" /></div>
						         </div>
					       	</div>
					       	
					       	<div class="label_hang">
					            <div class="label_ltit">简短描述:</div>
					            <div class="label_rwbenx">
					            	<s:textarea id="short_note" name="ware.short_note" cssStyle="width:50%;" rows="3" title="仓库简短描述" cssClass="label_hang_linput validate[maxSize[128]]" />
					            </div>
					        </div>
					        
					        
					        
					        <div class="label_hang">
					            <div class="label_ltit">仓库详细描述:</div>
					            <div class="label_rwbenx">
					            </div>
					        </div>
							
							<div class="note_area">
				        	<s:textarea id="long_note" name="ware.note" title="详细说明" cssClass="xheditorArea validate[maxSize[65535]]" />
				        	</div>
				        	
				        	<div class="label_hang">
					            <div class="label_ltit">修改人:</div>
					            <div class="label_rwben">
					           <span id="ware.lm_user"></span>
					            </div>
				       		</div>
				       		
				       		<div class="label_hang">
					            <div class="label_ltit">修改时间:</div>
					            <div class="label_rwben" style="width:auto;">
					            <span id="ware.lm_time"></span>
					            </div>
				       		</div>
							<div class="label_hang clear">
								<div class="label_ltit">相关操作:</div>
								<div class="label_rwbenx ">
								<c:if test="${ it:checkPermit('QKJ_EBIZ_WARE_ADD',null)==true}">
									<span id="label_add"><s:submit id="add" name="add" value="新增" action="ware_add" cssClass="input-blue"/></span>
								</c:if>
								<c:if test="${ it:checkPermit('QKJ_EBIZ_WARE_MDY',null)==true}">
							    	<span id="label_save" style="display:none;"><s:submit id="save" name="save" value="保存" action="ware_save" cssClass="input-blue"/></span>
							    </c:if>
							    <c:if test="${ it:checkPermit('QKJ_WARE_WAREPOWER_LIST',null)==true}">
							    	<span id="label_power" style="display:none;">
							    	<input type="button" value="管理权限" onclick="comPower();" />
							    	</span>	
							    </c:if>
									<span id="label_del" style="display:none;"><s:submit id="delete" name="delete" value="删除" action="ware_del" onclick="return isDel();" cssClass="input-red"/></span>
									&nbsp;<span id="message"><s:property value="message" /></span>
								</div>
							</div>
						</div>
						
					</s:form>
				</td>
			</tr>
		</table>
	</div>
</div>



<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
	var divID =document.getElementById("dtree");  
	d = new dTree('d');
	//d.config.isAddNoRootNode = true;
	d.icon = {
			root		: '<s:url value="/include/dtree/" />'+'img/globe.gif',
			folder		: '<s:url value="/include/dtree/" />'+'img/folder.gif',
			folderOpen	: '<s:url value="/include/dtree/" />'+'img/folderopen.gif',
			node		: '<s:url value="/include/dtree/" />'+'img/page.gif',
			empty		: '<s:url value="/include/dtree/" />'+'img/empty.gif',
			line		: '<s:url value="/include/dtree/" />'+'img/line.gif',
			join		: '<s:url value="/include/dtree/" />'+'img/join.gif',
			joinBottom	: '<s:url value="/include/dtree/" />'+'img/joinbottom.gif',
			plus		: '<s:url value="/include/dtree/" />'+'img/plus.gif',
			plusBottom	: '<s:url value="/include/dtree/" />'+'img/plusbottom.gif',
			minus		: '<s:url value="/include/dtree/" />'+'img/minus.gif',
			minusBottom	: '<s:url value="/include/dtree/" />'+'img/minusbottom.gif',
			nlPlus		: '<s:url value="/include/dtree/" />'+'img/nolines_plus.gif',
			nlMinus		: '<s:url value="/include/dtree/" />'+'img/nolines_minus.gif'
	};		
	d.add('0','-1','仓库列表');
	<s:iterator value="wares">
	d.add('<s:property value="uuid" />','<s:property value="parent_ware" />','<s:property value="ware_name" />',"javascript:getInfo('<s:property value="uuid" />')");
	</s:iterator>
	d.add();
	divID.innerHTML = d;
</script>

<script type="text/javascript">
var puuid = '<s:property value="ware.uuid" />';
var cflag = 0;//状态符,0代表新增状态 1代表修改状态

$(function(){
	if(puuid=='') {
		cflag = 1;
		setControl('add');
		cflag = 0;
	} else {
		getInfo(puuid);
	}	
});

function getInfo(obj) {
	var ajax = new Common_Ajax('message');
	ajax.config.action_url = '<s:url value="/common_ajax/json_ajax" />';
	ajax.config._success = function(data, textStatus) {
		var json = data[0];
		$("#ware\\.uuid").val(json.uuid);
		//单选框,复选框,多选下拉菜单都要用数组赋值
		//单选下拉菜单用字符串直接赋值
		$(":radio[name='ware.ware_class']").val([json.ware_class]);
		$("#ware\\.ware_name").val(json.ware_name);
		$("#ware\\.parent_ware").val(json.parent_ware);		
		$("#ware\\.address").val(json.address );
		$("#short_note").val(json.short_note);
		$("#ware\\.note").val(json.note);
		$("#ware\\.lm_user").text(json.lm_user_name);
		$("#ware\\.lm_time").text(formatDate(json.lm_time));
		$("#ware_class").val(json.ware_class);
		$("#long_note").val(json.note);
		setControl("save");
		$("#message").text("获取数据成功!");
	};
	ajax.addParameter("privilege_id","QKJ_EBIZ_WARE_AJAX_LOAD");
	ajax.addParameter("parameters","uuid="+obj);
	ajax.sendAjax();
}


function setControl(ct,flag) {
	if("save"==ct) {
		if(cflag == 0) {
			$('#label_add').hide();
			$('#label_save').show();
			$('#label_del').show();
			$('#label_power').show();
			$('#ware\\.uuid').attr("readonly","true");
			cflag = 1;
		}		
	} else if("add"==ct) {
		if(cflag == 1) {
			$('#label_add').show();
			$('#label_save').hide();
			$('#label_del').hide();
			$('#label_power').hide();
			$('#message').empty();
			var new_parent_id = $('#ware\\.uuid').val();
			var new_class=$("#ware_class").val();
			form1.reset();
			$("#ware\\.lm_user").empty();
			$("#ware\\.lm_time").empty();
			$("#ware\\.ware_name").val("");
			$("#ware\\.address").val("");
			$("#ware\\.short_note").val("");
			$('#ware\\.parent_ware').val(new_parent_id).checked;
			if(flag==1){
				$(":radio[name='ware.ware_class']").val([new_class]);
			}
			cflag = 0;
		}
	}
}
function view(obj) {
	var str = "";
	for(var i in obj) {
		str += i+"\t";
	}
	$('message').innerHTML = str;
}

function comPower(){
	var uuid=$("#ware\\.uuid").val();
	var name=$("#ware\\.ware_name").val();
	 location.href="/sysebiz/ware_power?ware.uuid="+uuid+"&ware.ware_name="+name;
}
</script>

</body>
</html>