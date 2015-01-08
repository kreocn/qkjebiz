<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<script type="text/javascript"></script>
<body>
<div class="main" >
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
	    	<a href="<s:url namespace="/sysvip" action="memberStock_list"><s:param name="memberStock.dealer" value="uuid"></s:param></s:url>">查看库存</a>
	    	</s:if>
		</td>
	    <td class="td0 op-area"><a onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
	  </tr>
</s:iterator>
</table>
</div>
<div class="pagination"><script type="text/javascript">var spage = new ShowPage(${currPage});	spage.show2(${recCount},${pageSize},2);</script></div>
</div>
</body>
</html>