<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工业旅游申请管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.dialog.iframe.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
<body>
  <div id="main">
    <div id="result">
      <div class="itablemdy">
        <div class="itabletitle">
          <span class="title1"><s:if test="null == travel && 'add' == viewFlag">增加</s:if>
            <s:elseif test="null != travel && 'mdy' == viewFlag">修改</s:elseif>工业旅游申请</span> <span class="extra1"> <a href="<s:url action="travel_list" namespace="/qkjmanage" />">工业旅游申请列表</a>
          </span>
        </div>
        <s:form name="form1" action="travel_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
          <div class="ifromoperate">
            <!-- 
            业务审核状态
            业务审核人<s:hidden name="travel.check_user" />
            业务审核时间<s:hidden name="travel.check_time" />
            业务审核意见<s:hidden name="travel.check_note" />
            行政审核状态
            行政审核人<s:hidden name="travel.acheck_user" />
            行政审核时间<s:hidden name="travel.acheck_time" />
            行政审核意见<s:hidden name="travel.acheck_note" />
             -->
          </div>
          <table class="ilisttable" width="100%">
            <s:if test="null != travel">
              <tr>
                <td class='firstRow3'>申请单编号:</td>
                <td class='secRow3'><s:property value="travel.uuid" />
                 <s:hidden name="travel.uuid" title="申请单编号" /></td>
                 <td class='firstRow3'>业务审核状态:</td>
                 <td class='secRow3'>
                    <s:if test="travel.check_status==0">新申请</s:if>
                    <s:if test="travel.check_status==5"><span class="message_error" title="${travel.check_user_name}">已退回</span></s:if>
                    <s:if test="travel.check_status==10"><span class="message_warning">待审核</span></s:if>
                    <s:if test="travel.check_status==20"><span class="message_pass"  title="${travel.check_user_name}">经理/大区已审</span></s:if>
                    <s:if test="travel.check_status==30"><span class="message_pass"  title="${travel.check_user_name}">总监已审</span></s:if>
                    <s:if test="travel.check_status==40"><span class="message_pass"  title="${travel.check_user_name}">业务副总已审</span></s:if>
                    <s:hidden name="travel.check_status" />
                 </td>
                 <td class='firstRow3'>行政审核状态:</td>
                 <td class='secRow3'>
                    <s:if test="travel.acheck_status==0">新申请</s:if>
                 	<s:if test="travel.acheck_status==5"><span class="message_error" title="${travel.acheck_user_name}">已退回</span></s:if>
                    <s:if test="travel.acheck_status==10"><span class="message_warning">待审核</span></s:if>
                    <s:if test="travel.acheck_status==20"><span class="message_pass"  title="${travel.acheck_user_name}">经理/大区已审</span></s:if>
                    <s:if test="travel.acheck_status==30"><span class="message_pass"  title="${travel.acheck_user_name}">总监已审</span></s:if>
                    <s:if test="travel.acheck_status==40"><span class="message_pass"  title="${travel.acheck_user_name}">业务副总已审</span></s:if>
                    <s:hidden name="travel.acheck_status" />
                 </td>
              </tr>
            </s:if>
            <tr>
              <td class='firstRow3'>申请部门/人:</td>
              <td class='secRow3' colspan="5">
                <s:textfield id="userdept_codeid" name="travel.apply_dept" readonly="true"  title="部门编号" require="required" controlName="部门编号" />
                <s:textfield id="userdept_nameid" name="travel.apply_dept_name" readonly="true"  title="部门名称" require="required" controlName="申请部门名称" />
                <img class="imglink" src='<s:url value="/images/open2.gif" />' onclick="selectDept();" />
                <span id="ajax_member_message"></span>
                <s:select id="membermanagerid" name="travel.apply_user" list="#{}" headerKey="" headerValue="--请选择--" />
             </td>
            </tr>
            <tr>
              <td class='firstRow3'>申请项目:</td>
              <td class='secRow3' colspan="5">
                <s:checkboxlist  name="travel.apply_items" list="#{'ITEM01':'厂区工艺流程','ITEM02':'新厂区','ITEM03':'高尔夫练习场打球体验','ITEM04':'参观中华土族园','ITEM99':'其他' }" />
             </td>
            </tr>
            <tr>
              <td class='firstRow3'>执行日期:</td>
              <td class='secRow3' colspan="5">
                   从<input id="travel_travel_date" name="travel.travel_date"  value="${it:formatDate(travel.travel_date,'yyyy-MM-dd')}" class="date_input" type="text" title="执行日期" dataType="date" controlName="执行日期" />
                   到<input id="travel_travel_date_end" name="travel.travel_date_end" value="${it:formatDate(travel.travel_date_end,'yyyy-MM-dd')}" class="date_input" type="text" title="执行日期" dataType="date" controlName="执行日期" />
             </td>
            </tr>
            <tr>
              <td class='firstRow3'>客户人数:</td>
              <td class='secRow3'><s:textfield name="travel.travel_num" title="客户人数" dataLength="0,10"  cssClass="int_input" dataType="integer" controlName="客户人数" /> 人</td>
              <td class='firstRow3'>陪同人数:</td>
              <td class='secRow3'><s:textfield name="travel.accompany_num" title="陪同人数" dataLength="0,10" cssClass="int_input" dataType="integer" controlName="陪同人数" /> 人</td>
              <td class='firstRow3'>客户单位:</td>
              <td class='secRow3'>共 <s:textfield name="travel.member_num" title="客户家数"  cssClass="int_input" dataLength="0,10" dataType="integer" controlName="客户家数" /> 家单位</td>
            </tr>
            <tr>
              <td class="titleRow" colspan="6">接待标准</td>
            </tr>
            <tr>
              <td class='firstRow3'>午餐用餐标准:</td>
              <td class='secRow3' colspan="3">
                      ￥<s:textfield name="travel.lunch_price" cssClass="date_input" title="午餐标准/桌" dataLength="0,10" dataType="number" controlName="午餐标准" /> 元/桌
                      共<s:textfield name="travel.lunch_num"  cssClass="int_input" title="午餐次数" dataLength="0,10" dataType="integer" controlName="午餐次数" /> 次
                      每次<s:textfield name="travel.lunch_desk"  cssClass="int_input" title="午餐桌数" dataLength="0,10" dataType="integer" controlName="午餐桌数" /> 桌
              </td>
              <td class='firstRow3'>是否使用香烟:</td>
               <td class='secRow3'>
                <s:radio name="travel.cigarette" list="#{0:'否',1:'是' }" />
                <s:textfield name="travel.cigarette_num" title="准备香烟包数" cssClass="int_input" dataLength="0,10" dataType="integer" controlName="准备香烟包数" /> 包
              </td>
            </tr>
            <tr>
              <td class='firstRow3'>晚餐用餐标准:</td>
              <td class='secRow3'  colspan="3">
                      ￥<s:textfield name="travel.dinner_price" title="晚餐标准/桌"  cssClass="date_input" dataLength="0,10" dataType="number" controlName="晚餐标准/桌" /> 元/桌
                      共<s:textfield name="travel.dinner_num" title="晚餐次数"  cssClass="int_input" dataLength="0,10" dataType="integer" controlName="晚餐次数" /> 次
                      每次<s:textfield name="travel.dinner_desk" title="晚餐桌数"  cssClass="int_input" dataLength="0,10" dataType="integer" controlName="晚餐桌数" /> 桌
              </td>
              <td class='firstRow3'>是否准备水果:</td>
              <td class='secRow3'><s:radio name="travel.fruit" list="#{0:'否',1:'是' }" /></td>
            </tr>
            <tr>
              <td class='firstRow3'>是否安排住宿:</td>
              <td class='secRow3'  colspan="3"><s:radio name="travel.hotel" list="#{0:'否',1:'是' }" /></td>
              <td class='firstRow3'>别墅规格:</td>
              <td class='secRow3'>
                <s:textfield name="travel.hotel_house" title="别墅规格(几人一套)"  cssClass="int_input" dataLength="0,10" dataType="integer" controlName="别墅规格(几人一套)" /> 人间
                <s:textfield name="travel.hotel_house_num" title="别墅套数"  cssClass="int_input" dataLength="0,10" dataType="integer" controlName="别墅套数" /> 套
              </td>
            </tr>
            <tr>
              
            </tr>
            <tr>
              <td class='firstRow3'>住宿时间:</td>
              <td class='secRow3' colspan="3">
                <input id="travel_hotel_start" name="travel.hotel_start"  value="${it:formatDate(travel.hotel_start,'yyyy-MM-dd')}" class="date_input" type="text" title="开始住宿时间" dataType="date" controlName="开始住宿时间" />
                -
                <input id="travel_hotel_end" name="travel.hotel_end"  value="${it:formatDate(travel.hotel_end,'yyyy-MM-dd')}" class="date_input" type="text" title="结束住宿时间" dataType="date" controlName="结束住宿时间" />
                      共 <s:textfield name="travel.hotel_total"  cssClass="int_input" title="总共住宿天数" dataLength="0,10" dataType="integer" controlName="总共住宿天数" /> 天
             </td>
              <td class='firstRow3'>标间:</td>
              <td class='secRow3'><s:textfield name="travel.hotel_twinroom"  cssClass="int_input" title="标间间数" dataLength="0,10" dataType="integer" controlName="标间间数" /> 间</td>
            </tr>
            <tr>
              <td class='firstRow3'>是否联系旅行社:</td>
              <td class='secRow3'><s:radio name="travel.travel_agency" list="#{0:'否',1:'是' }" /></td>
              <td class='firstRow3'>车辆派送:</td>
              <td class='secRow3' colspan="3"><s:checkboxlist name="travel.cars" list="#{'大巴':'大巴','中巴':'中巴','商务':'商务','轿车':'轿车'}" /></td>
            </tr>
            <tr>
              <td class='firstRow3'>具体行程安排:</td>
              <td class='secRow3' colspan="5">
                <s:textfield id="travel_trip" name="travel.trip" title="具体行程安排" dataLength="0,65535" controlName="具体行程安排" />
              </td>
            </tr>
            <tr>
              <td class="titleRow" colspan="6">礼品标准</td>
            </tr>
            <tr>
              <td class='firstRow3'>礼品品相:</td>
              <td class='secRow3' colspan="3"><s:textfield name="travel.gift" title="礼品品相" dataLength="0,108" controlName="礼品品相" /></td>
              <td class='firstRow3'>礼品份数:</td>
              <td class='secRow3'><s:textfield name="travel.gift_num" title="礼品份数" dataLength="0,10" dataType="integer" controlName="礼品份数" /></td>
            </tr>
            <tr>
              <td class='firstRow3'>其他情况说明:</td>
              <td class='secRow3' colspan="5"><s:textarea name="travel.note" cssStyle="width:80%;" rows="4" title="其他情况说明" dataLength="0,65535" controlName="其他情况说明" /></td>
            </tr>
            <tr>
              <td class='firstRow3'>相关操作:</td>
              <td class='secRow3' colspan="20">
                <s:if test="null == travel && 'add' == viewFlag">
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ADD')">
                    <s:submit id="add" name="add" value="确定" action="travel_add" />
                  </s:if>
                </s:if>
                <s:elseif test="null != travel && 'mdy' == viewFlag">
                <s:if test="travel.check_status<=5 ||  travel.acheck_status<=5">
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_MDY')">
                    <s:submit id="save" name="save" value="保存" action="travel_save" />
                  </s:if>
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK')">
                    <s:submit id="travel_mdyCheck" name="travel_mdyCheck" value="报审" action="travel_mdyCheck" onclick="return isOp('确定要执行此操作?');" />
                  </s:if>
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_DEL')">
                    <s:submit id="delete" name="delete" value="删除" action="travel_del" onclick="return isDel();" />
                  </s:if>
                </s:if>
                <s:else>
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK10') && travel.check_status==10">
                    <s:submit id="travel_mdyCheckStatus10" name="travel_mdyCheckStatus10" value="经理/大区审核通过" action="travel_mdyCheckStatus10" />
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
                    <s:submit id="travel_mdyCheckStatus5" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" />
                    </s:if>
                  </s:if>
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK20') && travel.check_status==20">
                    <s:submit id="travel_mdyCheckStatus20" name="travel_mdyCheckStatus20" value="总监审核通过" action="travel_mdyCheckStatus20" />
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
                    <s:submit id="travel_mdyCheckStatus5" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" />
                    </s:if>
                  </s:if>
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK30') && travel.check_status==30">
                    <s:submit id="travel_mdyCheckStatus30" name="travel_mdyCheckStatus30" value="业务副总审核通过" action="travel_mdyCheckStatus30" />
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
                    <s:submit id="travel_mdyCheckStatus5" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" />
                    </s:if>
                  </s:if>
                  <s:if test="travel.check_status>=20">
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK10') && travel.acheck_status==10">
                      <s:submit id="travel_mdyACheckStatus10" name="travel_mdyACheckStatus10" value="行政经理审核通过" action="travel_mdyACheckStatus10" />
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
                      <s:submit id="travel_mdyACheckStatus5" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" />
                      </s:if>
                    </s:if>
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK20') && travel.acheck_status==20">
                      <s:submit id="travel_mdyACheckStatus20" name="travel_mdyACheckStatus20" value="行政副总审核通过" action="travel_mdyACheckStatus20" />
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
                      <s:submit id="travel_mdyACheckStatus5" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" />
                      </s:if>
                    </s:if>
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK30') && travel.acheck_status==30">
                      <s:submit id="travel_mdyACheckStatus30" name="travel_mdyACheckStatus30" value="总经理审核通过" action="travel_mdyACheckStatus30" />
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
                      <s:submit id="travel_mdyACheckStatus5" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" />
                      </s:if>
                    </s:if>
                  </s:if>
                </s:else>
              </s:elseif> 
                <input type="button" value="返回" onclick="linkurl('<s:url action="travel_relist" namespace="/qkjmanage" />');" />
                <span id="message"><s:property value="message" /></span> 
               </td>
            </tr>
          </table>
        </s:form>
      </div>
    </div>
  </div>
  <script type="text/javascript">
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
var curr_dept = '${travel.apply_dept}';
var curr_user = '${travel.apply_user}';
var infoeditor01;
$(function(){
  if($("#travel_trip").length>0) {
    infoeditor01 = new widget_textarea();
    infoeditor01.init("travel_trip");
  }
  if(curr_dept!='') {
    loadManagers(curr_dept);
  }
  $('#travel_hotel_start').datepicker();
  $('#travel_hotel_end').datepicker();
  $('#travel_travel_date').datepicker();
  $('#travel_travel_date_end').datepicker();
});

var sobj01;
var selectDept = function() {
  sobj01 = new DialogIFrame({src:'<s:url namespace="/sys" action="dept_permit_select" />?objname=sobj01',title:"选择部门"});
  sobj01.selfAction = function(val1,val2) {
    $("#userdept_codeid").val(val1);
    $("#userdept_nameid").val(val2);
    loadManagers(val1);
  };
  sobj01.create();
  sobj01.open();
};

function loadManagers(dept_code) {
  var ajax = new Common_Ajax('ajax_member_message');
  ajax.config.action_url = ajax_url_action;
  ajax.config._success = function(data, textStatus) {
    $("#membermanagerid").clearAllOption();
    $("#membermanagerid").addOption("--请选择--","");
    $.each(data, function(i, n){
      $("#membermanagerid").addOption(n.user_name,n.uuid);
    });
    if(curr_user!='') {
      $("#membermanagerid").val(curr_user);
    }
  };
  ajax.addParameter("work", "AutoComplete");
  ajax.addParameter("parameters", "privilege_id=QKJCJ_SYS_AJAXLOAD_USER&dept_code=" + encodeURI(dept_code));
  ajax.sendAjax2();
}
</script>
</body>
</html>