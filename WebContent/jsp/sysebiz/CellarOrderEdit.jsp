<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sx" uri="/struts-dojo-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>取酒订单管理--<s:text name="APP_NAME" /></title>
</head>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/select_area.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/singlejs/order.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript">
var sa;
var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
$(function() {
	setInitAddress();
	// 此段代码可以方式回车提交
	jQuery(function($){
	    $("form").keypress(function(e){
	        if(e.keyCode == 13) {
	            e.preventDefault();
	        }
	    });  
	});
});
	
var setInitAddress = function() {
	var c_con_name,c_con_mobile,c_con_province,c_con_city,c_con_area,c_con_post,c_con_street,c_con_note;
	c_con_name = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_name" />','<s:property value="order.con_name" />'));
	c_con_mobile = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_mobile" />','<s:property value="order.con_mobile" />'));
	c_con_province = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_province" />','<s:property value="order.con_province" />'));
	c_con_city = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_city" />','<s:property value="order.con_city" />'));
	c_con_area = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_area" />','<s:property value="order.con_area" />'));
	c_con_post = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_post" />','<s:property value="order.con_post" />'));
	c_con_street = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_street" />','<s:property value="order.con_street" />'));
	c_con_note = toHTML.un(getValueNotEmpty('<s:property value="cellarOrder.con_note" />','<s:property value="order.con_note" />'));

	$(":input[name='cellarOrder.con_name']").val(c_con_name);
	$(":input[name='cellarOrder.con_mobile']").val(c_con_mobile);
	$(":input[name='cellarOrder.con_post']").val(c_con_post);
	$(":input[name='cellarOrder.con_street']").val(c_con_street);
	$(":input[name='cellarOrder.con_note']").val(c_con_note);
	
	sa = new SArea($("#con_provinceid"), $("#con_cityid"), $("#con_areaid"));
	sa.ajax_url = ajax_url_action;
	sa.init(c_con_province, c_con_city,c_con_area);
};

//工具类,如果val1不为空,则返回val1,否则返回val2
var getValueNotEmpty = function(val1,val2) {
	return (val1==null || val1=='')?val2:val1;
}
</script>
<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == cellarOrder && 'add' == viewFlag">增加</s:if><s:elseif test="null != cellarOrder && 'mdy' == viewFlag">修改</s:elseif>取酒订单</span>
		<span class="extra1">
			<a href="<s:url action="cellarOrder_list" namespace="/sysebiz" />" >取酒订单列表</a>
		</span>	
	</div>
