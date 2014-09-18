<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>出库单</title>
<title>出库管理--<s:text name="APP_NAME" /></title>
<link rel="stylesheet" href="<s:url value="/css/css.css" />" />
<link rel="stylesheet" href="<s:url value="/css/navigate.css" />" />
<link rel="stylesheet" href="<s:url value="/css/main.css" />" />
<script type="text/javascript" src="<s:url value="/js/form_validator.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_cptb.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-1.8.3.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.select.js" />"></script>
<link rel="stylesheet" href="<s:url value="/include/jQuery/style.ui.smoothness/jquery-ui-1.10.3.min.css" />" />
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery-ui-1.10.3.custom.min.js" />"></script>
<script type="text/javascript" src="<s:url value="/include/jQuery/jquery.ui.datepicker-zh.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/common_ajax2.0.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/func/select_member.js" />"></script>
<script type="text/javascript" src="<s:url value="/js/jquery.CommonUtil.js" />"></script>
</head>

<body>
<div id="main">
<div id="result">
	<div class="itablemdy">
	<div class="itabletitle">
		<span class="title1"><s:if test="null == outStock && 'add' == viewFlag">增加</s:if><s:elseif test="null != outStock && 'mdy' == viewFlag">修改</s:elseif>出库单（NO.<s:property value="outStock.ordernum" />）</span>
	</div>
<s:form name="form1" action="outStock_add" namespace="/outStock" onsubmit="return validator(this);" method="post" theme="simple">
	<div class="ifromoperate" ></div>
	<table class="ilisttable" width="100%">
	<!-- 主表显示 -->
		<s:if test="null != outStock">
		  <tr>
			<td class='firstRow'><span style="color:red;">*</span> 出库单号:</td>
			<td class='secRow' colspan="4"><s:property value="outStock.ordernum" />
			<s:hidden name="outStock.uuid"></s:hidden>
			<s:hidden name="outStock.send"></s:hidden>
			<s:hidden name="outDetail.lading_id"  title="出库单号" /></td>
			
		</tr>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span> 出库时间:</td>
			<td class='secRow'><s:date name="outStock.date" format="yyyy-MM-dd" /><s:hidden name="outStock.date" title="出库时间" /></td>
			<td class='firstRow'>状态:</td>
			<td class='secRow'>
				<s:if test='0==outStock.send'>借出未还</s:if>
				<s:if test='1==outStock.send'>借出已还</s:if>
				<s:if test='2==outStock.send'>新单</s:if>
				<s:if test='3==outStock.send'>待审核</s:if>
				<s:if test='4==outStock.send'>结案-<s:date name="lading.close_time" format="yyyy-MM-dd HH:mm:ss" /></s:if>
				<s:if test='5==outStock.send'>已取消订单</s:if>
			</td>
		</tr>
		</s:if>
		<tr>
		<td class='firstRow'><span style="color:red;">*</span>经手人:</td>
		<td class='secRow'><s:property value="outStock.operator_name" /></td>
		<td class='firstRow'><span style="color:red;">*</span> 保管员:</td>
		<td class='secRow' colspan="3"><s:property value="outStock.take_name" /></td>
		</tr>
		<tr>
			<td class='firstRow'><span style="color:red;">*</span> 单据性质:</td>
			<td class='secRow'>
							<s:if test="%{outStock.reason==0}">销售出库
							</s:if>
							 <s:if test="%{outStock.reason==1}">招待用酒
							</s:if>
							<s:if test="%{outStock.reason==2 }">借货
							</s:if>
							<s:if test="%{outStock.reason==3 }">报损
							</s:if>
							<s:if test="%{outStock.reason==4 }">赠酒
							</s:if>
			</td>
			<td class='firstRow'><span style="color:red;">*</span> 出库仓库:</td>
			<td class='secRow' colspan="3">
					<select name="outStock.store_id" title="出库仓库" >
							
							<s:iterator value="wares" status="sta" var="x">
							<option value="<s:property value="uuid" />" 
							<s:if test="#x.uuid==outStock.store_id">
							selected="selected"
							</s:if>
							/><s:property value="ware_name" />
							</s:iterator>
					</select>
			</td>
		</tr>
		<s:if test="%{outStock.reason==2}">
			<tr class="borrow" id="borrow"> 
								<td class='firstRow'><span style="color: red;">*</span>
									借货仓库:</td>
								<td class='secRow' colspan="3"><select name="outStock.borrowStore_id"
									title="借货仓库">
										<s:iterator value="borrowwares" status="sta" var="x">
											<option 
											<s:if test="#x.uuid==outStock.borrowStore_id">
											selected="selected"
											</s:if>
											 value="<s:property value="uuid" />"/>
											<s:property value="ware_name" />
										</s:iterator>
								</select></td>
			</tr>
		</s:if>

<tr>
	<td class='firstRow'>其它说明:</td>
	<td class='secRow' colspan="6">
	<s:textarea name="outStock.note" title="其它说明" cssStyle="width:80%;" rows="4"></s:textarea>
