<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请列表--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/common_listtable.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/show_page.js" />"></script>
<script type="text/javascript">
$(function(){
	CommonUtil.pickrow('table1');
	CommonUtil.pickrowAll('table1','uuidcheck');
 });
</script>
<body>
  <div id="main">
    <div id="result">
      <div class="itablemdy">
        <div class="itabletitle">
          <span class="title1">工业旅游申请列表</span> <span class="extra1"> <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ADD')">
              <a href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">add</s:param></s:url>">添加工业旅游申请</a>
            </s:if>
          </span>
        </div>
        <div class="ilistsearch">
          <s:form name="form_serach" action="travel_list" method="get" namespace="/qkjmanage" theme="simple">
            <table class="ilisttable" id="serach_table" width="100%">
              <tr>
                <td class='firstRow'>主键自增:</td>
                <td class='secRow'><s:property value="travel.uuid" /> <s:hidden name="travel.uuid" title="主键自增" /></td>
                <td class='firstRow'>申请部门:</td>
                <td class='secRow'><s:textfield name="travel.apply_dept" title="申请部门" dataLength="0,24" controlName="申请部门" /></td>
              </tr>
              <tr>
                <td class='firstRow'>申请人:</td>
                <td class='secRow'><s:textfield name="travel.apply_user" title="申请人" dataLength="0,48" controlName="申请人" /></td>
                <td class='firstRow'>业务审核状态:</td>
                <td class='secRow'><s:textfield name="travel.check_status" title="业务审核状态" dataLength="0,10" dataType="integer" controlName="业务审核状态" /></td>
              </tr>
              <tr>
                <td class='firstRow'>行政审核状态:</td>
                <td class='secRow'><s:textfield name="travel.acheck_status" title="行政审核状态" dataLength="0,10" dataType="integer" controlName="行政审核状态" /></td>
              </tr>
              <tr>
                <td colspan="4" class="buttonarea"><s:submit value="搜索" /> <s:reset value="重置" /></td>
              </tr>
            </table>
          </s:form>
        </div>
        <s:form name="form1" theme="simple">
          <table class="ilisttable ilisttable-center" id="table1" width="100%">
            <col width="30" />
            <tr>
              <th><input name="uuidcheck" type="checkbox" /></th>
              <th>申请编号</th>
              <th>申请部门</th>
              <th>申请人</th>
              <th>执行日期</th>
              <th>业务审核状态</th>
              <th>行政审核状态</th>
              <th>操作</th>
            </tr>
            <s:iterator value="travels" status="sta">
              <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
                <td align="center"><input name="uuid" type="checkbox" value="<s:property value="uuid" />" /></td>
                <td><s:property value="uuid" /></td>
                <td><s:property value="apply_dept_name" /></td>
                <td><s:property value="apply_user_name" /></td>
                <td>${it:formatDate(travel_date,'yyyy-MM-dd')} -- ${it:formatDate(travel_date_end,'yyyy-MM-dd')}</td>
                <td>
                  <s:if test="check_status==0">新申请</s:if>
                  <s:if test="check_status==5"><span class="message_error" title="${check_user_name}">已退回</span></s:if>
                  <s:if test="check_status==10"><span class="message_warning">待审核</span></s:if>
                  <s:if test="check_status==20"><span class="message_pass"  title="${check_user_name}">经理/大区已审</span></s:if>
                  <s:if test="check_status==30"><span class="message_pass"  title="${check_user_name}">总监已审</span></s:if>
                  <s:if test="check_status==40"><span class="message_pass"  title="${check_user_name}">业务副总已审</span></s:if>
                </td>
                <td>
                  <s:if test="acheck_status==0">新申请</s:if>
                  <s:if test="acheck_status==5"><span class="message_error" title="${acheck_user_name}">已退回</span></s:if>
                  <s:if test="acheck_status==10"><span class="message_warning">待审核</span></s:if>
                  <s:if test="acheck_status==20"><span class="message_pass"  title="${acheck_user_name}">经理/大区已审</span></s:if>
                  <s:if test="acheck_status==30"><span class="message_pass"  title="${acheck_user_name}">总监已审</span></s:if>
                  <s:if test="acheck_status==40"><span class="message_pass"  title="${acheck_user_name}">业务副总已审</span></s:if>
                </td>
                <td align="center">
                <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL')">
    	    	[<a href="<s:url namespace="/qkjmanage" action="travel_load"><s:param name="viewFlag">mdy</s:param><s:param name="travel.uuid" value="uuid"></s:param></s:url>">修改</a>]
    	    	</s:if> 
                <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_DEL') && (check_status<=5 || acheck_status<=5)">
      	    	[<a href="<s:url namespace="/qkjmanage" action="travel_del"><s:param name="travel.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>]
      	    	</s:if>
                </td>
              </tr>
            </s:iterator>
            <tr>
              <td colspan="20" class="buttonarea">
              <script type="text/javascript">
      			var spage = new ShowPage(${currPage});
      			spage.show2(${recCount},${pageSize},2);
      		  </script>
            </td>
            </tr>
            <tr>
              <td colspan="20" class="buttonarea"><span id="message"><s:property value="message" /></span></td>
            </tr>
          </table>
        </s:form>
      </div>
    </div>
  </div>
</body>
</html>