<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员组列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		<a href="/manager/default">首页</a>&nbsp;&gt;&nbsp;会员组列表
		<span class="opb lb op-area"><a href="<s:url namespace="/sys" action="userrole_load_add"><s:param name="viewFlag">add</s:param></s:url>" >添加系统角色</a></span>
	</div>
	<div class="tab_warp">
	 		<table id="table1">
	 			<tr id="coltr">
					<th  class="td1"><input name="uuidcheck" type="checkbox" onclick="pickCheck(this,'uuid');" /></th>
					<th  class="td1">名称</th>
					<th  class="td3">等级</th>
					<th  class="td2">描述</th>
					<th  class="td2">添加时间</th>
					<th  class="td3">操作</th>
					<th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="roles" status="sta">
	            	<tr id="showtr${uuid}">
	            		<td  class="td1"><input name="uuid" type="checkbox" value="${uuid}" /></td>
	            		<td  class="td1">${role_name}</td>
	            		<td  class="td3">${role_rank}</td>
	            		<td  class="td2">${descriptions}</td>
	            		<td  class="td2">${it:formatDate(lm_time,'yyyy-MM-dd HH:mm:ss')}</td>
	            		<td  class="td3 op-area">
	            			<a class="input-blue" href="<s:url namespace="/sys" action="userrole_load_mdy"><s:param name="viewFlag">mdy</s:param><s:param name="role.uuid" value="uuid"></s:param></s:url>">修改</a>
	    					<a class="input-red" href="<s:url namespace="/sys" action="userrole_del"><s:param name="role.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	            		</td>
	            		<td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	            	</tr>
	            </s:iterator>
	            <tr>
				    <td colspan="20" class="buttonarea">
				    	<span id="message"><s:property value="message" /></span>
					</td>
				  </tr>
	         </table>
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