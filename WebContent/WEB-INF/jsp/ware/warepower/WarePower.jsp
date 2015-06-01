<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库权限管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<span class="opb lb op-area">
			<a href="<s:url action="ware_list" namespace="/sysebiz" />">返回仓库列表</a>
		</span>
	</div>
	
	<s:form id="addMemberFormTag" name="form1" cssClass="validForm" action="warepower_add" namespace="/warepower" onsubmit="return validator(this);" method="post" theme="simple">
	<s:hidden id="wareid" name="ware.uuid" value="%{ware.uuid}"/>
	<s:hidden name="ware.ware_name" value="%{ware.ware_name}"></s:hidden>
	<div class="label_con">
	<div class="label_main">
		<div class="label_hang">
            <div class="label_ltit">部门:</div>
	            <div class="label_rwben2">
	            	<span class="label_rwb">
					<s:textfield title="部门名称" id="userdept_nameid" name="warepower.dept_name" readonly="true" />
					<s:hidden title="部门代码" id="userdept_codeid" name="warepower.dept_code" readonly="true" />
					</span>
					<span class="lb nw">
					<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
					</span>
	            </div>
	        </div>
		   <div class="label_hang">
	            <div class="label_ltit">仓库管理员:</div>
	            <div class="label_rwben label_rwb">
	            	<s:select id="membermanagerid" cssClass="selectKick" name="warepower.username" list="#{}" headerKey="" headerValue="--请选择--" />
	            </div>
			 </div>
	            <div class="label_hang">
	            	<input type="checkbox" name="warepower.son"  value="1"  checked="checked" >是否包含子仓库
	            </div>
	            <div class="label_hang">
	            	 <div class="label_ltit">权限:</div>
						  	<div class="label_tiaoj"><s:checkbox name="warepower.prvg"  fieldValue="1"  /> 入库&调入</div>
				            <div class="label_tiaoj"><s:checkbox name="warepower.prvg" fieldValue="2"/> 出库&调出</div>
				            <div class="label_tiaoj"><s:checkbox name="warepower.prvg"  fieldValue="4"/> 查询</div>
				</div>
				<div class="label_hang label_button tac">
				<c:if test="${ it:checkPermit('QKJ_WARE_WAREPOWER_ADD',null)==true}">
		            <input id="addMe" type="button" value="新增"  class="input-blue"/>
		         </c:if>
		         <font id="addMemcost" color="red"></font>
		        </div>
        
		  </div>
		</div>
	</s:form>
	</div>
<s:form id="form2" name="form2" cssClass="validForm" action="warepower_save" namespace="/warepower" method="post" theme="simple">
	<div class="tab_warp">
		<table>
	 		<tr id="coltr">
			<th class="td1">管理员</th>
			<th class="td1">权限</th>
			<th class="td4">操作</th>
		  	</tr>
		  	<s:iterator value="wps" status="sta">
		  		<tr id="showtr${uuid}">
				    <td class="td1 nw">
				     <s:if test="%{username!=null&&username!=''}"><s:property value="user_name" /></s:if>
				     <s:else><s:property value="dept_name" /></s:else>
				     </td>
				    <td class="td3 nw">
				            <input type="checkbox" name="prvg${uuid}"  value="1"  <s:if test="%{prvg.indexOf('1')>=0}">checked="checked"</s:if> >入库&调入
				            <input type="checkbox" name="prvg${uuid}"  value="2"  <s:if test="%{prvg.indexOf('2')>=0}">checked="checked"</s:if> > 出库&调出
				            <input type="checkbox" name="prvg${uuid}"  value="4"  <s:if test="%{prvg.indexOf('4')>=0}">checked="checked"</s:if> > 查询
				    
				    <input type="checkbox" id="son${uuid}" name="son${uuid}"  value="1" 
				    <s:if test="%{son==1}">
				     checked="checked" </s:if> >子仓库操作权限
				    </td>
			
					<td class="td4 op-area">
					<c:if test="${ it:checkPermit('QKJ_WARE_WAREPOWER_MDY',null)==true}">
						<a class="input-blue" href="javascript:;" onclick="comPower(${uuid},${ware.uuid});">修改</a>
				    </c:if>	
				    <c:if test="${ it:checkPermit('QKJ_WARE_WAREPOWER_DEL',null)==true}">
				    	<a class="input-red" href="<s:url namespace="/warepower" action="warepower_del"><s:param name="warepower.uuid" value="uuid"></s:param><s:param name="ware.uuid" value="%{ware.uuid}"></s:param><s:param name="ware.ware_name" value="%{ware.ware_name}"></s:param></s:url>" onclick="return isDel();">删除</a>
				    </c:if>
				    </td>
		  		</tr>
		  	</s:iterator>
	 		</table>
	</div>
</s:form>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
		$("#addMe").click(function(){
			if($("#membermanagerid").val()=='') {
	 			alert("【管理员】不许为空!");
	 			$("#membermanagerid").focus();
	 		}else{
	 			checkUs();
	 		}
			});
			function checkUs(){
				 $.ajax({
				     type:'POST',
				     url: '/warepower/Check_User',
				     data: "userid="+$("#membermanagerid").val()+"&wareid="+$("#wareid").val(),
				     beforeSend:function() {
				    	 $("#addMemcost").text("正在验证...");
				     },
				     success: function(data){
				    	 if(data=="false"){
				 			alert("管理员重复.");
				 		} else if($("#userdept_codeid").val()=='') {
				 			alert("【部门】不许为空!");
				 			$("#userdept_codeid").focus();
				 		} else if($("#membermanagerid").val()=='') {
				 			alert("【管理员】不许为空!");
				 			$("#membermanagerid").focus();
				 		}  else {
				 			
				 			var flag=false;
				 			var prvg=document.getElementsByName("warepower.prvg"); ;//选择所有name="interest"的对象，返回数组    
				 		     for(var i=0;i<prvg.length;i++){
				 		          if(prvg[i].checked){
				 		        	 flag=true;   //如果选中，将value添加到变量s中    
				 		        	 break;
				 		          } //取到对象数组后，我们来循环检测它是不是被选中
				 		         
				 		     }
				 			if(flag==true){
				 				$('addMemberFormTag').action="/warepower/warepower_add";
				 				$("#addMemberFormTag").submit();
				 			}else{
				 				alert("【权限】不许全部空!");
				 			}
				 			
				 		}
				    },
				    complete:function(){
				    	$("#addMemcost").text("");
				    }				    
				  });
			}
		</script>
		
<script type="text/javascript">
function comPower(puid,uuid){
	
     var prvg=document.getElementsByName("prvg"+puid); ;//选择所有name="interest"的对象，返回数组    
     var s='';//如果这样定义var s;变量s中会默认被赋个null值
     for(var i=0;i<prvg.length;i++){
          if(prvg[i].checked) //取到对象数组后，我们来循环检测它是不是被选中
          s+=prvg[i].value+',';   //如果选中，将value添加到变量s中    
     }
	var t='';
	var son=document.getElementsByName("son"+puid); 
	for(var i=0;i<son.length;i++){
		if(son[i].checked){
			t=son[i].value;
		}
	}
	var nprvg=s.substr(0,s.length-1);
	if(s==null || s==""){
		alert("权限不能全部为空");
	}else{
		location.href="/warepower/warepower_save?warepower.uuid="+puid+"&ware.uuid="+uuid+"&warepower.prvg="+nprvg+"&warepower.son="+t;
	}

}
</script>
</body>
</html>