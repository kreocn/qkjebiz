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
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="/ckframe/include/widget.js"></script>
<body>
  <div id="main">
    <div id="result">
      <div class="itablemdy">
        <div class="itabletitle">
          <span class="title1"><s:if test="'add' == viewFlag">增加</s:if>
            <s:elseif test="'mdy' == viewFlag">修改</s:elseif>工业旅游申请</span> <span class="extra1"> <a href="<s:url action="travel_list" namespace="/qkjmanage" />">工业旅游申请列表</a>
          </span>
        </div>
        <s:form name="form1" action="travel_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
          <div class="ifromoperate"></div>
          <table class="ilisttable" width="100%">
            <s:if test="'mdy' == viewFlag">
              <tr>
                <td class='firstRow3'>申请单编号:</td>
                <td class='secRow3'>
                  <s:property value="travel.uuid" />
                  <s:hidden name="travel.uuid" /><s:hidden name="travel.check_status" /><s:hidden name="travel.acheck_status" />
                 </td>
                 <td class='firstRow3'>业务审核状态:</td>
                 <td class='secRow3'>
                    <s:if test="travel.check_status==0">新申请</s:if>
                    <s:if test="travel.check_status==5"><span class="message_error">已退回</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
                    <s:if test="travel.check_status==10"><span class="message_warning">待审核</span></s:if>
                    <s:if test="travel.check_status==20"><span class="message_pass">经理/大区已审</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
                    <s:if test="travel.check_status==30"><span class="message_pass">总监已审</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd')})</span></s:if>
                    <s:if test="travel.check_status==40"><span class="message_pass">业务副总已审</span><span class="nowrap">(${travel.check_user_name} ${it:formatDate(travel.check_time,'yyyy-MM-dd')})</span></s:if>
                 </td>
                 <td class='firstRow3'>行政审核状态:</td>
                 <td class='secRow3'>
                    <s:if test="travel.acheck_status==0">新申请</s:if>
                 	<s:if test="travel.acheck_status==5"><span class="message_error">已退回</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
                    <s:if test="travel.acheck_status==10"><span class="message_warning">待审核</span></s:if>
                    <s:if test="travel.acheck_status==20"><span class="message_pass">行政经理已审</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
                    <s:if test="travel.acheck_status==30"><span class="message_pass">行政副总已审</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
                    <s:if test="travel.acheck_status==40"><span class="message_pass">总经理已审</span><span class="nowrap">(${travel.acheck_user_name} ${it:formatDate(travel.acheck_time,'yyyy-MM-dd HH:mm:ss')})</span></s:if>
                 </td>
              </tr>
            </s:if>
            <tr>
              <td class='firstRow3'>申请部门/人:</td>
              <td class='secRow3' colspan="5">
                ${travel.apply_dept_name} ${travel.apply_user_name}
                <s:hidden name="travel.apply_dept" /><s:hidden name="travel.apply_user" />
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
              <td class='secRow3' colspan="3">
                   从<input id="travel_travel_date" name="travel.travel_date"  value="${it:formatDate(travel.travel_date,'yyyy-MM-dd')}" class="date_input" type="text" title="执行日期" dataType="date" controlName="执行日期" />
                   到<input id="travel_travel_date_end" name="travel.travel_date_end" value="${it:formatDate(travel.travel_date_end,'yyyy-MM-dd')}" class="date_input" type="text" title="执行日期" dataType="date" controlName="执行日期" />
             </td>
             <td class='firstRow3'>客户人数:</td>
              <td class='secRow3'>
                <s:textfield name="travel.travel_num" title="客户人数" dataLength="0,10"  cssClass="int_input" dataType="integer" controlName="客户人数" /> 人
                <span class="fb">陪同:</span>
                <s:textfield name="travel.accompany_num" title="陪同人数" dataLength="0,10" cssClass="int_input" dataType="integer" controlName="陪同人数" /> 人
             </td>
            </tr>
            <tr>
              <td class='firstRow3'>客户单位:</td>
              <td class='secRow3' colspan="5"> 
                <s:textfield id="travel_members_names" name="travel.members_names" title="客户单位" cssStyle="width:95%;"  />
                <span class="nowrap message_prompt">单位名称之间请用半角逗号,或者空格隔开</span>
               </td>
             </tr>
             <s:if test="'mdy' == viewFlag">
             <tbody id="cus_info_tbody">
             <tr>
              <td class="titleRow" colspan="6">客户详情/来访客户资料
              <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
              <input type="button" id="AddCustomer" value="添加客户资料" />
              </s:if>
              </td>
            </tr>
            <tr>
              <td class="secRow3" colspan="6">
                <s:if test="travelCustomers==null || travelCustomers.size==0">
                        <div style="text-align: center;line-height: 30px;">暂无客户信息</div>
                </s:if>
                <s:else>
                <table class="ilisttable ilisttable-center" id="table1" width="100%">
                  <tr>
                    <th>资料编号</th>
                    <th>客户姓名</th>
                    <th>性别</th>
                    <th>单位名称</th>
                    <th>客户类别</th>
                    <th>联系电话</th>
                    <th>身份证号</th>
                    <th>操作</th>
                  </tr>
              <s:iterator value="travelCustomers" status="sta">
                  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
                    <td><s:property value="uuid" /></td>
                      <td><s:property value="cus_name" /></td>
                      <td>
                        <s:if test="cus_sex==0">男</s:if>
                        <s:elseif test="cus_sex==1">女</s:elseif>
                      </td>
                      <td><s:property value="cus_company" /></td>
                      <td>
                        <s:if test="cus_type==1">政府</s:if>
                        <s:elseif test="cus_type==2">企业</s:elseif>
                        <s:elseif test="cus_type==3">经销商</s:elseif>
                        <s:elseif test="cus_type==4">潜在客户</s:elseif>
                        <s:elseif test="cus_type==5">终端零售</s:elseif>
                        <s:elseif test="cus_type==6">专卖店消费者</s:elseif>
                        <s:elseif test="cus_type==7">其他</s:elseif>
                      </td>
                      <td><s:property value="cus_phone" /></td>
                      <td><s:property value="cus_idcard" /></td>
                  <td align="center">
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_DEL') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
                      [<a href="<s:url namespace="/qkjmanage" action="travelCustomer_del"><s:param name="travelCustomer.uuid" value="uuid" /><s:param name="travelCustomer.travel_id" value="travel_id" /></s:url>" onclick="return isDel();">删除</a>]
                      </s:if>    
                    </td>
                  </tr>
              </s:iterator>
                </table>
                </s:else>
              </td>
            </tr>
            </tbody>
            </s:if>
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
            <s:if test="'mdy' == viewFlag">
            <tr>
              <td class='firstRow3'>
                      餐酒标准:<br />
                <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELPRODUCT_ADD') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
                <input type="button" id="AddProduct" value="添加酒品" />
                </s:if>
              </td>
              <td class='secRow3'  colspan="5">
               <s:if test="travelProducts==null || travelProducts.size==0">
                    <div style="line-height: 30px;">暂无酒品信息</div>
                </s:if>
                <s:else>
              <table class="ilisttable ilisttable-center" id="table1">
                  <col width="" />
                  <col width="50" />
                  <col width="" />
                  <tr>
                    <th>产品名称</th>
                    <th>数量(瓶|公斤)</th>
                    <th>操作</th>
                  </tr>
                  <s:iterator value="travelProducts" status="sta">
                    <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>" type="pickrow">
                      <td><s:property value="product_name" /></td>
                      <td><s:property value="num" /></td>
                      <td align="center">
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELPRODUCT_DEL') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
                      [<a href="<s:url namespace="/qkjmanage" action="travelProduct_del"><s:param name="travelProduct.uuid" value="uuid" /><s:param name="travelProduct.travel_id" value="travel_id" /></s:url>" onclick="return isDel();">删除</a>]
                      </s:if>
                    </td>
                    </tr>
                  </s:iterator>
                </table>
                <span class="message_prompt nowrap">散酒的单位是:公斤 | 瓶装酒单位是:瓶</span>
                </s:else>
              </td>
            </tr>
            </s:if>
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
              <td class='firstRow3'>车辆派送:</td>
              <td class='secRow3' colspan="3"><s:checkboxlist name="travel.cars" list="#{'大巴':'大巴','中巴':'中巴','商务':'商务','轿车':'轿车'}" /></td>
              <td class='firstRow3'>是否联系旅行社:</td>
              <td class='secRow3'><s:radio name="travel.travel_agency" list="#{0:'否',1:'是' }" /></td>
            </tr>
            <tr>
              <td class="titleRow" colspan="6">具体行程安排<span class="message_prompt nowrap">请尽量不要超过8行</span></td>
            </tr>
            <tr>
              <td class='secRow3' colspan="6">
                <s:if test="travel.check_status<=5 ||  travel.acheck_status<=5">
                <s:textfield id="travel_trip" name="travel.trip" title="具体行程安排" dataLength="0,65535" controlName="具体行程安排" />
                </s:if>
                <s:else>${travel.trip}</s:else>
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
              <td class='secRow3' colspan="5">
                <s:if test="travel.check_status<=5 ||  travel.acheck_status<=5">
                <s:textarea name="travel.note" cssStyle="width:80%;" rows="4" title="其他情况说明" dataLength="0,65535" controlName="其他情况说明" />
                </s:if>
                <s:else>${travel.note}</s:else>
              </td>
            </tr>
            <tr>
              <td class='firstRow3'>相关操作:</td>
              <td class='secRow3' colspan="20">
                <s:if test="'add' == viewFlag">
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ADD')">
                    <s:submit id="add" name="add" value="下一步-添加客户信息和招待酒品信息" action="travel_add" />
                  </s:if>
                </s:if>
                <s:elseif test="'mdy' == viewFlag">
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
                    <s:submit id="travel_mdyCheckStatus10" name="travel_mdyCheckStatus10" value="经理/大区审核通过" action="travel_mdyCheckStatus10" onclick="return isOp('确定要执行此操作?');" />
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
                    <s:submit id="travel_mdyCheckStatus5" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" onclick="return isOp('确定要执行此操作?');" />
                    </s:if>
                  </s:if>
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK20') && travel.check_status==20">
                    <s:submit id="travel_mdyCheckStatus20" name="travel_mdyCheckStatus20" value="总监审核通过" action="travel_mdyCheckStatus20" onclick="return isOp('确定要执行此操作?');" />
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
                    <s:submit id="travel_mdyCheckStatus5" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" onclick="return isOp('确定要执行此操作?');" />
                    </s:if>
                  </s:if>
                  <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK30') && travel.check_status==30">
                    <s:submit id="travel_mdyCheckStatus30" name="travel_mdyCheckStatus30" value="业务副总审核通过" action="travel_mdyCheckStatus30" onclick="return isOp('确定要执行此操作?');" />
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_CHECK5')">
                    <s:submit id="travel_mdyCheckStatus5" name="travel_mdyCheckStatus5" value="审核不通过" action="travel_mdyCheckStatus5" onclick="return isOp('确定要执行此操作?');" />
                    </s:if>
                  </s:if>
                  <s:if test="travel.check_status>=30">
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK10') && travel.acheck_status==10">
                      <s:submit id="travel_mdyACheckStatus10" name="travel_mdyACheckStatus10" value="行政经理审核通过" action="travel_mdyACheckStatus10" onclick="return isOp('确定要执行此操作?');" />
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
                      <s:submit id="travel_mdyACheckStatus5" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" onclick="return isOp('确定要执行此操作?');" />
                      </s:if>
                    </s:if>
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK20') && travel.acheck_status==20">
                      <s:submit id="travel_mdyACheckStatus20" name="travel_mdyACheckStatus20" value="行政副总审核通过" action="travel_mdyACheckStatus20" onclick="return isOp('确定要执行此操作?');" />
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
                      <s:submit id="travel_mdyACheckStatus5" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" onclick="return isOp('确定要执行此操作?');" />
                      </s:if>
                    </s:if>
                    <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK30') && travel.acheck_status==30">
                      <s:submit id="travel_mdyACheckStatus30" name="travel_mdyACheckStatus30" value="总经理审核通过" action="travel_mdyACheckStatus30" onclick="return isOp('确定要执行此操作?');" />
                      <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVEL_ACHECK5')">
                      <s:submit id="travel_mdyACheckStatus5" name="travel_mdyACheckStatus5" value="审核不通过" action="travel_mdyACheckStatus5" onclick="return isOp('确定要执行此操作?');" />
                      </s:if>
                    </s:if>
                  </s:if>
                </s:else>
              </s:elseif> 
                <input type="button" value="返回" onclick="location.href='<s:url action="travel_relist" namespace="/qkjmanage" />';" />
                <span id="message"><s:property value="message" /></span> 
               </td>
            </tr>
          </table>
        </s:form>
      </div>
    </div>
  </div>
  <s:if test="'mdy' == viewFlag">
  <div id="AddCustomerForm" title="添加客户资料">
  <s:form name="form1" action="travelCustomer_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
  <div class="ifromoperate" >
    <input type="hidden" name="travelCustomer.travel_id" value="${travel.uuid }" />
  </div>
  <table class="ilisttable" width="100%">
      <tr>
      <td class='firstRow'><span style="color:red;">*</span> 客户姓名:</td>
      <td class='secRow'><s:textfield name="travelCustomer.cus_name" title="客户姓名" require="required" dataLength="0,32" controlName="客户姓名" /></td>
      </tr>
      <tr>
      <td class='firstRow'>性别:</td>
      <td class='secRow'><s:radio name="travelCustomer.cus_sex" list="#{0:'男',1:'女'}" /></td>
      </tr>
      <tr>
      <td class='firstRow'>单位名称:</td>
      <td class='secRow'>
        <s:textfield id="travelCustomer_cus_company" name="travelCustomer.cus_company" title="单位名称" dataLength="0,255" controlName="单位名称" />
        <select id="cus_select"><option>--请选择--</option></select>
      </td>
      </tr>
      <tr>
      <td class='firstRow'>客户类别:</td>
      <td class='secRow'>
        <s:select name="travelCustomer.cus_type" title="客户类别" list="#{1:'政府',2:'企业',3:'经销商',4:'潜在客户',5:'终端零售',6:'专卖店消费者',7:'其他'}" />
      </td>
      </tr>
      <tr>
      <td class='firstRow'>联系电话:</td>
      <td class='secRow'><s:textfield name="travelCustomer.cus_phone" title="联系电话" dataLength="0,55" controlName="联系电话" /></td>
      </tr>
      <tr>
      <td class='firstRow'>身份证号:</td>
      <td class='secRow'><s:textfield name="travelCustomer.cus_idcard" title="身份证号" dataLength="0,32" controlName="身份证号" /></td>
      </tr>
      <tr>
      <td class='firstRow'>备注:</td>
      <td class='secRow'><s:textfield name="travelCustomer.note" title="备注" dataLength="0,255" controlName="备注" /></td>
      </tr>
    <tr>
        <td colspan="20" class="buttonarea">
          <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELCUSTOMER_ADD') && (travel.check_status<=5 ||  travel.acheck_status<=5)">
          <s:submit id="add" name="add" value="确定" action="travelCustomer_add" />
          </s:if>
      </td>
      </tr>
  </table>  
