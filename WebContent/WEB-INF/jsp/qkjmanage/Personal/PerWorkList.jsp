<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人工作--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
		<div class="dq_step">
			${path}
		</div>
		<!-- 条件查询 -->
		<s:form id="serachForm" name="serachForm" action="perWork_list"  method="get" namespace="/qkjmanage" theme="simple">
			<div class="label_con">
			<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">类型:</div>
		            <div class="label_rwben label_rwb">
		            	<select name="perWork.ptype">
		            	<option>--请选择--</option>
						  <option value ="活动">活动</option>
						  <option value ="至事由">至事由</option>
						 
						  <option value="请假">请假</option>
						  
						  <option value="换休">换休</option>
						  <option value="工业旅游">工业旅游</option>
						  <option value="提货结案单">提货结案单</option>
						  <option value="促销活动">促销活动</option>
						</select>
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
			<th class="td1">类型</th>
			<th class="td1">审核内容</th>
			<th class="td2">申请人</th>
			<th class="td4">操作</th>
			<th class="td0">查看</th>
	
		  	</tr>
		  	<s:iterator value="perWorks" status="sta">
		  		<tr id="showtr${perUuid}">
		  			<td class="td1 nw"><s:property value="perUuid" /></td>
		  			<td class="td1 nw">${ptype }</td>
				    <td class="td1 longnote" title="${title}">
				    <s:if test="%{ptype=='请假' || ptype=='换休'}">
				    ${title }
				    </s:if>
				    <s:else>
				    ${it:subString(title,18)}
				    </s:else>
				    
				    </td>
				    <td class="td2 nw">
				    ${apply_user_name }
				    </td>
				    
					<td class="td4 op-area">
				    	<a class="input-blue" href="<s:url namespace="%{nameSpace }" action="%{upaction }"><s:param name="perWorkF">mdy</s:param><s:param name="viewFlag">mdy</s:param><s:param name="%{upUuid }" value="perUuid"></s:param></s:url>">修改</a>
				    </td>
				    <td class="td0 op-area"><a onClick="showDetail('showtr${perUuid}');" class="input-nostyle">查看</a></td>
		  		</tr>
		  	</s:iterator>
	 		</table>
	 	</div>
	 	<div><font color="red">${message }</font></div>
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