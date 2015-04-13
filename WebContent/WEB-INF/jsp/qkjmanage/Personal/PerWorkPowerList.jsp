<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人工作权限--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main" >
		<div class="dq_step">
			${path}
			<span class="opb lb op-area">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_PERSONAL_POWER_ADD')">
				<a href="<s:url namespace="/person" action="perWorkPower_load"><s:param name="viewFlag">add</s:param></s:url>" >添加权限</a>
				</s:if>
	     		</span>
		</div>
		<div class="tab_warp">
	 		<table>
	 		<tr id="coltr">
	 		<th class="td1">编号</th>
			<th class="td1">权限</th>
			<th class="td1">表名</th>
			<th class="td2">查询字段</th>
			<th class="td3">备注</th>
			<th class="td4">操作</th>
			<th class="td0">查看</th>
	
		  	</tr>
		  	<s:iterator value="perWorkSelects" status="sta">
		  		<tr id="showtr${uuid}">
		  			<td class="td1 nw"><s:property value="uuid" /></td>
		  			<td class="td1 nw">${roles }</td>
				    <td class="td1 longnote" title="${table_name}">${it:subString(table_name,18)}</td>
				    <td class="td2 longnote">
				    ${it:subString(table_field,18)}
				    </td>
				     <td class="td3 longnote">
				    ${it:subString(table_field,18)}
				    </td>
					<td class="td4 op-area">
				    	<a class="input-blue" href="<s:url namespace="/person" action="perWorkPower_load"><s:param name="viewFlag">mdy</s:param><s:param name="perWorkSelect.uuid" value="uuid"></s:param></s:url>">修改</a>
				    </td>
				    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
		  		</tr>
		  	</s:iterator>
	 		</table>
	 	</div>
	 	<div id="listpage" class="pagination"></div>
	</div>
</div>

<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
</script>
</body>
</html>