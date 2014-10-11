<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>仓库管理--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>

<div class="main">
	<div class="dq_step">
		${path}
			<span class="opb lb op-area">
			<a href="<s:url namespace="/sysebiz" action="ware_load"><s:param name="viewFlag">add</s:param></s:url>" >添加仓库</a>
     		</span>
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="ware_list"  method="get" namespace="/sysebiz" theme="simple">
		<div class="label_con">
		<div class="label_main">
			
	        <div class="label_hang">
	            <div class="label_ltit">仓库分类:</div>
	            <div class="label_rwben label_rwb">
	            	<div class="iselect">
	            	<s:select name="ware.ware_class" list="#{0:'普通库', 1:'藏酒库'}" headerKey="" headerValue="--请选择--" />
	            	</div>
	            </div>
			</div>
        	<div class="label_hang">
            <div class="label_ltit">仓库名称:</div>
            <div class="label_rwben"><s:textfield title="仓库名称" name="ware.ware_name" /></div>
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
		<th class="td1">仓库类型</th>
		<th class="td1">仓库名称</th>
		<th class="td1">仓库地址</th>
		<th class="td4">操作</th>
		

	  	</tr>
	  	<s:iterator value="wares" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw"><s:property value="uuid" /></td>
			   <td class="td1 nw">
			    	<s:if test="0==ware_class">普通库</s:if>
			    	<s:elseif test="1==ware_class">藏酒库</s:elseif>
			    </td>
			    <td class="td1 nw"><s:property value="ware_name" /></td>
				<td class="td1 nw"><s:property value="address" /></td>
				<td class="td4 op-area">
			    	<a class="input-blue" href="<s:url namespace="/sysebiz" action="ware_load"><s:param name="viewFlag">mdy</s:param><s:param name="ware.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	<a class="input-red" href="<s:url namespace="/sysebiz" action="ware_del"><s:param name="ware.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    </td>
	  		</tr>
	  	</s:iterator>
 		</table>
 	</div>
 	<div class="pagination">
		<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
		</script>
	</div>
</div>
</html>