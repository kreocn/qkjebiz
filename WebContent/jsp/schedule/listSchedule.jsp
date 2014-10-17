<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>调库列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>

<body>
<div class="main">
	<div class="dq_step">
		${path}
			<span class="opb lb op-area">
			<a href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">add</s:param></s:url>" >添加公告</a>
			</span>
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="schedule_leftList"  method="get" namespace="/sche"  theme="simple">
		<div class="label_con">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">主题:</div>
            <div class="label_rwben"><s:textfield title="标题" name="sche.title" /></div>
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
		<th class="td1">主题</th>
		<th class="td1">日期</th>
		<th class="td3">内容</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="sches" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw">${uuid }</td>
	  			<td class="td1 nw">
			    	${title }
			    </td>
	    		<td class="td1 nw">${sdate } </td>
				<td class="td3 nw">
				<s:property value="%{content.toString().substring(0,18)+'......'}"/>
				</td>
				<td class="td4 op-area">
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">mdy</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	<a class="input-red" href="<s:url namespace="/sche" action="schedule_del"><s:param name="sche.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    </td>
			    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
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
	<div class="hidden_area">
	<div id="infoDetail" class="idialog" title="查看详情" style="width:100%;"><div id="detailMain" class="label_main op-area"></div></div>
	</div>
</div>
</body>
</html>