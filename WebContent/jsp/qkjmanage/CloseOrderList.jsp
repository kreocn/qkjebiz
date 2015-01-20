<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="it" uri="http://qkjchina.com/iweb/iwebTags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>结案提货单列表--<s:text name="APP_NAME" /></title>
<s:action name="ref" namespace="/manager" executeResult="true" />
</head>
<body>
	<div class="main">
		<div class="dq_step">
			${path}
			<s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_ADD')">
				<span class="opb lb op-area"><a href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">add</s:param></s:url>">添加结案提货单</a></span>
			</s:if>
		</div>
		<s:form id="serachForm" name="serachForm" action="closeOrder_list" method="get" namespace="/qkjmanage" theme="simple">
			<div class="label_con">
				<div class="label_main">
					<div class='label_hang'>
						<div class='label_ltit'>主键自增:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.uuid' cssClass=' validate[maxSize[10],custom[integer],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>结案时间:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.close_time' cssClass=' datepicker validate[custom[date],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>内容:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.content' cssClass=' validate[maxSize[65535],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>申请部门:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.apply_dept' cssClass=' validate[maxSize[24],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>制表人:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.apply_user' cssClass=' validate[maxSize[50],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>收货人:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.member_id' cssClass=' validate[maxSize[32],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>收货地址:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.member_address' cssClass=' validate[maxSize[255],]' />
						</div>
					</div>
					<div class='label_hang'>
						<div class='label_ltit'>审核人:</div>
						<div class='label_rwben'>
							<s:textfield name='closeOrder.check_user' cssClass=' validate[maxSize[50],]' />
						</div>
					</div>
					<div class="label_hang tac">
						<s:checkbox id="search_mcondition" name="search_mcondition" fieldValue="true" value="true" cssClass="regular-checkbox" />
						<label for="search_mcondition"></label>更多条件
						<s:submit value="搜索" />
						<s:reset value="重置" />
					</div>
				</div>
			</div>
		</s:form>
		<div class="tab_warp">
			<table>
				<tr id="coltr">
					<th>主键自增</th>
					<th>申请部门</th>
					<th>制表人</th>
					<th>主题</th>
					<th>收货人</th>
					<th>收货地址</th>
					<th>联系电话</th>
					<th>总价</th>
					<th>数据中心审核人</th>

					<th class="td4">操作</th>
					<th class="td0">查看</th>
				</tr>
				<s:iterator value="closeOrders" status="sta">
					<tr id="showtr${uuid}">
						<td>${uuid}</td>
						<td>${apply_dept}</td>
						<td>${apply_user}</td>
						<td>${theme}</td>
						<td>${member_id}</td>
						<td>${member_address}</td>
						<td>${member_phone}</td>
						<td>${totel_price}</td>
						<td>${nd_check_user}</td>

						<td class="td4 op-area"><s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER')">
								<a class="input-blue" href="<s:url namespace="/qkjmanage" action="closeOrder_load"><s:param name="viewFlag">mdy</s:param><s:param name="closeOrder.uuid" value="uuid"></s:param></s:url>">修改</a>
							</s:if> <s:if test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_QKJMANAGE_CLOSEORDER_DEL')">
								<a class="input-red" href="<s:url namespace="/qkjmanage" action="closeOrder_del"><s:param name="closeOrder.uuid" value="uuid"></s:param></s:url>" onclick="return isDel();">删除</a>
							</s:if></td>
						<td class="td0 op-area"><a href="javascript:;" onClick="showDetail('showtr${uuid}');" class="input-nostyle">查看</a></td>
					</tr>
				</s:iterator>
			</table>
		</div>
		<div class="pagination">
			<script type="text/javascript">
		var spage = new ShowPage(${currPage});
		spage.show2(${recCount},${pageSize},2);
		</script>
		</div>
	</div>
</body>
</html>