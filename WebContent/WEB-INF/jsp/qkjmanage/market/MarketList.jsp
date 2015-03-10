<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>网络营销--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
	<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
		<div class="dq_step">
			${path}
				<span class="opb lb op-area">
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_MARKET_ADD')">
				<a href="<s:url namespace="/qkjmanage" action="market_load"><s:param name="viewFlag">add</s:param></s:url>" >添加信息</a>
				</s:if>
				<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_MARKET')">
				<a href="<s:url namespace="/qkjmanage" action="market_writejs"></s:url>" >生成营销网络</a>
				</s:if>
	     		</span>
		</div>
		<!-- 条件查询 -->
		<s:form id="serachForm" name="serachForm" action="market_list"  method="get" namespace="/qkjmanage" theme="simple">
			<div class="label_con">
			<div class="label_main">
		        <div class="label_hang">
		            <div class="label_ltit">公司名称:</div>
		            <div class="label_rwben label_rwb">
		            	<s:textfield title="名称" name="market.name" />
		            </div>
				</div>
	        	<div class="label_hang">
	            <div class="label_ltit">所属区域:</div>
	            <div class="label_rwben"><s:textfield title="名称" name="market.area" /></div>
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
			<th class="td1">公司名称</th>
			<th class="td2">区域</th>
			<th class="td3">性质</th>
			<th class="td3">联系地址</th>
			<th class="td3">联系信息</th>
			<th class="td1">位置信息</th>
			<th class="td4">操作</th>
			<th class="td0">查看</th>
	
		  	</tr>
		  	<s:iterator value="markets" status="sta">
		  		<tr id="showtr${uuid}">
		  			<td class="td1 nw"><s:property value="uuid" /></td>
		  			 <td class="td1 nw">${name }</td>
				   
				    <td class="td2 nw">${area }</td>
				    <td class="td3 nw">${lead }</td>
				    <td class="td3 longnote" title="${address}">${it:subString(address,18)}</td>
				    <td class="td3 nw">
				    <s:if test="%{people!=null && people!=''}">联系人:${people }&nbsp;</s:if>
				    联系电话：${phone }</td>
				    <td class="td1 nw">
				    <s:if test="%{abs!=null || yaxis!=null}">
				    	[${abs },${yaxis }]
				    </s:if>
				    <s:else>
				    <font color="red">没有位置信息</font>
				    </s:else>
				    </td>
				    
					<td class="td4 op-area">
				    	<a class="input-blue" href="<s:url namespace="/qkjmanage" action="market_load"><s:param name="viewFlag">mdy</s:param><s:param name="market.uuid" value="uuid"></s:param></s:url>">修改</a>
				    	<a class="input-red" href="<s:url namespace="/qkjmanage" action="market_del"><s:param name="market.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
				    </td>
				    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
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