</s:form>
  </div>
  <div id="AddProductForm" title="添加酒品">
    <s:form name="form1" action="travelProduct_add" namespace="/qkjmanage" onsubmit="return validator(this);" method="post" theme="simple">
      <div class="ifromoperate"><input type="hidden" name="travelProduct.travel_id"  value="${travel.uuid }" /></div>
      <table class="ilisttable" width="100%">
        <tr>
          <td class='firstRow'><span style="color: red;">*</span> 产品:</td>
          <td class='secRow'>
            <s:select name="travelProduct.product_id" list="products" listKey="uuid" listValue="title" require="required"
                headerKey="" headerValue="--请选择--"  />
          </td>
        </tr>
        <tr>
          <td class='firstRow'><span style="color: red;">*</span> 数量:</td>
          <td class='secRow'>
            <s:textfield name="travelProduct.num" title="数量" require="required" dataLength="0,10" dataType="integer" controlName="数量" />
            <span class="message_prompt nowrap">散酒(公斤) | 瓶装酒(瓶)</span>
         </td>
        </tr>
        <tr>
          <td colspan="20" class="buttonarea">
              <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_TRAVELPRODUCT_ADD')">
                <s:submit id="add" name="add" value="确定" action="travelProduct_add" />
              </s:if>
           </td>
        </tr>
      </table>
    </s:form>
  </div>
  </s:if>
  <script type="text/javascript">
