<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品类型管理--<s:text name="APP_NAME" /></title>
<s:action name="ref_head" namespace="/manager" executeResult="true" />
</head>
<body>
 <s:action name="nav" namespace="/manage" executeResult="true" />
<div class="tab_right">
	<div class="tab_warp main">
	<div class="dq_step">
		${path}
		<span class="opb lb op-area"><a href="<s:url namespace="/sysebiz" action="goodsType_load"><s:param name="viewFlag">add</s:param></s:url>" >添加商品类型</a></span>
	</div>
	<div class="tab_warp">
 		<table id="table1">
 			<tr id="coltr">
              <th  class="td1">编号</th>
              <th  class="td1">类型名称</th>
              <th  class="td2">属性分组</th>
              <th  class="td3">属性个数</th>
              <th  class="td3">状态</th>
              <th  class="td4">操作</th>
              <th  class="td0">查看</th>
            </tr>
            <s:iterator value="goodsTypes" status="sta">
            	<tr id="showtr${uuid}">
	              <td  class="td1">${uuid}</td>
	              <td  class="td1">${type_name}</td>
	              <td  class="td2">${type_group}</td>
	              <td  class="td3">${item_num}</td>
	              <td  class="td3">
	              		<s:if test="0==status"><span class="yesarea"></span></s:if>
						<s:elseif test="1==status"><span class="noarea"></span></s:elseif>
	              </td>
	              <td  class="td4 op-area">
	              		<a class="input-blue" href="<s:url namespace="/sysebiz" action="goodsType_load"><s:param name="viewFlag">mdy</s:param><s:param name="goodsType.uuid" value="uuid"></s:param></s:url>">修改</a>
	    				<a class="input-red" href="<s:url namespace="/sysebiz" action="goodsType_del"><s:param name="goodsType.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
	              </td>
	              <td  class="td0 op-area"><a onclick="showDetail('showtr${uuid}');" href="javascript:;" class="input-nostyle">查看</a></td>
	            </tr>
            </s:iterator>
       	</table>
    </div>
   <div id="listpage" class="pagination"></div>
	<div class="tab_warp">
		<span id="message"><s:property value="message" /></span>
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