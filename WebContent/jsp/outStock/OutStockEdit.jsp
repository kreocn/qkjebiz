<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>出库管理--<s:text name="APP_NAME" /></title>
</head>
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

<style type="text/css">
.confirm_td {
	text-align: center;
	padding: 5px 0 0 !important;
}

.confirm_button {
	margin: auto;
	display: block;
	border: #333 solid 1px;
	border-radius: 3px;
	font-size: 28px;
	margin-bottom: 5px;
	color: #333;
}

a.confirm_button {
	width: 100px;
	text-decoration: none;
	cursor: pointer;
}

a.confirm_button:hover {
	background-color: #333;
	color: #FFF;
}

.confirm_ok {
	line-height: 50px;
}

.confirm_cancel {
	line-height: 35px;
}

.confirmd {
	display: block;
	margin: auto;
	text-indent: -9999px;
	width: 50px;
	height: 50px;
	background: url(../images/icon/yesno_wb.png) transparent no-repeat;
}

.confirmd_ok {
	background-position: -150px 0;
}

.confirmd_cancel {
	background-position: -150px -150px;
}

.fd_button {
	width: 50px;
	height: 50px;
	font-size: 14px;
	border: #333 solid 1px;
	border-radius: 5px;
	cursor: pointer;
}
</style>

<body onload="wol();">
	<div id="main">
		<div id="result">
			<div class="itablemdy">
				<div class="itabletitle">
					<span class="title1"><s:if
							test="null == outStock && 'add' == viewFlag">增加</s:if>
						<s:elseif test="null != outStock && 'mdy' == viewFlag">修改</s:elseif>出库</span>
					<span class="extra1"> <a
						href="<s:url action="outStock_list" namespace="/outStock" />">出库列表</a>
					</span>
				</div>
				<s:form name="form1" action="outStock_add" namespace="/outStock"
					onsubmit="return validator(this);" method="post" theme="simple">
					<div class="ifromoperate"></div>
					<table class="ilisttable" width="100%">
						<tr>
							<td class='firstRow'><span style="color: red;">*</span>
									出库时间:</td>
							<td class='secRow'><s:textfield id="indate"
										name="outStock.date" title="出库时间" controlName="出库时间" /> <script
										type="text/javascript">
											$("#indate").datepicker();
										</script></td>
						</tr>
						<tr>
							<td  class='firstRow'><span style="color: red;">*</span>经手人:</td>
							<td  class='secRow'>
							<s:textfield  name="outStock.operator_id" title="经手人" controlName="经手人" /></td>
						</tr>
						<tr>
							<td class='firstRow'><span style="color: red;">*</span> 保管员:</td>
							<td class='secRow'><s:textfield  name="outStock.take_id" title="保管员" controlName="保管员" /></td>
						</tr>
						<tr>
							<td class='firstRow'><span style="color: red;">*</span> 状态:</td>
							<td class='secRow'><select name="outStock.reason" title="状态">
									<option value="0">销售出库</option>
									<option value="1">董事会出库</option>
									<option value="2">借货</option>
									<option value="3">报损</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class='firstRow'><span style="color: red;">*</span>
								出库仓库:</td>
							<td class='secRow'><select name="outStock.store_id"
								title="出库仓库">

									<s:iterator value="wares" status="sta" var="x">
										<option value="<s:property value="uuid" />"/>
										<s:property value="ware_name" />
									</s:iterator>
							</select></td>
						</tr>
						<tr>
							<td class='firstRow'>其它说明:</td>
							<td class='secRow'><s:textarea name="outStock.note"
									title="其它说明" cssStyle="width:80%;" rows="4"></s:textarea>
						</tr>
						<tr>
							<td colspan="20" class="buttonarea"><s:if
									test="null == outStock && 'new' == viewFlag">
									<s:if
										test="@org.iweb.sys.ContextHelper@checkPermit('QKJ_OUTSTOCK_OUTSTOCK_ADD')">
										<s:submit id="add" name="add" value="保存&填写明细"
											action="outStock_add" />
									</s:if>
								</s:if> <input type="button" value="返回"
								onclick="linkurl('<s:url action="outStock_list" namespace="/outStock"><s:param name="viewFlag">relist</s:param></s:url>');" />
							</td>

						</tr>
					</table>
				</s:form>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">
	var ajax_url_action = '<s:url value="/common_ajax/json_ajax" />';
	var c_mid = '<s:property value="outStock.member_id" />';
	$(function() {
		SimpleLoadMember(ajax_url_action, function(event, ui) {
			loadAddress(ui.item.order_user_id);
		});
		if (c_mid != '') {
			loadAddress(c_mid);
		}
		$("#addItemForm").dialog({
			autoOpen : false,
			height : 200,
			width : 600,
			modal : true
		});
		$("#addItem").click(function() {
			openAddForm();
		});

		$("#addoutStockPay").dialog({
			autoOpen : false,
			height : 200,
			width : 600,
			modal : true
		});
		$("#addoutStockPayOpen").click(function() {
			$("#addoutStockPay").dialog("open");
		});

		//outStock_fd_date
		if ($("#outStock_fd_date").length > 0) {
			$("#outStock_fd_date").datepicker();
		}

		// 此段代码可以方式回车提交
		jQuery(function($) {
			$("form").keypress(function(e) {
				if (e.keyCode == 13) {
					e.preventDefault();
				}
			});
		});

		CommonUtil.pickrow('fd_list_table');
	});

	function loadAddress(memberid) {
		var ajax = new Common_Ajax();
		ajax.config.action_url = ajax_url_action;
		ajax.config._success = function(data, textStatus) {
			createAddreeeSelect(data);
		};
		ajax.addParameter("privilege_id", "QKJCJ_SYSEBIZ_AJAXLOAD_ADDRESS");
		ajax.addParameter("parameters", "member_id=" + memberid);
		ajax.sendAjax();
	}

	var c_data = new Array(); // 保存当前用户的所有联系人信息
	function createAddreeeSelect(p_data) {
		var selectid = $("#selectAddress");
		selectid.clearAllOption();
		var sh = "";
		for (var i = 0; i < p_data.length; i++) {
			selectid.addOption(i + "-" + p_data[i].province, i);
			sh += p_data[i].province + " " + p_data[i].city + " "
					+ p_data[i].area + " " + p_data[i].street + "  "
					+ p_data[i].con_name + ' 收  邮编:' + p_data[i].post
					+ ' 联系电话:' + p_data[i].mobile;
			if (p_data[i].defaultaddress == 1) {
				$(":input[name='outStock.address']").val(sh);
				selectid.setSelectedValue(i);
			}
			c_data[i] = sh;
			sh = "";
		}
		selectid.unbind().bind(
				"change",
				function() {
					$(":input[name='outStock.address']").val(
							c_data[$(this).getSelectedValue()]);
				});
	}

	function openAddForm() {
		$("#addItemForm").dialog("open");
	}

	function closeAddForm() {
		$("#addItemForm").dialog("close");
	}

	//当前日期
	function wol() {
		var date = new Date();
		var dateString = date.getFullYear() + '-' + (date.getMonth() + 1) + '-'
				+ date.getDate();
		document.getElementById("indate").value = dateString;
	}
</script>
</html>