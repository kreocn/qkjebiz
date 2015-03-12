<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>系统角色列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="main">
		<div class="dq_step">
			<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;系统角色列表
			<span class="opb lb op-area"><a href="<s:url namespace="/sys" action="role_load"><s:param name="viewFlag">add</s:param></s:url>">添加系统角色</a></span>
		</div>
		<div class="tab_warp">
	 		<table>
	 			<tr id="coltr">
				    <th class="td1">编号</th>
					<th class="td1">角色名称</th>
					<th class="td2">角色描述</th>
					<th class="td3">添加时间</th>
					<th class="td4">操作</th>
					<th class="td0">查看</th>
				</tr>
				<s:iterator value="roles" status="sta">
				<tr id="showtr${uuid}">
					<td class="td1">${uuid}</td>
					<td class="td1">${role_name}</td>
					<td class="td2">${descriptions}</td>
					<td class="td3">${it:formatDate(lm_time,'yyyy-MM-dd  HH:mm:ss')}</td>
					<td class="td4 op-area">
						<a class="input-blue" href="<s:url namespace="/sys" action="role_load"><s:param name="viewFlag">mdy</s:param><s:param name="role.uuid" value="uuid"></s:param></s:url>">修改</a>
	    				<a class="input-red" href="<s:url namespace="/sys" action="role_del"><s:param name="role.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
					</td>
					<td class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
				</tr>
				</s:iterator>
	 		</table>
 		</div>
 		<div class="pagination">
			<div id="listpage" class="pagination"></div>
		</div>
	</div>
</div>
<s:action name="ref_foot" namespace="/manager" executeResult="true" />
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
});
</script>
</body>
</html>