<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>固定资产列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<!--right列表-->
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<c:if test="${it:checkPermit('QKJ_ADM_ASSETS_ADD',null)==true}">
			<span class="opb lb op-area"><a href="<s:url namespace="/adm" action="fixassets_load"><s:param name="viewFlag">add</s:param></s:url>" >添加资产</a></span>
		</c:if>
	</div>
	<s:form id="serachForm" name="serachForm" action="fixassets_list"  method="get" namespace="/adm" theme="simple">
		<div class="label_con">
 			<div class="label_main">
				<div class="label_hang">
				       <div class="label_ltit">系统编号:</div>
				       <div class="label_rwben"><s:textfield name="fixassets.uuid"  title="系统编号"/></div>
				</div>
				<%-- <div class="label_hang">
				       <div class="label_ltit">资产分类:</div>
				       <div class="label_rwbenx" id="mmtype">
				       		<div class="label_rwben" style="margin-right:5px;"><select name="assets.typea" title="资产种类" class="prov" require="required" controlName="资产种类"></select></div>
							<div class="label_rwben" style="margin-right:5px;"><select name="assets.typeb" title="资产类别" class="city" disabled="disabled"></select></div>
							<div class="label_rwben"><select name="assets.typec" title="子类别" class="dist" disabled="disabled"></select></div>
				       </div>
				</div> --%>
				
				<div class="label_hang">
							<div class="label_ltit">资产分类:</div>
							<div class="label_rwben2">
								<span class="label_rwb"> <s:textfield title="资产名称" id="userasset_nameid" name="fixassets.type_title" readonly="true" /> <s:hidden title="资产编号" id="userasset_codeid" name="fixassets.typea" readonly="true" />
								</span> <span class="lb nw"> <img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectWarevar('userasset_codeid','userasset_nameid',1);" />
								</span>
							</div>
						</div>
						
						
				<div class="label_hang">
				       <div class="label_ltit">资产名称:</div>
				       <div class="label_rwben"><s:textfield name="fixassets.title"  title="资产名称" cssClass="validate[maxSize[128]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">所属公司:</div>
				       <div class="label_rwbenx"><s:select name="fixassets.company" title="所属公司" headerKey="" headerValue="--请选择--" list="#{0:'北京互助天佑德青稞酒销售有限公司',1:'华实集团',2:'华奥地产',3:'青海互助青稞酒股份有限公司',4:'青海互助青稞酒销售有限公司',5:'北京互助天佑德青稞酒销售有限公司第二分公司'}" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">采购公司:</div>
				       <div class="label_rwbenx"><s:textfield name="fixassets.p_company"  title="采购公司" cssClass="validate[maxSize[128]]" /></div>
				</div>
				<div class="label_hang">
				       <div class="label_ltit">采购时间:</div>
				       <div class="label_rwbenx">
				       		<div class="label_rwben"><input id="assets_p_time_start" class="datepicker validate[custom[date]]" type="text" name="fixassets.p_time_start" title="采购时间" value="${it:formatDate(assets.p_time_start,'yyyy-MM-dd')}" /></div><span style="float:left;">&nbsp;-&nbsp;</span><div class="label_rwben"><input id="assets_p_time_end" class="datepicker validate[custom[date]]" type="text" name="assets.p_time_end" title="采购时间" value="${it:formatDate(assets.p_time_end,'yyyy-MM-dd')}" /></div>
				       </div>
				</div>
				<%-- <div class="label_hang">
				       <div class="label_ltit">剩余数量:</div>
				       <div class="label_rwben">
				       		<s:textfield name="fixassets.residue_num_begin" cssStyle="width:40%;float:left;"  title="剩余数量" cssClass="validate[custom[integer],maxSize[10]]" />
				       		<span style="float:left;">&nbsp;-&nbsp;</span>
				       		<s:textfield name="fixassets.residue_num_end"  cssStyle="width:40%;float:left;" title="剩余数量" cssClass="validate[custom[integer],maxSize[10]]" />
				       	</div>
				</div> --%>
				<div class="label_hang label_button tac">
		        	<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
					<label for="search_mcondition"></label>更多条件
		            <s:submit value="搜索" /> <s:reset value="重置" />
		        </div>
			</div>
		</div>
	</s:form>
	<div class="tab_warp">
	 		<table id="table1">
	 			<tr id="coltr">
	              <th  class="td1">系统编号</th>
	              <th  class="td2">资产归类</th>
	              <th  class="td4">参考型号</th>
	              <th  class="td4">参考规则</th>
	              <th  class="td1">资产名称</th>
	              <th  class="td3">数量</th>
	              <th  class="td2">价格</th>
	               <th  class="td3">采购公司</th>
	              <th  class="td3">采购时间</th>
	              <th  class="td3">保修期限</th>
	              <th  class="td3">采购公司电话</th>
	              <th  class="td4">操作</th>
	              <th  class="td0">查看</th>
	            </tr>
	            <s:iterator value="fixassetss" status="sta">
		            <tr id="showtr${uuid}">
           				<td  class="td1">${uuid}</td>
						<td  class="td2">${type_title}</td>
						<td  class="td4">${model}</td>
						<td  class="td4">${spec}</td>
						<td  class="td1">${title}</td>
						<td  class="td3">${residue_num}/${num}</td>
						<td  class="td2">${price_scope}(${price})</td>
						<td  class="td3">${p_company}</td>
						<td  class="td3">${it:formatDate(p_time,'yyyy-MM-dd')}</td>
						<td  class="td3">${warrantytime}</td>
						<td  class="td4">${p_mobile}</td>
						<td  class="td4 op-area">
							<c:if test="${it:checkPermit('QKJ_ADM_ASSETS',null)==true}">
					    	<a class="input-blue" href="<s:url namespace="/adm" action="fixassets_load"><s:param name="viewFlag">mdy</s:param><s:param name="fixassets.uuid" value="uuid"></s:param></s:url>">修改</a>
					    	<a class="input-blue" onclick="return isOp('对这条信息进行类似创建吗?');" href="<s:url namespace="/adm" action="fixassets_addP"><s:param name="fixassets.uuid" value="uuid"></s:param></s:url>">类似添加</a>
					    	</c:if>
					    	<c:if test="${it:checkPermit('QKJ_ADM_ASSETS_DEL',null)==true}">
					    	<a class="input-red" href="<s:url namespace="/adm" action="fixassets_del"><s:param name="fixassets.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
					    	</c:if>
						</td>
						<td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
		            </tr>
		        </s:iterator>
	       </table>
    </div>
    <div id="listpage" class="pagination"></div>
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