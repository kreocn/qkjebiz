<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库管理权限列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true"/>
</head>

<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
	<div class="dq_step">
		${path}
		<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_ADD')">
			<span class="opb lb op-area">
			<a href="<s:url namespace="/warepower" action="warepower_load"><s:param name="viewFlag">add</s:param></s:url>" >添加仓库管理权限</a>
     		</span>
		</s:if>
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="warepower_list"  method="get" namespace="/warepower" theme="simple">
		<div class="label_con">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">申请部门:</div>
            <div class="label_rwben nw">
            	<s:textfield title="部门名称" id="userdept_nameid"  name="warepower.dept_name"  readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="warepower.dept_code" readonly="true" />
		    </div>
			<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
	        </div>
	        <div class="label_hang">
	            <div class="label_ltit">申请人:</div>
	            <div class="label_rwben label_rwb">
	            	<s:select id="membermanagerid" cssClass="selectKick" name="warepower.username" list="#{}" headerKey="" headerValue="--请选择--" />
	            </div>
			</div>
        	<div class="label_hang">
            <div class="label_ltit">仓库:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="allot.sourceid" title="调出仓库" headerKey="" headerValue="--请选择--" list="wares" listKey="uuid" listValue="ware_name" />
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
	
	<!-- 列表 -->
	<div class="tab_warp">
 		<table>
 		<tr id="coltr">
		<th class="td1">编号</th>
		<th class="td1">管理员</th>
		<th class="td1">仓库</th>
		<th class="td3">权限</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="warepowers" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw"><s:property value="uuid" /></td>
			    <td class="td1 nw">
			     <s:if test="%{username!=null&&username!=''}"><s:property value="user_name" /></s:if>
			     <s:else><s:property value="dept_name" /></s:else>
			     </td>
			    <td class="td1 nw"><s:property value="ware_name" /></td>
			    <td class="td3 nw">
			    <s:if test="%{prvg.indexOf('1')>=0}">入库&nbsp;</s:if>
			    <s:if test="%{prvg.indexOf('2')>=0}">出库&nbsp;</s:if>
			    <s:if test="%{prvg.indexOf('3')>=0}">调库&nbsp;</s:if>
			    <s:if test="%{prvg.indexOf('4')>=0}">查询&nbsp;</s:if>
			    </td>
		
				<td class="td4 op-area">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_MDY')">
			    	<a class="input-blue" href="<s:url namespace="/warepower" action="warepower_load"><s:param name="viewFlag">mdy</s:param><s:param name="warepower.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:if>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_WARE_WAREPOWER_DEL')">
			    	<a class="input-red" href="<s:url namespace="/warepower" action="warepower_del"><s:param name="warepower.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>	   
			    </td>
				<td class="td0 op-area"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
	  		</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div id="listpage" class="pagination"></div>
	<div class="hidden_area">
	<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
	</div>
</div>
</div>
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
</script>
</body>
</html>