<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员列表--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<script type="text/javascript"></script>
<body>
	<!-- 顶部和左侧菜单导航 -->
<s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
 	<div class="tab_warp main" >
<div class="dq_step">
${path}
<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYSVIP_MEMBER_ADD')">
	<span class="opb lb op-area"><a href="<s:url namespace="/sysvip" action="member_load"><s:param name="viewFlag">add</s:param></s:url>">添加会员</a></span>
</s:if>
</div>
	<s:form id="serachForm" name="serachForm"  method="get" namespace="/sysvip" theme="simple">
<div class="label_con">
<div class="label_main">
      <div class="label_hang">
          <div class="label_ltit">会员号:</div>
          <div class="label_rwben"><s:textfield name="member.uuid" /></div>
      </div>
      <div class="label_hang">
          <div class="label_ltit">会员姓名:</div>
          <div class="label_rwben"><s:textfield name="member.member_name" cssClass="iI iI-s" /></div>
      </div>
      <div class="label_hang">
          <div class="label_ltit">会员手机:</div>
          <div class="label_rwben"><s:textfield name="member.mobile" /></div>
      </div>
      <div class="label_hang">
          <div class="label_ltit">会员EMAIL:</div>
          <div class="label_rwben"><s:textfield name="member.email" cssClass="iI iI-s" /></div>
		</div>
		<div class="label_hang">
            <div class="label_ltit">所属部门:</div>
            <div class="label_rwben2">
            	<span class="label_rwb">
				<s:textfield title="部门名称" id="userdept_nameid" name="member.dept_name" readonly="true" />
				<s:hidden title="部门代码" id="userdept_codeid" name="member.DEPT_CODE" readonly="true" />
				</span>
				<span class="lb nw">
				<img class="detail vatop" src='<s:url value="/images/open2.gif" />' onclick="selectDept('userdept_codeid','userdept_nameid',true);" />
				<s:checkbox id="apply_is_sub_dept" name="member.is_sub_dept" cssClass="regular-checkbox" />
				<label for="apply_is_sub_dept"></label>包含子部门<span id="ajax_member_message"></span>
				</span>
            </div>
        </div>
        
        <div class="label_hang">
            <div class="label_ltit">客户经理:</div>
            <div class="label_rwben label_rwb">
            	<s:select id="membermanagerid" cssClass="selectKick" name="member.manager" list="#{}" headerKey="" headerValue="--请选择--" />
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
<div class="tab_warp">
<table>
<tr id="coltr">
	<th class="td1">会员号</th>
	<th class="td1">会员手机</th>
	<th class="td2">会员姓名</th>
	<th class="td5">会员分组</th>
	<th class="td5">资产</th>
	<th class="td5">随量积分</th>
	<th class="td5">返利积分</th>
	<th class="td5">消费积分</th>
	<th class="td3">所属部门</th>
	<th class="td2">客户经理</th>
	<th class="td4">操作</th>
	<th class="td0">查看</th>
</tr>
<s:iterator value="members" status="sta">
	  <tr id="showtr${uuid}">
	    <td class="td1">${uuid}</td>
		<td class="td1">${mobile}</td>
		<td class="td2">${member_name}<s:if test="contact!=null">(${contact})</s:if></td>
		<td class="td5">${user_type_name}</td>
		<td class="td5">￥${money}</td>
		<td class="td5">${with_score}</td>
		<td class="td5">${re_score}</td>
		<td class="td5">${score}</td>
		<td class="td3">${dept_name}</td>
		<td class="td2">${manager_name}</td>
		<td class="td4 op-area">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYSVIP_MEMBER_MDY')">
	    	<a class="input-blue" href="<s:url namespace="/sysvip" action="member_load"><s:param name="viewFlag">mdy</s:param><s:param name="member.uuid" value="uuid"></s:param></s:url>">修改</a>
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('SYSVIP_MEMBER_DEL')">
	    	<a class="input-red" href="<s:url namespace="/sysvip" action="member_del"><s:param name="member.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	    	</s:if>
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_LIST')">
				<a class="input-blue" href="javascript:;" onclick="linkurl('<s:url action="memberStock_out" namespace="/sysvip" ><s:param name="member.member_name" value="%{member_name}"></s:param><s:param name="member.uuid" value="%{uuid}"></s:param></s:url>');" >生成盘点模板</a>
			</s:if>
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