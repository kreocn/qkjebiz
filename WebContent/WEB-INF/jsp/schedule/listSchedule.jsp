<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>公告列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>

<body>
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
			<span class="opb lb op-area">
					<s:if test="sctype==0">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_MANU_ADD')">
					<a href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">add</s:param><s:param name="sche.type">0</s:param></s:url>" >添加部门手册</a>
					</s:if>
					</s:if>
					<s:if test="sctype==1">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_COMP_ADD')">
					<a href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">add</s:param><s:param name="sche.type">1</s:param></s:url>" >添加公司制度</a>
					</s:if>
					</s:if>
					<s:if test="sctype==2">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_FILE_ADD')">
					<a href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">add</s:param><s:param name="sche.type">2</s:param></s:url>" >添加公司文件</a></s:if></s:if>
					<s:if test="sctype==3">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_UPSC_ADD')">
					<a href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">add</s:param><s:param name="sche.type">3</s:param></s:url>" >添加系统公告</a></s:if></s:if>
			</span>
	</div>
	<!-- 条件查询 -->
	<s:form id="serachForm" name="serachForm" action="schedule_leftList"  method="get" namespace="/sche"  theme="simple">
		<div class="label_con">
		<div class="label_main">
			<div class="label_hang">
            <div class="label_ltit">主题:</div>
            <div class="label_rwben"><s:textfield title="标题" name="sche.title" />
            <s:hidden name="sche.type" value="%{sctype }"/>
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
		<th class="td1">主题</th>
		<th class="td1">更新日期</th>
		
		<th class="td2">发布人</th>
		<th class="td2">公告类别</th>
		<th class="td3">最后修改人</th>
		<th class="td3">最后修改时间</th>
		<th class="td4">操作</th>
		<th class="td0">查看</th>
	  	</tr>
	  	<s:iterator value="sches" status="sta">
	  		<tr id="showtr${uuid}">
	  			<td class="td1 nw">${uuid }</td>
	  			<td class="td1 nw">
			    	<a class="leave_cause_show" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">view</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">
			    	${title }
			    	</a>
			    </td>
	    		<td class="td1 nw">${sdate } </td>
				
				<td class="td2 nw">
				<s:property value="%{p_name}"/>
				</td>
				<td class="td2 nw">
				 	<s:if test="type==0">部门手册</s:if>
					<s:if test="type==1">公司制度和章程</s:if>
					<s:if test="type==2">公司文件</s:if>
					<s:if test="type==3">更新公告</s:if>
				</td>
				<td class="td3 nw">
				 		${lm_user_name }
				</td>
				<td class="td3 nw">
				 	${it:formatDate(lm_time,'yyyy-MM-dd hh:mm:ss')}
				</td>
				<td class="td4 op-area">
			    <s:if test="type==0">
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_MANU_SAVE')">
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">mdy</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:if>
			    	<s:else>
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">view</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">详情</a>
			    	</s:else>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_MANU_DEL')">
			    	<a class="input-red" href="<s:url namespace="/sche" action="schedule_del"><s:param name="sche.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>
			    
			    </s:if>	
			    <s:if test="type==1">
			    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_COMP_SAVE')">
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">mdy</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:if>
			    	<s:else>
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">view</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">详情</a>
			    	</s:else>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_COMP_DEL')">
			    	<a class="input-red" href="<s:url namespace="/sche" action="schedule_del"><s:param name="sche.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>
			    </s:if>
			    <s:if test="type==2">
			    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_FILE_SAVE')">
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">mdy</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">修改</a>
			    </s:if>
			    	<s:else>
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">view</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">详情</a>
			    	</s:else>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_FILE_DEL')">
			    	<a class="input-red" href="<s:url namespace="/sche" action="schedule_del"><s:param name="sche.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>
			    </s:if>
			    <s:if test="type==3">
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_UPSC_SAVE')">
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">mdy</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">修改</a>
			    	</s:if>
			    	<s:else>
			    	<a class="input-blue" href="<s:url namespace="/sche" action="schedule_load"><s:param name="viewFlag">view</s:param><s:param name="sche.uuid" value="uuid"></s:param></s:url>">详情</a>
			    	</s:else>
			    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_SCHE_UPSC_DEL')">
			    	<a class="input-red" href="<s:url namespace="/sche" action="schedule_del"><s:param name="sche.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
			    	</s:if>
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
<script type="text/javascript">
$(function(){
	printPagination("listpage",'${currPage}','${recCount}','${pageSize}');
});
</script>
</body>
</html>