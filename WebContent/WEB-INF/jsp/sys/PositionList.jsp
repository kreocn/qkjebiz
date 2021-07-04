<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>职务管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
		<div class="dq_step">
			${path}
			<span class="opb lb op-area"><a href="<s:url namespace="/sys" action="position_load"><s:param name="viewFlag">add</s:param></s:url>" >添加职务</a></span>
		</div>
		<s:form id="serachForm" name="serachForm" action="position_list"  method="get" namespace="/sys" theme="simple">
		<div class="label_main">
			<div class="label_hang">
		       <div class="label_ltit">职务名称:</div>
		       <div class="label_rwbenx"><s:textfield title="职务名称" name="position.position_name" /></div>
			</div>
			<div class="label_hang label_button tac">
	        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
				<label for="search_mcondition"></label>更多条件
	            <s:submit value="搜索" /> <s:reset value="重置" />
	        </div>
		</div>
		</s:form>
		<div class="tab_warp">
	 		<table id="table1">
	 			<tr id="coltr">
	              <th  class="td1">系统编号</th>
	              <th  class="td1">职务名称</th>
	              <th  class="td2">职务等级</th>
	              <th  class="td2">职务属性</th>
	              <th  class="td3">职务描述</th>
	              <th  class="td4">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="positions" status="sta">
	            <tr id="showtr${uuid}">
	              <td  class="td1">${uuid}</td>
	              <td  class="td1">${position_name}</td>
	              <td  class="td2">
		              	<s:if test="1==position_grade">总经理</s:if>
						<s:if test="2==position_grade">副总经理</s:if>
						<s:if test="3==position_grade">总监</s:if>
						<s:if test="4==position_grade">经理</s:if>
						<s:if test="5==position_grade">主管</s:if>
						<s:if test="6==position_grade">员工</s:if>
	              </td>
	              <td  class="td2">${position_attribute}</td>
	              <td  class="td3">${position_note}</td>
	              <td  class="td4 op-area">
	              		<a class="input-blue" href="<s:url namespace="/sys" action="position_load"><s:param name="viewFlag">mdy</s:param><s:param name="position.uuid" value="uuid"></s:param></s:url>">修改</a>
	    				<a class="input-red" href="<s:url namespace="/sys" action="position_del"><s:param name="position.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	              </td>
	              <td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	            </tr>
	            </s:iterator>
	        </table>
	    </div>
	    <div id="listpage" class="pagination"></div>
	    <div class="tab_warp"><span id="message"><s:property value="message" /></span></div>
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