var infoeditor01;
var mns = '${travel.members_names}';
$(function(){
  if($("#travel_trip").length>0) {
    infoeditor01 = new widget_textarea();
    infoeditor01.init("travel_trip");
  }
  $('#travel_hotel_start').datepicker();
  $('#travel_hotel_end').datepicker();
  $('#travel_travel_date').datepicker();
  $('#travel_travel_date_end').datepicker();
  //<s:if test="'mdy' == viewFlag">
  $("#AddCustomerForm").dialog({
      autoOpen: false,
      height: 330,
      width: 400,
      modal: true
  });
  
  $("#AddCustomer").click(function(){
	  if(mns!=null || mns!='') {
		  $("#cus_select").clearAllOption();
		  $("#cus_select").addOption("--请选择--","");
		  var ts = mns.replace(/\s+/g," ").split(/[,| ]/);
		  for(i=0;i<ts.length;i++) {
			  $("#cus_select").addOption(ts[i],ts[i]);
		  }
	  }
	  $("#AddCustomerForm").dialog("open");
  });
  
  $("#cus_select").change(function(){
	  $("#travelCustomer_cus_company").val($(this).val());
  });
  
  $("#AddProductForm").dialog({
      autoOpen: false,
      height: 160,
      width: 400,
      modal: true
  });
  
  $("#AddProduct").click(function(){
	  $("#AddProductForm").dialog("open");
  });
  //</s:if>
});
</script>
</body>
</html>