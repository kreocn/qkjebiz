<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会员库存--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<script type="text/javascript"></script>
<body>
<div class="main" >
<div class="dq_step">
${path}
<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_ADD')">
	<span class="opb lb op-area"><a href="<s:url namespace="/sysvip" action="memberStock_load"><s:param name="viewFlag">add</s:param></s:url>">添加会员</a></span>
</s:if>
</div>
	<s:form id="serachForm" name="serachForm"  method="get" namespace="/sysvip" theme="simple">
<div class="label_con">
<div class="label_main">
      <div class="label_hang">
          <div class="label_ltit">编号:</div>
          <div class="label_rwben"><s:textfield name="memberStock.uuid" /></div>
      </div>
      <div class="label_hang">
          <div class="label_ltit">经销商编号:</div>
          <div class="label_rwben"><s:textfield name="memberStock.dealer" cssClass="iI iI-s" /></div>
      </div>
      <div class="label_hang">
          <div class="label_ltit">产品:</div>
          <div class="label_rwben"><s:textfield name="memberStock.product" /></div>
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
	<th class="td1">编号</th>
	<th class="td1">经销商帐号</th>
	<th class="td1">产品</th>
	<th class="td2">库存数量（瓶）</th>
	<th class="td2">核对日期</th>
	<th class="td4">操作</th>
	<th class="td0">查看</th>
</tr>
<s:iterator value="memberStocks" status="sta">
	  <tr id="showtr${uuid}">
	  	 <td class="td1">${uuid}</td>
	    <td class="td1">${dealer}</td>
		<td class="td1">${product}</td>
		<td class="td2">${stock}</td>
		<td class="td2">${check_date}</td>
		<td class="td4 op-area">
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_MDY')">
	    	<a class="input-blue" href="<s:url namespace="/sysvip" action="memberStock_load"><s:param name="viewFlag">mdy</s:param><s:param name="memberStock.uuid" value="uuid"></s:param></s:url>">修改</a>
	    	</s:if>
	    	<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJM_SYSVIP_MEMBERSTOCK_DEL')">
	    	<a class="input-red" href="<s:url namespace="/sysvip" action="memberStock_del"><s:param name="memberStock.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
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