</tr>

<s:if test="%{outStock.reason==3}"><!-- 报损出库，不审核，自动入库到报损库 -->
	<tr>
		<td class='firstRow'><span style="color:red;">*</span> 报损原因:</td>
		<td class='secRow' colspan="3">
		<s:textarea id="bsreason" name="outStock.bsreason" title="内容" cssStyle="width:80%;" rows="4" require="required" controlName="报损原因"></s:textarea>
	</tr>
</s:if>
<s:elseif test="%{outStock.reason==0}"><!-- 销售出库 -->
<tr>
				<td class='firstRow'><span style="color:red;">*</span> 客户信息:</td>
				<td class='secRow' colspan="6">
				会员号:
				<s:textfield id="order_user_id" name="outStock.member_id" title="会员号" require="required" dataLength="0,85" controlName="会员号" />
				手机:
				<s:textfield id="order_user_mobile" name="outStock.member_mebile"  title="手机" controlName="手机" />
				姓名:
				<s:textfield id="order_user_name" name="outStock.member_name" title="姓名" controlName="姓名" />
				</td>
		</tr>
		<tr>
		<td class='firstRow'>配送地点:</td>
		<td class='secRow' colspan="6">
		<s:textarea id="address" name="outStock.address" title="配送地点" cssStyle="width:80%;" rows="2" require="required" controlName="配送地点"></s:textarea>
		<br />
		选择预设地址:<select id="selectAddress"></select>
		</td>
		</tr>
</s:elseif>
<s:else><!-- 其它出库，不审核，但要 填写目的地，收货人，联系方式，基本费用-->
	<tr>
		<td class='firstRow'><span style="color:red;">*</span> 出库信息:</td>
		<td class='secRow' colspan="3">
		收货人:
		<s:textfield id="order_user_name" name="outStock.member_name" title="姓名" controlName="姓名" />
		联系方式 :
		<s:textfield id="order_user_mobile" name="outStock.member_mebile" title="手机" controlName="手机" />
		基本费用:
		<s:textfield id="order_price" name="outStock.member_price" title="基本费用" controlName="基本费用" />
		</td>
		</tr>
		<tr>
		<td class='firstRow'>配送地点:</td>
		<td class='secRow' colspan="3">
		<s:textarea id="address" name="outStock.member_adress" title="配送地点" cssStyle="width:80%;" rows="2" require="required" controlName="配送地点"></s:textarea>
		</td>
	</tr>

</s:else>

<s:if test="null != outStock">
<tr>
<td class='firstRow'>出库明细:
</td>
<td class='secRow' colspan="6">
<table class="ilisttable" id="table_item" width="100%">
  <tr>
    <th>主键编号</th>
	<th>产品名称</th>
	<th>单价</th>
	<th>订单数量</th>
	<th>实际价格</th>

  </tr>
<s:iterator value="outDetails" status="sta">
  <tr class="<s:if test="#sta.odd == true">oddStyle</s:if><s:else>evenStyle</s:else>">
    <td align="center"><s:property value="uuid" /></td>
	<td><s:property value="product_name" /></td>
	<td align="right"><s:property value="price" /></td>
	<td align="center">
		<s:property value="num" />(<s:property value="num/(case_spec*1.0)" /> 件)
	</td>
	<td align="right"><s:property value="totel" /></td>
  </tr>
</s:iterator>
	<tr>
	<td></td><td></td><td></td>
	<td align="right">总计:</td>
	<td align="right"><s:property value="outStock.total_price" /></td>
	<td></td>
	</tr>
</table>
</td>
</tr>
	<tr>
		<td class='firstRow'>添加人:</td>
		<td class='secRow'><s:property value="outStock.add_user_name" /></td>
		<td class='firstRow'>添加时间:</td>
		<td class='secRow' colspan="3"><s:date name="outStock.add_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
		<tr>
		<td class='firstRow'>最后修改人:</td>
		<td class='secRow'><s:property value="outStock.lm_user_name" /></td>
		<td class='firstRow'>最后修改时间:</td>
		<td class='secRow' colspan="3"><s:date name="outStock.lm_timer" format="yyyy-MM-dd HH:mm:ss" /></td>
	</tr>
	<s:if test="%{outStock.manager_check!=null}">
			<tr>
				<td class='firstRow'>确认人:</td>
				<td class='secRow'><s:property value="outStock.manager_check_user_name" /></td>
				<td class='firstRow'>确认时间:</td>
				<td class='secRow'><s:date name="outStock.manager_check_time" format="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
	</s:if>
</s:if>
		<tr>
		<td colspan="20" class="buttonarea">
			<div class="printarea"><input type="button" onclick="window.print();" value="打印本页"/></div>	
		</td>
		    
	    </tr>
	</table>	
</s:form>
	</div>
</div>
</div>
</body>
</html>