<s:form id="formEdit" name="formEdit" action="cellarOrder_add" namespace="/sysebiz" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
		
		
	<tr><td class="titleRow" colspan="20">取酒订单基本信息</td></tr>
	<s:if test="null != cellarOrder">
	<tr>
		<td class='firstRow'>订单号:</td>
		<td class='secRow'><s:property value="cellarOrder.uuid" /><s:hidden name="cellarOrder.uuid" /></td>
		<td class='firstRow'>订单状态:</td>
		<td class='secRow'>
			<s:if test="0==cellarOrder.status">作废订单</s:if>
			<s:if test="10==cellarOrder.status">新订单</s:if>	
			<s:if test="20==cellarOrder.status">已灌装</s:if>
			<s:if test="30==cellarOrder.status">已发货</s:if>	
			<s:if test="40==cellarOrder.status">已收货</s:if>
			<s:if test="50==cellarOrder.status">已评价</s:if>
		</td>
	</tr>
	</s:if>
	<tr>
		<td class='firstRow'><span style="color:red;">*</span>取酒数量:</td>
		<td class='secRow'>
		<s:if test="(null == cellarOrder && 'add' == viewFlag) || (cellarOrder.status>=10 && cellarOrder.status<=20)">
			<select id="order_num_id" name="cellarOrder.order_num" ></select>
			<s:property value="memberCellar.goods_spec_unit" />
			(剩余:<s:property value="memberCellar.stock" />L)
			<script type="text/javascript">
			for(var i=4;i<=<s:if test="cellarOrder==null || cellarOrder.order_num==null"><s:property value="memberCellar.stock" /></s:if><s:else><s:property value="memberCellar.stock+cellarOrder.order_num" /></s:else>;i=i+4) {
				$("#order_num_id").addOption(i,i);
				//<s:if test="cellarOrder.order_num!=null">
				$("#order_num_id").setSelectedValue(<s:property value="cellarOrder.order_num" />);
				//</s:if>
			}
			</script>
		</s:if>	
		<s:else>
			<s:property value="cellarOrder.order_num" />
			<s:property value="cellarOrder.cellar_unit" />
			<s:hidden name="cellarOrder.order_num" />
		</s:else>
		</td>
		<s:if test="null != cellarOrder">
		<td class='firstRow'>订单来源:</td>
		<td class='secRow'>
			<s:if test="0==cellarOrder.order_source"><span class="message_pass">客户自助下单</span></s:if>
			<s:if test="1==cellarOrder.order_source">代客下单</s:if>
		</td>
		</s:if>
	</tr>
	<s:if test="null != cellarOrder">
	<tr>
	<td class='firstRow'>订单添加人:</td>
	<td class='secRow'><s:property value="cellarOrder.add_user_name" />[<s:date name="cellarOrder.add_time" format="yyyy-MM-dd HH:mm:ss" />]</td>
	<td class='firstRow'>最后修改人:</td>
	<td class='secRow'><s:property value="cellarOrder.lm_user_name" />[<s:date name="cellarOrder.lm_time" format="yyyy-MM-dd HH:mm:ss" />]</td>
	</tr>
	</s:if>
	<tr>
		<td class='firstRow'>取酒仓库:</td>
		<td class='secRow'><s:property value="memberCellar.ware_name" /></td>
		<td class='firstRow'>酒坛位置:</td>
		<td class='secRow'><s:property value="memberCellar.cellar_position" /></td>
	</tr>
	<tr><td class="titleRow" colspan="20">送货/快递地址 <!--[<a id="moreaddresstext" href="javascript:;" onclick="showMoreAddress();">显示更多地址</a>] --></td></tr>
		<tr id="orderconsigneid_p" style="display: none;">
		<td class='secRow' colspan="20" id="orderconsigneid"></td>
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span>配送方式:</td>
		<td class='secRow'>
			<s:select name="cellarOrder.express_type" title="配送方式" headerKey="" headerValue="--请选择--" list="#{0:'快递',1:'上门自提'}" controlName="配送方式" require="required" />	
		</td>
		<td class='firstRow'>快递单号:</td>
		<td class='secRow'><s:textfield name="cellarOrder.express_no" title="快递单号" dataLength="0,85" controlName="快递单号" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span>收货人姓名:</td>
			<td class='secRow'><s:textfield name="cellarOrder.con_name" title="收货人姓名" dataLength="0,85" controlName="收货人姓名" require="required" /></td>
			<td class='firstRow'><span style="color:red;">*</span>联系电话:</td>
			<td class='secRow'><s:textfield name="cellarOrder.con_mobile" title="手机/联系电话" dataLength="0,85" controlName="手机/联系电话" require="required" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span>收货地区:</td>
			<td class='secRow'>
				<s:select name="cellarOrder.con_province" id="con_provinceid" title="省" list="#{}" require="required" controlName="所在地区"></s:select>
				<s:select name="cellarOrder.con_city" id="con_cityid" title="市" list="#{}"></s:select>
				<s:select name="cellarOrder.con_area" id="con_areaid" title="县" list="#{}"></s:select>
			<td class='firstRow'>邮编:</td>
			<td class='secRow'><s:textfield name="cellarOrder.con_post" title="邮编" dataLength="0,85" controlName="邮编" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span>街道地址:</td>
			<td class='secRow'><s:textarea name="cellarOrder.con_street" title="街道地址" dataLength="0,21845" controlName="街道地址" require="required" cssStyle="width:80%;" /></td>
			<td class='firstRow'>收货人备注:</td>
			<td class='secRow'><s:textarea  name="cellarOrder.con_note" title="收货人备注" dataLength="0,21845" controlName="收货人备注" cssStyle="width:80%;"></s:textarea></td>
		</tr>
		<tr><td class="titleRow" colspan="20">视频信息</td></tr>
		<tr>
		<td class='firstRow'>视频地址:</td>
		<td class='secRow'><s:textfield name="cellarOrder.order_video" title="视频地址" controlName="视频地址" cssStyle="width:90%;" /></td>
		<td class='firstRow'>视频提取密码:</td>
		<td class='secRow'><s:textfield name="cellarOrder.order_video_pass" title="提取密码" dataLength="0,85" controlName="提取密码" /></td>
		</tr>
		<tr><td class="titleRow" colspan="20">原订单信息</td></tr>
		<tr>
			<td class='firstRow'>订单号:</td>
			<td class='secRow'><s:property value="order.uuid" /></td>
			<td class='firstRow'>会员号:</td>
			<td class='secRow'><s:property value="order.user_id" /></td>
		</tr>
		<tr>
			<td class='firstRow'>会员姓名:</td>
			<td class='secRow'><s:property value="order.user_name" /></td>
			<td class='firstRow'>联系电话:</td>
			<td class='secRow'><s:property value="order.user_mobile" /></td>
		</tr>
		<tr>
		    <td colspan="20" class="buttonarea">
		    	<s:hidden name="memberCellarID" />
		    	<span id="message"><s:property value="message" /></span>
				<s:if test="null == cellarOrder && 'add' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_CELLARORDER_ADD')">
					<s:submit id="add" name="add" value="新增订单" action="cellarOrder_add" />
					</s:if>
				</s:if>
				<s:elseif test="null != cellarOrder && 'mdy' == viewFlag">
					<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_CELLARORDER_MDY')">
						<s:submit id="save" name="save" value="保存订单" action="cellarOrder_save" />
						<script type="text/javascript">
						$(function(){
							$("#formEdit :input").change(function(){
								//if()cellarOrder_check0 10 15 20
								//$("#rebates_mdyRebatesStatus0").attr("disabled","disabled");
								if($("#cellarOrder_check0").length>0) {
									$("#cellarOrder_check0").attr("disabled","disabled");
								}
								if($("#cellarOrder_check10").length>0) {
									$("#cellarOrder_check10").attr("disabled","disabled");
								}
								if($("#cellarOrder_check15").length>0) {
									$("#cellarOrder_check15").attr("disabled","disabled");
								}
								if($("#cellarOrder_check20").length>0) {
									$("#cellarOrder_check20").attr("disabled","disabled");
								}
								$("#message").text("请先保存后才能做其他操作!");
							});
						});
						</script>
					</s:if>
					
					<s:if test="10==cellarOrder.status">
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_CELLARORDER_CHECK10')">
						<s:submit id="cellarOrder_check10" name="cellarOrder_check10" value="灌装完成" action="cellarOrder_check10" onclick="return isOp('是否灌装完成?');" />
						</s:if>
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_CELLARORDER_CHECK0')">
						<s:submit id="cellarOrder_check0" name="cellarOrder_check0" value="订单作废" action="cellarOrder_check0" onclick="return isOp('是否订单作废?\n订单作废后将直接删除!');" />
						</s:if>
					</s:if>
					<s:if test="20==cellarOrder.status">
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_CELLARORDER_CHECK20')">
						<s:submit id="cellarOrder_check20" name="cellarOrder_check20" value="发货完成" action="cellarOrder_check20" onclick="return isOp('是否发货完成?') && check_express_no();" />
						</s:if>
					</s:if>
					<s:if test="30==cellarOrder.status">
						<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJCJ_SYSEBIZ_CELLARORDER_CHECK15')">
						<s:submit id="cellarOrder_check15" name="cellarOrder_check15" value="重新发货" action="cellarOrder_check15" onclick="return isOp('是否重新发货?')" />
						</s:if>
					</s:if>
				</s:elseif>
				<input type="button" value="返回订单列表" onclick="linkurl('<s:url action="cellarOrder_list" namespace="/sysebiz" />');" />
			</td>
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>